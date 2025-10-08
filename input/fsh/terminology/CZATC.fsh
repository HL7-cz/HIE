CodeSystem:     CZ_ATCCs
Id:	        cz-atc-cs
Title:	       "CZ Audit Trail Consumption Event Types CodeSystem"
Description:   "Codesystem for Audit Trail Consumption Event Types codes."

* ^language = #cs-CZ
* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:oid:1.2.203.24341.11.2.10.2.1"
* ^version = "1.0"
* ^status = #active
* ^date = "2025-01-17"
* ^experimental = false
* ^publisher = "UZIS"
* ^jurisdiction = urn:iso:std:iso:3166#CZ "Czechia"
* ^caseSensitive = true
* ^content = #complete

* #ATC_DOC_CREATE	"Document upload"
* #ATC_DOC_READ	"Document retrieval"
* #ATC_DOC_UPDATE	"Document or Document Metadata update"
* #ATC_DOC_DELETE	"Document removal"
* #ATC_DOC_SEARCH	"Document search"
* #ATC_POL_CREATE_AUT_PART_AL	"Authorize participants to access level/date"
* #ATC_POL_UPDATE_AUT_PART_AL	"Update access level/date of authorized participants"
* #ATC_POL_REMOVE_AUT_PART_AL	"Remove authorization for participants to access level/date"
* #ATC_POL_DEF_CONFLEVEL	"Set or update the default Confidentiality Level for new documents"
* #ATC_POL_DIS_EMER_USE	"Disabling Emergency Access"
* #ATC_POL_ENA_EMER_USE	"Enabling Emergency Access"
* #ATC_POL_INCL_BLACKLIST	"Assign a Healthcare Professional to Blacklist"
* #ATC_POL_EXL_BLACKLIST	"Exclude a Healthcare Professional from Blacklist"
* #ATC_LOG_READ	"Accessing the Patient Audit Record Repository"
* #ATC_HPD_GROUP_ENTRY_NOTIFY	"Entry of healthcare professionals into a group"