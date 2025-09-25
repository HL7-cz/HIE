Profile: CZMhdProvideDocumentBundleComprehensiveResponse
Parent: Bundle
Id: cz-mhd-providedocumentbundle-comprehensive-response
Title: "CZ MHD Provide Document Bundle Comprehensive Response"
Description: "IHE MHD profile on Response of Provide Document Bundle (ITI-65) transaction with Comprehensive Metadata."
* type = #transaction-response (exactly)
* type 
* link 
* link.url 
* entry 2.. 
* entry ^short = "One entry for each entry in the request, in the same order as received"
* entry.response 1.. 
* entry.response ^short = "Indicating the results of processing the entry"
* entry.response.status 
* entry.response.location 1.. 
* entry.response.etag 
* entry.response.outcome 