Profile: CZ_PolicyAuditEvent
Id: cz-policyAuditEvent
Parent: AuditEvent
Title: "CZ Access Check Audit Event"
Description: "Auditní událost ověření oprávnění přístupu k dokumentaci pacienta v centrálním Registru oprávnění. AAfD ji zaznamená při každém dotazu do Registru oprávnění (MZ REST nebo plánovaná transakce ITI-108), typicky v rámci vyhledání nebo získání dokumentace (ITI-66, ITI-67, ITI-68)."

* type = $dcm#110112 "Query"
* subtype 1..
* subtype ^slicing.discriminator.type = #value
* subtype ^slicing.discriminator.path = "system"
* subtype ^slicing.rules = #open
* subtype contains accessCheck 1..1
* subtype[accessCheck] from CZ_PolicyAuditEventTypeVs (required)
* subtype[accessCheck] ^short = "Ověření oprávnění v Registru oprávnění (ATC_POL_ACCESS_CHECK)"

* recorded 1..1
  * ^short = "Datum a čas události"
* outcome 1..1
  * ^short = "0 = ověření proběhlo (výsledek viz entity[decision]); 4, 8, 12 = ověření se nepodařilo provést"

* agent ^slicing.discriminator.type = #pattern
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent contains aafd 1..1 and registry 1..1 and mainUser 0..1
* insert CZ_AuditSecurityAgents
* insert CZ_AuditNodeIdentity(aafd, registry)
* agent[aafd]
  * ^short = "AAfD, která oprávnění ověřuje (identifikace HCID)"
  * type = $dcm#110153 "Source Role ID"
  * who 1..1
  * who.identifier 1..1
  * requestor = false
* agent[registry]
  * ^short = "Registr oprávnění (centrální služba elektronického zdravotnictví)"
  * type = $dcm#110152 "Destination Role ID"
  * who 1..1
  * requestor = false
  * network 1..1
* agent[mainUser]
  * ^short = "Zdravotnický pracovník, pro kterého se oprávnění ověřuje"
  * type = $v3ParticipationType#RESP "responsible party"
  * altId 1..1
  * altId ^short = "Identifikátor ZP z KRZP"
  * name 1..1
  * requestor = true
  * purposeOfUse 1..1
  * purposeOfUse from CZ_HIEPurposeOfUseVs (required)
  * purposeOfUse ^short = "Účel použití (NORM, EMER, AUTO)"

* entity ^slicing.discriminator.type = #pattern
* entity ^slicing.discriminator.path = "type"
* entity ^slicing.rules = #open
* entity contains patient 1..1 and decision 1..1 and traceparent 0..1
* entity[patient]
  * ^short = "Pacient, k jehož dokumentaci se oprávnění ověřuje"
  * type = $auditEntityType#1 "Person"
  * role = $objectRole#1 "Patient"
  * what 1..1
  * what.identifier 1..1
    * system 1..1
    * system = "https://ncez.mzcr.cz/fhir/sid/rid"
    * value 1..1
  * what.identifier ^short = "RID nebo DRID pacienta"
* entity[decision]
  * ^short = "Výsledek ověření v Registru oprávnění"
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#13 "Security Resource"
  * detail 1..1
  * detail.type = "decision"
  * detail.value[x] only string
  * detail.valueString ^short = "permit | restrict | deny"
  * detail ^comment = "permit = přístup povolen; restrict = přístup omezen (pacient omezil oprávnění); deny = přístup zamítnut."
* entity[traceparent]
  * ^short = "Hodnota hlavičky traceparent transakce, v jejímž rámci se oprávnění ověřovalo (ITI-66/67/68)"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"
  * what 1..1
  * what.identifier 1..1
  * what.identifier.value 1..1


Instance:   CZ-PolicyAuditEventExample
InstanceOf: CZ_PolicyAuditEvent
Description: "Příklad auditní události ověření oprávnění v Registru oprávnění"
Usage:      #example
* insert CZ_AuditPzsExample
* insert CZ_ExampleAAfDNode(aafd)
* insert CZ_ExampleAAfDObserver
* subtype[accessCheck] = CZ_PolicyAuditEventTypeCs#ATC_POL_ACCESS_CHECK "Ověření oprávnění v Registru oprávnění"
* recorded = "2024-10-28T09:43:57Z"
* outcome = #0
* agent[registry]
  * who.display = "Registr oprávnění"
  * requestor = false
  * network
    * address = "https://example.com/registr-opravneni"
    * type = #5
* agent[mainUser]
  * role = CZ_DocumentEntryAuthorRoleCs#HCP
  * altId = "2000000090092"
  * name = "Mračena Mrakomorová"
  * requestor = true
  * purposeOfUse = CZ_HIEPurposeOfUseCs#NORM "Normální přístup"
* entity[patient]
  * what.identifier
    * system = "https://ncez.mzcr.cz/fhir/sid/rid"
    * value = "4567891235"
* entity[decision]
  * what.display = "Rozhodnutí Registru oprávnění"
  * detail.type = "decision"
  * detail.valueString = "permit"
* entity[traceparent]
  * what.identifier.value = "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
