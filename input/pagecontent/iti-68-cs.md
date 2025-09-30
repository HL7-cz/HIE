Tato část odpovídá transakci [ITI-68] technického rámce IHE. Transakce [ITI-68] je používána aktéry Document Consumer (Spotřebitel dokumentů) a Document Responder (Odesílatel dokumentů).

### Rozsah

Transakce Retrieve Document [ITI-68] (Načíst dokument) je používána aktérem Document Consumer (Spotřebitel dokumentů) k načtení dokumentu od aktéra Document Responder (Odesílatel dokumentů).

### Role aktérů

**Tabulka 1: Role aktérů**

|Aktér | Role |
|-------------------+--------------------------|
| [Spotřebitel dokumentů]    | Požádá o dokument z odpovídače dokumentů |
| [Odesílatel dokumentů] | Poskytne dokument spotřebiteli dokumentů |
{: .grid}

### Odkazované normy

**FHIR-R4** [HL7 FHIR Release 4.0](http://www.hl7.org/FHIR/R4)

### Zprávy

<div>
{%include ITI-68-seq.svg%}
</div>

<br clear="all">

**Obrázek 1: Interakce při načítání dokumentu**

#### Zpráva s požadavkem na načtení dokumentu

Tato zpráva je požadavek HTTP GET na načtení dokumentu. 

##### Spouštěcí události

Spotřebitel dokumentu chce získat dokument. 

##### Sémantika zprávy

Spotřebitel dokumentu odešle serveru požadavek HTTP GET. Požadavek spotřebitele dokumentu může spočívat v načtení obsahu dokumentu, na který odkazuje DocumentReference.content.attachment.url. 

Spotřebitel dokumentu může poskytnout hlavičku HTTP Accept v souladu se sémantikou protokolů HTTP (viz RFC2616, oddíl 14.1).  To umožňuje spotřebiteli dokumentu označit preferované typy MIME, aby respondent dokumentu mohl poskytnout požadovaný dokument v jiném kódování, než je kódování uvedené v DocumentReference. Například označení `application/fhir+json` by mohlo vést k tomu, že odpověď od respondenta dokumentu bude json FHIR Bundle typu `document` se všemi obsahy kódovanými jako zdroje FHIR.

Jediným MIME typem, u kterého je zaručeno, že bude vrácen, je MIME typ uvedený v DocumentReference.content.attachment.contentType.

Hlavička HTTP If-Unmodified-Since nesmí být zahrnuta v požadavku GET.

##### Očekávané akce

Document Responder poskytne dokument v požadovaném typu MIME nebo odpoví HTTP stavovým kódem označujícím chybový stav. Document Responder není povinen dokument transformovat.

#### Načtení zprávy s odpovědí na dokument

Jedná se o odpověď odeslanou odesílatelem dokumentů. 

##### Spouštěcí události

Zpráva HTTP Response je odeslána po dokončení požadavku Retrieve Document Request. 

##### Sémantika zprávy

Tato zpráva musí být HTTP odpovědí, jak je specifikováno v RFC2616. Po vrácení požadovaného dokumentu musí dokumentový respondent odpovědět HTTP stavovým kódem 200. Tělo HTTP zprávy musí být obsahem požadovaného dokumentu.

Tabulka 2 obsahuje chybové situace a HTTP odpověď.

**Tabulka 2: Chybové kódy HTTP odpovědí a doporučený text**

|Situace    | HTTP odpověď |
|-----------|---------------|
|URI není známo    | 404 Document Not Found |
|Dokument je zastaralý nebo není k dispozici    | 410 Gone (nebo 404, pokud je 410 nepřijatelný z důvodu zásad zabezpečení/ochrany osobních údajů) |
|Odpovídající dokument není možné formátovat dokument v typech obsahu uvedených v poli „Accept“    | 406 Not Acceptable |
|Zadaný požadavek HTTP není jinak platnou hodnotou    | 403 Forbidden/Request Type Not Supported |
{: .grid}

Odpovídající dokument může vrátit jiné kódy stavu HTTP. Pokyny pro řešení odmítnutí přístupu souvisejícího s použitím 200, 403 a 404 naleznete v [ITI TF-2x: Příloha Z.7](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.8-mobile-security-considerations).

Odpovídající dokument by měl doplnit vrácený chybový kód o popis chybového stavu srozumitelný pro člověka.

##### Očekávané akce

Spotřebitel dokumentu zpracovává výsledky podle pravidel definovaných aplikací.

#### CapabilityStatement

Odpovídající dokumenty implementující tuto transakci musí poskytnout zdroj CapabilityStatement, jak je popsáno v [ITI TF-2x: Příloha Z.3](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.3-capabilitystatement-resource), který označuje, že transakce byla implementována. 
- Požadavky CapabilityStatement pro [Spotřebitele dokumentů](CapabilityStatement-CZ-MHD-DocumentConsumer.html)
- Požadavky CapabilityStatement pro [Odpovídajícího na dokumenty](CapabilityStatement-CZ-MHD-DocumentResponder.html)

### Bezpečnostní aspekty

Tato transakce by neměla vracet informace, ke kterým nemá spotřebitel dokumentů oprávnění. 

#### Bezpečnostní audit

Kritéria bezpečnostního auditu jsou podobná jako u transakce Retrieve Document Set-b [ITI-43].

Specifikace bude dodána později (ATNA).

##### Document Consumer Audit



##### Document Responder Audit

