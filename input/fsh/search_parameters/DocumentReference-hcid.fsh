Instance: DocumentReference-hcid
InstanceOf: SearchParameter
Usage: #definition
* name = "DocumentReferenceHCId"
* status = #active
* date = "2025-12-12T14:09:31.7181197+00:00"
* publisher = "UZIS"
* description = "Parameter for searching home community ID"
* code = #hcid
* base = #DocumentReference
* type = #token
* expression = "extension.where(url='https://hl7.cz/fhir/hie/StructureDefinition/cz-mhd-home-community-id').value"
* multipleOr = true
* multipleAnd = true