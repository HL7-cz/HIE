// Server Actor
Instance: CZ-ATNA-AuditRecordRepository
InstanceOf: CapabilityStatement
Usage: #definition
* name = "CZ_ATNA_Audit_Record_Repository"
* title = "ATNA Audit Record Repository (server)"
* description = "CapabilityStatement for Server Actor in the IHE IT Infrastructure Technical Framework Supplement Add RESTful ATNA."
* rest.mode = #server
* rest.security.cors = false
* rest.security.service[+] = http://terminology.hl7.org/CodeSystem/restful-security-service#OAuth "OAuth"
* rest.security.service[+] = http://terminology.hl7.org/CodeSystem/restful-security-service#Certificates "Certificates"
* rest.security.description = "mTLS (TLS 1.3, min. TLS 1.2) with mutual node authentication according to ATNA [ITI-19] using certificates issued by the MZCR certification authority SHALL be used together with an IUA access token (JWT) issued by the central eHealth authorization server [ITI-71] and conveyed according to [ITI-72]."
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
    * supportedProfile[+] = "https://hl7.cz/fhir/hie/StructureDefinition/cz-auditEventIti65Recipient"
    * supportedProfile[+] = "https://hl7.cz/fhir/hie/StructureDefinition/cz-auditEventIti65Source"
    * supportedProfile[+] = "https://hl7.cz/fhir/hie/StructureDefinition/cz-auditEventIti67Consumer"
    * supportedProfile[+] = "https://hl7.cz/fhir/hie/StructureDefinition/cz-auditEventIti67Responder"
    * supportedProfile[+] = "https://hl7.cz/fhir/hie/StructureDefinition/cz-auditEventIti68Consumer"