### Introduction 
This implementation guide is based on [FHIR version R4]. The national extensions documented in this implementation guide are used in conjunction with the definitions of integration profiles, actors, and transactions specified in volumes 1 to 3 of the IHE IT Infrastructure Technical Framework.
This implementation guide with national extensions to IHE integration profiles was created to fulfil the requirements of Act No. 236/2025 Coll. on the digitisation of healthcare. 

### Scope
Temporary storage is a key component of the eHealth infrastructure within healthcare information exchange networks. It is used for the temporary storage and distribution of healthcare documentation between healthcare providers, health insurance companies, and other authorized entities.

The main objective of this implementation guide is to describe communication with the Temporary Storage.  Temporary Storage is part of the National eHealth Plan and its architecture is designed with security, interoperability, and scalability in mind, in accordance with applicable Czech and EU legislation (e.g., GDPR, NIS2, EHDS).
The temporary storage is a central repository of healthcare data that supports the following key functionalities:
- Storage of healthcare documentation in electronic form, including metadata (FHIR, CDA, XML, PDF).
- Secure transfer of documentation between healthcare providers and health insurance companies via secure APIs and a portal solution.
- Validation and verification of sender and recipient identities via the Master Register of Healthcare Professionals (KRZP), the Master Register of Healthcare Providers (KRPZS), and the Register of Rights and Mandates.
- Ensuring data integrity and authenticity through electronic signatures and certified hash functions.
- The ability to audit and monitor access in accordance with the requirements of the Cybersecurity Act and GDPR.

This guide is divided into several pages which are listed at the top of each page in the menu bar.

- [Home](index.html): This page provides the introduction and scope for this guide.
- Volume 1:
  - [Mobile Access to Health Documents (MHD)](mhd.html): This section specifies Czech national extensions to the Mobile Access to Health Documents (MHD) 
- Volume 2:  
  - [Provide Document Bundle [ITI-65]](iti-65.html): This section describes the additional requirements for the Czech HIE of the Provide Document Bundle [ITI-65] transaction defined in the MHD Profile published in the IHE ITI Trial Implementation “Mobile Access to Health Documents”.
- Appendix:
  - [Profiles](profiles.html): This section contains all profiles defined in this implementation guide.
- [Artifacts](artifacts.html): This page provides a list of the FHIR artifacts defined as part of this implementation guide.


### Dependencies

{% include dependency-table.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### IP statements

{% include ip-statements.xhtml %}

