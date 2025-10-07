// Server Actor
Instance: CZ-ATNA-AuditRecordRepository
InstanceOf: CapabilityStatement
Usage: #definition
* name = "CZ_ATNA_Audit_Record_Repository"
* title = "ATNA Audit Record Repository (server)"
* description = "CapabilityStatement for Server Actor in the IHE IT Infrastructure Technical Framework Supplement Add RESTful ATNA."
* rest.mode = #server
* status = #active
* experimental = false
* date = "2024-01-08"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest
  * documentation = "IHE ITI ATNA ITI-20 endpoint"
  * interaction[+]
    * code = #batch
    * documentation = "ITI-20 Send Audit Bundle Request Message - FHIR Feed Interaction"
  * resource[+]
    * type = #AuditEvent
    * interaction[+].code = #create
    * versioning = #no-version
    * supportedProfile[+] = "http://fhir.cz/ig/hie/StructureDefinition/AuditEventIti65Recipient"
    * supportedProfile[+] = "http://fhir.cz/ig/hie/StructureDefinition/AuditEventIti65Source"
    * supportedProfile[+] = "http://fhir.cz/ig/hie/StructureDefinition/AuditEventIti67Consumer"
    * supportedProfile[+] = "http://fhir.cz/ig/hie/StructureDefinition/AuditEventIti67Responder"
    * supportedProfile[+] = "http://fhir.cz/ig/hie/StructureDefinition/AuditEventIti68Consumer"