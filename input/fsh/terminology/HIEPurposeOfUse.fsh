CodeSystem:     CZ_HIEPurposeOfUseCs
Id:	        cz-purposeOfUse-cs
Title:	       "CZ Purpose of use CodeSystem"
Description:   "Codesystem for purpose of use codes."

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
* #EMER "Emergentní přístup"
* #NORM "Normální přístup"
* #AUTO "Automatizované nahrávání"

ValueSet: CZ_HIEPurposeOfUseVs
Id: cz-purposeOfUse-vs
Title: "CZ Purpose of use ValueSet"
Description: "Valueset for Purpose of use codes."

* ^experimental = false
* include codes from system CZ_HIEPurposeOfUseCs