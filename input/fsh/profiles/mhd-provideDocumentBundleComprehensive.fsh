Profile: CZMhdProvideDocumentBundleComprehensive
Parent: $IHE.MHD.Comprehensive.ProvideBundle
Id: cz-mhd-providedocumentbundle-comprehensive
Title: "CZ MHD Provide Document Bundle Comprehensive"
Description: "IHE MHD profile on Provide Document Bundle (ITI-65) transaction with Comprehensive Metadata for the Czech national interoperability standards."
* meta 1..
* meta.profile 
* meta.profile ^slicing.discriminator.type = #value
* meta.profile ^slicing.discriminator.path = "$this"
* meta.profile ^slicing.rules = #open
* meta.profile contains comprehensiveMetadata 1..1 
* meta.profile[comprehensiveMetadata] = "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Comprehensive.ProvideBundle"
* entry 3..
* entry[SubmissionSet] ^sliceName = "SubmissionSet"
* entry[SubmissionSet].resource 1.. 
* entry[SubmissionSet].resource ^type.profile = $cz-mhd-submissionset-comprehensive
* entry[SubmissionSet].request 1.. 
* entry[SubmissionSet].request.method = #POST
* entry[SubmissionSet].request.method 
* entry[DocumentRefs] ^sliceName = "DocumentRefs"
* entry[DocumentRefs].resource 1.. 
* entry[DocumentRefs].resource ^type.profile = Canonical(CZMhdDocumentReferenceComprehensive)
* entry[DocumentRefs].request 
* entry[DocumentRefs].request.method = #POST
* entry[DocumentRefs].request.method 
* entry[Documents] ^sliceName = "Documents"
* entry[Documents].resource 1.. 
* entry[Documents].resource only Binary
* entry[Documents].request 1.. 
* entry[Documents].request.method = #POST
* entry[Documents].request.method 
* entry[Folders] 0..0 
* entry[Patient] 0..0