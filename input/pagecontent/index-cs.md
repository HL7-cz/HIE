### Úvod 
Tato implementační příručka vychází z [FHIR verze R4]. Národní rozšíření dokumentovaná v této implementační příručce se používají ve spojení s definicemi integračních profilů, aktérů a transakcí uvedenými v svazcích 1 až 3 Technického rámce IT infrastruktury IHE.
Tato implementační příručka s národními rozšířeními integračních profilů IHE byla vytvořena za účelem splnění požadavků zákona č. 236/2025 Sb. o digitalizaci zdravotnictví. 

### Stručný rozsah
Dočasné úložiště je klíčovou součástí infrastruktury elektronického zdravotnictví v rámci sítí pro výměnu informací o zdravotní péči. Slouží k dočasnému ukládání a distribuci dokumentace o zdravotní péči mezi poskytovateli zdravotní péče, zdravotními pojišťovnami a dalšími oprávněnými subjekty.

Hlavním cílem této implementační příručky je popsat komunikaci s dočasným úložištěm. Dočasné úložiště je součástí Národního plánu elektronického zdravotnictví a jeho architektura je navržena s ohledem na bezpečnost, interoperabilitu a škálovatelnost v souladu s platnými českými a evropskými právními předpisy (např. GDPR, NIS2, EHDS).
Dočasné úložiště je centrální úložiště zdravotnických údajů, které podporuje následující klíčové funkce:
- Ukládání zdravotnické dokumentace v elektronické podobě, včetně metadat (FHIR, CDA, XML, PDF).
- Bezpečný přenos dokumentace mezi poskytovateli zdravotní péče a zdravotními pojišťovnami prostřednictvím zabezpečených API a portálového řešení.
- Ověřování a validace totožnosti odesílatele a příjemce prostřednictvím hlavního registru zdravotnických pracovníků (KRZP), hlavního registru poskytovatelů zdravotní péče (KRPZS) a registru práv a mandátů.
- Zajištění integrity a autenticity dat prostřednictvím elektronických podpisů a certifikovaných hash funkcí.
- Možnost auditu a monitorování přístupu v souladu s požadavky zákona o kybernetické bezpečnosti a GDPR.

Tato příručka je rozdělena na několik stránek, které jsou uvedeny v horní části každé stránky na liště nabídek.

- [Home - Domovská stránka](index.html): Tato stránka obsahuje úvod a rozsah této příručky.
- Svazek 1:
  - [Mobilní přístup k zdravotním dokumentům (MHD)](mhd.html): Tato část specifikuje české národní rozšíření pro mobilní přístup k zdravotním dokumentům (MHD) 
- Svazek 2:
  - [Poskytnutí balíčku dokumentů [ITI-65]](iti-65.html): Tato část popisuje dodatečné požadavky pro českou HIE transakce Poskytnutí balíčku dokumentů [ITI-65] definované v profilu MHD zveřejněném v IHE ITI Trial Implementation „Mobilní přístup k zdravotním dokumentům“.
- Příloha:
  - [Profily](profiles.html): Tato část obsahuje všechny profily definované v této implementační příručce.
- [Artefakty](artifacts.html): Tato stránka obsahuje seznam artefaktů FHIR definovaných jako součást této implementační příručky.

### Závislosti

{% include dependency-table.xhtml %}

### Rozdílová analýza verzí

{% include cross-version-analysis.xhtml %}

### Prohlášení o duševním vlastnictví

{% include ip-statements.xhtml %}

