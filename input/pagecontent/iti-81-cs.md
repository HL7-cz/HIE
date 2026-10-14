### Constraints on Retrieve ATNA Audit Event [ITI-81] for CZ:ATC

Transakce Retrieve ATNA Audit Event [ITI‑81] je definována v [IHE ITI TF-2](https://profiles.ihe.net/ITI/TF/Volume2/index.html) a v dodatku [IHE ITI Supplement Add RESTful Query to ATNA](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf). Pro profil CZ:ATC platí následující pravidla:

#### Sémantika zprávy

Zpráva Retrieve ATNA Audit Event musí být provedena jako HTTP GET žádost směrem k Patient Audit Record Repository. Tato zpráva je FHIR search dotaz (popsáno v [http://hl7.org/fhir/R4/search.html](http://hl7.org/fhir/R4/search.html)) na zdroje typu AuditEvent(popsáno v [http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)). Formát URL je následující:

``` http
<scheme>://<authority>/<path>/AuditEvent?date=ge[start-time]&date=le[stop-time]&<query>
```

kde:

<ol type="a">
  <li>
    <code>&lt;scheme&gt;</code> musí být https.
  </li>
  <li>
    <code>&lt;query&gt;</code> musí obsahovat alespoň jeden parametr určující subjekt údajů podle <a href="#další-atna-parametry-dotazu">Další ATNA parametry dotazu</a> a může obsahovat další parametry ATNA. Pokud parametr určující subjekt údajů není obsažen, server odpoví HTTP kódem 400 Bad Request.
  </li>
</ol>


#### Další ATNA parametry dotazu

Žurnál činností vyhledává auditní záznamy pro subjekt údajů – pacienta, zdravotnického pracovníka (ZP) nebo poskytovatele zdravotních služeb (PZS). Subjekt se určuje jedním z těchto parametrů:

| Subjekt | Parametr | Porovnává se s | Příklad hodnoty |
|---------|----------|----------------|-----------------|
| Pacient | `entity.identifier` | `AuditEvent.entity.what.identifier` (ParticipantObjectID v DICOM) | `https://ncez.mzcr.cz/fhir/sid/rid\|2066425387` (RID, případně DRID) |
| Zdravotnický pracovník | `altid` | `AuditEvent.agent.altId` (identifikátor ZP z KRZP) | `2000000090092` |
| Poskytovatel zdravotních služeb | `agent:identifier` | `AuditEvent.agent.who.identifier` (IČO PZS z přístupového tokenu) | `https://ncez.mzcr.cz/fhir/sid/ico\|12345678` |
{:class="table table-bordered"}

Parametry typu token MUSÍ obsahovat systém i hodnotu. Spotřebitel auditu smí používat ostatní parametry uvedené v profilu Retrieve Audit Event [ITI‑81].

Příklad dotazu na auditní záznamy pacienta:
``` http
https://example.com/ARRservice/AuditEvent?date=ge2020-03-22&date=le2025-03-22&entity.identifier=https://ncez.mzcr.cz/fhir/sid/rid|2066425387
```

Příklad dotazu na auditní záznamy zdravotnického pracovníka:
``` http
https://example.com/ARRservice/AuditEvent?date=ge2025-01-01&date=le2025-03-31&altid=2000000090092
```


#### Sémantika odpovědi zprávy

Zdroje AuditEvent vrácené v Bundle musí být v souladu s profilem CZ:ATC AuditEvent, popsané v [Volume 3 - CZ:ATC Audit Event Content Profiles](volume3-cs.html).


#### Bezpečnostní hlediska

Zabezpečení transakce vychází ze Standardu akreditovaných afinitních domén (AAfD). Transportní vrstva (mTLS) a aplikační vrstva (přístupový token IUA) se používají **vždy současně**, nejde o alternativy.

##### Transportní vrstva – autentizace uzlů (mTLS)

Transakce MUSÍ být zabezpečena protokolem TLS 1.3 (minimálně TLS 1.2 se silnými šifrovacími sadami) se vzájemnou autentizací uzlů (mTLS) dle transakce ATNA [Authenticate Node [ITI-19]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-19.html). Klient i server se prokazují certifikátem X.509 vydaným certifikační autoritou MZČR a každá strana ověřuje platnost certifikátu protistrany. mTLS se používá pro veškerou komunikaci: mezi IS PZS a AAfD, mezi AAfD navzájem i mezi AAfD a centrálními službami elektronického zdravotnictví.

##### Aplikační vrstva – autorizace (IUA)

Klient MUSÍ v každém požadavku předat přístupový token dle profilu IHE IUA ve formátu JSON Web Token (JWT):

1. IS PZS získá metadata centrálního autorizačního serveru elektronického zdravotnictví transakcí [Get Authorization Server Metadata [ITI-103]](https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103) a přístupový token transakcí [Get Access Token [ITI-71]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71). Vůči autorizačnímu serveru se prokazuje JWT assertion podepsanou privátním klíčem svého systémového certifikátu. Token obsahuje identifikaci PZS. Token se obnovuje před uplynutím jeho platnosti.
2. Token je předán v hlavičce `Authorization: Bearer` dle transakce [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72).
3. Server (IUA Resource Server) MUSÍ token validovat (podpis, vydavatel, platnost, cílová služba) a ověřit, že PZS identifikovaný v tokenu je platný v Kmenovém registru poskytovatelů zdravotních služeb, je připojen k dané AAfD a má oprávnění k požadované operaci. Je-li v kontextu volání uveden zdravotnický pracovník, MUSÍ být evidován v kontextu PZS a platný v Kmenovém registru zdravotnických pracovníků.

##### Komunikace mezi AAfD

Předává-li domovská AAfD požadavek do jiné AAfD, získá pro cílovou AAfD nový přístupový token mechanismem OAuth 2.0 Token Exchange dle [RFC 8693](https://www.rfc-editor.org/rfc/rfc8693): `subject_token` je přístupový token PZS, `actor_token` je systémový token volající AAfD. Cílová AAfD ověří v Katalogu služeb, že volající AAfD je akreditovaná, a vydá token, který obsahuje identitu PZS (`sub`) a identitu zprostředkující AAfD (`act`). Přímé předávání tokenu PZS do jiné AAfD bez validace není dovoleno.

Aktéři MUSÍ podporovat zpracování hlavičky `traceparent` dle [W3C Trace Context](https://www.w3.org/TR/trace-context/).

Konzumentem auditních záznamů (Patient Audit Consumer) je centrální komponenta elektronického zdravotnictví Žurnál činností. Prokazuje se certifikátem při mTLS a svým systémovým přístupovým tokenem. Úložiště auditních záznamů MUSÍ ověřit, že volající je oprávněn auditní záznamy číst, a vrátit pouze záznamy týkající se dotazovaného subjektu.

#### Bezpečnostní audit

Úložiště auditních záznamů MUSÍ zaznamenat každý dotaz na auditní záznamy jako auditní událost dle [Profilu obsahu přístupu k auditní stopě](volume3-cs.html#profil-obsahu-přístupu-k-auditní-stopě), včetně identity volajícího z mTLS a z přístupového tokenu (viz [Zaznamenání zabezpečení komunikace](iti-20-cs.html#zaznamenání-zabezpečení-komunikace)).
