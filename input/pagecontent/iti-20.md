### Scope

This section describes the Czech national extension (for Accredited Affinity Domains – AAfD) of the [Send Audit Resource Request Message – 
RESTful interaction [ITI-20]](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf) transaction defined in the RESTful ATNA profile which is currently prepared as IHE 
Trial Implementation with the working title ”Add RESTful ATNA (Query and Feed)”. The Audit Record Repository SHALL support the ATX: FHIR Feed Option.

### Actor Roles

**Actor:** Any actor or any other application that is grouped with the Secure Node or Secure Application (Audit Creator).  
**Role:** Create an audit record and transmit this record to the Audit Record Repository.   
**Actor:** Audit Record Repository  
**Role:** Receive an audit record from the Audit Record Creator and store this for audit purposes.

### Referenced Standards

1. [Add RESTful ATNA (Query and Feed), Rev. 3.3](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf)  
2. This RESTful ATNA profile is based on Release 4 of the [HL7® FHIR®](https://hl7.org/fhir/R4/index.html) standard.

### Messages

The “Send Audit Resource Request Message – FHIR Feed Interaction” is used for auditing the FHIR Audit Event Resource using the RESTful protocol. 

<div>{% include RESTATNA_ActorDiagram_ITI-20.svg %}</div>

#### Send Audit Resource Request Message – FHIR Feed Interaction

##### Trigger Events

This message is sent when an actor that is grouped with Secure Node or Secure Application or an
Audit Record Forwarder needs to post a single or multiple AuditEvent Resource to the Audit Record
Repository.

##### Message Semantics

Audit events of the MHD transactions SHALL conform to these profiles:

| Transaction | Actor | Profile |
|-------------|-------|---------|
| Provide Document Bundle [ITI-65] | Document Source | [CZ Audit Event for [ITI-65] Document Source](StructureDefinition-cz-auditEventIti65Source.html) |
| Provide Document Bundle [ITI-65] | Document Recipient | [CZ Audit Event for [ITI-65] Document Recipient](StructureDefinition-cz-auditEventIti65Recipient.html) |
| Find Document Lists [ITI-66] | Document Consumer | [CZ Audit Event for [ITI-66] Document List Consumer](StructureDefinition-cz-auditEventIti66Consumer.html) |
| Find Document Lists [ITI-66] | Document Responder | [CZ Audit Event for [ITI-66] Document List](StructureDefinition-cz-auditEventIti66Responder.html) |
| Find Document References [ITI-67] | Document Consumer | [CZ Audit Event for [ITI-67] Document Consumer](StructureDefinition-cz-auditEventIti67Consumer.html) |
| Find Document References [ITI-67] | Document Responder | [CZ Audit Event for [ITI-67] Document Responder](StructureDefinition-cz-auditEventIti67Responder.html) |
| Retrieve Document [ITI-68] | Document Consumer | [CZ Audit Event for [ITI-68] Document Consumer](StructureDefinition-cz-auditEventIti68Consumer.html) |
| Retrieve Document [ITI-68] | Document Responder | [CZ Audit Event for [ITI-68] Document Responder](StructureDefinition-cz-auditEventIti68Responder.html) |
{:class="table table-bordered"}

The content of audit events for the patient audit trail is described in [Volume 3](volume3.html).

##### Recording the communication security

Every audit event SHALL record who authenticated with a certificate (mTLS) and with an access token (IUA):

| Data | Source | AuditEvent element |
|------|--------|--------------------|
| Calling system (node) | mTLS client certificate [ITI-19] | Agent of the calling system (Document Source / Document Consumer): `who.identifier` – identity from the certificate (for an AAfD its HCID), `network.address` – IP address or hostname |
| Called system (node) | mTLS server certificate [ITI-19] | Agent of the called system (Document Recipient / Document Responder): `who.identifier`, `network.address` |
| Healthcare provider (PZS) | Healthcare provider identification in the IUA access token | `agent[pzs].who.identifier` – company ID (IČO, `https://ncez.mzcr.cz/fhir/sid/ico`) |
| Access token identifier | `jti` claim of the IUA token | `agent[pzs].policy` as `urn:ietf:params:oauth:jti:<jti>` (as in IHE BALP) |
| Healthcare professional | Identification passed by the provider's system (KRZP) | `agent[mainUser].altId`, `agent[mainUser].name` |
| Purpose of use | Request context | `agent[mainUser].purposeOfUse` |
| Intermediary AAfD (communication between AAfDs) | `act` claim of the token obtained by RFC 8693 token exchange, and the mTLS certificate | Agent of the calling system: `who.identifier` – HCID of the calling AAfD |
| Patient | RID or DRID | `entity[patient].what.identifier` |
| Transaction correlation | `traceparent` header | `entity[traceparent]` |
{:class="table table-bordered"}

The access token or any part of it SHALL NOT be stored in the audit event; only its identifier (`jti`) is recorded.

##### Failed authentication and authorization

When the server rejects a connection or a request, it SHALL record an audit event with an `outcome` other than `0` (success):

- invalid, unverifiable or missing client certificate (mTLS): `type` = `DCM#110113 "Security Alert"`, `subtype` = `DCM#110126 "Node Authentication"`,
- invalid, expired or missing access token, or a mismatch between the healthcare provider in the token and in the request: `type` = `DCM#110114 "User Authentication"`, `subtype` = `DCM#110122 "Login"`.

These events are used to evaluate security events (e.g. repeated access with invalid or compromised tokens).

##### Expected Actions

Same message semantics and expected actions apply as described in the ITI-20 transaction.

The Audit Record Repository of the AAfD stores the audit event in its audit log and forwards it to the central eHealth ATNA component (the AAfD acting as Audit Record Forwarder). Participants of the AAfD (healthcare provider systems) may send their audit events to the Audit Record Repository of their AAfD with this transaction.

#### Send Audit Resource Response

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Audit Creator** is
[ATNA Audit Creator](CapabilityStatement-CZ-ATNA-AuditCreator.html).

The CapabilityStatement resource for the **Audit Record Repository** is
[ATNA Audit Record Repository](CapabilityStatement-CZ-ATNA-AuditRecordRepository.html).

### Security Considerations

The transaction SHALL be secured by TLS 1.3 (at least TLS 1.2 with strong cipher suites) with mutual node authentication (mTLS) as defined in the ATNA [Authenticate Node [ITI-19]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-19.html) transaction. Both client and server authenticate with an X.509 certificate issued by the certification authority of the Czech Ministry of Health (MZČR).

When a healthcare provider system sends an audit event to the Audit Record Repository of the AAfD, it SHALL also convey the IUA access token obtained with [Get Access Token [ITI-71]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71) in the `Authorization: Bearer` header as defined in [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72). The Audit Record Repository (IUA Resource Server) validates the token as for the MHD transactions (see [ITI-65 Security Considerations](iti-65.html#security-considerations)).

Audit events are forwarded from the AAfD to the central ATNA component over mTLS with the system access token of the AAfD.
