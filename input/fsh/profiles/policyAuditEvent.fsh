Profile: CZ_PolicytAuditevent
Id: cz-policyAuditEvent
Parent: AuditEvent
Title: "CZ Policy Audit Event"
Description: "CZ FHIR profile on AuditEvent for policy."

* type from $auditEventTypeVS (extensible)
* subtype from CZ_PolicyAuditEventTypeVs (extensible)
* subtype 1..1
  * ^short = "Event Type"

* recorded 1..1
  * ^short = "Event Date and Time"

* agent 1..
  * ^short = "Participants"

* agent.role 1..1
* agent.role from CZ_ParticipantsVs (required)
* agent.role 1..1
  * ^short = "role (PAT, HCP)"

* agent.who 0..1
* agent.who.identifier 1..1
  * ^short = "Identifier if applicable"
* agent.name 1..
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
* entity contains Patient 0..1
* entity[Patient] 1..1
  * ^short = "Patient"
* entity[Patient].what.identifier 1..1
  * ^short = "RID"
* entity contains Resource 0..1
* entity[Resource]
  * ^short = "Resource (HCP, Group)"
* entity[Resource].what.identifier 0..1
  * ^short = "Identifier: HCP (KRZP)"
  * ^short = "Identifier: KRZP for HCP"
* entity[Resource].role 1..
* entity[Resource].role from CZ_ParticipantsVs (required)
* entity[Resource].role 1..1
  * ^short = "role (HCP, GRP)"