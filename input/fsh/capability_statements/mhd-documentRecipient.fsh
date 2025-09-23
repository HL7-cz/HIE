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
* rest.security.description = "TLS SHALL be used together with IUA extended access token"
* rest.interaction.code = #transaction
* rest.interaction.documentation = "https://hl7.cz/fhir/hie/StructureDefinition/cz-mhd-providedocumentbundle-comprehensive"