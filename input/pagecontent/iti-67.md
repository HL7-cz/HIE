This section describes the additional requirements for the Czech HIE of the [Find Document References
[ITI-67]](https://profiles.ihe.net/ITI/MHD/ITI-67.html) transaction defined in the MHD Profile published in the IHE ITI
Trial Implementation “Mobile Access to Health Documents”.

### Scope

The Find Document References transaction is used to find DocumentReference Resources that
satisfy a set of parameters. It is equivalent to the _FindDocuments_ and
_FindDocumentsByReferenceId_ queries from the _Registry Stored Query_ [ITI-18] transaction. The
result of the query is a FHIR Bundle containing DocumentReference Resources that match the
query parameters.

### Actor Roles

**Table 1: Actor Roles**

|Actor | Role |
|-------------------+--------------------------|
| [Document Consumer]     | Requests a list of DocumentReference Resources, matching the supplied set of criteria, from the Document Responder |
| [Document Responder] | Returns DocumentReference Resources that match the search criteria provided by the Document Consumer |
{: .grid}

### Referenced Standards

**FHIR-R4** [HL7 FHIR Release 4.0](http://www.hl7.org/FHIR/R4)

### Messages

<div>{% include ITI-67-seq.svg %}</div>

#### Find Document References Request Message

The Document Consumer SHALL include the search parameter patient.identifier with the RID or DRID of the patient.
The search parameters of type [token](https://hl7.org/fhir/R4/search.html#token) SHALL contain both the system and the code.

_Find Document Reference_ example **request**:
```http
GET [base]/DocumentReference?patient.identifier=https://ncez.mzcr.cz/fhir/sid/rid|2066425387&status=current HTTP/1.1
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00
```

#### Expected Actions

The Document Responder SHALL process the query to discover the DocumentReference entries that match the search parameters given.

The Document Responder SHALL support search page count requests from the Document Consumer of up to 100 resources.

The Document Responder SHALL set the `DocumentReference.content.attachment.url` value to the URL used in ITI-68 
transactions to retrieve that document's content.

#### Find Document References Response Message

The response Bundle SHALL follow the [CZ MHD Find Document References Comprehensive Response message](StructureDefinition-cz-mhd-finddocumentreference-comprehensive-bundle.html).

##### Federated Cross Community Access Option

If a Document Responder does not respond, an OperationOutcome with a severity warning SHALL be added to the aggregated results indicating the community does not respond.

For matching DocumentReferences returned by the Document Responder, the Document Responder SHALL ensure by rewriting the id and attachment.url that follow-up reads, updates or document retrieval will be handled by same Document Responder actor. Any id, url rewrite SHALL be resolvable for at least an hour.

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Document Consumer** is [MHD Document Consumer](CapabilityStatement-CZ-MHD-DocumentConsumer.html).

The CapabilityStatement resource for the **Document Responder** is [MHD Document Responder](CapabilityStatement-CZ-MHD-DocumentResponder.html).

### Security Considerations

Security of the transaction is based on the Czech Standard for Accredited Affinity Domains (AAfD). The transport layer (mTLS) and the application layer (IUA access token) are **always used together**; they are not alternatives.

#### Transport layer – node authentication (mTLS)

The transaction SHALL be secured by TLS 1.3 (at least TLS 1.2 with strong cipher suites) with mutual node authentication (mTLS) as defined in the ATNA [Authenticate Node [ITI-19]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-19.html) transaction. Both client and server authenticate with an X.509 certificate issued by the certification authority of the Czech Ministry of Health (MZČR), and each side validates the certificate of its peer. mTLS is used for all communication: between the healthcare provider's system (IS PZS) and the AAfD, between AAfDs, and between an AAfD and the central eHealth services.

#### Application layer – authorization (IUA)

The client SHALL convey an IHE IUA access token in JSON Web Token (JWT) format in every request:

1. The IS PZS retrieves the metadata of the central eHealth authorization server with [Get Authorization Server Metadata [ITI-103]](https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103) and an access token with [Get Access Token [ITI-71]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71). It authenticates to the authorization server with a JWT assertion signed with the private key of its system certificate. The token contains the identification of the healthcare provider (PZS). The token is renewed before it expires.
2. The token is conveyed in the `Authorization: Bearer` header as defined in [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72).
3. The server (IUA Resource Server) SHALL validate the token (signature, issuer, validity, audience) and verify that the healthcare provider identified in the token is valid in the national registry of healthcare providers, is connected to the AAfD and is authorized for the requested operation. If a healthcare professional is given in the request context, the professional SHALL be registered with the healthcare provider and valid in the national registry of healthcare professionals.

#### Communication between AAfDs

When the home AAfD forwards a request to another AAfD, it obtains a new access token for the target AAfD using OAuth 2.0 Token Exchange as defined in [RFC 8693](https://www.rfc-editor.org/rfc/rfc8693): the `subject_token` is the access token of the healthcare provider and the `actor_token` is the system token of the calling AAfD. The target AAfD verifies in the eHealth Service Catalogue that the calling AAfD is accredited and issues a token containing the identity of the healthcare provider (`sub`) and of the intermediary AAfD (`act`). Forwarding the healthcare provider's token to another AAfD without validation is not allowed.

Actors SHALL support the `traceparent` header as defined in [W3C Trace Context](https://www.w3.org/TR/trace-context/).

### Security Audit Considerations

The actors SHALL record an audit event and send it with [Record Audit Event [ITI-20]](iti-20.html):

- the **Document Consumer** according to the [CZ Audit Event for [ITI-67] Document Consumer](StructureDefinition-cz-auditEventIti67Consumer.html) profile,
- the **Document Responder** according to the [CZ Audit Event for [ITI-67] Document Responder](StructureDefinition-cz-auditEventIti67Responder.html) profile.

The audit event SHALL record the node identities from mTLS and the details of the IUA access token as defined in [Recording the communication security](iti-20.html#recording-the-communication-security). The AAfD records the query and its result (healthcare provider, healthcare professional, RID or DRID, query parameters). When querying other AAfDs, the home AAfD records each outgoing query as Document Consumer and the target AAfD records it as Document Responder, with the HCID of the home AAfD as the calling system.
