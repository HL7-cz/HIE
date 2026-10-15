Tato kapitola popisuje obsah auditních událostí, které AAfD zaznamenává do svého auditního logu a zpřístupňuje je centrální komponentě Žurnál činností transakcí [Retrieve ATNA Audit Event [ITI-81]](iti-81-cs.html). Auditní záznamy se dohledávají podle subjektu údajů – pacienta, zdravotnického pracovníka (ZP) i poskytovatele zdravotních služeb (PZS) – a slouží také k vyhodnocení bezpečnostních událostí.

V kontextu HIE se rozlišují tyto kategorie auditních událostí:

1. **Správa dokumentů** – např. dokument pacienta byl nahrán do AAfD nebo byl vyhledán seznam metadat dokumentů.
2. **Ověření oprávnění** – AAfD ověřila v centrálním Registru oprávnění, zda pacient udělil nebo omezil oprávnění k přístupu ke své zdravotnické dokumentaci. AAfD oprávnění v Registru oprávnění pouze čte, nenastavuje je.
3. **Přístup k auditní stopě** – Žurnál činností si vyžádal auditní záznamy pacienta, zdravotnického pracovníka nebo poskytovatele zdravotních služeb.
4. **Bezpečnostní události** – např. odmítnutí spojení kvůli neplatnému certifikátu (mTLS) nebo odmítnutí požadavku kvůli neplatnému přístupovému tokenu. Tyto události nemají vlastní kód v tabulce níže, zaznamenávají se s typy DICOM podle kapitoly [Neúspěšná autentizace a autorizace](iti-20-cs.html#neúspěšná-autentizace-a-autorizace).

Každá kategorie je popsána jako profil obsahu. Profily obsahu vycházejí ze zdroje [AuditEvent](http://hl7.org/fhir/R4/auditevent.html), který má [mapovací pravidla na formát auditní zprávy DICOM](http://hl7.org/fhir/R4/auditevent-mappings.html#dicom), a tím umožňuje mapování na ATNA.

Způsob zaznamenání zabezpečení komunikace (identita uzlů z mTLS, PZS a identifikátor přístupového tokenu IUA) je společný všem kategoriím a popisuje ho kapitola [Zaznamenání zabezpečení komunikace](iti-20-cs.html#zaznamenání-zabezpečení-komunikace).

### Typy auditních událostí

Následující typy událostí jsou definovány v kódovém systému [CZ Audit Trail Event Types](CodeSystem-cz-atc-cs.html) a AAfD je MUSÍ podporovat.

| Typ | Popis | Profil obsahu | Povinnost |
|-----|-------|---------------|-----------|
| ATC_DOC_CREATE | Nahrání dokumentu | [Profil obsahu auditních událostí dokumentů](#profil-obsahu-auditních-událostí-dokumentů) | R (povinné) |
| ATC_DOC_READ | Získání dokumentu | [Profil obsahu auditních událostí dokumentů](#profil-obsahu-auditních-událostí-dokumentů) | R (povinné) |
| ATC_DOC_UPDATE | Aktualizace dokumentu nebo metadat dokumentu | [Profil obsahu auditních událostí dokumentů](#profil-obsahu-auditních-událostí-dokumentů) | R (povinné) |
| ATC_DOC_DELETE | Odstranění dokumentu | [Profil obsahu auditních událostí dokumentů](#profil-obsahu-auditních-událostí-dokumentů) | R (povinné) |
| ATC_DOC_SEARCH | Vyhledání dokumentů | [Profil obsahu auditních událostí dokumentů](#profil-obsahu-auditních-událostí-dokumentů) | R (povinné) |
| ATC_POL_ACCESS_CHECK | Ověření oprávnění v Registru oprávnění | [Profil obsahu auditní události ověření oprávnění](#profil-obsahu-auditní-události-ověření-oprávnění) | R (povinné) |
| ATC_LOG_READ | Přístup k auditní stopě | [Profil obsahu přístupu k auditní stopě](#profil-obsahu-přístupu-k-auditní-stopě) | R (povinné) |
{:class="table table-bordered"}

_Tabulka 1: Typy auditních událostí_

### Profil obsahu auditních událostí dokumentů

Tento profil obsahu popisuje auditní události související se správou dokumentů. Musí být poskytnuty následující datové prvky:

| Datový prvek | Popis | Hodnota |
|--------------|-------|---------|
| Typ události | | Nahrání dokumentu, získání dokumentu, aktualizace dokumentu nebo metadat dokumentu, odstranění dokumentu, vyhledání dokumentů |
| Datum a čas události | | FHIR instant |
| **Účastníci** | | |
| Iniciátor | Pacient | Jméno, RID nebo DRID |
| | Zástupce pacienta | Jméno, RID nebo DRID |
| | Zdravotnický pracovník | Jméno, identifikátor z KRZP |
| | Asistent zdravotnického pracovníka | Jméno, identifikátor z KRZP |
| | Technický uživatel | Jméno, identifikátor |
| Odpovědná osoba<sup>1</sup> | Pacient | Jméno, RID nebo DRID |
| | Zdravotnický pracovník | Jméno, identifikátor z KRZP |
| Poskytovatel zdravotních služeb | PZS identifikovaný v přístupovém tokenu IUA | Název, IČO |
| Účel použití | | NORM, EMER, AUTO |
| **Pacient** | Dotčený pacient | RID nebo DRID |
| **Dokument**<sup>2</sup> | Typ dokumentu | typeCode |
| | Odkaz na dokument | uniqueId, repositoryUniqueId, homeCommunityId |
| | Název dokumentu | title |
{:class="table table-bordered"}

<sup>1</sup> Pokud se liší od iniciátora (např. zástupce pacienta jedná jménem pacienta, odpovědnou osobou je pacient).<br/>
<sup>2</sup> Vyžadováno pro nahrání, získání, aktualizaci a odstranění dokumentu, nikoli pro vyhledání dokumentů.

_Tabulka 2: Datové prvky auditní události dokumentů_

Strukturu auditních událostí jednotlivých transakcí MHD definují profily [ITI-65](StructureDefinition-cz-auditEventIti65Source.html), [ITI-66](StructureDefinition-cz-auditEventIti66Consumer.html), [ITI-67](StructureDefinition-cz-auditEventIti67Consumer.html) a [ITI-68](StructureDefinition-cz-auditEventIti68Consumer.html) a obecný profil [CZ Document Audit Event](StructureDefinition-cz-documentAuditEvent.html).

### Profil obsahu auditní události ověření oprávnění

AAfD před zpřístupněním dokumentace ověřuje v centrálním Registru oprávnění, zda osoba v roli pacienta udělila nebo omezila oprávnění třetí osobě (MZ REST nebo plánovaná transakce [ITI-108] Souhlas s přístupem). Každé takové ověření AAfD zaznamená jako auditní událost. Musí být poskytnuty následující datové prvky:

| Datový prvek | Popis | Hodnota |
|--------------|-------|---------|
| Typ události | | Ověření oprávnění v Registru oprávnění (ATC_POL_ACCESS_CHECK) |
| Datum a čas události | | FHIR instant |
| **Účastníci** | | |
| AAfD | AAfD, která oprávnění ověřuje | Název, HCID |
| Registr oprávnění | Centrální služba elektronického zdravotnictví | Název, adresa služby |
| Poskytovatel zdravotních služeb | PZS identifikovaný v přístupovém tokenu IUA | Název, IČO, identifikátor tokenu (jti) |
| Zdravotnický pracovník | ZP, pro kterého se oprávnění ověřuje (pokud je v kontextu volání) | Jméno, identifikátor z KRZP |
| Účel použití | | NORM, EMER, AUTO |
| **Pacient** | Pacient, k jehož dokumentaci se oprávnění ověřuje | RID nebo DRID |
| **Výsledek** | Rozhodnutí Registru oprávnění | permit (povoleno), restrict (omezeno), deny (zamítnuto) |
| Transakce | Hodnota hlavičky traceparent transakce, v jejímž rámci se ověřovalo (ITI-66, ITI-67, ITI-68) | traceparent |
{:class="table table-bordered"}

_Tabulka 3: Datové prvky auditní události ověření oprávnění_

Strukturu definuje profil [CZ Access Check Audit Event](StructureDefinition-cz-policyAuditEvent.html), viz také [příklad](AuditEvent-CZ-PolicyAuditEventExample.html).

### Profil obsahu přístupu k auditní stopě

Tento profil obsahu popisuje auditní událost, kterou úložiště auditních záznamů zaznamená, když Žurnál činností vyhledá auditní záznamy transakcí [ITI-81](iti-81-cs.html). Musí být poskytnuty následující datové prvky:

| Datový prvek | Popis | Hodnota |
|--------------|-------|---------|
| Typ události | | Přístup k auditní stopě (ATC_LOG_READ) |
| Datum a čas události | | FHIR instant |
| **Účastníci** | | |
| Iniciátor | Žurnál činností (centrální služba elektronického zdravotnictví) | Identita z certifikátu mTLS a z přístupového tokenu |
| Úložiště auditních záznamů | Úložiště, které auditní záznamy vrátilo | Název, HCID AAfD |
| **Subjekt dotazu** | Pacient | RID nebo DRID |
| | Zdravotnický pracovník | identifikátor z KRZP |
| | Poskytovatel zdravotních služeb | IČO |
{:class="table table-bordered"}

_Tabulka 4: Datové prvky přístupu k auditní stopě_

#### Příklady

Budou doplněny.
