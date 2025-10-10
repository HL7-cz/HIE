### Rozsah

Tato kapitola popisuje švýcarské národní rozšíření pro transakci „Send Audit Resource Request Message – RESTful interaction [ITI-20](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf)“, definovanou v profilu RESTful ATNA (doplňek „Add RESTful ATNA (Query and Feed)“ v režimu IHE Trial Implementation). Úložiště auditních záznamů (Audit Record Repository) MUSÍ podporovat volbu ATX: FHIR Feed Option.

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

Základní profily pro české AuditEvent v rámci EPR jsou:

• CZ Audit Event with a Basic Auth Token – pokud je transakce zabezpečena základním IUA tokenem.

• CZ Audit Event with an Extended Token – pokud je transakce zabezpečena rozšířeným IUA tokenem.

#### Očekávané akce

Platí stejné sémantiky zpráv a očekávané akce, jak jsou popsány v transakci ITI‑20.

#### Send Audit Resource Response

#### Zdroje CapabilityStatement

CapabilityStatement pro Audit Creator: [ATNA Audit Creator](CapabilityStatement-CH.ATNA.AuditCreator.html).
CapabilityStatement pro Audit Record Repository: [ATNA Audit Record Repository](CapabilityStatement-CH.ATNA.AuditRecordRepository.html).

###  Bezpečnostní aspekty

Transakce MUSÍ být zabezpečena šifrováním Transport Layer Security (TLS) a autentizací serveru prostřednictvím serverových certifikátů.

Transakce MUSÍ používat autentizaci klienta a autorizaci jednou z následujících strategií:
1. Použití základního přístupového tokenu podle IUA, předávaného dle transakce „I[Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72)“.
2. Nebo vzájemná autentizace (mTLS) na transportní vrstvě.
