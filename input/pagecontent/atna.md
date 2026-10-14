This section specifies Czech national extensions to the Add RESTful ATNA (Query and Feed) supplement, which is [published](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf) as an IHE ITI Trial Implementation profile.

###	Scope  
An HIE App needs to submit audit records according to the IHE ITI profiles. The Add RESTful ATNA (Query and Feed) 
supplement allows an HIE App to add audit events through a RESTful Feed to the Audit Record Repository.

###	Use Cases  
No extensions or restrictions to the profile use cases are specified in the Czech in national extension.

### Actors and Transactions  
No extensions or restrictions to the actors and transactions are specified in the Czech national extension. 

<div>
{%include ATNA_actor_diagram.svg %}
</div>
This figure shows the actors directly involved in the _Add RESTful ATNA_ Profile and the relevant transactions 
between them.

### ATNA Actor Options
The Audit Record Repository SHALL support the ATX: FHIR Feed Option.

### Required Actor Grouping  
This national extension enforces authentication and authorization for access control. Therefore actors of this profile must be grouped with actors of other profiles according to the following table: 

| Actor                                                     | Required Grouping                                                | Optionality | Remark |
|-----------------------------------------------------------|------------------------------------------------------------------|-------------|--------|
| Audit Record Repository                                   |IUA Resource Server, ATNA Secure Node       | R           | Communication is secured with mTLS [ITI-19] and an IUA access token [ITI-72] |
| Any Actor grouped with Secure Node or Secure Application  |IUA Authorization Client  | R           | Obtains the access token from the central eHealth authorization server [ITI-71] |
| AAfD                                                      | ATNA Audit Record Forwarder | R        | Forwards audit events to the central eHealth ATNA component |
{:class="table table-bordered"}

<figcaption ID="1">Table 1: Grouping of actors required by this national extension. </figcaption>