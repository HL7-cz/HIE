Profile:     CZ_AuditEventIti68Consumer
Parent:      AuditRetrieveDocumentConsumer
Id: cz-auditEventIti68Consumer
Title:       "CZ Audit Event for [ITI-68] Document Consumer"
Description: "This profile is used to define the CZ Audit Event for the [ITI-68] transaction and the actor 'Document
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
* entity[data]
  * ^short = "The document that was accessed"
  * what.reference 1..1
    * ^short = "The URL accessed by the Document Consumer"
  * securityLabel from CZ_DocumentEntryConfidentialityCodeVs
  * securityLabel ^short = "The confidentiality code of the document, if known"


Profile:     CZ_AuditEventIti68Responder
Parent:      AuditRetrieveDocumentResponder
Id: cz-auditEventIti68Responder
Title:       "CZ Audit Event for [ITI-68] Document Responder"
Description: "This profile is used to define the CZ Audit Event for the [ITI-68] transaction and the actor 'Document
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
* entity[data]
  * ^short = "The document that was accessed"
  * what.reference 1..1
    * ^short = "The URL accessed by the Document Consumer"
  * securityLabel from CZ_DocumentEntryConfidentialityCodeVs
  * securityLabel ^short = "The confidentiality code of the document, if known"



Instance:   CZ-AuditEventIti68ConsumerExample
InstanceOf: CZ_AuditEventIti68Consumer
Description: "Example of AuditEvent profile CZ_AuditEventIti68Consumer"
Usage:      #example
* recorded = "2024-10-28T09:43:56Z"
* outcome = #0
* agent[server]
  * type = DCM#110153 "Source Role ID"
  * who.display = "Affinitní doména A"
  * requestor = false
  * network
    * address = "https://example.org/blah/blah.pdf"
    * type = #5
* agent[client]
  * type = DCM#110152 "Destination Role ID"
  * who.display = "Portal"
  * requestor = false
  * network
    * address = "192.168.1.1"
    * type = #2
* entity[traceparent]
  * what
    * identifier
      * value = "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"
* agent[mainUser]
  * role = CZ_DocumentEntryAuthorRoleCs#HCP
  * altId = "2000000090092"
  * name = "Mracena Mrakomorová"
  * requestor = true
  * purposeOfUse = CZ_HIEPurposeOfUseCs#NORM "Normální přístup"
* entity[patient]
  * what.identifier
    * value = "4567891235"
    * system = "https://ncez.mzcr.cz/fhir/sid/rid"
  * type = $auditEntityType#1 "Person"
  * role = $objectRole#1 "Patient"
* type = $auditEventType#rest
* subtype[anyRead] = $restfulInteraction#read "read"
* subtype[iti68] = $eventTypeCode#ITI-68 "Retrieve Document"
* entity[data]
  * what.reference = "https://example.org/blah/blah.pdf"
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#3 "Report"
* source
  * site = "2.16.756.1.2.3"
  * observer.display = "Portal" // TODO je to spravne?


Instance:   CZ-AuditEventIti68ResponderExample
InstanceOf: CZ_AuditEventIti68Responder
Description: "Example of AuditEvent profile CZ_AuditEventIti68Responder"
Usage:      #example
* recorded = "2024-10-28T09:43:56Z"
* outcome = #0
* agent[server]
  * type = DCM#110153 "Source Role ID"
  * who.display = "Affinitní doména A"
  * requestor = false
  * network
    * address = "https://example.org/blah/blah.pdf"
    * type = #5
* agent[client]
  * type = DCM#110152 "Destination Role ID"
  * who.display = "Portal"
  * requestor = false
  * network
    * address = "192.168.1.1"
    * type = #2
* entity[traceparent]
  * what
    * identifier
      * value = "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
  * type = $auditEntityType#4 "Other"
  * role = $objectRole#26 "Processing Element"
* agent[mainUser]
  * role = CZ_DocumentEntryAuthorRoleCs#HCP
  * altId = "2000000090092"
  * name = "Mracena Mrakomorová"
  * requestor = true
  * purposeOfUse = CZ_HIEPurposeOfUseCs#NORM "Normální přístup"
* entity[patient]
  * what.identifier
    * value = "4567891235"
    * system = "https://ncez.mzcr.cz/fhir/sid/rid"
  * type = $auditEntityType#1 "Person"
  * role = $objectRole#1 "Patient"
* type = $auditEventType#rest
* subtype[anyRead] = $restfulInteraction#read "read"
* subtype[iti68] = $eventTypeCode#ITI-68 "Retrieve Document"
* entity[data]
  * what.reference = "https://example.org/blah/blah.pdf"
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#3 "Report"
* source
  * site = "2.16.756.4.5.6"
  * observer.display = "Affinitní doména A" // TODO je to spravne?
