Instance: CZ-MHD-DocumentRecipient
InstanceOf: CapabilityStatement
Usage: #definition
* name = "CZ_MHD_DocumentRecipient"
* title = "MHD Document Recipient (server)"
* status = #active
* date = "2025-09-23"
* description = "CapabilityStatement for Actor MHD Document Recipient (server)."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #server
* rest.documentation = "MHD server accepts the document and metadata sent from the Document Source [ITI-65]."
* rest.security.cors = false
* rest.security.description = "mTLS (TLS 1.3, min. TLS 1.2) with mutual node authentication according to ATNA [ITI-19] using certificates issued by the MZCR certification authority SHALL be used together with an IUA access token (JWT) issued by the central eHealth authorization server [ITI-71] and conveyed according to [ITI-72]."
* rest.security.service[+] = http://terminology.hl7.org/CodeSystem/restful-security-service#OAuth "OAuth"
* rest.security.service[+] = http://terminology.hl7.org/CodeSystem/restful-security-service#Certificates "Certificates"
* rest.interaction.code = #transaction
* rest.interaction.documentation = "https://hl7.cz/fhir/hie/StructureDefinition/cz-mhd-providedocumentbundle-comprehensive"