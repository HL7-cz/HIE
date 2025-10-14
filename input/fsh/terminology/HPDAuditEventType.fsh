CodeSystem:     CZ_HPDAuditEventTypeCs
Id:	        cz-HPDAuditEvent-type-cs
Title:	       "CZ HPD Audit Event Type CodeSystem"
Description:   "Codesystem for HPD audit event type."

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
* #ATC_HPD_GROUP_ENTRY_NOTIFY "Vstoupení zdravotnického pracovníka do skupiny"

ValueSet: CZ_HPDAuditEventTypeVs
Id: cz-HPDAuditEvent-type-vs  
Title: "CZ HPD Audit Event Type ValueSet"
Description: "HPD audit event type."
* ^experimental = false
* include codes from system CZ_HPDAuditEventTypeCs