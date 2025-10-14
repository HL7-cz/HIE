Profile: CZ_DocumentAuditEvent
Id: cz-documentAuditEvent
Parent: AuditEvent
Title: "CZ Document Audit Event"
Description: "CZ FHIR profile on AuditEvent for document."

* type from $auditEventTypeVS (extensible)
* subtype 1.. 
* subtype ^slicing.discriminator.type = #value
* subtype ^slicing.discriminator.path = "system"
* subtype ^slicing.rules = #open
* subtype ^slicing.ordered = false
* subtype contains DocumentAuditEventType 1..1
* subtype[DocumentAuditEventType] from CZ_DocumentAuditEventTypeVs (required)

* recorded 1..1
  * ^short = "Event Date and Time"

* purposeOfEvent 1..1
* purposeOfEvent from CZ_HIEPurposeOfUseVs (required) 
  * ^short = "Purpose of Event"

* agent 1..1
  * ^short = "Participants"
* agent.role 1..1
* agent.role from CZ_ParticipantsVs (required)
  * ^short = "role (PAT, HCP, GRP)"
* agent.who 0..1
* agent.who.identifier 1..1
  * ^short = "Identifier if applicable"
* agent.name 0..1
  * ^short = "Name"
* agent.requestor 1..1
  * ^short = "If participant is Initiator"

* entity 1..
* entity ^slicing.discriminator.type = #value
* entity ^slicing.discriminator.path = "type.code"
* entity ^slicing.discriminator.type = #value
* entity ^slicing.discriminator.path = "role.code"
* entity ^slicing.rules = #open
* entity ^slicing.ordered = false
* entity contains Patient 1..
* entity[Patient] 1..1
  * ^short = "Patient"
* entity[Patient].what.identifier 1..1
  * ^short = "RID"
* entity contains Document 0..1
* entity[Document] 1..1
  * ^short = "Document"
* entity[Document].what.identifier 1..1
  * ^short = "XDSDocumentEntry.uniqueId"
* entity[Document].what.identifier only CZ_UniqueIDIdentifier

* entity[Document].detail 3..
* entity[Document].detail ^slicing.discriminator.type = #value
* entity[Document].detail ^slicing.discriminator.path = "type"
* entity[Document].detail ^slicing.rules = #open
* entity[Document].detail ^slicing.ordered = false
* entity[Document].detail contains repositoryUniqueId 1..1 
  * ^short = "RepositoryUniqueId"
* entity[Document].detail contains DocumentType 1..1
  * ^short = "DocumentType"
* entity[Document].detail contains Title 1..1
  * ^short = "Title"

// Lze sem vlozit i Communiky ID pro AFFD
