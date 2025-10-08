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
* entry[SubmissionSet].resource 1.. MS
* entry[SubmissionSet].resource ^type.profile = $cz-mhd-submissionset-comprehensive
* entry[SubmissionSet].request 1.. MS
* entry[SubmissionSet].request.method = #POST
* entry[SubmissionSet].request.method MS
* entry[DocumentRefs] ^sliceName = "DocumentRefs"
* entry[DocumentRefs] ^mustSupport = true
* entry[DocumentRefs].resource 1.. MS
* entry[DocumentRefs].resource ^type.profile = Canonical(CZMhdDocumentReferenceComprehensive)
* entry[DocumentRefs].request MS
* entry[DocumentRefs].request.method = #POST
* entry[DocumentRefs].request.method MS
* entry[Documents] ^sliceName = "Documents"
* entry[Documents] ^mustSupport = true
* entry[Documents].resource 1.. MS
* entry[Documents].resource only Binary
* entry[Documents].request 1.. MS
* entry[Documents].request.method = #POST
* entry[Documents].request.method MS
* entry[Folders] 0..0 
* entry[Patient] 0..0