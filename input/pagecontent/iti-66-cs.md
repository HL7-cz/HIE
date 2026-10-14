Tato část odpovídá transakci [ITI-66] technického rámce IHE. Transakce [ITI-66] je používána aktéry Document Consumer a Document Responder. Tato transakce se používá k vyhledání a vrácení metadat pro dříve uložené sady nebo složky odeslaných dokumentů.

### Rozsah

Transakce Find Document Lists [ITI-66] se používá k vyhledání seznamů zdrojů, které splňují sadu parametrů. Je ekvivalentní: 

* dotazu FindSubmissionSets v transakci Registry Stored Query [\[ITI-18\]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html), jak je dokumentováno v [ITI TF-2: 3.18.4.1.2.3.7.2](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html#3.18.4.1.2.3.7.2). 
* Dotaz FindFolders v transakci Registry Stored Query [\[ITI-18\]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html), jak je popsáno v [ITI TF-2: 3.18.4.1.2.3.7.3](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html#3.18.4.1.2.3.7.3). 

Výsledkem dotazu je balíček obsahující seznam zdrojů, které odpovídají parametrům dotazu.

### Role aktérů

**Tabulka 1: Role aktérů**

|Aktér | Role |
|-------------------+--------------------------|
| Spotřebitel dokumentů    | Žádá o seznam zdrojů, které odpovídají zadaným kritériím, od respondenta dokumentů |
| Odesílatel dokumentů | Vrací seznam zdrojů, které odpovídají vyhledávacím kritériím poskytnutým spotřebitelem dokumentů |
{: .grid}

### Odkazované normy

**FHIR-R4** [HL7 FHIR Release 4.0](http://www.hl7.org/FHIR/R4)

### Zprávy

<div>
{%include ITI-66-seq.svg%}
</div>

<br clear="all">

**Obrázek 1: Interakce vyhledávání seznamů dokumentů**

#### Najít odkazy na dokumenty Odpověď

Odpověď MUSÍ odpovídat struktuře [CZ MHD Najít odkazy na dokumenty Komplexní odpověď](StructureDefinition-cz-mhd-finddocumentlists-comprehensive-bundle.html).

##### Možnost federovaného přístupu napříč komunitami

Pokud odesílatel neodpoví, MUSÍ být k agregovaným výsledkům přidána operace OperationOutcome s varováním o závažnosti, které označuje, že komunita neodpovídá.

U shodných odkazů na dokumenty vrácených odesílatelem MUSÍ odesílatel zajistit přepsáním identifikátoru a adresy attachment.url, že následné čtení, aktualizace nebo načtení dokumentů bude zpracováno stejným aktérem dokumentového respondenta. Jakékoli přepsání identifikátoru nebo adresy URL MUSÍ být řešitelné po dobu alespoň jedné hodiny.

#### Zdroj CapabilityStatement

Zdrojem CapabilityStatement pro **Spotřebitele seznamů dokumentů** je [Spotřebitel seznamů dokumentů MHD](CapabilityStatement-CZ-MHD-DocumentConsumer.html).

Zdrojem CapabilityStatement pro **Odpovídajícího na seznamy dokumentů** je [Odpovídající na seznamy dokumentů MHD](CapabilityStatement-CZ-MHD-DocumentResponder.html).

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

- **Spotřebitel seznamů dokumentů (Document Consumer)** dle profilu [CZ Audit Event for [ITI-66] Document List Consumer](StructureDefinition-cz-auditEventIti66Consumer.html),
- **Respondent (Document Responder)** dle profilu [CZ Audit Event for [ITI-66] Document Responder](StructureDefinition-cz-auditEventIti66Responder.html).

Auditní událost MUSÍ zachytit identitu uzlů z mTLS a údaje z přístupového tokenu IUA podle pravidel v kapitole [Zaznamenání zabezpečení komunikace](iti-20-cs.html#zaznamenání-zabezpečení-komunikace). AAfD zaznamená dotaz a jeho výsledek (PZS, ZP, RID nebo DRID, parametry dotazu).
