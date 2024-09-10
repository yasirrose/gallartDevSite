<cfparam name="form.subject" default="">
<cfparam name="form.testemail" default="">

<cfquery name="getImportList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT count(*) as importCount,import_name,IL.pk_email_imports_list from email_imports_list IL
	INNER JOIN email_imports I
	on IL.pk_email_imports_list = I.fk_email_imports_list
	group by import_name,pk_email_imports_list
</cfquery>


<script language="JavaScript">
	function postTemplateID(templateID) {
		document.postTemplateFrm.pk_emailtemplate.value = templateID;
		document.postTemplateFrm.subject.value = document.emailForm.subject.value;
		document.postTemplateFrm.submit();	
	}
	function CheckEntries(){
		
		
		opSelected = false;
		for(var i=0; i<document.emailForm.table_name.length; i++){
			if(document.emailForm.table_name[i].checked){
				opSelected = true;
			}
		}
		for(var i=0; i<document.emailForm.imports.length; i++){
			if(document.emailForm.imports[i].checked){
				opSelected = true;
			}
		}
		if(opSelected == false){
			alert('Please, select an email list');
			return false;
		}
		if(document.emailForm.pk_emailtemplate.value == ''){
			alert('Please, select a Template');
			return false;
		}
}
</script>
<cfoutput>

	<cfform method="post" action="index.cfm?event=email.emailCompile" name="emailForm" onsubmit="return CheckEntries()">
	<table cellspacing="2" cellpadding="5" border="0" width="300" height="600">
		<tr>
			<td align="center" colspan=2 valign="top">
				<font face="verdana,arial,helvetica" size="2">Select Template:</font>
			</td>
		</tr>
		<tr>
			<td align="center" colspan=2 valign="top">
				<select name="pk_emailtemplate" style="font-size: 8pt;" onchange="postTemplateID(this.value);">
					<option value="">Please Select
					<cfloop query="getAllEmailTemplates">
						<option value="#pk_emailtemplate#" <cfif isDefined('form.pk_emailtemplate') and form.pk_emailtemplate eq pk_emailtemplate>selected</cfif>>#email_name#</option>
					</cfloop>
				</select>
			</td>
		</tr>
		<tr>
		    <td align="right" valign="top"><font face="verdana,arial,helvetica" size="1"><b>Subject:</b></font></td>
		    <td><cfinput type="Text" name="subject" message="You must enter a subject." required="Yes" size="30" value="#form.subject#"></td>
		</tr>
	
		<cfif isDefined('form.pk_emailtemplate') AND form.pk_emailtemplate NEQ 0>
		
		<tr>
		    <td colspan="2" style="padding: 5px;" valign="top">
				<hr>
			</td>
		</tr>
		<tr>
		    <td colspan="2" valign="top">
			<font face="verdana,arial,helvetica" size="1"><b>Template:</b></font>
		</td>
		</tr>
		<tr>
		    <td colspan="2" align="center" valign="top">
				#pk_emailtemplate.email_content#
			</td>
		</tr>
		<tr>
		    <td colspan="2" style="padding: 5px;" valign="top">
				<hr>
			</td>
		</tr>
		</cfif>
		<tr>
			<td align="center"  colspan=2 valign="top">
				<font face="verdana,arial,helvetica" size="2">Select Email List(s):</font>
			</td>
		</tr>
		<tr>
			<td align="center" colspan=2 valign="top">
				<font face="verdana,arial,helvetica" size="2">
				<input type="Checkbox" name="table_name" value="sellers">Sellers&nbsp;
				<input type="Checkbox" name="table_name" value="customers">Customers&nbsp;
				<input type="Checkbox" name="table_name" value="leads">Leads&nbsp;
				</font>
			</td>
		</tr>
		<tr>
			<td align="left" colspan=2 valign="top">
				<font face="verdana,arial,helvetica" size="2">
				Imports:
				</font>
			</td>
		</tr>
		<tr>
			<td align="left" colspan=2 valign="top">
				<font face="verdana,arial,helvetica" size="2">
				<cfloop query="getImportList">
					<input type="Checkbox" name="imports" value="#pk_email_imports_list#">&nbsp;#import_name# - #importCount# records<br>
				</cfloop>
				</font>
			</td>
		</tr>
		<tr>
			<td colspan=2 align="center" valign="top">
			<input type="Submit" value="Compile">
			</td>
		</tr>
		<tr>
			<td colspan=2 align="center" valign="top" height="400">&nbsp;
				
			</td>
		</tr>
	</table>
	</cfform>


<form method="post" action="#script_name#?#query_string#" name="postTemplateFrm">
	<input type="Hidden" name="pk_emailtemplate">
	<input type="Hidden" name="subject">
</form>


</cfoutput>

