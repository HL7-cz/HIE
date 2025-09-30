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

The request Bundle SHALL follow the [CH MHD Provide Document Bundle Comprehensive](StructureDefinition-cz-mhd-providedocumentbundle-comprehensive.html).

The `DocumentReference.content.attachment.url` value SHALL point to a Binary resource included in the Bundle (see
[Resolving references in Bundles](https://hl7.org/fhir/R4/bundle.html#references) for how to create a valid reference).

#### Provide Document Bundle Response Message

The response Bundle SHALL follow the [CH MHD Provide Document Bundle Comprehensive Response](StructureDefinition-cz-mhd-providedocumentbundle-comprehensive-response.html).

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Document Source** is [MHD Document Source](CapabilityStatement-CZ-MHD-DocumentSource.html).

The CapabilityStatement resource for the **Document Recipient** is [MHD Document Recipient](CapabilityStatement-CZ-MHD-DocumentRecipient.html).

### Security Consideration

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with 
server certificates. 

The transaction SHALL use client authentication and authorization using one of the following strategies:
1. Use an extended access token defined in IUA conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.
2. or, use mutual authentication (mTLS) on the transport layer in combination with a XUA token for authorization from the Get X-User Assertion transaction (Annex 5.1 1.6.4.2). The XUA token SHALL be conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.

#### Security Audit Considerations

It will be added in future (ATNA).

##### Document Source Audit


##### Document Recipient Audit
