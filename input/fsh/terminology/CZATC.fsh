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

* #ATC_DOC_CREATE	"Document upload" "Nahrání dokumentu pacienta do úložiště."
* #ATC_DOC_READ	"Document retrieval" "Získání (stažení) dokumentu pacienta."
* #ATC_DOC_UPDATE	"Document or Document Metadata update" "Aktualizace dokumentu nebo metadat dokumentu."
* #ATC_DOC_DELETE	"Document removal" "Odstranění dokumentu."
* #ATC_DOC_SEARCH	"Document search" "Vyhledání dokumentů nebo metadat dokumentů pacienta."
* #ATC_POL_CREATE_AUT_PART_AL	"Authorize participants to access level/date" "Udělení oprávnění účastníkům (zdravotnickým pracovníkům, skupinám nebo zástupcům pacienta) pro úroveň přístupu, případně s omezením do data."
* #ATC_POL_UPDATE_AUT_PART_AL	"Update access level/date of authorized participants" "Změna úrovně přístupu nebo data omezení přístupu u již oprávněných účastníků."
* #ATC_POL_REMOVE_AUT_PART_AL	"Remove authorization for participants to access level/date" "Odebrání oprávnění účastníkům."
* #ATC_POL_DEF_CONFLEVEL	"Set or update the default Confidentiality Level for new documents" "Nastavení nebo změna výchozí úrovně důvěrnosti pro nové dokumenty."
* #ATC_POL_DIS_EMER_USE	"Disabling Emergency Access" "Zakázání nouzového přístupu k dokumentaci pacienta."
* #ATC_POL_ENA_EMER_USE	"Enabling Emergency Access" "Povolení nouzového přístupu k dokumentaci pacienta."
* #ATC_POL_INCL_BLACKLIST	"Assign a Healthcare Professional to Blacklist" "Vyloučení zdravotnického pracovníka z přístupu k dokumentaci pacienta (zařazení na černou listinu)."
* #ATC_POL_EXL_BLACKLIST	"Exclude a Healthcare Professional from Blacklist" "Zrušení vyloučení zdravotnického pracovníka z přístupu k dokumentaci pacienta (vyřazení z černé listiny)."
* #ATC_LOG_READ	"Accessing the Patient Audit Record Repository" "Přístup pacienta nebo jeho zástupce k auditní stopě v úložišti auditních záznamů pacienta."
* #ATC_HPD_GROUP_ENTRY_NOTIFY	"Entry of healthcare professionals into a group" "Notifikace pacienta o vstupu zdravotnických pracovníků do skupiny."