CodeSystem:     CZ_ATCCs
Id:	        cz-atc-cs
Title:	       "CZ Audit Trail Event Types CodeSystem"
Description:   "Typy auditních událostí, které AAfD zaznamenává a zpřístupňuje Žurnálu činností pro dohledání činností podle subjektu (pacient, zdravotnický pracovník, poskytovatel zdravotních služeb)."

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

* #ATC_DOC_CREATE	"Document upload" "Nahrání dokumentu pacienta do úložiště."
* #ATC_DOC_READ	"Document retrieval" "Získání (stažení) dokumentu pacienta."
* #ATC_DOC_UPDATE	"Document or Document Metadata update" "Aktualizace dokumentu nebo metadat dokumentu."
* #ATC_DOC_DELETE	"Document removal" "Odstranění dokumentu."
* #ATC_DOC_SEARCH	"Document search" "Vyhledání dokumentů nebo metadat dokumentů pacienta."
* #ATC_POL_ACCESS_CHECK "Access check in the Consent Registry" "AAfD ověřila v centrálním Registru oprávnění, zda pacient udělil nebo omezil oprávnění k přístupu k jeho zdravotnické dokumentaci (MZ REST nebo plánovaná transakce ITI-108)."
* #ATC_LOG_READ	"Accessing the audit trail" "Přístup k auditním záznamům – dotaz Žurnálu činností na úložiště auditních záznamů (ITI-81)."
