Profile:        CZFindListsComprehensiveResponse
Parent:         Bundle
Id:             cz-mhd-finddocumentlists-comprehensive-bundle
Title:          "CZ MHD Find Document Lists Comprehensive Response Message"
Description:    "A profile on the Find Document Lists Comprehensive Response message (ITI-66)"
* type = #searchset (exactly)
* total 1..
* entry ^slicing.discriminator[0].type = #profile
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.rules = #closed
* entry contains 
  SubmissionSet 0..* and
  Folder 0..*
* entry[SubmissionSet] ^short = "SubmissionSets"
* entry[SubmissionSet].fullUrl 1..
* entry[SubmissionSet].resource 1..
* entry[SubmissionSet].resource ^type.code = "List"
* entry[SubmissionSet].resource ^type.profile = Canonical(CZMhdSubmissionSetComprehensive)
* entry[Folder] ^short = "Folders"
* entry[Folder].fullUrl 1..
* entry[Folder].resource 1..
* entry[Folder].resource ^type.code = "List"
* entry[Folder].resource ^type.profile = Canonical(cz-mhd-folder-comprehensive)