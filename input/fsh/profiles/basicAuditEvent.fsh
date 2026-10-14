Profile: CZ_AuditEvent
Id: cz-auditEvent
Parent: AuditEvent
Title: "CZ Audit Event"
Description: "CZ FHIR profile on AuditEvent."

* entity ^slicing.discriminator.type = #value
* entity ^slicing.discriminator.path = "type.code"
* entity ^slicing.discriminator.type = #value
* entity ^slicing.discriminator.path = "role.code"
* entity ^slicing.rules = #open
* entity ^slicing.ordered = false
* entity contains patient 0..1
* entity[patient].what only Reference(CZ_PatientCore)
* entity[patient].what.identifier 1..1
  * ^short = "Identifikátor pacienta (RID nebo DRID)"
  * ^comment = "RID, případně dočasný RID (DRID) přidělený Kmenovým registrem pacientů."
* entity[patient].what.identifier.system 1..1
