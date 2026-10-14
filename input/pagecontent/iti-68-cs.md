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

### Bezpečnostní hlediska

Zabezpečení transakce vychází ze Standardu akreditovaných afinitních domén (AAfD). Transportní vrstva (mTLS) a aplikační vrstva (přístupový token IUA) se používají **vždy současně**, nejde o alternativy.

#### Transportní vrstva – autentizace uzlů (mTLS)

Transakce MUSÍ být zabezpečena protokolem TLS 1.3 (minimálně TLS 1.2 se silnými šifrovacími sadami) se vzájemnou autentizací uzlů (mTLS) dle transakce ATNA [Authenticate Node [ITI-19]](https://profiles.ihe.net/ITI/TF/Volume2/ITI-19.html). Klient i server se prokazují certifikátem X.509 vydaným certifikační autoritou MZČR a každá strana ověřuje platnost certifikátu protistrany. mTLS se používá pro veškerou komunikaci: mezi IS PZS a AAfD, mezi AAfD navzájem i mezi AAfD a centrálními službami elektronického zdravotnictví.

#### Aplikační vrstva – autorizace (IUA)

Klient MUSÍ v každém požadavku předat přístupový token dle profilu IHE IUA ve formátu JSON Web Token (JWT):

1. IS PZS získá metadata centrálního autorizačního serveru elektronického zdravotnictví transakcí [Get Authorization Server Metadata [ITI-103]](https://profiles.ihe.net/ITI/IUA/index.html#3103-get-authorization-server-metadata-iti-103) a přístupový token transakcí [Get Access Token [ITI-71]](https://profiles.ihe.net/ITI/IUA/index.html#371-get-access-token-iti-71). Vůči autorizačnímu serveru se prokazuje JWT assertion podepsanou privátním klíčem svého systémového certifikátu. Token obsahuje identifikaci PZS. Token se obnovuje před uplynutím jeho platnosti.
2. Token je předán v hlavičce `Authorization: Bearer` dle transakce [Incorporate Access Token [ITI-72]](https://profiles.ihe.net/ITI/IUA/index.html#372-incorporate-access-token-iti-72).
3. Server (IUA Resource Server) MUSÍ token validovat (podpis, vydavatel, platnost, cílová služba) a ověřit, že PZS identifikovaný v tokenu je platný v Kmenovém registru poskytovatelů zdravotních služeb, je připojen k dané AAfD a má oprávnění k požadované operaci. Je-li v kontextu volání uveden zdravotnický pracovník, MUSÍ být evidován v kontextu PZS a platný v Kmenovém registru zdravotnických pracovníků.

#### Komunikace mezi AAfD

Předává-li domovská AAfD požadavek do jiné AAfD, získá pro cílovou AAfD nový přístupový token mechanismem OAuth 2.0 Token Exchange dle [RFC 8693](https://www.rfc-editor.org/rfc/rfc8693): `subject_token` je přístupový token PZS, `actor_token` je systémový token volající AAfD. Cílová AAfD ověří v Katalogu služeb, že volající AAfD je akreditovaná, a vydá token, který obsahuje identitu PZS (`sub`) a identitu zprostředkující AAfD (`act`). Přímé předávání tokenu PZS do jiné AAfD bez validace není dovoleno.

Aktéři MUSÍ podporovat zpracování hlavičky `traceparent` dle [W3C Trace Context](https://www.w3.org/TR/trace-context/).

Tato transakce nesmí vracet informace, ke kterým nemá spotřebitel dokumentů oprávnění.

### Bezpečnostní audit

Aktéři MUSÍ zaznamenat auditní událost a odeslat ji transakcí [Record Audit Event [ITI-20]](iti-20-cs.html):

- **Spotřebitel dokumentů (Document Consumer)** dle profilu [CZ Audit Event for [ITI-68] Document Consumer](StructureDefinition-cz-auditEventIti68Consumer.html),
- **Respondent (Document Responder)** dle profilu [CZ Audit Event for [ITI-68] Document Responder](StructureDefinition-cz-auditEventIti68Responder.html).

Auditní událost MUSÍ zachytit identitu uzlů z mTLS a údaje z přístupového tokenu IUA podle pravidel v kapitole [Zaznamenání zabezpečení komunikace](iti-20-cs.html#zaznamenání-zabezpečení-komunikace). AAfD zaznamená poskytnutí dokumentu (PZS, ZP, RID nebo DRID, URI dokumentu). Předává-li AAfD dokument získaný z jiné AAfD, zaznamená tuto skutečnost, přestože dokument neukládá.
