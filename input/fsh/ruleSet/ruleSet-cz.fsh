RuleSet: SNOMEDCopyrightForVS
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement"
* ^experimental = false

// ---------------------------------------------------------------------------
// Zaznamenání zabezpečení komunikace (mTLS + IUA) v auditních událostech
// Viz Standard akreditovaných afinitních domén (AAfD) a stránka ITI-20.
// ---------------------------------------------------------------------------

RuleSet: CZ_AuditSecurityAgents
* agent contains pzs 1..1
* agent[pzs]
  * ^short = "Poskytovatel zdravotních služeb (PZS) identifikovaný v přístupovém tokenu IUA"
  * ^definition = "Poskytovatel zdravotních služeb, jehož identifikace je uvedena v přístupovém tokenu IUA (ITI-71/ITI-72). U komunikace mezi AAfD jde o PZS z claimu sub tokenu získaného výměnou dle RFC 8693."
  * type = $v3RoleClass#PROV "healthcare provider"
  * who 1..1
  * who.identifier 1..1
    * system 1..1
    * system = "https://ncez.mzcr.cz/fhir/sid/ico"
    * value 1..1
  * who.identifier ^short = "IČO PZS z přístupového tokenu IUA"
  * requestor = false
  * policy 1..1
  * policy ^short = "Identifikátor přístupového tokenu IUA (claim jti) ve tvaru urn:ietf:params:oauth:jti:<jti>"
  * policy ^comment = "Přístupový token ani jeho část se do auditní události neukládá, zaznamenává se pouze jeho identifikátor (IHE BALP)."
  * media 0..0
  * network 0..0

RuleSet: CZ_AuditNodeIdentity(client, server)
* agent[{client}].who ^comment = "Volající systém (uzel) autentizovaný klientským certifikátem mTLS dle ATNA [ITI-19]. Do who.identifier se zapisuje identita z certifikátu, u AAfD její HCID. U komunikace mezi AAfD jde o zprostředkující AAfD (claim act tokenu získaného výměnou dle RFC 8693)."
* agent[{server}].who ^comment = "Volaný systém (uzel) autentizovaný serverovým certifikátem mTLS dle ATNA [ITI-19]. Do who.identifier se zapisuje identita z certifikátu, u AAfD její HCID."

RuleSet: CZ_AuditPzsExample
* agent[pzs]
  * type = $v3RoleClass#PROV "healthcare provider"
  * who.identifier.system = "https://ncez.mzcr.cz/fhir/sid/ico"
  * who.identifier.value = "12345678"
  * who.display = "Nemocnice XYZ"
  * requestor = false
  * policy = "urn:ietf:params:oauth:jti:9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d"
