### Úvod 

Tato implementační specifikace se zaměřuje na národní implementaci profilu MHD (Mobile access to Health Documents) v prostředí akreditovaných afinitních domén (AAfD) a centrálních služeb elektronického zdravotnictví (EZ) vycházející z národního [Standard Akreditovaných afinitních domén](https://ncez.mzcr.cz/sites/default/files/media-documents/Standard%20Do%C4%8Dasn%C3%A9%20ulo%C5%BEi%C5%A1t%C4%9B%20v%200.10.pdf) 

Následující schéma ilustruje základní architekturu řešení a vzájemné vztahy mezi systémy: 

<div>
<img src="schema.png" class="figure-img img-responsive img-rounded center-block" width="40%">
<p><strong>Obr. 1: Schéma základní infrastruktury</strong></p>
<p> </p>
</div>

**Systém publikující zdravotnickou dokumentaci (ZD)**

Primární systém poskytovatele, který prostřednictvím MHD a souvisejících rozhraní publikuje dokumenty a metadata. 

**Centrální služby EZ**

Poskytují registr identit (KRP), registr oprávnění, číselníky a terminologie, časová razítka a auditní služby. Zajišťují také směrování a federaci dotazů mezi jednotlivými AAfD pomocí identifikátoru HCID. 

**AAfD publikující a konzumenta**

Doménové komponenty, které zajišťují příjem a vyhledávání dokumentů, ověřování identity a oprávnění, notifikace a audit. 

**Systém konzumenta ZD**

Aplikace uživatele (např. klinický systém nebo portál), která na základě autorizace vyhledává a stahuje dokumenty, případně přijímá notifikace o nových záznamech. 

Schéma ukazuje podporované transakce IHE (ITI-65, ITI-66, ITI-67, ITI-68, DSUBm/ITI-112, RESTful ATNA/ITI-20) i národní rozhraní EZ (např. registr oprávnění, časová autorita, číselníky). Tato architektura tvoří základ pro interoperabilní sdílení zdravotnické dokumentace v České republice. 

### Rozsah 

Národní specifikace MHD pro Českou republiku vyžaduje podporu transakcí ITI-65, ITI-66, ITI-67 a ITI-68 pro sdílení zdravotnických dokumentů v rámci Akreditovaných afinitních domén (AAfD). ITI-66 je v českém kontextu povinná pro mezidoménové vyhledávání (HCID). 

### Případy užití 

#### Mezidoménové vyhledání a stažení 

PZS v AAfD-B zadá dotaz (ITI-66/67) na dokument pacienta, domácí AAfD na základě HCID rozešle požadavek do sousedních AAfD (včetně AAfD-A) a agreguje výsledky. Z obdržených metadat si PZS vybere konkrétní záznam a přes ITI-68 je směrován požadavek na repozitář v AAfD-A, odkud je dokument bezpečně stažen. Všechny kroky jsou autentizovány pomocí IUA a auditovány přes RESTful ATNA 

#### Notifikace nových dokumentů 

Pokud je v AAfD publikován nový dokument, systém prostřednictvím profilu DSUBm (ITI-112) odešle notifikaci registrovanému poskytovateli zdravotních služeb (PZS), který si tuto událost předem přihlásil. Notifikace obsahuje základní metadata (např. identifikátor pacienta RID, typ dokumentu, odkaz na DocumentReference), aby PZS věděl, že je k dispozici nový záznam. Následně může PZS podle potřeby spustit vyhledání a stažení dokumentu standardními transakcemi MHD (ITI-66 až 68). 

#### Aktualizace nebo zneplatnění metadat 

Pokud zdravotnický pracovník potřebuje opravit nebo zneplatnit dokument, jeho primární systém odešle požadavek na změnu. V prostředí AAfD se to řeší obvykle publikací nové verze dokumentu a zneplatněním původního záznamu, zatímco Dočasné úložiště pro tento účel nabízí služby Změna/Zneplatnění zásilky (PUT). Tím je zajištěno, že uživatelé vždy pracují s aktuálními a validními metadaty i obsahem. 

### Aktéři a transakce 

{:class="table table-bordered"}
| Aktér                                         | Role                      | Hlavní transakce  |
|-----------------------------------------------|---------------------------|-------------|
| Document Source                               | Publikuje dokumenty a metadata do AAfD    | ITI-65 Provide Document Bundle      |
| Document Consumer                             | Vyhledává a stahuje dokumenty            | ITI-66 Find, ITI-67 Find References, ITI-68 Retrieve   |
| Document Responder                            | Odpovídá na vyhledávací dotazy a vrací metadata  | ITI-66, ITI-67  |
| Document Recipient                             | Přijímá publikované dokumenty do repozitáře   | ITI-65   |
| Notification Recipient                            | Přijímá notifikace o nových dokumentech   | DSUBm / ITI-112    |


<figcaption ID="1">Tabulka 1: Aktéři a transakce.</figcaption>
<p> </p>

### Požadované seskupení aktérů 

{:class="table table-bordered"}
| Aktér                                         | Povinné seskupen                 | Poznámka   |
|-----------------------------------------------|---------------------------|-------------|
| Document Source                               | IUA klient, ATNA audit repository    | Publikace dokumentů vyžaduje autorizaci a audit       |
| Document Consumer                             | IUA klient, ATNA audit repository            | Vyhledávání a stahování vyžaduje autorizaci a audit    |
| Document Responder (Registry)                 | IUA Authorization Server, ATNA audit repository  | Odpovědi na dotazy vyžadují validaci tokenu a audit |
| Document Recipient (Repository)               | Document Registry, ATNA audit repository   | Ukládání dokumentů v AAfD, evidence metadat   |
| Notification Recipient                            | IUA klient, ATNA audit repository    | Příjem notifikací o nových dokumentech    |


<figcaption ID="1">Tabulka 2: Požadované seskupení aktérů.</figcaption>
<p> </p>

Všichni aktéři AAfD musí také využívat centrální služby EZ: Kmenové registry (identifikátor pacienta RID), Registr oprávnění, Terminologický server, Časová autorita. 

### Sekvence 

Domácí akreditovaná afinitní doména (AAfD) přijme vyhledávací dotaz ITI-66 obsahující jednoznačný identifikátor pacienta (RID). Na základě HCID indexu identifikuje relevantní partnerské AAfD a distribuuje jim odpovídající dotazy. Následně provede agregaci navrácených záznamů typu DocumentReference a zprostředkuje uživateli ucelený seznam výsledků. V případě volby konkrétního záznamu směruje požadavek ITI-68 Retrieve Document na repozitář příslušné AAfD, z níž dokument pochází.  

### Bezpečnost 

Procesy autentizace a autorizace jsou realizovány dle profilu IUA (OAuth 2.0 / JWT). Veškerá komunikace probíhá zabezpečeným protokolem TLS 1.2+ a každá transakce je auditována prostřednictvím profilu RESTful ATNA (ITI-20). Identita pacienta a oprávnění zdravotnického pracovníka se ověřují proti Kmenovému registru pacientů (KRPZS/KRP)a Registru práv a mandátů (RO). 

### Terminologie 

Pro hodnoty klasifikace, typů a formátů dokumentů se využívají číselníky a kódové systémy publikované na Terminologickém serveru elektronického zdravotnictví. Jednoznačná identifikace pacienta je v rámci transakcí zajištěna prostřednictvím RID z Kmenového registru pacientů (KRP). 