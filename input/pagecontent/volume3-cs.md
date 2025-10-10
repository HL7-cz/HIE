V kontextu HIE existují čtyři různé kategorie Auditních Událostí:

<ol type="a">
    <li>
        Správa dokumentů (např. dokument pacienta byl nahrán nebo byl vyhledán seznam metadat dokumentů).
    </li>
    <li>
        Správa politik (např. pacient udělil zdravotnickému pracovníkovi přístupová práva ke svému záznamu).
    </li>
    <li>
        Přístup k Repozitáři Auditních Záznamů Pacienta pacientem nebo jeho zástupcem (pacient si zobrazil Auditní Stopu Repozitáře Auditních Záznamů).
    </li>
    <li>
        Notifikace pacienta o vstupu zdravotnických pracovníků do skupiny.
    </li>
</ol>

Každá kategorie je popsána jako profil obsahu. Tyto profily obsahu vycházejí ze zdrojového objektu AuditEvent (Auditní Událost) [http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html).

Zdrojový objekt AuditEvent má [mapovací pravidla na formát DICOM auditní zprávy](http://hl7.org/fhir/R4/auditevent-mappings.html#dicom), což umožňuje mapování na ATNA.

### Typy Událostí Konzumace Auditní Stopy
Následující Typy Událostí Konzumace Auditní Stopy (Audit Trail Consumption Event Types) jsou definovány a musí být podporovány.

{:class="table table-bordered"}
| Typ | Popis | Odkaz na profil| Komunitní požadavek (Opt Community) |
| --- | --- | --- | --- |
| ATC_DOC_CREATE | Nahrání dokumentu | [Profil Obsahu Auditních Událostí Dokumentů](#document-audit-event-content-profile) | R (Vyžadováno) |
| ATC_DOC_READ | Získání dokumentu | [Profil Obsahu Auditních Událostí Dokumentů](#document-audit-event-content-profile) | R (Vyžadováno) |
| ATC_DOC_UPDATE | Aktualizace dokumentu nebo metadat dokumentu | [Profil Obsahu Auditních Událostí Dokumentů](#document-audit-event-content-profile) | R (Vyžadováno) |
| ATC_DOC_DELETE | Odstranění dokumentu | [Profil Obsahu Auditních Událostí Dokumentů](#document-audit-event-content-profile) | R (Vyžadováno) |
| ATC_DOC_SEARCH | Vyhledávání dokumentů | [Profil Obsahu Auditních Událostí Dokumentů](#document-audit-event-content-profile) | R (Vyžadováno) |
| ATC_POL_CREATE_AUT_PART_AL | ATC_POL_CREATE_AUT_PART_AL	Autorizovat účastníky pro úroveň/datum přístupu | [Profil Obsahu Auditních Událostí Politik](#policy-audit-event-content-profile) | R, (NP, pokud se nejedná o referenční komunitu) |
| ATC_POL_UPDATE_AUT_PART_AL | Aktualizovat úroveň/datum přístupu autorizovaných účastníků | [Profil Obsahu Auditních Událostí Politik](#policy-audit-event-content-profile) | R, (NP, pokud se nejedná o referenční komunitu) |
| ATC_POL_REMOVE_AUT_PART_AL | Odebrat autorizaci pro účastníky | [Profil Obsahu Auditních Událostí Politik](#policy-audit-event-content-profile) | R, (NP, pokud se nejedná o referenční komunitu) |
| ATC_POL_DEF_CONFLEVEL | Nastavit nebo aktualizovat výchozí Úroveň Důvěrnosti | [Profil Obsahu Auditních Událostí Politik](#policy-audit-event-content-profile) | R, (NP, pokud se nejedná o referenční komunitu) |
| ATC_POL_DIS_EMER_USE | Zakázání Nouzového Přístupu | [Profil Obsahu Auditních Událostí Politik](#policy-audit-event-content-profile) | R, (NP, pokud se nejedná o referenční komunitu) |
| ATC_POL_ENA_EMER_USE | Povolení Nouzového Přístupu | [Profil Obsahu Auditních Událostí Politik](#policy-audit-event-content-profile) | R, (NP, pokud se nejedná o referenční komunitu) |
| ATC_POL_INCL_BLACKLIST | Přiřadit Zdravotnického Pracovníka na Černou Listinu | [Profil Obsahu Auditních Událostí Politik](#policy-audit-event-content-profile) | R, (NP, pokud se nejedná o referenční komunitu) |
| ATC_POL_EXL_BLACKLIST | Vyloučit Zdravotnického Pracovníka z Černé Listiny | [Profil Obsahu Auditních Událostí Politik](#policy-audit-event-content-profile) | R, (NP, pokud se nejedná o referenční komunitu) |
| ATC_LOG_READ | Přístup k Repozitáři Auditních Záznamů Pacienta | [Access Audit Trail Content Profile](#access-audit-trail-content-profile) | R |
| ATC_HPD_GROUP_ENTRY_NOTIFY | Vstup zdravotnických pracovníků do skupiny | [HPD Group Entry Audit Event Content Profile](#hpd-group-entry-audit-event-content-profile) | R, (NP, pokud se nejedná o referenční komunituy) |

_Tabulka 4: Typy Událostí Konzumace Auditní Stopy


### Profil Obsahu Auditních Událostí Dokumentů

Tento profil obsahu popisuje Auditní Události související se Správou Dokumentů. Musí být poskytnuty následující datové prvky:

{:class="table table-bordered"}
<table>
    <tbody>
        <tr>
            <td>
                <p><strong>Datový Prvek</strong></p>
            </td>
            <td>
                <p><strong>Popis</strong></p>
            </td>
            <td>
                <p><strong>Vlastnost/Hodnota</strong></p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Typ události</p>
            </td>
            <td colspan="2">
                <p>
                    Nahrání dokumentu, Získání dokumentu, Aktualizace dokumentu nebo metadat dokumentu, Odstranění dokumentu, Vyhledávání dokumentů
                </p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Datum a Čas Události</p>
            </td>
            <td>
                <p>&nbsp;</p>
            </td>
            <td>
                <p>FHIR instant</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Účastníci</p>
            </td>
            <td>
                <p>&nbsp;</p>
            </td>
            <td>
                <p>&nbsp;</p>
            </td>
        </tr>
        <tr>
            <td rowspan="6">
                <p>Iniciátor</p>
            </td>
            <td>
                <p>Pacient</p>
            </td>
            <td>
                <p>Jméno<br />RID</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Zástupce pacienta</p>
            </td>
            <td>
                <p>Jméno<br />RID</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Autorizovaný Zdravotnický Pracovník</p>
            </td>
            <td>
                <p>Jméno<br />KRZP</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Asistent Zdravotnického Pracovníka</p>
            </td>
            <td>
                <p>Jméno<br />KRZP</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Technický Uživatel</p>
            </td>
            <td>
                <p>Jméno<br />Identifikátor</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Administrátor dokumentu</p>
            </td>
            <td>
                <p>Jméno<br />KRZP</p>
            </td>
        </tr>
        <tr>
            <td rowspan="2">
                <p>Odpovědná osoba<sup><a href="#_ftn5.1">[5.1]</a></sup></p>
            </td>
            <td>
                <p>Pacient</p>
            </td>
            <td>
                <p>Jméno<br />RID</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Zdravotnický Pracovník</p>
            </td>
            <td>
                <p>Jméno<br />KRZP</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Skupiny, kde je Zdravotnický Pracovník členem</p>
            </td>
            <td>
                <p>&nbsp;</p>
            </td>
            <td>
                <p>Jméno skupiny<br />KRPZS</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Účel Použití</p>
            </td>
            <td>
                <p>&nbsp;</p>
            </td>
            <td>
                <p>NORM, EMER, AUTO, DICOM_AUTO</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Pacient</p>
            </td>
            <td>
                <p>Dotčený pacient</p>
            </td>
            <td>
                <p>RID</p>
            </td>
        </tr>
        <tr>
            <td rowspan="3">
                <p>Dokument<sup><a href="#_ftn5.2">[5.2]</a></sup></p>
            </td>
            <td>
                <p>Typ dokumentu</p>
            </td>
            <td>
                <p>typeCode (SNOMED CT code)</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Odkaz na dokument</p>
            </td>
            <td>
                <p>
                    uniqueId<br />repositoryUniqueId<br />homeCommunityID
                </p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Název dokumentu</p>
            </td>
            <td>
                <p>
                    title
                </p>
            </td>
        </tr>
    </tbody>
</table>
<p><sup><a href="#_ftnref5.1" name="_ftn5.1">[5.1]</a></sup> <small>Pokud se liší od Iniciátora (např. Zástupce pacienta jedná jménem pacienta, pak je pacient Odpovědnou stranou).</small></p>
<p><sup><a href="#_ftnref5.2" name="_ftn5.2">[5.2]</a></sup> <small>Vyžadováno pro nahrání dokumentu, získání dokumentu, aktualizaci dokumentu nebo metadat dokumentu a odstranění dokumentu, ale ne pro vyhledávání dokumentů.</small></p>

_Tabulka 5: Datové Prvky Auditní Události Dokumentů_

Tento profil definuje obsah auditních událostí dokumentů, které musí komunita poskytovat pro auditní stopu pacienta. Vychází ze zdrojového objektu AuditEvent. ([http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)).   


#### Příklady

Budou dodány


### Profil Obsahu Auditních Událostí Politik

Tento profil obsahu popisuje Auditní Události související se Správou Politik (Policy Management). Musí být poskytnuty následující datové prvky:

{:class="table table-bordered"}
<table>
    <tbody>
        <tr>
            <td>
                <p><strong>Datový Prvek</strong></p>
            </td>
            <td>
                <p><strong>Popis</strong></p>
            </td>
            <td>
                <p><strong>Vlastnost/Hodnota</strong></p>
            </td>
        </tr>
        <tr>
            <td rowspan="8">
                <p>Typ Události</p>
            </td>
            <td colspan="2">
                <p>Autorizovat účastníky pro úroveň/datum přístupu</p>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p>Aktualizovat úroveň/datum přístupu autorizovaných účastníků</p>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p>Odebrat autorizaci pro účastníky pro úroveň/datum přístupu</p>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p>Nastavit nebo aktualizovat výchozí Úroveň Důvěrnosti pro nové dokumenty</p>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p>Zakázání Nouzového Přístupu</p>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p>Povolení Nouzového Přístupu</p>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p>Vyloučit Zdravotnického Pracovníka z přístupu</p>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p>Zrušit vyloučení Zdravotnického Pracovníka z přístupu</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Datum a Čas Události</p>
            </td>
            <td>&nbsp;</td>
            <td>
                <p>FHIR instant</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Účastníci</p>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td rowspan="5">
                <p>Iniciátor</p>
            </td>
            <td>
                <p>Pacient</p>
            </td>
            <td>
                <p>Jméno/RID</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Zástupce pacienta</p>
            </td>
            <td>
                <p>Jméno<br />RID</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Autorizovaný Zdravotnický Pracovník<sup><a href="#_ftn8.1" name="_ftnref8.1">[8.1]</a></sup></p>
            </td>
            <td>
                <p>Jméno<br />KRZP</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Asistent Zdravotnického Pracovníka</p>
            </td>
            <td>
                <p>Jméno<br />KRZP</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Administrátor Politik</p>
            </td>
            <td>
                <p>Jméno<br />KRZP</p>
            </td>
        </tr>
        <tr>
            <td rowspan="2">
                <p>Odpovědná strana</p>
            </td>
            <td>
                <p>Pacient</p>
            </td>
            <td>
                <p>Jméno/RID</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Zdravotnický Pracovník</p>
            </td>
            <td>
                <p>Jméno<br />KRZP</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Pacient</p>
            </td>
            <td>
                <p>Dotčený pacient</p>
            </td>
            <td>
                <p>RID</p>
            </td>
        </tr>
        <tr>
            <td rowspan="7">
                <p>Zdroj</p>
            </td>
            <td>
                <p>Role zdroje</p>
            </td>
            <td>
                <p>HCP, GRP or REP</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Zdravotnický pracovník</p>
            </td>
            <td>
                <p>Jméno<br />KRZP</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Skupina Zdravotnických Pracovníků</p>
            </td>
            <td>
                <p>Jméno<br />KRPZS</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Zástupce pacienta</p>
            </td>
            <td>
                <p>Jméno<br />RID</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Úroveň přístupu<sup><a href="#_ftn8.2" name="_ftnref8.2">[8.2]</a></sup></p>
            </td>
            <td>
                <p>jedna z hodnot úrovně přístupu:<br />normal, restricted, delegation-and-restricted, delegation-and-normal, full</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Přístup omezen do data <sup><a href="#_ftn8.2" name="_ftnref8.2">[8.2]</a></sup></p>
            </td>
            <td>
                <p>Datum</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Úroveň poskytnutí<sup><a href="#_ftn8.3" name="_ftnref8.3">[8.3]</a></sup></p>
            </td>
            <td>
                <p>Jedna z hodnot:<br />normal, restricted, secret</p>
            </td>
        </tr>
    </tbody>
</table>
<p><sup><a href="#_ftnref8.1" name="_ftn8.1">[8.1]</a></sup> <small>Zdravotnický Pracovník nebo Asistent Zdravotnického Pracovníka může být účastníkem pouze pro první Typ Události (Autorizovat účastníky pro úroveň přístupu).</small></p>
<p><sup><a href="#_ftnref8.2" name="_ftn8.2">[8.2]</a></sup> <small>Úroveň Přístupu a datum, pokud je přístup omezen (AccessLimitedToDate), jsou vyžadovány pro první dva Typy Událostí (Autorizovat, aktualizovat Autorizaci účastníků pro úroveň/datum přístupu); pro ostatní Typy Událostí tyto parametry nemusí být specifikovány.</small></p>
<p><sup><a href="#_ftnref8.3" name="_ftn8.3">[8.3]</a></sup> <small>Úroveň Poskytnutí je relevantní pouze pro Typ Události Výchozí Úroveň Důvěrnosti pro nové Dokumenty.</small></p>

_Tabulka 8: Datové Prvky Auditní Události Politik_

Tento profil definuje obsah auditních událostí politik, které musí komunita poskytovat pro auditní stopu pacienta. Vychází ze zdrojového objektu AuditEvent ([http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)).   

#### Příklady

Budou dodány

### Profil Obsahu Přístupu k Auditní Stopě

Tento profil obsahu popisuje Auditní Událost související s Přístupem k Auditní Stopě Pacienta z Repozitáře Auditních Záznamů Pacienta. Musí být poskytnuty následující datové prvky:

{:class="table table-bordered"}
<table>
    <tbody>
        <tr>
            <td>
                <p><strong>Datový Prvek</strong></p>
            </td>
            <td>
                <p><strong>Popis</strong></p>
            </td>
            <td>
                <p><strong>Vlastnost/Hodnota</strong></p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Typ Události</p>
            </td>
            <td>
                <p>&nbsp;</p>
            </td>
            <td>
                <p>Přístup k Auditní Stopě</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Datum a Čas Události</p>
            </td>
            <td>
                <p>&nbsp;</p>
            </td>
            <td>
                <p>FHIR instant</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Účastníci</p>
            </td>
            <td>
                <p>&nbsp;</p>
            </td>
            <td>
                <p>&nbsp;</p>
            </td>
        </tr>
        <tr>
            <td rowspan="2">
                <p>Iniciátor</p>
            </td>
            <td>
                <p>Pacient</p>
            </td>
            <td>
                <p>Jméno<br />RID</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Zástupce pacienta</p>
            </td>
            <td>
                <p>Jméno<br />RID</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Odpovědná strana</p>
            </td>
            <td>
                <p>Pacient</p>
            </td>
            <td>
                <p>Jméno<br />RID</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Pacient</p>
            </td>
            <td>
                <p>Dotčený pacient</p>
            </td>
            <td>
                <p>EPR-SPID</p>
            </td>
        </tr>
    </tbody>
</table>

_Table 11: Datové Prvky Přístupu k Auditní Stopě_

Tento profil definuje událost přístupu k auditní stopě, kterou musí komunita poskytovat pro auditní stopu pacienta. Vychází ze zdrojového objektu AuditEvent. ([http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)).   

#### Příklady 

Budou dodány


### Profil Obsahu Auditních Událostí Vstupu do Skupiny HPD

Tento profil obsahu popisuje Auditní Událost související se vstupem zdravotnického pracovníka do skupiny HPD, o čemž je pacient notifikován. Musí být poskytnuty následující datové prvky:

{:class="table table-bordered"}
<table>
    <tbody>
        <tr>
            <td>
                <p><strong>Datový prvek</strong></p>
            </td>
            <td>
                <p><strong>Popis</strong></p>
            </td>
            <td>
                <p><strong>Vlastnost/Hodnota</strong></p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Typ Události</p>
            </td>
            <td colspan="2">
                <p>Pacient notifikován o přidání Zdravotnických Pracovníků do skupiny</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Datum a Čas Události</p>
            </td>
            <td>
                <p>&nbsp;</p>
            </td>
            <td>
                <p>FHIR instant</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Notifikační služba</p>
            </td>
            <td>
                <p>&nbsp;</p>
            </td>
            <td>
                <p>Jméno</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Pacient</p>
            </td>
            <td>
                <p>Notifikovaný pacient</p>
            </td>
            <td>
                <p>RID</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Zdravotničtí Pracovníci</p>
            </td>
            <td>
                <p>Zdravotničtí Pracovníci</p>
            </td>
            <td>
                <p>Jméno<br />KRZP</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>Skupina</p>
            </td>
            <td>
                <p>Skupina, do které jsou Zdravotničtí Pracovníci přidáni jako členové</p>
            </td>
            <td>
                <p>Jméno<br />KRPZS</p>
            </td>
        </tr>
    </tbody>
</table>

_Table 13: Prvky Auditní Události Vstupu do Skupiny HPD_

Tento profil definuje obsah auditní události vstupu do skupiny HPD. Vychází ze zdrojového objektu AuditEvent ([http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)).   

#### Příklady

Budou doplněny

