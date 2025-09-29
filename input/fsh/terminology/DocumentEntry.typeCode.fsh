CodeSystem:     CZ_DocumentEntryTypeCodeCs
Id:	        cz-documentEntry-typeCode-cs
Title:	       "CZ DocumentEntry TypeCode CodeSystem"
Description:   "Codesystem for document type codes."

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
* #01 "Propouštěcí zpráva z nemocnice"
* #02 "Zpráva z laboratorního vyšetření"
* #03 "Zpráva z obrazového vyšetření"
* #04 "Pacientský souhrn"
* #05 "Žádanka na obrazové vyšetření"
* #06 "Laboratorní žádanka"
* #07 "Ambulantní zpráva"
* #08 "Objednávka laboratorního vyšetření"
* #09 "Objednávka obrazového vyšetření"
* #10 "Záznam o výjezdu zdravotnické záchranné služby"
* #11 "Hlášení výsledků laboratorních vyšetření do NZIS"

ValueSet: CZ_DocumentEntryTypeCodeVs
Id: cz-documentEntry-typeCode-vs
Title: "CZ DocumentEntry TypeCode ValueSet"
Description: "Document type codes."

* ^experimental = false
* include codes from system CZ_DocumentEntryTypeCodeCs