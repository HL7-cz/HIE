Profile: CZ_FindDocumentReferencesComprehensiveResponse
Parent: Bundle
Id: cz-mhd-finddocumentreference-comprehensive-bundle
Title: "CZ MHD Find Document References Comprehensive Response message"
Description: "A profile on the Find Document References Comprehensive Response message (ITI-67)"
* type = #searchset (exactly)
* total 1..
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry.fullUrl 1.. 
* entry.fullUrl obeys cz-mhd-bdl-1

* entry contains 
    DocumentReference 0..* and 
    OperationOutcome 0..1
* entry[DocumentReference] ^short = "DocumentReference"
* entry[DocumentReference].resource 1.. 
* entry[DocumentReference].resource only CZ_MhdDocumentReferenceComprehensive

* entry[OperationOutcome] ^short = "OperationOutcome"
* entry[OperationOutcome].resource 1..
* entry[OperationOutcome].resource ^type.code = "OperationOutcome"
* entry[OperationOutcome].resource ^type.profile = Canonical(OperationOutcome)

Invariant: cz-mhd-bdl-1
Description: "The fullUrl must be an absolute URL server address or an URI for UUID/OID"
* severity = #error
* expression = "startsWith('http') or startsWith('urn:uuid:') = true"