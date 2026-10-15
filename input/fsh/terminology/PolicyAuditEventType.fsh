CodeSystem:     CZ_PolicyAuditEventTypeCs
Id:	        cz-PolicyAuditEvent-type-cs
Title:	       "CZ Access Check Audit Event Type CodeSystem"
Description:   "Typ auditní události ověření oprávnění v Registru oprávnění."

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
* #ATC_POL_ACCESS_CHECK "Ověření oprávnění v Registru oprávnění" "AAfD ověřila v centrálním Registru oprávnění, zda pacient udělil nebo omezil oprávnění k přístupu k jeho zdravotnické dokumentaci (MZ REST nebo plánovaná transakce ITI-108)."

ValueSet: CZ_PolicyAuditEventTypeVs
Id: cz-PolicyAuditEvent-type-vs  
Title: "CZ Access Check Audit Event Type ValueSet"
Description: "Typ auditní události ověření oprávnění v Registru oprávnění."
* ^experimental = false
* include codes from system CZ_PolicyAuditEventTypeCs