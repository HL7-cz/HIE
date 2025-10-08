// Client Actor
Instance: CZ-ATNA-AuditCreator
InstanceOf: CapabilityStatement
Usage: #definition
* name = "CZ_ATNA_Audit_Creator"
* title = "ATNA Audit Creator (client)"
* description = "CapabilityStatement for Client Actor in the IHE IT Infrastructure Technical Framework Supplement Add RESTful ATNA."
* rest.mode = #client
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
    * supportedProfile[+] = "https://hl7.cz/fhir/hie/StructureDefinition/CzAuditEventIti65Recipient"
    * supportedProfile[+] = "https://hl7.cz/fhir/hie/StructureDefinition/CzAuditEventIti65Source"
    * supportedProfile[+] = "https://hl7.cz/fhir/hie/StructureDefinition/CzAuditEventIti67Consumer"
    * supportedProfile[+] = "https://hl7.cz/fhir/hie/StructureDefinition/CzAuditEventIti67Responder"
    * supportedProfile[+] = "https://hl7.cz/fhir/hie/StructureDefinition/CzAuditEventIti68Consumer"