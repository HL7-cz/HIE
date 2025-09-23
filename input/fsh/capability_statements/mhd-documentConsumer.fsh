Instance: CZ-MHD-DocumentConsumer
InstanceOf: CapabilityStatement
Usage: #definition
* name = "CZ_MHD_DocumentConsumer"
* title = "MHD Document Consumer (client)"
* status = #active
* date = "2025-09-23"
* description = "CapabilityStatement for Actor MHD Document Consumer (client)."
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* rest.mode = #client
* rest.documentation = "MHD client requests a list of DocumentReference Resources, matching the supplied set of criteria, from the Document Responder [ITI-67]. MHD client requests a document from the Document Responder [ITI-68]."
* rest.security.cors = false
* rest.security.description = "TLS SHALL be used together with IUA extended access token"
* rest.resource[0].type = #DocumentReference
* rest.resource[=].profile = "https://hl7.cz/fhir/hie/StructureDefinition/cz-mhd-documentreference-comprehensive"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].searchParam[0].name = "_id"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Logical id of this artifact"
* rest.resource[=].searchParam[+].name = "_lastUpdated"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "When the resource version last changed"
* rest.resource[=].searchParam[+].name = "author"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-author"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Who and/or what authored the document"
* rest.resource[=].searchParam[+].name = "category"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-category"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Categorization of document"
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "When this document reference was created"
* rest.resource[=].searchParam[+].name = "event"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-event"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Main clinical acts documented"
* rest.resource[=].searchParam[+].name = "facility"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-facility"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Kind of facility where patient was seen"
* rest.resource[=].searchParam[+].name = "format"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-format"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Format/content rules for the document"
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "The identifier for this DocumentReference"
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Who/what is the subject of the document"
* rest.resource[=].searchParam[+].name = "period"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-period"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "Time of service that is being documented"
* rest.resource[=].searchParam[+].name = "related"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-related"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Related Resource"
* rest.resource[=].searchParam[+].name = "security-label"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-security-label"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Document security-tags"
* rest.resource[=].searchParam[+].name = "setting"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-setting"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Additional details about where the content was created (e.g. clinical specialty)"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "current | superseded | entered-in-error"
* rest.resource[=].searchParam[+].name = "type"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-type"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Kind of document (LOINC if possible)"
* rest.resource[+].type = #List
* rest.resource[=].profile = "https://hl7.cz/fhir/hie/StructureDefinition/cz-mhd-submissionset-comprehensive"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].searchParam[0].name = "_id"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Logical id of this artifact"
* rest.resource[=].searchParam[+].name = "_lastupdated"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "When the resource version last changed"
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "This parameter, of type token, specifies the code.coding value supplied in the List Resource. The value of the code element indicates the List of type SubmissionSet or Folder as indicated."
* rest.resource[=].searchParam[+].name = "creation"
* rest.resource[=].searchParam[=].definition = "https://profiles.ihe.net/ITI/MHD/SearchParameter/DocumentReference-Creation"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "When this document was created"
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "This parameter, of type date, specifies the time when the List was created."
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "This parameter, of type token, specifies an identifier for this List. The search results represent the results of a search on List.masterIdentifier and List.identifier. See ITI TF-2: Appendix Z.2 for additional constraints on the use of the token search parameter type."
* rest.resource[=].searchParam[+].name = "subject"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "This parameter is of type Reference(Patient). The Document Consumer may get this reference through the use of the PDQm or PIXm Profiles, or by some other method. When the patient parameter is used, the Patient reference would need to be accessible to both the Document Consumer and the Document Responder."
* rest.resource[+].type = #Binary
* rest.resource[=].interaction.code = #read
* rest.interaction.code = #search-system
