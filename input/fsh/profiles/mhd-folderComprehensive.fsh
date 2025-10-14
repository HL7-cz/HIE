Profile:        CZ_Folder
Parent:         MhdList
Id:             cz-mhd-folder-comprehensive
Title:          "CZ MHD Folder Comprehensive"
Description:    "A profile on the List resource for MHD use as a Folder with Comprehensive Metadata"
* extension[designationType] 1..*
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #open
* identifier contains uniqueId 0..1
* identifier[uniqueId] only UniqueIdIdentifier
* identifier contains entryUUID 0..*
* identifier[entryUUID] only EntryUUIDIdentifier
//* status 
* mode = #working
* title 1..1
* code = MHDlistTypes#folder
* subject 1..1
* subject only Reference(CZ_PatientCore)
* encounter 0..0
* date 0..1
* orderedBy 0..0
* source 0..0
* note 0..1
* entry.flag 0..0
* entry.deleted 0..0
* entry.date 0..0
* entry.item 1..1
* entry.item only Reference(DocumentReference)
* emptyReason 0..0