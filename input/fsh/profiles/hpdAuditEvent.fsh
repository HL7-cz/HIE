Profile: CZ_HPDAuditEvent
Id: cz-hpdAuditEvent
Parent: AuditEvent
Title: "CZ HPD Audit Event"
Description: "CZ FHIR profile on AuditEvent for HPD event."

* type from $auditEventTypeVS (extensible)
* subtype from CZ_HPDAuditEventTypeVs (extensible)
* subtype 1..1
  * ^short = "Event Type"
* recorded 1..1
  * ^short = "Event Date and Time"

* agent 1..
  * ^short = "Notification service"
* agent.who 0..1
  * identifier 1..1
    * ^short = "Identifier if applicable"
* agent.name 1..
  * ^short = "Name"
* agent.requestor 1..1
  * ^short = "If notification service is Initiator"

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

* entity contains HealthProfessional 1..*
* entity[HealthProfessional] 1..1
  * ^short = "Health Professional"
* entity[HealthProfessional].what.identifier 1..1
  * ^short = "Identifier for HCP (KRZP)"
  * system = "https://ncez.mzcr.cz/fhir/sid/krzp"