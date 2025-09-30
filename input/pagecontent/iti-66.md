This section corresponds to transaction [ITI-66] of the IHE Technical Framework. Transaction [ITI-66] is used by the Document Consumer and Document Responder Actors. This transaction is used to locate and return metadata for previously stored document submission sets or folders.

### Scope

The Find Document Lists [ITI-66] transaction is used to find List Resources that satisfy a set of parameters. It is equivalent to the: 

* FindSubmissionSets query in the Registry Stored Query [\[ITI-18\]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html) transaction, as documented in [ITI TF-2: 3.18.4.1.2.3.7.2](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html#3.18.4.1.2.3.7.2). 
* FindFolders query in the Registry Stored Query [\[ITI-18\]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html) transaction, as documented in [ITI TF-2: 3.18.4.1.2.3.7.3](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html#3.18.4.1.2.3.7.3). 

The result of the query is a Bundle containing List Resources that match the query parameters.

### Actors Roles

**Table 1: Actor Roles**

|Actor | Role |
|-------------------+--------------------------|
| Document Consumer    | Requests List Resources, matching the supplied set of criteria, from the Document Responder |
| Document Responder | Returns List Resources that match the search criteria provided by the Document Consumer |
{: .grid}

### Referenced Standards

**FHIR-R4** [HL7 FHIR Release 4.0](http://www.hl7.org/FHIR/R4)

### Messages

<div>
{%include ITI-66-seq.svg%}
</div>

<br clear="all">

**Figure 1: Find Document Lists Interactions**

#### Find Document References Response Message

The response Bundle SHALL follow the [CZ MHD Find Document References Comprehensive Response message](StructureDefinition-cz-mhd-finddocumentlists-comprehensive-bundle.html).

##### Federated Cross Community Access Option

If a Document Responder does not respond, an OperationOutcome with a severity warning SHALL be added to the aggregated results indicating the community does not respond.

For matching DocumentReferences returned by the Document Responder, the Document Responder SHALL ensure by rewriting the id and attachment.url that follow-up reads, updates or document retrieval will be handled by same Document Responder actor. Any id, url rewrite SHALL be resolvable for at least an hour.

#### CapabilityStatement Resource

The CapabilityStatement resource for the **Document Consumer** is [MHD Document Consumer](CapabilityStatement-CZ-MHD-DocumentConsumer.html).

The CapabilityStatement resource for the **Document Responder** is [MHD Document Responder](CapabilityStatement-CZ-MHD-DocumentResponder.html).

### Security Consideration

The transaction SHALL be secured by Transport Layer Security (TLS) encryption and server authentication with
server certificates. Transactions across communities SHALL use mTLS.

The transaction SHALL use client authentication and authorization using one of the following strategies:
1. Use an extended access token defined in IUA conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.
2. or, use mutual authentication (mTLS) on the transport layer in combination with a XUA token for authorization from the Get X-User Assertion transaction (Annex 5.1 1.6.4.2). The XUA token SHALL be conveyed as defined in the [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72) transaction.

#### Security Audit Considerations

Will be added in future (ATNA)

##### Document Consumer Audit


##### Document Responder Audit