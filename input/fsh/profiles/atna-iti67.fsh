Profile:     CzAuditEventIti67Consumer
Parent:      AuditFindDocumentReferencesConsumer
Title:       "CZ Audit Event for [ITI-67] Document Consumer"
Description: "This profile is used to define the CZ Audit Event for the [ITI-67] transaction and the actor 'Document
Consumer'."
* agent contains mainUser 1..1 and delegatedUser 0..1
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
* agent[client] ^short = "The 'Document Consumer' actor (Client application)"
* agent[server] ^short = "The 'Document Responder' actor (Server API)"


Profile:     CzAuditEventIti67Responder
Parent:      AuditFindDocumentReferencesResponder
Title:       "CZ Audit Event for [ITI-67] Document Responder"
Description: "This profile is used to define the CZ Audit Event for the [ITI-67] transaction and the actor 'Document
Responder'."
* agent contains mainUser 1..1 and delegatedUser 0..1
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
* agent[client] ^short = "The 'Document Consumer' actor (Client application)"
* agent[server] ^short = "The 'Document Responder' actor (Server API)"


Instance:   CzAuditEventIti67ConsumerExample
InstanceOf: CzAuditEventIti67Consumer
Description: "Example of AuditEvent profile CzAuditEventIti67Consumer"
Usage:      #example
* recorded = "2024-10-28T09:43:56Z"
* outcome = #0
* agent[client]
  * type = DCM#110153 "Source Role ID"
  * who.display = "Affinitní doména A" // TODO je to spravne?
  * requestor = false
  * network
    * address = "192.168.1.1"
    * type = #2
* agent[server]
  * type = DCM#110152 "Destination Role ID"
  * who.display = "Nemocnice XYZ" // TODO je to spravne? Nemělo by být DÚ?
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
* subtype[iti67] = $eventTypeCode#ITI-67 "Find Document References"
* agent[server].network.address = "https://example.com"
* entity[query]
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#24 "Query"
  * query = "aHR0cDovL2V4YW1wbGUuY29tL2ZoaXIvRG9jdW1lbnRSZWZlcmVuY2U/cGF0aWVudC5pZGVudGlmaWVyPXVybjpvaWQ6Mi4xNi43NTYuNS4zMC4xLjEyNy4zLjEwLjN8NzYxMzM3NjEwNDExMzUzNjUwJnN0YXR1cz1jdXJyZW50"
* source
  * site = "2.16.756.4.5.6"
  * observer.display = "Affinitní doména A" // TODO je to spravne?

Instance:   CzAuditEventIti67ResponderExample
InstanceOf: CzAuditEventIti67Responder
Description: "Example of AuditEvent profile CzAuditEventIti67Responder"
Usage:      #example
* recorded = "2024-10-28T09:43:56Z"
* outcome = #0
* agent[client]
  * type = DCM#110153 "Source Role ID"
  * who.display = "Affinitní doména A" // TODO je to spravne?
  * requestor = false
  * network
    * address = "192.168.1.1"
    * type = #2
* agent[server]
  * type = DCM#110152 "Destination Role ID"
  * who.display = "Nemocnice XYZ" // TODO je to spravne? Nemělo by být DÚ?
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
* subtype[iti67] = $eventTypeCode#ITI-67 "Find Document References"
* agent[server].network.address = "https://example.com"
* entity[query]
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#24 "Query"
  * query = "aHR0cDovL2V4YW1wbGUuY29tL2ZoaXIvRG9jdW1lbnRSZWZlcmVuY2U/cGF0aWVudC5pZGVudGlmaWVyPXVybjpvaWQ6Mi4xNi43NTYuNS4zMC4xLjEyNy4zLjEwLjN8NzYxMzM3NjEwNDExMzUzNjUwJnN0YXR1cz1jdXJyZW50"
* source
  * site = "2.16.756.1.2.3"
  * observer.display = "Nemocnice XYZ" // TODO je to spravne?