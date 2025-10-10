Tato kapitola specifikuje česká národní rozšíření pro doplněk Add RESTful ATNA (Query and Feed), publikovaný v rámci profilu [IHE ITI Trial Implementation](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_RESTful-ATNA.pdf).

###	Rozsah  
Aplikace elektronické zdravotní dokumentace (HIE App) musí odesílat auditní záznamy v souladu s profily IHE ITI. Doplňkový profil Add RESTful ATNA (Query and Feed) umožňuje aplikaci EPR přidávat auditní události prostřednictvím RESTful feedu do Úložiště auditních záznamů (Audit Record Repository).

###	Případy použití  
V národním českém rozšíření nejsou definována žádná další omezení ani přídavky k případům použití původního profilu.

### Role a transakce  
V národním rozšíření nejsou přidány ani změněny role (aktory) ani transakce oproti základnímu profilu. 

<div>
{%include ATNA_actor_diagram.svg %}
</div>
Toto schéma znázornuje aktéry a jejich transakce profilu ATNA.

### Možnosti aktorů ATNA
Úložiště auditních záznamů (Audit Record Repository) musí podporovat možnost ATX: FHIR Feed Option.

### Požadované seskupení aktorů  
Toto národní rozšíření vynucuje autentizaci a autorizaci pro řízení přístupu. Proto musí být aktory tohoto profilu seskupeny s aktory z jiných profilů takto: 

| Aktor                                                     | Požadované seskupení                                                | Volitelnost | Poznámka |
|-----------------------------------------------------------|------------------------------------------------------------------|-------------|--------|
| Audit Record Repository                                  |  IUA Resource Server       | R (povinné)           | -      |
| Jakýkoli aktor seskupený se Secure Node nebo Secure Application  |IUA Authorization Client  | R (povinné)          | -      |
{:class="table table-bordered"}

<figcaption ID="1">Tabulka 1: Seskupování aktorů v kontextu národního rozšíření. </figcaption>

Poznámka: „R“ znamená povinné (Required).