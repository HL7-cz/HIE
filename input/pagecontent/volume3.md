This section describes the content of the audit events that an AAfD records in its audit log and makes available to the central Activity Journal (Žurnál činností) through [Retrieve ATNA Audit Event [ITI-81]](iti-81.html). Audit records are retrieved by data subject – a patient, a healthcare professional or a healthcare provider – and are also used to evaluate security events.

There are the following categories of audit events in the context of HIE:

1. **Document management** – e.g. a patient's document has been uploaded to the AAfD or a list of document metadata has been retrieved.
2. **Access check** – the AAfD has checked in the central Consent Registry (Registr oprávnění) whether the patient has granted or restricted access to their health records. The AAfD only reads permissions from the Consent Registry; it does not set them.
3. **Access to the audit trail** – the Activity Journal has retrieved the audit records of a patient, a healthcare professional or a healthcare provider.
4. **Security events** – e.g. a connection rejected because of an invalid certificate (mTLS) or a request rejected because of an invalid access token. These events have no code of their own in the table below; they are recorded with DICOM event types as defined in [Failed authentication and authorization](iti-20.html#failed-authentication-and-authorization).

Each category is described as a content profile. The content profiles are based on the [AuditEvent](http://hl7.org/fhir/R4/auditevent.html) resource, which has [mapping rules to the DICOM audit message format](http://hl7.org/fhir/R4/auditevent-mappings.html#dicom) and thus allows mapping to ATNA.

Recording of the communication security (node identities from mTLS, healthcare provider and IUA access token identifier) is common to all categories and is described in [Recording the communication security](iti-20.html#recording-the-communication-security).

### Audit Trail Event Types

The following event types are defined in the [CZ Audit Trail Event Types](CodeSystem-cz-atc-cs.html) code system and SHALL be supported by an AAfD.

| Type | Description | Content profile | Optionality |
|------|-------------|-----------------|-------------|
| ATC_DOC_CREATE | Document upload | [Document Audit Event Content Profile](#document-audit-event-content-profile) | R |
| ATC_DOC_READ | Document retrieval | [Document Audit Event Content Profile](#document-audit-event-content-profile) | R |
| ATC_DOC_UPDATE | Document or document metadata update | [Document Audit Event Content Profile](#document-audit-event-content-profile) | R |
| ATC_DOC_DELETE | Document removal | [Document Audit Event Content Profile](#document-audit-event-content-profile) | R |
| ATC_DOC_SEARCH | Document search | [Document Audit Event Content Profile](#document-audit-event-content-profile) | R |
| ATC_POL_ACCESS_CHECK | Access check in the Consent Registry | [Access Check Audit Event Content Profile](#access-check-audit-event-content-profile) | R |
| ATC_LOG_READ | Access to the audit trail | [Access Audit Trail Content Profile](#access-audit-trail-content-profile) | R |
{:class="table table-bordered"}

_Table 1: Audit Trail Event Types_

### Document Audit Event Content Profile

This content profile describes audit events related to document management. The following data elements SHALL be provided:

| Data element | Description | Value |
|--------------|-------------|-------|
| Event type | | Document upload, document retrieval, document or document metadata update, document removal, document search |
| Event date and time | | FHIR instant |
| **Participants** | | |
| Initiator | Patient | Name, RID or DRID |
| | Patient representative | Name, RID or DRID |
| | Healthcare professional | Name, KRZP identifier |
| | Assistant of a healthcare professional | Name, KRZP identifier |
| | Technical user | Name, identifier |
| Responsible<sup>1</sup> | Patient | Name, RID or DRID |
| | Healthcare professional | Name, KRZP identifier |
| Healthcare provider | Provider identified in the IUA access token | Name, company ID (IČO) |
| Purpose of use | | NORM, EMER, AUTO |
| **Patient** | Concerned patient | RID or DRID |
| **Document**<sup>2</sup> | Document type | typeCode |
| | Document reference | uniqueId, repositoryUniqueId, homeCommunityId |
| | Document title | title |
{:class="table table-bordered"}

<sup>1</sup> If different from the initiator (e.g. a patient representative acts on behalf of a patient, then the patient is responsible).<br/>
<sup>2</sup> Required for document upload, retrieval, update and removal, but not for document search.

_Table 2: Document Audit Event Data Elements_

The structure of the audit events of the individual MHD transactions is defined by the [ITI-65](StructureDefinition-cz-auditEventIti65Source.html), [ITI-66](StructureDefinition-cz-auditEventIti66Consumer.html), [ITI-67](StructureDefinition-cz-auditEventIti67Consumer.html) and [ITI-68](StructureDefinition-cz-auditEventIti68Consumer.html) profiles and the general [CZ Document Audit Event](StructureDefinition-cz-documentAuditEvent.html) profile.

### Access Check Audit Event Content Profile

Before making health records available, the AAfD checks in the central Consent Registry whether the patient has granted or restricted access for a third party (MZ REST or the planned [ITI-108] transaction). The AAfD records every such check as an audit event. The following data elements SHALL be provided:

| Data element | Description | Value |
|--------------|-------------|-------|
| Event type | | Access check in the Consent Registry (ATC_POL_ACCESS_CHECK) |
| Event date and time | | FHIR instant |
| **Participants** | | |
| AAfD | AAfD performing the check | Name, HCID |
| Consent Registry | Central eHealth service | Name, service address |
| Healthcare provider | Provider identified in the IUA access token | Name, company ID (IČO), token identifier (jti) |
| Healthcare professional | Professional for whom access is checked (if present in the request context) | Name, KRZP identifier |
| Purpose of use | | NORM, EMER, AUTO |
| **Patient** | Patient whose records are concerned | RID or DRID |
| **Decision** | Decision of the Consent Registry | permit, restrict, deny |
| Transaction | `traceparent` of the transaction in which the check was performed (ITI-66, ITI-67, ITI-68) | traceparent |
{:class="table table-bordered"}

_Table 3: Access Check Audit Event Data Elements_

The structure is defined by the [CZ Access Check Audit Event](StructureDefinition-cz-policyAuditEvent.html) profile, see also the [example](AuditEvent-CZ-PolicyAuditEventExample.html).

### Access Audit Trail Content Profile

This content profile describes the audit event recorded by the Audit Record Repository when the Activity Journal retrieves audit records with [ITI-81](iti-81.html). The following data elements SHALL be provided:

| Data element | Description | Value |
|--------------|-------------|-------|
| Event type | | Access to the audit trail (ATC_LOG_READ) |
| Event date and time | | FHIR instant |
| **Participants** | | |
| Initiator | Activity Journal (central eHealth service) | Identity from the mTLS certificate and the access token |
| Audit Record Repository | Repository that returned the audit records | Name, HCID of the AAfD |
| **Query subject** | Patient | RID or DRID |
| | Healthcare professional | KRZP identifier |
| | Healthcare provider | Company ID (IČO) |
{:class="table table-bordered"}

_Table 4: Access Audit Trail Data Elements_

#### Examples

To be added.
