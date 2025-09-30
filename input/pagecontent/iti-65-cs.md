Tato část odpovídá transakci [ITI-65] technického rámce IHE. Transakce [ITI-65] je používána aktéry zdroje dokumentu a příjemcem dokumentu. Transakce Provide Document Bundle [ITI-65] se používá k přenosu sady dokumentů a souvisejících metadat.

### Rozsah

Transakce Provide Document Bundle [ITI-65] předává požadavek Provide Document Bundle Request od zdroje dokumentu příjemci dokumentu.

### Role aktérů

**Tabulka 1: Role aktérů**

|Aktér | Role |
|-------------------+--------------------------|
| Zdroj dokumentu    | Odesílá dokumenty a metadata příjemci dokumentu |
| Příjemce dokumentů | Přijímá dokumenty a metadata odeslané ze zdroje dokumentů |
{: .grid}

### Odkazované normy

**FHIR-R4** [HL7 FHIR Release 4.0](http://www.hl7.org/FHIR/R4)

### Zprávy

<div>
{%include ITI-65-seq.svg%}
</div>

<br clear="all">

**Obrázek 1: Interakce při poskytování balíčku dokumentů**

#### Požadavek na balíček dokumentů

FHIR `Bundle.meta.profile` musí mít následující hodnotu:

`https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Comprehensive.ProvideBundle`

Žádost o balíček MUSÍ odpovídat [CH MHD Poskytnutí komplexního balíčku dokumentů](StructureDefinition-cz-mhd-providedocumentbundle-comprehensive.html).

Hodnota DocumentReference.content.attachment.url MUSÍ odkazovat na binární zdroj obsažený v balíčku (viz
[Vyřešení odkazů v balíčcích](https://hl7.org/fhir/R4/bundle.html#references) pro informace o tom, jak vytvořit platný odkaz).

#### Odpověď na balíček dokumentů

Balíček odpovědi MUSÍ odpovídat [CH MHD Poskytnout komplexní odpověď na balíček dokumentů](StructureDefinition-cz-mhd-providedocumentbundle-comprehensive-response.html).

#### Zdroj CapabilityStatement

Zdroj CapabilityStatement pro **zdroj dokumentu** je [MHD Document Source](CapabilityStatement-CZ-MHD-DocumentSource.html).

Zdroj CapabilityStatement pro **příjemce dokumentu** je [MHD Document Recipient](CapabilityStatement-CZ-MHD-DocumentRecipient.html).

### Bezpečnostní hlediska

Transakce MUSÍ být zabezpečena šifrováním Transport Layer Security (TLS) a ověřením serveru pomocí 
serverových certifikátů. 

Transakce MUSÍ používat ověřování a autorizaci klienta pomocí jedné z následujících strategií:
1. Použít rozšířený přístupový token definovaný v IUA předávaný podle definice v transakci [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72).
2. nebo použít vzájemné ověření (mTLS) na transportní vrstvě v kombinaci s tokenem XUA pro autorizaci z transakce Get X-User Assertion (příloha 5.1 1.6.4.2). Token XUA MUSÍ být předán tak, jak je definováno v transakci [Začlenění přístupového tokenu [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72).

#### Úvahy týkající se bezpečnostního auditu

##### Audit zdroje dokumentu

Bude dodáno v budoucnu (ATNA).

**Zdroj dokumentu** musí zaznamenat

##### Audit příjemce dokumentu
