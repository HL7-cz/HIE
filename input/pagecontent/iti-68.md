This section corresponds to transaction [ITI-68] of the IHE Technical Framework. Transaction [ITI-68] is used by the Document Consumer and Document Responder Actors.

### Scope

The Retrieve Document [ITI-68] transaction is used by the Document Consumer to retrieve a document from the Document Responder.

### Actors Roles

**Table 1: Actor Roles**

|Actor | Role |
|-------------------+--------------------------|
| Document Consumer    | Requests a document from the Document Responder |
| Document Responder | Serves the document to the Document Consumer |
{: .grid}

### Referenced Standards

**FHIR-R4** [HL7 FHIR Release 4.0](http://www.hl7.org/FHIR/R4)

### Messages

<div>
{%include ITI-68-seq.svg%}
</div>

<br clear="all">

**Figure 1: Retrieve Document Interactions**

#### Retrieve Document Request Message

This message is an HTTP GET request to retrieve the document. 

##### Trigger Events

The Document Consumer wants to obtain a document. 

##### Message Semantics

The Document Consumer sends a HTTP GET request to the server. The Document Consumer request may be to retrieve the document content referenced by a DocumentReference.content.attachment.url. 

The Document Consumer may provide HTTP Accept header, according to the semantics of the HTTP protocols (see RFC2616, Section 14.1).  This enables the Document Consumer to indicate preferred mime-types such that the Document Responder could provide the document requested in an encoding other than the encoding indicated in the DocumentReference. For example, indicating `application/fhir+json` could result in the response from the Document Responder being a json FHIR Bundle of type `document` with all the content encoded as FHIR resources.

The only MIME type assured to be returned is the MIME type indicated in the DocumentReference.content.attachment.contentType.

The HTTP If-Unmodified-Since header shall not be included in the GET request.

##### Expected Actions

The Document Responder shall provide the document in the requested MIME type or reply with an HTTP status code indicating the error condition. The Document Responder is not required to transform the document.

#### Retrieve Document Response Message

This is the return message sent by the Document Responder. 

##### Trigger Events

The HTTP Response message is sent upon completion of the Retrieve Document Request. 

##### Message Semantics

This message shall be an HTTP Response, as specified by RFC2616. When the requested document is returned, the Document Responder shall respond with HTTP Status Code 200. The HTTP message-body shall be the content of the requested document.

Table 1 contains error situations and the HTTP Response.

**Table 2: HTTP Error Response Codes and Suggested Text**

|Situation	| HTTP Response |
|-----------|---------------|
|URI not known	| 404 Document Not Found |
|Document is Deprecated or not available	| 410 Gone (or 404 when 410 is unacceptable due to security/privacy policy) |
|Document Responder unable to format document in content types listed the 'Accept' field	| 406 Not Acceptable |
|HTTP request specified is otherwise not a legal value	| 403 Forbidden/Request Type Not Supported |
{: .grid}

The Document Responder may return other HTTP Status Codes. Guidance on handling Access Denied related to use of 200, 403 and 404 can be found in [ITI TF-2x: Appendix Z.7](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.8-mobile-security-considerations).

The Document Responder should complement the returned error code with a human readable description of the error condition.

##### Expected Actions

The Document Consumer processes the results according to application-defined rules.

#### CapabilityStatement Resource

Document Responders implementing this transaction shall provide a CapabilityStatement Resource as described in [ITI TF-2x: Appendix Z.3](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.3-capabilitystatement-resource) indicating the transaction has been implemented. 
- Requirements CapabilityStatement for [Document Consumer](CapabilityStatement-CZ-MHD-DocumentConsumer.html)
- Requirements CapabilityStatement for [Document Responder](CapabilityStatement-CZ-MHD-DocumentResponder.html)

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

This transaction shall not return information that the Document Consumer is not authorized to access.

### Security Audit Considerations

The actors SHALL record an audit event and send it with [Record Audit Event [ITI-20]](iti-20.html):

- the **Document Consumer** according to the [CZ Audit Event for [ITI-68] Document Consumer](StructureDefinition-cz-auditEventIti68Consumer.html) profile,
- the **Document Responder** according to the [CZ Audit Event for [ITI-68] Document Responder](StructureDefinition-cz-auditEventIti68Responder.html) profile.

The audit event SHALL record the node identities from mTLS and the details of the IUA access token as defined in [Recording the communication security](iti-20.html#recording-the-communication-security). The AAfD records the retrieval of the document (healthcare provider, healthcare professional, RID or DRID, document URI). When an AAfD passes on a document retrieved from another AAfD, it records this even though it does not store the document.
