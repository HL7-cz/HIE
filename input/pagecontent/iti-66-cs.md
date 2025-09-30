Tato část odpovídá transakci [ITI-66] technického rámce IHE. Transakce [ITI-66] je používána aktéry Document Consumer a Document Responder. Tato transakce se používá k vyhledání a vrácení metadat pro dříve uložené sady nebo složky odeslaných dokumentů.

### Rozsah

Transakce Find Document Lists [ITI-66] se používá k vyhledání seznamů zdrojů, které splňují sadu parametrů. Je ekvivalentní: 

* dotazu FindSubmissionSets v transakci Registry Stored Query [\[ITI-18\]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html), jak je dokumentováno v [ITI TF-2: 3.18.4.1.2.3.7.2](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html#3.18.4.1.2.3.7.2). 
* Dotaz FindFolders v transakci Registry Stored Query [\[ITI-18\]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html), jak je popsáno v [ITI TF-2: 3.18.4.1.2.3.7.3](https://profiles.ihe.net/ITI/TF/Volume2/ITI-18.html#3.18.4.1.2.3.7.3). 

Výsledkem dotazu je balíček obsahující seznam zdrojů, které odpovídají parametrům dotazu.

### Role aktérů

**Tabulka 1: Role aktérů**

|Aktér | Role |
|-------------------+--------------------------|
| Spotřebitel dokumentů    | Žádá o seznam zdrojů, které odpovídají zadaným kritériím, od respondenta dokumentů |
| Odesílatel dokumentů | Vrací seznam zdrojů, které odpovídají vyhledávacím kritériím poskytnutým spotřebitelem dokumentů |
{: .grid}

### Odkazované normy

**FHIR-R4** [HL7 FHIR Release 4.0](http://www.hl7.org/FHIR/R4)

### Zprávy

<div>
{%include ITI-66-seq.svg%}
</div>

<br clear="all">

**Obrázek 1: Interakce vyhledávání seznamů dokumentů**

#### Najít odkazy na dokumenty Odpověď

Odpověď MUSÍ odpovídat struktuře [CZ MHD Najít odkazy na dokumenty Komplexní odpověď](StructureDefinition-cz-mhd-finddocumentlists-comprehensive-bundle.html).

##### Možnost federovaného přístupu napříč komunitami

Pokud odesílatel neodpoví, MUSÍ být k agregovaným výsledkům přidána operace OperationOutcome s varováním o závažnosti, které označuje, že komunita neodpovídá.

U shodných odkazů na dokumenty vrácených odesílatelem MUSÍ odesílatel zajistit přepsáním identifikátoru a adresy attachment.url, že následné čtení, aktualizace nebo načtení dokumentů bude zpracováno stejným aktérem dokumentového respondenta. Jakékoli přepsání identifikátoru nebo adresy URL MUSÍ být řešitelné po dobu alespoň jedné hodiny.

#### Zdroj CapabilityStatement

Zdrojem CapabilityStatement pro **Spotřebitele seznamů dokumentů** je [Spotřebitel seznamů dokumentů MHD](CapabilityStatement-CZ-MHD-DocumentConsumer.html).

Zdrojem CapabilityStatement pro **Odpovídajícího na seznamy dokumentů** je [Odpovídající na seznamy dokumentů MHD](CapabilityStatement-CZ-MHD-DocumentResponder.html).

### Bezpečnostní hlediska

Transakce MUSÍ být zabezpečena šifrováním Transport Layer Security (TLS) a ověřením serveru pomocí
serverových certifikátů. Transakce mezi komunitami MUSÍ používat mTLS.

Transakce MUSÍ používat ověřování a autorizaci klienta pomocí jedné z následujících strategií:
1. Použít rozšířený přístupový token definovaný v IUA, který je předáván podle definice v transakci [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72).
2. nebo použít vzájemné ověřování (mTLS) na transportní vrstvě v kombinaci s tokenem XUA pro autorizaci z transakce Get X-User Assertion (příloha 5.1 1.6.4.2). Token XUA MUSÍ být předán tak, jak je definováno v transakci [Začlenění přístupového tokenu [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72).

#### Úvahy týkající se bezpečnostního auditu

Bude doplněno v budoucnu (ATNA)

##### Audit spotřebitele dokumentu


##### Audit respondenta dokumentu