### Constraints on Retrieve ATNA Audit Event [ITI-81] for CH:ATC

Transakce Retrieve ATNA Audit Event [ITI‑81] je definována v [IHE ITI TF-2](https://profiles.ihe.net/ITI/TF/Volume2/index.html) a v dodatku [IHE ITI Supplement Add RESTful Query to ATNA](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf). Pro profil CZ:ATC platí následující pravidla:

#### Sémantika zprávy

Zpráva Retrieve ATNA Audit Event musí být provedena jako HTTP GET žádost směrem k Patient Audit Record Repository. Tato zpráva je FHIR search dotaz (popsáno v [http://hl7.org/fhir/R4/search.html](http://hl7.org/fhir/R4/search.html)) na zdroje typu AuditEvent(popsáno v [http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)). Formát URL je následující:

``` http
<scheme>://<authority>/<path>/AuditEvent?date=ge[start-time]&date=le[stop-time]&<query>
```

kde:

• <scheme> musí být https.
• <query> musí obsahovat parametr entity.identifier podle Additional ATNA Search Parameters a může obsahovat další parametry ATNA. Pokud entity.identifier není obsažen, server odpoví HTTP kódem 400 Bad Request.


<ol type="a">
  <li>
    <code>&lt;scheme&gt;</code> musí být https.
  </li>
  <li>
    <code>&lt;query&gt;</code> musí obsahovat parametr entity.identifier podle <a href="#additional-atna-search-parameters">Additional ATNA Search Parameters</a> a může obsahovat další parametry ATNA. Pokud entity.identifier není obsažen, server odpoví HTTP kódem 400 Bad Request.
  </li>
</ol>


#### Další ATNA parametry dotazu

Spotřebitel auditu (Patient Audit Consumer) nesmí používat v parametrech dotazu následující parametry: address, patient.identifier, source, type, outcome. Smí používat ostatní parametry uvedené v profilu Retrieve Audit Event [ITI‑81]. Parametr **entity.identifier** je typu token a určuje jedinečný identifikátor objektu.

Příklad: 
``` http
http://example.com/ARRservice/AuditEvent?date=ge2020-03-22&date=le2025-03-22&entity.identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|5678
```
Úložiště auditních záznamů (Audit Record Repository) musí tento parametr porovnávat s polem AuditEvent.entity.what.identifier (typ identifier), které odpovídá ParticipantObjectID v DICOM schématu.

Pro profil CZ:ATC musí být hodnota entity.identifier rovna EPR‑SPID, tedy:
`entity.identifier = urn:oid:2.16.756.5.30.1.127.3.10.3|<<<hodnota EPR‑SPID>>>`


#### Sémantika odpovědi zprávy

Zdroje AuditEvent vrácené v Bundle musí být v souladu s profilem CH:ATC AuditEvent, popsané v [Volume 3 - CH:ATC Audit Event Content Profiles](volume3.html).


#### Bezpečnostní aspekty

Transakce musí být zabezpečena pomocí TLS a autentizace serveru prostřednictvím serverových certifikátů.	

Autentizace klienta a autorizace musí být zajištěna jednou z následujících strategií:
1. Použití rozšířeného přístupového tokenu (Extended Access Token) dle IUA, přenášeného podle transakce Incorporate Access Token [ITI‑72].
2. Nebo použití vzájemné autentizace (mTLS) na transportní vrstvě v kombinaci s XUA tokenem pro autorizaci (XUA token předán podle  [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)).
   
Úložiště auditních záznamů CZ:ATC musí být seskupeno s CZ:ADR (Authorization Decision Request). To znamená, že CZ:ATC Patient Audit Record Repository používá CZ:ADR transakci pro rozhodnutí autorizace a vynucuje výsledek rozhodnutí z CZ:ADR Authorization Decision Response.

Aktory musí podporovat zpracování hlavičky traceparent, jak je definováno v dodatku Trace Context.

#### Auditní bezpečnostní úvahy

Auditivní událost podle profilu [Access Audit Trail Content Profile](volume3.html#access-audit-trail-content-profile) musí být vrácena v odpovědi na dotaz ze strany Patient Audit Consumer, poté co Patient Audit Record Repository byl již dotázán.