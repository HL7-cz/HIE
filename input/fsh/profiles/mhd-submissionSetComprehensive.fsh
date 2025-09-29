Profile: CZMhdSubmissionSetComprehensive
Parent: $IHE.MHD.UnContained.Comprehensive.SubmissionSet
Id: cz-mhd-submissionset-comprehensive
Title: "CZ MHD SubmissionSet Comprehensive"
Description: "CZ MHD SubmissionSet Comprehensive"
* extension 2..
//* extension contains $ch-ext-author-authorrole named authorAuthorRole 0..1 
//* extension[designationType].value[x] from $SubmissionSet.contentTypeCode (required)
//* extension[designationType] ^sliceName = "designationType"
//* extension[designationType] ^mustSupport = true
* extension[sourceId] ^sliceName = "sourceId"
* extension[sourceId] ^mustSupport = true
//* extension[authorAuthorRole] ^short = "The SubmissionSet.Author element MAY be used to track the user who made the latest changes to the document metadata."
* identifier[uniqueId] 
* identifier[entryUUID] 
* identifier ^short = "identifier, for uniqueID set use to usual"
* status 
* mode 
* code 
* subject 1.. 
* subject.identifier 1..1
* subject.identifier only  CZ_RID_Identifier
* subject ^comment = "Not a contained resource. The identifier points to an existing patient in the XDS Affinity Domain."
* date 
* source 
* source.extension[authorOrg] 0..0
* entry 1.. 
* entry.item only Reference($cz-mhd-documentreference-comprehensive)
* entry.item 
* entry.item ^type.aggregation[0] = #referenced
* entry.item ^type.aggregation[+] = #bundled