There are four different categories of Audit Events in the context of the EPR:

<ol type="a">
    <li>
        Document management (e.g. a document has been uploaded to the EPR of a patient or a list of document metadata has been retrieved)
    </li>
    <li>
        Policy management (e.g. a patient has given a healthcare professional access rights to his EPR)
    </li>
    <li>
        Access Patient Audit Record Repository by a patient or representative (a patient viewed the Audit Trail for the Audit Record Repository)
    </li>
    <li>
        Notification of the patient about the entry of healthcare professionals into a group
    </li>
</ol>

Each category is described as a content profile. These content profiles are based on the AuditEvent Resource, [http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html).

The AuditEvent Resource has [mapping rules to the DICOM audit message format](http://hl7.org/fhir/R4/auditevent-mappings.html#dicom), which allows to map to ATNA.

### Audit Trail Consumption Event Types
The following Audit Trail Consumption Event Types are defined and shall be supported.

{:class="table table-bordered"}
| Type | Description | Profile Ref | Opt Community |
| --- | --- | --- | --- |
| ATC_DOC_CREATE | Document upload | [Document Audit Event Content Profile](#document-audit-event-content-profile) | R |
| ATC_DOC_READ | Document retrieval | [Document Audit Event Content Profile](#document-audit-event-content-profile) | R |
| ATC_DOC_UPDATE | Document or Document Metadata update | [Document Audit Event Content Profile](#document-audit-event-content-profile) | R |
| ATC_DOC_DELETE | Document removal | [Document Audit Event Content Profile](#document-audit-event-content-profile) | R |
| ATC_DOC_SEARCH | Document search | [Document Audit Event Content Profile](#document-audit-event-content-profile) | R |
| ATC_POL_CREATE_AUT_PART_AL | Authorize participants to access level/date | [Policy Audit Event Content Profile](#policy-audit-event-content-profile) | R, (NP if not reference community) |
| ATC_POL_UPDATE_AUT_PART_AL | Update access level/date of authorized participants | [Policy Audit Event Content Profile](#policy-audit-event-content-profile) | R, (NP: if not reference community) |
| ATC_POL_REMOVE_AUT_PART_AL | Remove authorization for participants | [Policy Audit Event Content Profile](#policy-audit-event-content-profile) | R, (NP: if not reference community) |
| ATC_POL_DEF_CONFLEVEL | Set or update default Confidentiality Level | [Policy Audit Event Content Profile](#policy-audit-event-content-profile) | R, (NP: if not reference community) |
| ATC_POL_DIS_EMER_USE | Disabling Emergency Access | [Policy Audit Event Content Profile](#policy-audit-event-content-profile) | R, (NP: if not reference community) |
| ATC_POL_ENA_EMER_USE | Enabling Emergency Access | [Policy Audit Event Content Profile](#policy-audit-event-content-profile) | R, (NP: if not reference community) |
| ATC_POL_INCL_BLACKLIST | Assign Healthcare Professional to Blacklist | [Policy Audit Event Content Profile](#policy-audit-event-content-profile) | R, (NP: if not reference community) |
| ATC_POL_EXL_BLACKLIST | Exclude Healthcare Professional from Blacklist | [Policy Audit Event Content Profile](#policy-audit-event-content-profile) | R, (NP: if not reference community) |
| ATC_LOG_READ | Accessing Patient Audit Record Repository | [Access Audit Trail Content Profile](#access-audit-trail-content-profile) | R |
| ATC_HPD_GROUP_ENTRY_NOTIFY | Entry of healthcare professionals into a group | [HPD Group Entry Audit Event Content Profile](#hpd-group-entry-audit-event-content-profile) | R, (NP: if not reference community) |

_Table 1: Audit Trail Consumption Event Types_


### Document Audit Event Content Profile

This content profile describes Audit Event related to Document Management. The following Data Elements shall be provided:

{:class="table table-bordered"}
<table>
	<tbody>
		<tr>
			<td>
				<p><strong>Data Element</strong></p>
			</td>
			<td>
				<p><strong>Description</strong></p>
			</td>
			<td>
				<p><strong>Property/Value</strong></p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Event Type</p>
			</td>
			<td colspan="2">
				<p>
                    Document upload<br />
                    Document retrieval<br />
                    Document or Document Metadata update<br />
                    Document removal<br />
				    Document search
                </p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Event Date and Time</p>
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
				<p>Participants</p>
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
				<p>Initiator</p>
			</td>
			<td>
				<p>Patient</p>
			</td>
			<td>
				<p>Name<br />RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Representative of patient</p>
			</td>
			<td>
				<p>Name<br />RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Authorized Healthcare Professional</p>
			</td>
			<td>
				<p>Name<br />KRPZ</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Assistant of a Healthcare Professional</p>
			</td>
			<td>
				<p>Name<br />KRPZ</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Technical User</p>
			</td>
			<td>
				<p>Name<br />Identifier</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Document Administrator</p>
			</td>
			<td>
				<p>Name<br />KRPZ</p>
			</td>
		</tr>
		<tr>
			<td rowspan="2">
				<p>Responsible<sup><a href="#_ftn2.1" name="_ftnref2.1">[2.1]</a></sup></p>
			</td>
			<td>
				<p>Patient</p>
			</td>
			<td>
				<p>Name<br />RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Healthcare Professional</p>
			</td>
			<td>
				<p>Name<br />KRPZ</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Groups where Healthcare Professional is member</p>
			</td>
			<td>
				<p>&nbsp;</p>
			</td>
			<td>
				<p>Name of Group<br />KRPZS</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Purpose of Use</p>
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
				<p>Patient</p>
			</td>
			<td>
				<p>Involved patient</p>
			</td>
			<td>
				<p>RID</p>
			</td>
		</tr>
		<tr>
			<td rowspan="3">
				<p>Document<sup><a href="#_ftn2.2" name="_ftnref2.2">[2.2]</a></sup></p>
			</td>
			<td>
				<p>type of document</p>
			</td>
			<td>
				<p>typeCode (SNOMED CT code)</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>reference to document</p>
			</td>
			<td>
				<p>
                    uniqueId<br />repositoryUniqueId<br />homeCommunityID
                </p>
			</td>
		</tr>
		<tr>
			<td>
				<p>title of document</p>
			</td>
			<td>
				<p>
                    title
                </p>
			</td>
		</tr>
	</tbody>
</table>
<p><sup><a href="#_ftnref2.1" name="_ftn2.1">[2.1]</a></sup> <small>If different from Initiator (Representative of patient acting on behalf of a patient then patient is responsible).</small></p>
<p><sup><a href="#_ftnref2.2" name="_ftn2.2">[2.2]</a></sup> <small>Required for Document upload, Document retrieval, Document or Document Metadata update and Document removal but not for Document search.</small></p>

_Table 2: Document Audit Event Data Elements_

This profile defines the content of the document audit events which a community has to provide for a patient's audit trail. This profile builds on AuditEvent ([http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)).   


#### Examples

It will be added


### Policy Audit Event Content Profile

This content profile describes Audit Events related to Policy Management. The following Data Elements shall be provided:

{:class="table table-bordered"}
<table>
	<tbody>
		<tr>
			<td>
				<p><strong>Data Element</strong></p>
			</td>
			<td>
				<p><strong>Description</strong></p>
			</td>
			<td>
				<p><strong>Property/Value</strong></p>
			</td>
		</tr>
		<tr>
			<td rowspan="8">
				<p>Event Type</p>
			</td>
			<td colspan="2">
				<p>Authorize participants to access level/date</p>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<p>Update access level/date of authorized participants</p>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<p>Remove authorization for participants to access level/date</p>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<p>Set or update the default Confidentiality Level for new documents</p>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<p>Disabling Emergency Access</p>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<p>Enabling Emergency Access</p>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<p>Exclude a Healthcare Professional from accessing the EPR</p>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<p>Revoke the exclusion of a Healthcare Professional from accessing the EPR</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Event Date Time</p>
			</td>
			<td>&nbsp;</td>
			<td>
				<p>FHIR instant</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Participants</p>
			</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td rowspan="5">
				<p>Initiator</p>
			</td>
			<td>
				<p>Patient</p>
			</td>
			<td>
				<p>Name<br />RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Representative of patient</p>
			</td>
			<td>
				<p>Name<br />RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Authorized Healthcare Professional<sup><a href="#_ftn3.1" name="_ftnref3.1">[3.1]</a></sup></p>
			</td>
			<td>
				<p>Name<br />KRPZ</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Assistant of a Healthcare Professional</p>
			</td>
			<td>
				<p>Name<br />KRPZ</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Policy Administrator</p>
			</td>
			<td>
				<p>Name<br />KRPZ</p>
			</td>
		</tr>
		<tr>
			<td rowspan="2">
				<p>Responsible</p>
			</td>
			<td>
				<p>Patient</p>
			</td>
			<td>
				<p>Name<br />RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Healthcare Professional</p>
			</td>
			<td>
				<p>Name<br />KRPZ</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Patient</p>
			</td>
			<td>
				<p>Involved patient</p>
			</td>
			<td>
				<p>RID</p>
			</td>
		</tr>
		<tr>
			<td rowspan="7">
				<p>Resource</p>
			</td>
			<td>
				<p>Resource Role</p>
			</td>
			<td>
				<p>HCP, GRP or REP</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Healthcare Professional</p>
			</td>
			<td>
				<p>Name<br />KRPZ</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Group of Healthcare Professional</p>
			</td>
			<td>
				<p>Name of Group<br />KRPZS</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Representative of patient</p>
			</td>
			<td>
				<p>Name<br />RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>AccessLevel<sup><a href="#_ftn3.2" name="_ftnref3.2">[3.2]</a></sup></p>
			</td>
			<td>
				<p>one of urn:e-health-suisse:2015:policies:access-level:<br />normal, restricted, delegation-and-restricted, delegation-and-normal, full</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>AccessLimitedToDate<sup><a href="#_ftn3.2" name="_ftnref3.2">[3.2]</a></sup></p>
			</td>
			<td>
				<p>Date</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>ProvideLevel<sup><a href="#_ftn3.3" name="_ftnref3.3">[3.3]</a></sup></p>
			</td>
			<td>
				<p>one of urn:e-health-suisse:2015:policies:provide-level:<br />normal, restricted, secret</p>
			</td>
		</tr>
	</tbody>
</table>
<p><sup><a href="#_ftnref3.1" name="_ftn3.1">[3.1]</a></sup> <small>Healthcare Professional or Assistant of Healthcare Professional can only be a participant for the first Event Type (Authorize participants to access level).</small></p>
<p><sup><a href="#_ftnref3.2" name="_ftn3.2">[3.2]</a></sup> <small>Access Level and the date if the access is limited (AccessLimitedToDate) are required for the first two Event Types (Authorize, update Authorization participants to access level/date), for the other Event Types these parameters do not need to be specified.</small></p>
<p><sup><a href="#_ftnref3.3" name="_ftn3.3">[3.3]</a></sup> <small>Provide Level is only relevant for the Event Type Default Confidentiality Level for new Documents.</small></p>

_Table 3: Policy Audit Event Data Elements_

This content profile defines the document audit events which a community has to provide for a patients audit trail. This profile builds on AuditEvent ([http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)).   


#### Examples

It will be added


### Access Audit Trail Content Profile

This content profile describes Audit Event related to Accessing the Audit Trail of a Patient from a Patient Audit Record Repository. The following Data Elements shall be provided:

{:class="table table-bordered"}
<table>
	<tbody>
		<tr>
			<td>
				<p><strong>Data Element</strong></p>
			</td>
			<td>
				<p><strong>Description</strong></p>
			</td>
			<td>
				<p><strong>Property/Value</strong></p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Event Type</p>
			</td>
			<td>
				<p>&nbsp;</p>
			</td>
			<td>
				<p>Access Audit Trail</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Event Date and Time</p>
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
				<p>Participants</p>
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
				<p>Initiator</p>
			</td>
			<td>
				<p>Patient</p>
			</td>
			<td>
				<p>Name<br />RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Representative of patient</p>
			</td>
			<td>
				<p>Name<br />RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Responsible</p>
			</td>
			<td>
				<p>Patient</p>
			</td>
			<td>
				<p>Name<br />RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Patient</p>
			</td>
			<td>
				<p>Involved patient</p>
			</td>
			<td>
				<p>RID</p>
			</td>
		</tr>
	</tbody>
</table>

_Table 11: Access Audit Trail Data Elements_

This content profile defines the access audit trail event, which a community has to provide for a patient’s audit trail. This profile builds on AuditEvent ([http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)).   


#### Example

It will be added


### HPD Group Entry Audit Event Content Profile

This content profile describe the Audit Event related to the entry of a healthcare professional into a HPD group for which the patient is notified. The following Data Elements shall be provided:

{:class="table table-bordered"}
<table>
	<tbody>
		<tr>
			<td>
				<p><strong>Data Element</strong></p>
			</td>
			<td>
				<p><strong>Description</strong></p>
			</td>
			<td>
				<p><strong>Property/Value</strong></p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Event Type</p>
			</td>
			<td colspan="2">
				<p>Patient notified of Healthcare Professionals added to a group</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Event Date and Time</p>
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
				<p>Notification Service</p>
			</td>
			<td>
				<p>&nbsp;</p>
			</td>
			<td>
				<p>Name<br />RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Patient</p>
			</td>
			<td>
				<p>Notified patient</p>
			</td>
			<td>
				<p>RID</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Healthcare Professionals</p>
			</td>
			<td>
				<p>Healthcare professionals</p>
			</td>
			<td>
				<p>Name<br />KRPZ</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>Group</p>
			</td>
			<td>
				<p>Group where Healthcare Professionals are added as members</p>
			</td>
			<td>
				<p>Name of Group<br />KRPZS</p>
			</td>
		</tr>
	</tbody>
</table>

_Table 13: HPD Group Entry Audit Event Elements_

This profile defines the content of the HPD group entry audit event. This profile builds on AuditEvent ([http://hl7.org/fhir/R4/auditevent.html](http://hl7.org/fhir/R4/auditevent.html)).   

#### Example

It will be added