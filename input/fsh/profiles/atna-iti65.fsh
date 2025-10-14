// Audit events [ITI-65]
Profile:     CZ_AuditEventIti65Source
Parent:      AuditProvideBundleSource
Id: cz-auditEventIti65Source
Title:       "CZ Audit Event for [ITI-65] Document Source"
Description: "This profile is used to define the CZ Audit Event for the [ITI-65] transaction and the actor 'Document
Source'."
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
* agent[documentSource] ^short = "The 'Document Source' actor (Source application)"
* agent[documentRecipient] ^short = "The 'Document Recipient' actor (Recipient API)"
* entity[submissionSet].what.identifier 1..1
  * value 1..1
  * system 1..1
  * system = "urn:ietf:rfc:3986"


Profile:     CZ_AuditEventIti65Recipient
Parent:      AuditProvideBundleRecipient
Id: cz-auditEventIti65Recipient
Title:       "CZ Audit Event for [ITI-65] Document Recipient"
Description: "This profile is used to define the CZ Audit Event for the [ITI-65] transaction and the actor 'Document
Recipient'."
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
* agent[documentSource] ^short = "The 'Document Source' actor (Source application)"
* agent[documentRecipient] ^short = "The 'Document Recipient' actor (Recipient API)"
* entity[submissionSet].what.identifier 1..1
  * value 1..1
  * system 1..1
  * system = "urn:ietf:rfc:3986"


Instance:   CZ-AuditEventIti65SourceExample
InstanceOf: CZ_AuditEventIti65Source
Description: "Example of AuditEvent profile CZAuditEventIti65Source"
Usage:      #example
* insert CZ_AuditEventIti65ExampleRules
* source 
  * site = "2.16.756.1.2.3"
  * observer.display = "Nemocnice XYZ" // TODO je to spravne?
* type = DCM#110106 "Export"


Instance:   CZ-AuditEventIti65RecipientExample
InstanceOf: CZ_AuditEventIti65Recipient
Description: "Example of AuditEvent profile CZAuditEventIti65Recipient"
Usage:      #example
* insert CZ_AuditEventIti65ExampleRules
* source   
  * site = "2.16.756.4.5.6"
  * observer.display = "Affinitní doména A" // TODO je to spravne?
* type = DCM#110107 "Import"


RuleSet: CZ_AuditEventIti65ExampleRules
* recorded = "2024-10-28T09:43:56Z"
* outcome = #0
* agent[documentSource]
  * type = DCM#110153 "Source Role ID"
  * who.display = "Nemocnice XYZ" // TODO je to spravne?
  * requestor = false
  * network
    * address = "192.168.1.1"
    * type = #2
* agent[documentRecipient]
  * type = DCM#110152 "Destination Role ID"
  * who.display = "Affinitní doména A" // TODO je to spravne?
  * requestor = false
  * network.type = #5 // The address needs to be define in each example (transaction specific)
* entity[traceparent]
  * what.identifier.value = "00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00"
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
* subtype[iti65] = $eventTypeCode#ITI-65 "Provide Document Bundle"
* agent[documentRecipient].network.address = "https://example.com"
* entity[submissionSet]
  * what.identifier
    * value = "urn:oid:1.3.6.1.4.1.12559.11.13.2.6.2949"
    * system = "urn:ietf:rfc:3986"
  * type = $auditEntityType#2 "System Object"
  * role = $objectRole#20 "Job"