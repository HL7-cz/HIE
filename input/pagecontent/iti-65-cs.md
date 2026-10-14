Tato část odpovídá transakci [ITI-65] technického rámce IHE. Transakce [ITI-65] je používána aktéry zdroje dokumentu a příjemcem dokumentu. Transakce Provide Document Bundle [ITI-65] se používá k přenosu sady dokumentů a souvisejících metadat.

### Rozsah

Transakce Provide Document Bundle [ITI-65] předává požadavek Provide Document Bundle Request od zdroje dokumentu příjemci dokumentu.

### Role aktérů

**Tabulka 1: Role aktérů**

|Aktér | Role |
|-------------------+--------------------------|
| Zdroj dokumentu    | Odesílá dokumenty a metadata příjemci dokumentu |
| Příjemce dokumentů | Přijímá dokumenty a metadata odeslané ze zdroje dokumentů |
{: .grid}

### Odkazované normy

**FHIR-R4** [HL7 FHIR Release 4.0](http://www.hl7.org/FHIR/R4)

### Zprávy

<div>
{%include ITI-65-seq.svg%}
</div>

<br clear="all">

**Obrázek 1: Interakce při poskytování balíčku dokumentů**

#### Požadavek na balíček dokumentů

FHIR `Bundle.meta.profile` musí mít následující hodnotu:

`https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Comprehensive.ProvideBundle`

Žádost o balíček MUSÍ odpovídat [MHD Poskytnutí komplexního balíčku dokumentů](StructureDefinition-cz-mhd-providedocumentbundle-comprehensive.html).

Hodnota DocumentReference.content.attachment.url MUSÍ odkazovat na binární zdroj obsažený v balíčku (viz
[Vyřešení odkazů v balíčcích](https://hl7.org/fhir/R4/bundle.html#references) pro informace o tom, jak vytvořit platný odkaz).

#### Odpověď na balíček dokumentů

Balíček odpovědi MUSÍ odpovídat [MHD Poskytnout komplexní odpověď na balíček dokumentů](StructureDefinition-cz-mhd-providedocumentbundle-comprehensive-response.html).

#### Zdroj CapabilityStatement

Zdroj CapabilityStatement pro **zdroj dokumentu** je [MHD Document Source](CapabilityStatement-CZ-MHD-DocumentSource.html).

Zdroj CapabilityStatement pro **příjemce dokumentu** je [MHD Document Recipient](CapabilityStatement-CZ-MHD-DocumentRecipient.html).

### Bezpečnostní hlediska

Zabezpečení transakce vychází ze Standardu akreditovaných afinitních domén (AAfD). Transportní vrstva (mTLS) a aplikační vrstva (přístupový token IUA) se používají **vždy současně**, nejde o alternativy.

#### Transportní vrstva – autentizace uzlů (mTLS)

Transakce MUSÍ být zabezpečena protokolem TLS 1.3 (minimálně TLS 1.2 se silnými šifrovacími sadami) se vzájemnou autentizací uzlů (mTLS) dle transakce ATNA [Authenticate Node [ITI-19]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-19.html). Klient i server se prokazují certifikátem X.509 vydaným certifikační autoritou MZČR a každá strana ověřuje platnost certifikátu protistrany. mTLS se používá pro veškerou komunikaci: mezi IS PZS a AAfD, mezi AAfD navzájem i mezi AAfD a centrálními službami elektronického zdravotnictví.

#### Aplikační vrstva – autorizace (IUA)

Klient MUSÍ v každém požadavku předat přístupový token dle profilu IHE IUA ve formátu JSON Web Token (JWT):

1. IS PZS získá metadata centrálního autorizačního serveru elektronického zdravotnictví transakcí [Get Authorization Server Metadata [ITI-103]](https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103) a přístupový token transakcí [Get Access Token [ITI-71]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71). Vůči autorizačnímu serveru se prokazuje JWT assertion podepsanou privátním klíčem svého systémového certifikátu. Token obsahuje identifikaci PZS. Token se obnovuje před uplynutím jeho platnosti.
2. Token je předán v hlavičce `Authorization: Bearer` dle transakce [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72).
3. Server (IUA Resource Server) MUSÍ token validovat (podpis, vydavatel, platnost, cílová služba) a ověřit, že PZS identifikovaný v tokenu je platný v Kmenovém registru poskytovatelů zdravotních služeb, je připojen k dané AAfD a má oprávnění k požadované operaci. Je-li v kontextu volání uveden zdravotnický pracovník, MUSÍ být evidován v kontextu PZS a platný v Kmenovém registru zdravotnických pracovníků.

#### Komunikace mezi AAfD

Předává-li domovská AAfD požadavek do jiné AAfD, získá pro cílovou AAfD nový přístupový token mechanismem OAuth 2.0 Token Exchange dle [RFC 8693](https://www.rfc-editor.org/rfc/rfc8693): `subject_token` je přístupový token PZS, `actor_token` je systémový token volající AAfD. Cílová AAfD ověří v Katalogu služeb, že volající AAfD je akreditovaná, a vydá token, který obsahuje identitu PZS (`sub`) a identitu zprostředkující AAfD (`act`). Přímé předávání tokenu PZS do jiné AAfD bez validace není dovoleno.

Aktéři MUSÍ podporovat zpracování hlavičky `traceparent` dle [W3C Trace Context](https://www.w3.org/TR/trace-context/).

### Bezpečnostní audit

Aktéři MUSÍ zaznamenat auditní událost a odeslat ji transakcí [Record Audit Event [ITI-20]](iti-20-cs.html):

- **Zdroj dokumentu (Document Source)** dle profilu [CZ Audit Event for [ITI-65] Document Source](StructureDefinition-cz-auditEventIti65Source.html),
- **Příjemce dokumentu (Document Recipient)** dle profilu [CZ Audit Event for [ITI-65] Document Recipient](StructureDefinition-cz-auditEventIti65Recipient.html).

Auditní událost MUSÍ zachytit identitu uzlů z mTLS a údaje z přístupového tokenu IUA podle pravidel v kapitole [Zaznamenání zabezpečení komunikace](iti-20-cs.html#zaznamenání-zabezpečení-komunikace). AAfD zaznamená přijetí dokumentu (PZS, ZP, RID nebo DRID, identifikátor SubmissionSet) včetně neúspěšných pokusů, např. odmítnutí kvůli nesouladu PZS v tokenu a v metadatech dokumentu.
