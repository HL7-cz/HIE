Profile: CZMhdDocumentReferenceComprehensive
Parent: DocumentReference
Id: cz-mhd-documentreference-comprehensive
Title: "CZ MHD DocumentReference Comprehensive"
Description: "CZ MHD Profile on DocumentReference"
* obeys cz-mhd
//* extension contains
//     ChExtDeletionStatus named deletionStatus 0..1  and
//     ChExtAuthorAuthorRole named originalProviderRole 1..1 
//* extension[deletionStatus] ^short = "Deletion status of the document"
//* extension[originalProviderRole] ^short = "Original ProviderRole: This extra metadata attribute SHALL be set by the Document Source actor to the role value of the current user and SHALL NOT be updated by Update Initiator or Document Administrator actors."
* masterIdentifier 1.. 
* masterIdentifier only $IHE.MHD.UniqueIdIdentifier
* identifier 
* status 
* status ^short = "current | superseded"
* status ^comment = "approved -> status=current, deprecated -> status=superseded"
* docStatus ..0
* docStatus ^comment = "These HL7 FHIR elements are not used in XDS, therefore would not be present. Document Consumers should be robust to these elements holding values."
* type 1.. 
* type ^binding.strength = #required
* category 1..1 
* category ^binding.strength = #required
* subject 1.. 
* subject.identifier 1..1
//* subject.identifier only EPRSPIDIdentifier TODO nahradit KRZP id pacienta
* subject ^comment = "Not a contained resource. The identifier points to an existing patient in the XDS Affinity Domain."
* author only Reference
* author 
* author ^comment = "Contained resource."
* author ^type.aggregation = #contained
* authenticator only Reference
* authenticator ^type.aggregation = #contained
* custodian ..0
* relatesTo 
* relatesTo ^comment = "See ITI TF-2c: 3.65.4.1.2.3"
* description 
* securityLabel 1.. 
* securityLabel ^comment = "Note: This is NOT the DocumentReference.meta, as that holds the meta tags for the DocumentReference itself."
* securityLabel ^binding.strength = #required
* content ..1
* content.attachment 
* content.attachment.contentType 1.. 
//* content.attachment.contentType from $DocumentEntry.mimeType (required)
* content.attachment.language 1.. 
//* content.attachment.language from $DocumentEntry.languageCode (required)
* content.attachment.data ..0
* content.attachment.data ^comment = "These HL7 FHIR elements are not used in XDS, therefore would not be present. Document Consumers should be robust to these elements holding values."
* content.attachment.url 1..1 
* content.attachment.url ^short = "The ITI-68 endpoint to use, or a reference to the Binary resource in the Bundle."
* content.attachment.url ^comment = "When providing the document, this URL SHALL point to the Binary resource wrapping
the document content (which SHALL be included in the Bundle). When retrieving the DocumentReference, this URL SHALL
be the the one to use in ITI-68 transactions to retrieve the document content."
* content.attachment.size 
* content.attachment.hash 
* content.attachment.title 1..1 
* content.attachment.creation 1.. 
* content.format 1.. 
//* content.format from $DocumentEntry.formatCode (required)
* content.format ^binding.description = "Document Format Codes."
* context 1..
* context.event 
//* context.event from $DocumentEntry.eventCodeList (required)
* context.period 
* context.facilityType 1.. 
//* context.facilityType from $DocumentEntry.healthcareFacilityTypeCode (required)
* context.facilityType ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
* context.facilityType ^binding.extension.valueString = "DocumentC80FacilityType"
* context.facilityType ^binding.description = "XDS Facility Type."
* context.practiceSetting 1.. 
//* context.practiceSetting from $DocumentEntry.practiceSettingCode (required)
* context.practiceSetting ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
* context.practiceSetting ^binding.extension.valueString = "DocumentC80PracticeSetting"
* context.practiceSetting ^binding.description = "Additional details about where the content was created (e.g. clinical specialty)."
* context.sourcePatientInfo 1.. 
* context.sourcePatientInfo only Reference(Patient) //CZ_PatientCore hazi chybu
* context.sourcePatientInfo ^comment = "Contained Patient resource with Patient.identifier.use element set to ‘usual’.\r\n\r\nIndicates that the data within the XDS document entry be represented as a contained resource. See Section 4.5.4.4.7"
* context.sourcePatientInfo ^type.aggregation = #contained
* context.related ^slicing.discriminator.type = #value
* context.related ^slicing.discriminator.path = "identifier"
* context.related ^slicing.rules = #open
* context.related ^comment = "May be filled with URL pointers to Resources or Identifiers found in referenceIdList"
* context.related contains
    StudyInstanceUID 0..1 
//* context.related[StudyInstanceUID].identifier 
//* context.related[StudyInstanceUID].identifier only DicomStudyInstanceUidIdentifier
//* context.related[StudyInstanceUID].identifier ^short = "Requirements on XDS-I.b: When a Imaging Document Source provides a document to the Document Repository, it must provide the StudyInstanceUID, found in the to be registered KOS object, in the referenceIdList (urn:ihe:iti:xds:2013:referenceIdList) attribute of the documentEntry metadata."

Invariant: cz-mhd
Description: "The DocumentReference needs to conform to IHE.MHD.Comprehensive.DocumentReference"
* severity = #error
* expression = "conformsTo('https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Comprehensive.DocumentReference')"

// Extension: CZExtDeletionStatus
// Id: cz-ext-deletionstatus
// Title: "CZ Extension Deletion Status"
// Description: "Extension Deletion Status for DocumentReference"
// Context: DocumentReference
// * url only uri
// * url 
// * valueCoding 1.. 
// * valueCoding only Coding
// * valueCoding from $DocumentEntry.Ext.EprDeletionStatus (required)
// * valueCoding ^short = "Value of extension"

// Extension: CzExtAuthorAuthorRole
// Id: cz-ext-author-authorrole
// Title: "CZ Extension Author AuthorRole"
// Description: "Extension Author AuthorRole for SubmissionSet and DocumentEntry"
// Context: List, DocumentReference
// * url only uri
// * url 
// * valueCoding 1.. 
// * valueCoding only Coding
// * valueCoding from $DocumentEntry.originalProviderRole (required)
// * valueCoding ^short = "Value of extension"