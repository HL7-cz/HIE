Tato část popisuje dodatečné požadavky pro českou HIE transakci [Najít odkazy na dokumenty
[ITI-67]](https://profiles.ihe.net/ITI/MHD/ITI-67.html) definované v profilu MHD zveřejněném v IHE ITI
Zkušební implementace „Mobilní přístup k zdravotním dokumentům“.

### Rozsah

Transakce Find Document References se používá k vyhledání zdrojů DocumentReference, které
splňují sadu parametrů. Je ekvivalentní dotazům _FindDocuments_ a
_FindDocumentsByReferenceId_ z transakce _Registry Stored Query_ [ITI-18].
Výsledkem dotazu je balíček FHIR obsahující zdroje DocumentReference, které odpovídají
parametrům dotazu.

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

<div>{% include ITI-67-seq.svg %}</div>

#### Zpráva s požadavkem na vyhledání odkazů na dokumenty

Spotřebitel dokumentů MUSÍ zahrnout vyhledávací parametr patient.identifier typu RID.
Vyhledávací parametry typu [token](https://hl7.org/fhir/R4/search.html#token) MUSÍ obsahovat jak systém, tak kód.

Příklad **požadavku** na vyhledání odkazu na dokument:
```http
GET [base]/DocumentReference?patient.identifier=urn:oid:2.16.756.5.30.1.127.3.10.3|761337610411353650&status=current HTTP/1.1
Accept: application/fhir+json
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00
```

#### Očekávané akce

Odpovídající dokument MUSÍ zpracovat dotaz, aby zjistil položky DocumentReference, které odpovídají zadaným parametrům vyhledávání.

Odpovídající dokument MUSÍ podporovat požadavky na počet stránek vyhledávání od spotřebitele dokumentu až do 100 zdrojů.

Odpovídající dokument MUSÍ nastavit hodnotu `DocumentReference.content.attachment.url` na URL použitou v transakcích ITI-68 k načtení obsahu daného dokumentu.

#### Zpráva s odpovědí na vyhledání odkazů na dokumenty

Odpověď MUSÍ odpovídat [CZ MHD Find Document References Comprehensive Response message](StructureDefinition-cz-mhd-finddocumentreference-comprehensive-bundle.html)

##### Možnost federovaného přístupu napříč komunitami

Pokud dokumentový respondent neodpoví, MUSÍ být k agregovaným výsledkům přidán OperationOutcome s varováním o závažnosti, které označuje, že komunita neodpovídá.

U shodných odkazů na dokumenty vrácených dokumentovým respondentem MUSÍ dokumentový respondent zajistit přepsáním id a attachment.url, že následné čtení, aktualizace nebo načtení dokumentů bude zpracováno stejným aktérem dokumentového respondenta. Jakékoli přepsání id, url MUSÍ být řešitelné po dobu alespoň jedné hodiny.

#### Zdroj CapabilityStatement

Zdroj CapabilityStatement pro **Spotřebitele dokumentů** je [MHD Spotřebitel dokumentů](CapabilityStatement-CZ-MHD-DocumentConsumer.html).

Zdroj CapabilityStatement pro **Odpovídajícího na dokumenty** je [MHD Odpovídající na dokumenty](CapabilityStatement-CZ-MHD-DocumentResponder.html).

### Bezpečnostní opatření

Transakce MUSÍ být zabezpečena šifrováním Transport Layer Security (TLS) a ověřením serveru pomocí
serverových certifikátů. Transakce mezi komunitami MUSÍ používat mTLS.

Transakce MUSÍ používat ověřování a autorizaci klienta pomocí jedné z následujících strategií:
1. Použít rozšířený přístupový token definovaný v IUA předávaný podle definice v transakci [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72).
2. nebo použít vzájemné ověření (mTLS) na transportní vrstvě v kombinaci s tokenem XUA pro autorizaci z transakce Get X-User Assertion (příloha 5.1 1.6.4.2). Token XUA MUSÍ být předán tak, jak je definováno v transakci [Začlenění přístupového tokenu [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72).

#### Úvahy o bezpečnostním auditu

Bude dodáno později (ATNA).

##### Audit spotřebitele dokumentů

##### Audit respondenta dokumentu
