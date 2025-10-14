CodeSystem:     CZ_ParticipantsCs
Id:	        cz-participants-cs
Title:	       "CZ Participants CodeSystem"
Description:   "Codesystem for participant code."

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
* #PAT "Pacient"
* #HCP "Zdravotnický pracovník"
* #GRP "Zdravotnická skupina"

ValueSet: CZ_ParticipantsVs
Id: cz-participants-vs
Title: "CZ Participants ValueSet"
Description: "Participant codes."
* ^experimental = false
* include codes from system CZ_ParticipantsCs