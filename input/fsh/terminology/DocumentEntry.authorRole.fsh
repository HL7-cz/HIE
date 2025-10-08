CodeSystem:     CZ_DocumentEntryAuthorRoleCs
Id:	        cz-documentEntry-authorRole-cs
Title:	       "CZ DocumentEntry AuthorRole CodeSystem"
Description:   "Codesystem for author role codes."

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
* #PAT "Patient"
* #HCP "Healthcare professional"
// TODO Doplnit role

ValueSet: CZ_DocumentEntryAuthorRoleVs
Id: cz-documentEntry-authorRole-vs 
Title: "CZ DocumentEntry AuthorRole ValueSet"
Description: "Document author role codes."
* ^experimental = false
* include codes from system CZ_DocumentEntryAuthorRoleCs