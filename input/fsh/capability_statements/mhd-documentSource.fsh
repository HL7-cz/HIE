Instance: CZ-MHD-DocumentSource
InstanceOf: CapabilityStatement
Usage: #definition
* name = "CZ_MHD_DocumentSource"
* title = "MHD Document Source (client)"
* status = #active
* date = "2025-09-23"
* description = "CapabilityStatement for Actor MHD Document Source (client)."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #client
* rest.documentation = "MHD client sends documents and metadata to the Document Recipient [ITI-65]."
* rest.security.cors = false
* rest.security.description = "TLS SHALL be used together with IUA extended access token"
* rest.interaction.code = #transaction
* rest.interaction.documentation = "https://hl7.cz/fhir/hie/StructureDefinition/cz-mhd-providedocumentbundle-comprehensive"