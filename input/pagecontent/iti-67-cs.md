Tato část popisuje dodatečné požadavky pro českou HIE transakci [Najít odkazy na dokumenty
[ITI-67]](https://profiles.ihe.net/ITI/MHD/ITI-67.html) definované v profilu MHD zveřejněném v IHE ITI
Zkušební implementace „Mobilní přístup k zdravotním dokumentům“.

### Rozsah

Transakce Find Document References se používá k vyhledání zdrojů DocumentReference, které
splňují sadu parametrů. Je ekvivalentní dotazům _FindDocuments_ a
_FindDocumentsByReferenceId_ z transakce _Registry Stored Query_ [ITI-18].
Výsledkem dotazu je balíček FHIR obsahující zdroje DocumentReference, které odpovídají
parametrům dotazu.

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

<div>{% include ITI-67-seq.svg %}</div>

#### Zpráva s požadavkem na vyhledání odkazů na dokumenty

Spotřebitel dokumentů MUSÍ zahrnout vyhledávací parametr patient.identifier s RID nebo DRID pacienta.
Vyhledávací parametry typu [token](https://hl7.org/fhir/R4/search.html#token) MUSÍ obsahovat jak systém, tak kód.

Příklad **požadavku** na vyhledání odkazu na dokument:
```http
GET [base]/DocumentReference?patient.identifier=https://ncez.mzcr.cz/fhir/sid/rid|2066425387&status=current HTTP/1.1
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00
```

#### Očekávané akce

Odpovídající dokument MUSÍ zpracovat dotaz, aby zjistil položky DocumentReference, které odpovídají zadaným parametrům vyhledávání.

Odpovídající dokument MUSÍ podporovat požadavky na počet stránek vyhledávání od spotřebitele dokumentu až do 100 zdrojů.

Odpovídající dokument MUSÍ nastavit hodnotu `DocumentReference.content.attachment.url` na URL použitou v transakcích ITI-68 k načtení obsahu daného dokumentu.

#### Zpráva s odpovědí na vyhledání odkazů na dokumenty

Odpověď MUSÍ odpovídat [CZ MHD Find Document References Comprehensive Response message](StructureDefinition-cz-mhd-finddocumentreference-comprehensive-bundle.html)

##### Možnost federovaného přístupu napříč komunitami

Pokud dokumentový respondent neodpoví, MUSÍ být k agregovaným výsledkům přidán OperationOutcome s varováním o závažnosti, které označuje, že komunita neodpovídá.

U shodných odkazů na dokumenty vrácených dokumentovým respondentem MUSÍ dokumentový respondent zajistit přepsáním id a attachment.url, že následné čtení, aktualizace nebo načtení dokumentů bude zpracováno stejným aktérem dokumentového respondenta. Jakékoli přepsání id, url MUSÍ být řešitelné po dobu alespoň jedné hodiny.

#### Zdroj CapabilityStatement

Zdroj CapabilityStatement pro **Spotřebitele dokumentů** je [MHD Spotřebitel dokumentů](CapabilityStatement-CZ-MHD-DocumentConsumer.html).

Zdroj CapabilityStatement pro **Odpovídajícího na dokumenty** je [MHD Odpovídající na dokumenty](CapabilityStatement-CZ-MHD-DocumentResponder.html).

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

- **Spotřebitel dokumentů (Document Consumer)** dle profilu [CZ Audit Event for [ITI-67] Document Consumer](StructureDefinition-cz-auditEventIti67Consumer.html),
- **Respondent (Document Responder)** dle profilu [CZ Audit Event for [ITI-67] Document Responder](StructureDefinition-cz-auditEventIti67Responder.html).

Auditní událost MUSÍ zachytit identitu uzlů z mTLS a údaje z přístupového tokenu IUA podle pravidel v kapitole [Zaznamenání zabezpečení komunikace](iti-20-cs.html#zaznamenání-zabezpečení-komunikace). AAfD zaznamená dotaz a jeho výsledek (PZS, ZP, RID nebo DRID, parametry dotazu). Při dotazu do dalších AAfD zaznamená domovská AAfD každý odchozí dotaz jako Document Consumer a cílová AAfD jej zaznamená jako Document Responder, kde jako volající systém uvede HCID domovské AAfD.
