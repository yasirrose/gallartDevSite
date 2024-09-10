<cfoutput>

	<cfform method="post" action="index.cfm?event=exports.emailCompile" name="emailForm">
	<table cellspacing="2" cellpadding="5" border="0" width="400" height="600">
		<tr>
			<td align="center"  colspan=2 valign="top">
				<font face="verdana,arial,helvetica" size="2">Select Email List(s):</font>
			</td>
		</tr>
		<tr>
			<td align="center" colspan=2 valign="top">
				<font face="verdana,arial,helvetica" size="2">
				<input type="Checkbox" name="table_name" value="sellers" checked>Sellers&nbsp;
				<input type="Checkbox" name="table_name" value="customers" checked>Customers&nbsp;
				<input type="Checkbox" name="table_name" value="leads" checked>Leads&nbsp;
				<input type="Checkbox" name="table_name" value="appraisals" checked>Appraisals&nbsp;
				<input type="Checkbox" name="table_name" value="quotes" checked>Quotes&nbsp;
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
			<td colspan=2 align="center" valign="top" height="400">
				&nbsp;
			</td>
		</tr>
	</table>
	</cfform>

</cfoutput>

