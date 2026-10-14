Profile:     CZ_AuditEventIti66Consumer
Parent:      AuditFindDocumentListsConsumer
Id: cz-auditEventIti66Consumer
Title:       "CZ Audit Event for [ITI-66] Document List Consumer"
Description: "This profile is used to define the CZ Audit Event for the [ITI-66] transaction and the actor 'Document list
Consumer'."
* agent contains mainUser 1..1 and delegatedUser 0..1
* insert CZ_AuditSecurityAgents
* insert CZ_AuditNodeIdentity(client, server)
* agent[mainUser]
  * ^short = "The main user (patient, representative, healthcare professional, or administrator)"
  * type = $v3ParticipationType#RESP "responsible party"
  * role 1..1
  * altId 1..1
  * name 1..1
  * purposeOfUse 0..1
  * purposeOfUse from CZ_HIEPurposeOfUseVs
* agent[delegatedUser]
  * ^short = "The person who acted on behalf of the main user (an assistant or technical user)"
  * type = $v3ParticipationType#PPRF "primary performer"
  * role 1..1
  * altId 1..1
  * name 1..1
* source
  * site 1..1
  * site ^short = "The OID of the audit source"
* entity contains traceparent 0..1
* entity[traceparent]
  * ^short = "The 'traceparent' header value of the transaction"
  * what 1..1
    * identifier 1..1
      * value 1..1
      * value ^short = "The 'traceparent' header value"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"
* agent[mainUser].purposeOfUse 1..1
* entity[patient] 1..1
  * what.identifier 1..1
    * value 1..1
    * system 1..1
* agent[client] ^short = "The 'Document List Consumer' actor (Client application)"
* agent[server] ^short = "The 'Document List Responder' actor (Server API)"


Profile:     CZ_AuditEventIti66Responder
Parent:      AuditFindDocumentListsResponder
Id: cz-auditEventIti66Responder
Title:       "CZ Audit Event for [ITI-66] Document List"
Description: "This profile is used to define the CZ Audit Event for the [ITI-66] transaction and the actor 'Document
List Responder'."
* agent contains mainUser 1..1 and delegatedUser 0..1
* insert CZ_AuditSecurityAgents
* insert CZ_AuditNodeIdentity(client, server)
* agent[mainUser]
  * ^short = "The main user (patient, representative, healthcare professional, or administrator)"
  * type = $v3ParticipationType#RESP "responsible party"
  * role 1..1
  * altId 1..1
  * name 1..1
  * purposeOfUse 0..1
  * purposeOfUse from CZ_HIEPurposeOfUseVs
* agent[delegatedUser]
  * ^short = "The person who acted on behalf of the main user (an assistant or technical user)"
  * type = $v3ParticipationType#PPRF "primary performer"
  * role 1..1
  * altId 1..1
  * name 1..1
* source
  * site 1..1
  * site ^short = "The OID of the audit source"
* entity contains traceparent 0..1
* entity[traceparent]
  * ^short = "The 'traceparent' header value of the transaction"
  * what 1..1
    * identifier 1..1
      * value 1..1
      * value ^short = "The 'traceparent' header value"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"
* agent[mainUser].purposeOfUse 1..1
* entity[patient] 1..1
  * what.identifier 1..1
    * value 1..1
    * system 1..1
* agent[client] ^short = "The 'Document List Consumer' actor (Client application)"
* agent[server] ^short = "The 'Document List Responder' actor (Server API)"


Instance:   CZ-AuditEventIti66ConsumerExample
InstanceOf: CZ_AuditEventIti66Consumer
Description: "Example of AuditEvent profile CZ_AuditEventIti66Consumer"
Usage:      #example
* insert CZ_AuditPzsExample
* insert CZ_ExamplePzsNode(client)
* insert CZ_ExampleAAfDNode(server)
* insert CZ_ExamplePzsObserver
* recorded = "2024-10-28T09:43:56Z"
* outcome = #0
* agent[client]
  * type = $dcm#110153 "Source Role ID"
  * requestor = false
  * network
    * address = "192.168.1.1"
    * type = #2
* agent[server]
  * type = $dcm#110152 "Destination Role ID"
  * requestor = false
  * network.type = #5 // The address needs to be define in each example (transaction specific)
* entity[traceparent]
  * what.identifier.value = "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"
* agent[mainUser]
  * role = CZ_DocumentEntryAuthorRoleCs#HCP
  * altId = "2000000090092"
  * name = "Mračena Mrakomorová"
  * requestor = true
  * purposeOfUse = CZ_HIEPurposeOfUseCs#NORM "Normální přístup"
* entity[patient]
  * what.identifier
    * value = "4567891235"
    * system = "https://ncez.mzcr.cz/fhir/sid/rid"
  * type = $auditEntityType#1 "Person"
  * role = $objectRole#1 "Patient"
* type = $auditEventType#rest
* subtype[anySearch] = $restfulInteraction#search "search"
* subtype[iti66] = $eventTypeCode#ITI-66 "Find Document Lists"
* agent[server].network.address = "https://example.com"
* entity[query]
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#24 "Query"
  * query = "aHR0cHM6Ly9leGFtcGxlLmNvbS9maGlyL0xpc3Q/Y29kZT1zdWJtaXNzaW9uc2V0JnBhdGllbnQuaWRlbnRpZmllcj1odHRwczovL25jZXoubXpjci5jei9maGlyL3NpZC9yaWR8NDU2Nzg5MTIzNSZzdGF0dXM9Y3VycmVudA=="

Instance:   CZ-AuditEventIti66ResponderExample
InstanceOf: CZ_AuditEventIti66Responder
Description: "Example of AuditEvent profile CZ_AuditEventIti66Responder"
Usage:      #example
* insert CZ_AuditPzsExample
* insert CZ_ExamplePzsNode(client)
* insert CZ_ExampleAAfDNode(server)
* insert CZ_ExampleAAfDObserver
* recorded = "2024-10-28T09:43:56Z"
* outcome = #0
* agent[client]
  * type = $dcm#110153 "Source Role ID"
  * requestor = false
  * network
    * address = "192.168.1.1"
    * type = #2
* agent[server]
  * type = $dcm#110152 "Destination Role ID"
  * requestor = false
  * network.type = #5 // The address needs to be define in each example (transaction specific)
* entity[traceparent]
  * what.identifier.value = "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"
* agent[mainUser]
  * role = CZ_DocumentEntryAuthorRoleCs#HCP
  * altId = "2000000090092"
  * name = "Mračena Mrakomorová"
  * requestor = true
  * purposeOfUse = CZ_HIEPurposeOfUseCs#NORM "Normální přístup"
* entity[patient]
  * what.identifier
    * value = "4567891235"
    * system = "https://ncez.mzcr.cz/fhir/sid/rid"
  * type = $auditEntityType#1 "Person"
  * role = $objectRole#1 "Patient"
* type = $auditEventType#rest
* subtype[anySearch] = $restfulInteraction#search "search"
* subtype[iti66] = $eventTypeCode#ITI-66 "Find Document Lists"
* agent[server].network.address = "https://example.com"
* entity[query]
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#24 "Query"
  * query = "aHR0cHM6Ly9leGFtcGxlLmNvbS9maGlyL0xpc3Q/Y29kZT1zdWJtaXNzaW9uc2V0JnBhdGllbnQuaWRlbnRpZmllcj1odHRwczovL25jZXoubXpjci5jei9maGlyL3NpZC9yaWR8NDU2Nzg5MTIzNSZzdGF0dXM9Y3VycmVudA=="