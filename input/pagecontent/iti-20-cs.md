### Rozsah

Tato kapitola popisuje české národní rozšíření (pro akreditované afinitní domény – AAfD) pro transakci „Send Audit Resource Request Message – RESTful interaction [ITI-20](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf)“, definovanou v profilu RESTful ATNA (doplňek „Add RESTful ATNA (Query and Feed)“ v režimu IHE Trial Implementation). Úložiště auditních záznamů (Audit Record Repository) MUSÍ podporovat volbu ATX: FHIR Feed Option.

### Role aktorů

**Aktor**: libovolný aktor či aplikace seskupená se Secure Node nebo Secure Application (Audit Creator).  
**Role**: vytvoří auditní záznam a odešle jej do Úložiště auditních záznamů (Audit Record Repository).  
**Aktor**: Audit Record Repository.  
**Role**: přijme auditní záznam od Audit Record Creator a uloží jej pro potřeby auditu.  

### Odkazované standardy

1. [Add RESTful ATNA (Query and Feed), Rev. 3.3](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf).
2. This RESTful ATNA profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Zprávy

„Send Audit Resource Request Message – FHIR Feed Interaction“ se používá pro auditování zdroje FHIR AuditEvent prostřednictvím RESTful protokolu.

Interakční diagram pro [ITI‑20]:

<div>{% include RESTATNA_ActorDiagram_ITI-20.svg %}</div> 

#### Send Audit Resource Request Message – FHIR Feed Interaction

##### Spouštěcí události

Tato zpráva se odesílá, když aktor seskupený se Secure Node nebo Secure Application, případně Audit Record Forwarder, potřebuje odeslat jednu nebo více AuditEvent resource do Úložiště auditních záznamů.

##### Sémantika zprávy

Auditní události transakcí MHD MUSÍ odpovídat těmto profilům:

| Transakce | Aktor | Profil |
|-----------|-------|--------|
| Provide Document Bundle [ITI-65] | Document Source | [CZ Audit Event for [ITI-65] Document Source](StructureDefinition-cz-auditEventIti65Source.html) |
| Provide Document Bundle [ITI-65] | Document Recipient | [CZ Audit Event for [ITI-65] Document Recipient](StructureDefinition-cz-auditEventIti65Recipient.html) |
| Find Document Lists [ITI-66] | Document Consumer | [CZ Audit Event for [ITI-66] Document List Consumer](StructureDefinition-cz-auditEventIti66Consumer.html) |
| Find Document Lists [ITI-66] | Document Responder | [CZ Audit Event for [ITI-66] Document List](StructureDefinition-cz-auditEventIti66Responder.html) |
| Find Document References [ITI-67] | Document Consumer | [CZ Audit Event for [ITI-67] Document Consumer](StructureDefinition-cz-auditEventIti67Consumer.html) |
| Find Document References [ITI-67] | Document Responder | [CZ Audit Event for [ITI-67] Document Responder](StructureDefinition-cz-auditEventIti67Responder.html) |
| Retrieve Document [ITI-68] | Document Consumer | [CZ Audit Event for [ITI-68] Document Consumer](StructureDefinition-cz-auditEventIti68Consumer.html) |
| Retrieve Document [ITI-68] | Document Responder | [CZ Audit Event for [ITI-68] Document Responder](StructureDefinition-cz-auditEventIti68Responder.html) |
{:class="table table-bordered"}

Obsah auditních událostí, které AAfD zpřístupňuje Žurnálu činností, popisuje [Volume 3](volume3-cs.html).

##### Zaznamenání zabezpečení komunikace

Každá auditní událost MUSÍ zachytit, kdo se při komunikaci prokázal certifikátem (mTLS) a přístupovým tokenem (IUA):

| Údaj | Zdroj | Element AuditEvent |
|------|-------|--------------------|
| Volající systém (uzel) | Klientský certifikát mTLS [ITI-19] | Agent volajícího systému (Document Source / Document Consumer): `who.identifier` – identita z certifikátu (u AAfD její HCID), `network.address` – IP adresa nebo hostname |
| Volaný systém (uzel) | Serverový certifikát mTLS [ITI-19] | Agent volaného systému (Document Recipient / Document Responder): `who.identifier`, `network.address` |
| Poskytovatel zdravotních služeb (PZS) | Identifikace PZS v přístupovém tokenu IUA | `agent[pzs].who.identifier` – IČO PZS (`https://ncez.mzcr.cz/fhir/sid/ico`) |
| Identifikátor přístupového tokenu | Claim `jti` tokenu IUA | `agent[pzs].policy` ve tvaru `urn:ietf:params:oauth:jti:<jti>` (dle IHE BALP) |
| Zdravotnický pracovník | Identifikace ZP předaná IS PZS (KRZP) | `agent[mainUser].altId`, `agent[mainUser].name` |
| Účel použití | Kontext volání | `agent[mainUser].purposeOfUse` |
| Zprostředkující AAfD (komunikace mezi AAfD) | Claim `act` tokenu získaného výměnou dle RFC 8693 a certifikát mTLS | Agent volajícího systému: `who.identifier` – HCID volající AAfD |
| Pacient | RID nebo DRID | `entity[patient].what.identifier` |
| Korelace transakce | Hlavička `traceparent` | `entity[traceparent]` |
{:class="table table-bordered"}

Přístupový token ani jeho část se do auditní události neukládá, zaznamenává se pouze jeho identifikátor (`jti`).

##### Neúspěšná autentizace a autorizace

Pokud server odmítne spojení nebo požadavek, MUSÍ zaznamenat auditní událost s výsledkem (`outcome`) jiným než `0` (úspěch):

- neplatný, neověřitelný nebo chybějící klientský certifikát (mTLS): `type` = `DCM#110113 "Security Alert"`, `subtype` = `DCM#110126 "Node Authentication"`,
- neplatný, expirovaný nebo chybějící přístupový token, případně nesoulad PZS v tokenu s PZS v požadavku: `type` = `DCM#110114 "User Authentication"`, `subtype` = `DCM#110122 "Login"`.

Tyto události slouží k vyhodnocení bezpečnostních událostí (např. opakované přístupy s neplatnými nebo kompromitovanými tokeny).

#### Očekávané akce

Platí stejné sémantiky zpráv a očekávané akce, jak jsou popsány v transakci ITI‑20.

Úložiště auditních záznamů AAfD uloží auditní událost do svého auditního logu a zároveň ji předá do centrální komponenty ATNA elektronického zdravotnictví (AAfD v roli Audit Record Forwarder). Účastníci AAfD (IS PZS) mohou své auditní události odesílat do úložiště auditních záznamů své AAfD touto transakcí.

#### Send Audit Resource Response

#### Zdroje CapabilityStatement

CapabilityStatement pro Audit Creator: [ATNA Audit Creator](CapabilityStatement-CZ-ATNA-AuditCreator.html).
CapabilityStatement pro Audit Record Repository: [ATNA Audit Record Repository](CapabilityStatement-CZ-ATNA-AuditRecordRepository.html).

### Bezpečnostní hlediska

Transakce MUSÍ být zabezpečena protokolem TLS 1.3 (minimálně TLS 1.2 se silnými šifrovacími sadami) se vzájemnou autentizací uzlů (mTLS) dle transakce ATNA [Authenticate Node [ITI-19]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-19.html). Klient i server se prokazují certifikátem X.509 vydaným certifikační autoritou MZČR.

Odesílá-li auditní událost IS PZS do úložiště auditních záznamů AAfD, MUSÍ současně předat přístupový token IUA získaný transakcí [Get Access Token [ITI-71]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71) v hlavičce `Authorization: Bearer` dle transakce [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72). Úložiště auditních záznamů (IUA Resource Server) token validuje stejně jako u transakcí MHD (viz [Bezpečnostní hlediska ITI-65](iti-65-cs.html#bezpečnostní-hlediska)).

Předávání auditních událostí z AAfD do centrální komponenty ATNA probíhá přes mTLS se systémovým přístupovým tokenem AAfD.
