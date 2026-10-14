This section corresponds to transaction [ITI-65] of the IHE Technical Framework. Transaction [ITI-65] is used by the Document Source and Document Recipient Actors. The Provide Document Bundle [ITI-65] transaction is used to transmit a set of documents and associated metadata.

### Scope

The Provide Document Bundle [ITI-65] transaction passes a Provide Document Bundle Request from a Document Source to a Document Recipient.

### Actors Roles

**Table 1: Actor Roles**

|Actor | Role |
|-------------------+--------------------------|
| Document Source    | Sends documents and metadata to the Document Recipient |
| Document Recipient | Accepts the document and metadata sent from the Document Source |
{: .grid}

### Referenced Standards

**FHIR-R4** [HL7 FHIR Release 4.0](http://www.hl7.org/FHIR/R4)

### Messages

<div>
{%include ITI-65-seq.svg%}
</div>

<br clear="all">

**Figure 1: Provide Document Bundle Interactions**

#### Provide Document Bundle Request Message

The FHIR `Bundle.meta.profile` shall have the following value:

`https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Comprehensive.ProvideBundle`

The request Bundle SHALL follow the [MHD Provide Document Bundle Comprehensive](StructureDefinition-cz-mhd-providedocumentbundle-comprehensive.html).

The `DocumentReference.content.attachment.url` value SHALL point to a Binary resource included in the Bundle (see
[Resolving references in Bundles](https://hl7.org/fhir/R4/bundle.html#references) for how to create a valid reference).

#### Provide Document Bundle Response Message

The response Bundle SHALL follow the [MHD Provide Document Bundle Comprehensive Response](StructureDefinition-cz-mhd-providedocumentbundle-comprehensive-response.html).

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Document Source** is [MHD Document Source](CapabilityStatement-CZ-MHD-DocumentSource.html).

The CapabilityStatement resource for the **Document Recipient** is [MHD Document Recipient](CapabilityStatement-CZ-MHD-DocumentRecipient.html).

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

- the **Document Source** according to the [CZ Audit Event for [ITI-65] Document Source](StructureDefinition-cz-auditEventIti65Source.html) profile,
- the **Document Recipient** according to the [CZ Audit Event for [ITI-65] Document Recipient](StructureDefinition-cz-auditEventIti65Recipient.html) profile.

The audit event SHALL record the node identities from mTLS and the details of the IUA access token as defined in [Recording the communication security](iti-20.html#recording-the-communication-security). The AAfD records the receipt of the document (healthcare provider, healthcare professional, RID or DRID, SubmissionSet identifier), including unsuccessful attempts, e.g. a rejection because the healthcare provider in the token does not match the document metadata.
