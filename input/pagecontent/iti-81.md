### Czech national constraints on Retrieve ATNA Audit Event [ITI-81]

The Retrieve ATNA Audit Event [ITI-81] transaction is defined in [IHE ITI TF-2](https://profiles.ihe.net/ITI/TF/Volume2/index.html) and the [IHE ITI Supplement Add RESTful Query to ATNA](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf). The following rules apply in the Czech national extension.

#### Message Semantics

The Retrieve ATNA Audit Event message shall be a HTTP GET request sent to the Audit Record Repository. This message is a FHIR search (see [http://hl7.org/fhir/R4/search.html](http://hl7.org/fhir/R4/search.html)) on AuditEvent Resources (see [http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)). This "search" target is formatted as:

``` http
<scheme>://<authority>/<path>/AuditEvent?date=ge[start-time]&date=le[stop-time]&<query>
```

where:

<ol type="a">
  <li>
    <code>&lt;scheme&gt;</code> shall be https.
  </li>
  <li>
    <code>&lt;query&gt;</code> shall include at least one parameter identifying the data subject as defined in <a href="#additional-atna-search-parameters">Additional ATNA Search Parameters</a> and may include additional ATNA Search parameters. If no parameter identifying the data subject is included, an HTTP response code 400 - Bad Request shall be returned.
  </li>
</ol>


#### Additional ATNA Search Parameters

The Activity Journal (Žurnál činností) retrieves audit records for a data subject – a patient, a healthcare professional or a healthcare provider. The subject is identified by one of these parameters:

| Subject | Parameter | Matched against | Example value |
|---------|-----------|-----------------|---------------|
| Patient | `entity.identifier` | `AuditEvent.entity.what.identifier` (ParticipantObjectID in DICOM) | `https://ncez.mzcr.cz/fhir/sid/rid\|2066425387` (RID, or DRID) |
| Healthcare professional | `altid` | `AuditEvent.agent.altId` (KRZP identifier) | `2000000090092` |
| Healthcare provider | `agent:identifier` | `AuditEvent.agent.who.identifier` (provider company ID from the access token) | `https://ncez.mzcr.cz/fhir/sid/ico\|12345678` |
{:class="table table-bordered"}

Token parameters SHALL contain both the system and the value. The Audit Consumer may use other parameters as listed in Retrieve Audit Event [ITI-81].

Example query for the audit records of a patient:
``` http
https://example.com/ARRservice/AuditEvent?date=ge2020-03-22&date=le2025-03-22&entity.identifier=https://ncez.mzcr.cz/fhir/sid/rid|2066425387
```

Example query for the audit records of a healthcare professional:
``` http
https://example.com/ARRservice/AuditEvent?date=ge2025-01-01&date=le2025-03-31&altid=2000000090092
```


#### Message Semantics for Response

The returned AuditEvent FHIR resources in the Bundle shall conform to the audit event content profiles, see [Volume 3 – Audit Event Content Profiles](volume3.html).


#### Security Considerations

Security of the transaction is based on the Czech Standard for Accredited Affinity Domains (AAfD). The transport layer (mTLS) and the application layer (IUA access token) are **always used together**; they are not alternatives.

##### Transport layer – node authentication (mTLS)

The transaction SHALL be secured by TLS 1.3 (at least TLS 1.2 with strong cipher suites) with mutual node authentication (mTLS) as defined in the ATNA [Authenticate Node [ITI-19]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-19.html) transaction. Both client and server authenticate with an X.509 certificate issued by the certification authority of the Czech Ministry of Health (MZČR), and each side validates the certificate of its peer. mTLS is used for all communication: between the healthcare provider's system (IS PZS) and the AAfD, between AAfDs, and between an AAfD and the central eHealth services.

##### Application layer – authorization (IUA)

The client SHALL convey an IHE IUA access token in JSON Web Token (JWT) format in every request:

1. The IS PZS retrieves the metadata of the central eHealth authorization server with [Get Authorization Server Metadata [ITI-103]](https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103) and an access token with [Get Access Token [ITI-71]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71). It authenticates to the authorization server with a JWT assertion signed with the private key of its system certificate. The token contains the identification of the healthcare provider (PZS). The token is renewed before it expires.
2. The token is conveyed in the `Authorization: Bearer` header as defined in [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72).
3. The server (IUA Resource Server) SHALL validate the token (signature, issuer, validity, audience) and verify that the healthcare provider identified in the token is valid in the national registry of healthcare providers, is connected to the AAfD and is authorized for the requested operation. If a healthcare professional is given in the request context, the professional SHALL be registered with the healthcare provider and valid in the national registry of healthcare professionals.

##### Communication between AAfDs

When the home AAfD forwards a request to another AAfD, it obtains a new access token for the target AAfD using OAuth 2.0 Token Exchange as defined in [RFC 8693](https://www.rfc-editor.org/rfc/rfc8693): the `subject_token` is the access token of the healthcare provider and the `actor_token` is the system token of the calling AAfD. The target AAfD verifies in the eHealth Service Catalogue that the calling AAfD is accredited and issues a token containing the identity of the healthcare provider (`sub`) and of the intermediary AAfD (`act`). Forwarding the healthcare provider's token to another AAfD without validation is not allowed.

Actors SHALL support the `traceparent` header as defined in [W3C Trace Context](https://www.w3.org/TR/trace-context/).

The Audit Consumer is the central eHealth component Activity Journal (Žurnál činností). It authenticates with its certificate in mTLS and with its system access token. The Audit Record Repository SHALL verify that the caller is authorized to read audit records and SHALL return only records related to the queried subject.

#### Security Audit Considerations

The Audit Record Repository SHALL record every query for audit records as an audit event according to the [Access Audit Trail Content Profile](volume3.html#access-audit-trail-content-profile), including the identity of the caller from mTLS and from the access token (see [Recording the communication security](iti-20.html#recording-the-communication-security)).
