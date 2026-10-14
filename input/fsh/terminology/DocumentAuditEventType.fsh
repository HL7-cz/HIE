CodeSystem:     CZ_DocumentAuditEventTypeCs
Id:	        cz-documentAuditEvent-type-cs
Title:	       "CZ Document Audit Event Type CodeSystem"
Description:   "Codesystem for document audit event type."

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
* #ATC_DOC_CREATE "Vytvoření dokumentu" "Nahrání dokumentu pacienta do úložiště."
* #ATC_DOC_READ "Čtení dokumentu" "Získání (stažení) dokumentu pacienta."
* #ATC_DOC_UPDATE "Aktualizace dokumentu" "Aktualizace dokumentu nebo metadat dokumentu."
* #ATC_DOC_DELETE "Smazání dokumentu" "Odstranění dokumentu."
* #ATC_DOC_SEARCH "Vyhledání dokumentu" "Vyhledání dokumentů nebo metadat dokumentů pacienta."

ValueSet: CZ_DocumentAuditEventTypeVs
Id: cz-documentAuditEvent-type-vs  
Title: "CZ Document Audit Event Type ValueSet"
Description: "Document audit event type."
* ^experimental = false
* include codes from system CZ_DocumentAuditEventTypeCs