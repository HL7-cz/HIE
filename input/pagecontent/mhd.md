### Introduction 

This implementation specification focuses on the national implementation of the MHD (Mobile access to Health Documents) profile within the environment of Accredited Affinity Domains (AAfD) and the central eHealth services (EZ), based on the national [Standard of Accredited Affinity Domains](https://ncez.mzcr.cz/sites/default/files/media-documents/Standard%20Do%C4%8Dasn%C3%A9%20ulo%C5%BEi%C5%A1t%C4%9B%20v%200.10.pdf). 

The following diagram illustrates the core architecture of the solution and the interactions between systems: 

<div>
<img src="schema.png" class="figure-img img-responsive img-rounded center-block" width="40%">
<p><strong>Figure 1: Diagram of the core architecture</strong></p>
<p> </p>
</div>

**Health Document Publishing System** 

The provider’s primary system that publishes documents and metadata via MHD and related interfaces. 

**Central eHealth Services** 

Provide the Patient Identity Registry (KRP), Authorization Registry, code systems and terminology, time-stamping, and audit services. They also ensure query routing and federation across AAfDs using the Home Community ID (HCID). 

**Publishing and Consuming AAfD** 

Domain components that support document submission and search, identity and authorization verification, notifications, and auditing. 

**Health Document Consuming System**

The end-user application (e.g., clinical system or portal) that, once authorized, can search for and retrieve documents, and may also receive notifications of newly published records. 

The diagram highlights the supported IHE transactions (ITI-65, ITI-66, ITI-67, ITI-68, DSUBm/ITI-112, RESTful ATNA/ITI-20) as well as the national eHealth interfaces (e.g., Authorization Registry, Time Authority, code systems). This architecture constitutes the foundation for interoperable sharing of healthcare documentation in the Czech Republic. 

### Scope 

The national MHD specification for the Czech Republic requires support for the transactions ITI-65, ITI-66, ITI-67, and ITI-68 to enable the sharing of healthcare documents within Accredited Affinity Domains (AAfD). In the Czech context, ITI-66 (Find Document Lists) is mandatory for cross-domain searching using the Home Community ID (HCID). 

### Use cases 

#### Cross-domain search and retrieval 

A healthcare provider in AAfD-B issues a query (ITI-66/67) for a patient’s documents. The home AAfD uses the HCID to forward the request to neighboring AAfDs (including AAfD-A) and aggregates the returned results. From the retrieved metadata, the provider selects a specific record, and an ITI-68 request is then directed to the repository in AAfD-A, from which the document is securely retrieved. All steps are authenticated through IUA and audited via RESTful ATNA. 

#### Notification of new documents

When a new document is published in an AAfD, the system uses the DSUBm profile (ITI-112) to send a notification to the registered healthcare provider who previously subscribed to this event. The notification contains basic metadata (e.g., patient identifier RID, document type, reference to the DocumentReference) so that the provider knows a new record is available. The provider can then initiate a search and retrieval of the document using standard MHD transactions (ITI-66 through ITI-68). 

#### Metadata update or invalidation 

If a healthcare professional needs to correct or invalidate a document, the primary system issues a request for change. In the AAfD environment, this is typically handled by publishing a new version of the document and invalidating the original record. In contrast, the Temporary Repository provides dedicated services for Update/Invalidate (PUT) operations. This ensures that users always work with valid and up-to-date metadata and content. 

### Actors and transactions  

{:class="table table-bordered"}
| Actor                                         | Role                      | Main Transactions  |
|-----------------------------------------------|---------------------------|-------------|
| Document Source                               | Publishes documents and metadata into the AAfD     | ITI-65 Provide Document Bundle      |
| Document Consumer                             | Searches for and retrieves documents            | ITI-66 Find, ITI-67 Find References, ITI-68 Retrieve   |
| Document Responder                            | Responds to search queries and returns metadata   | ITI-66, ITI-67  |
| Document Recipient                             | Receives published documents into the repository    | ITI-65   |
| Notification Recipient                            | Receives notifications of newly published documents   | DSUBm / ITI-112    |


<figcaption ID="1">Table 1: Actors and transactions .</figcaption>
<p> </p>

### Required Actor Groupings 

{:class="table table-bordered"}
| Actor                                         | Required grouping                  | Note   |
|-----------------------------------------------|---------------------------|-------------|
| Document Source                               | IUA klient, ATNA audit repository    | Publishing documents requires authorization and audit logging      |
| Document Consumer                             | IUA klient, ATNA audit repository            | Searching and retrieving documents requires authorization and audit logging     |
| Document Responder (Registry)                 | IUA Authorization Server, ATNA audit repository  | Query responses require token validation and audit logging |
| Document Recipient (Repository)               | Document Registry, ATNA audit repository   | Responsible for storing documents and maintaining metadata in the AAfD   |
| Notification Recipient                            | IUA klient, ATNA audit repository    | Receives notifications about newly published documents     |


<figcaption ID="1">Table 2: Required Actor Groupings.</figcaption>
<p> </p>

All AAfD actors must also interoperate with central eHealth services: the Core Patient Registry (RID patient identifier), Authorization Registry, Terminology Server, and Time Authority. 

### Sequence 

The home Accredited Affinity Domain (AAfD) receives an ITI-66 query containing the unique patient identifier (RID). Using the HCID index, it identifies relevant partner AAfDs and forwards the query to them. The home AAfD then aggregates the returned DocumentReference records and provides the user with a consolidated result set. When a specific record is selected, an ITI-68 Retrieve Document request is directed to the repository of the respective AAfD where the document is stored. 

### Security 

Authentication and authorization are carried out in accordance with the IUA profile (OAuth 2.0 / JWT). All communication is secured with TLS 1.2+, and each transaction is logged using RESTful ATNA (ITI-20). Patient identity and healthcare professional permissions are validated against the Core Patient Registry (KRPZS/KRP) and the Authorization and Mandates Registry (RO). 

### Terminology 

Values for classification, document types, and formats are derived from the national Terminology Server for eHealth. Patient identity within the transactions is consistently represented by the RID from the Core Patient Registry (KRP).