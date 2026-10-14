CodeSystem:     CZ_PolicyAuditEventTypeCs
Id:	        cz-PolicyAuditEvent-type-cs
Title:	       "CZ Policy Audit Event Type CodeSystem"
Description:   "Codesystem for Policy audit event type."

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
* #ATC_POL_CREATE_AUT_PART_AL "Vytvoření oprávnění zdravotnického pracovníka ve skupině" "Udělení oprávnění účastníkům (zdravotnickým pracovníkům, skupinám nebo zástupcům pacienta) pro úroveň přístupu, případně s omezením do data."
* #ATC_POL_UPDATE_AUT_PART_AL "Aktualizace oprávnění zdravotnického pracovníka ve skupině" "Změna úrovně přístupu nebo data omezení přístupu u již oprávněných účastníků."
* #ATC_POL_REMOVE_AUT_PART_AL "Odebrání oprávnění zdravotnického pracovníka ve skupině" "Odebrání oprávnění účastníkům."
* #ATC_POL_DEL_CONFLEVEL "Smazání úrovně důvěrnosti" "Smazání nastavené úrovně důvěrnosti."
* #ATC_POL_DIS_EMER_USE "Zakázání nouzového přístupu" "Zakázání nouzového přístupu k dokumentaci pacienta."
* #ATC_POL_ENA_EMER_USE "Povolení nouzového přístupu" "Povolení nouzového přístupu k dokumentaci pacienta."
* #ATC_POL_INCL_BLACKLIST "Zařazení do černé listiny" "Vyloučení zdravotnického pracovníka z přístupu k dokumentaci pacienta (zařazení na černou listinu)."
* #ATC_POL_EXCL_BLACKLIST "Vyřazení z černé listiny" "Zrušení vyloučení zdravotnického pracovníka z přístupu k dokumentaci pacienta (vyřazení z černé listiny)."

ValueSet: CZ_PolicyAuditEventTypeVs
Id: cz-PolicyAuditEvent-type-vs  
Title: "CZ Policy Audit Event Type ValueSet"
Description: "Policy audit event type."
* ^experimental = false
* include codes from system CZ_PolicyAuditEventTypeCs