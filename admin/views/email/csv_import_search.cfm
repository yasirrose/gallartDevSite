<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td valign="top"><br>
			<h3>CSV IMPORT</h3><br><br>
				<FORM action="index.cfm?event=email.csvImportEnter" method="post" name="searchFrm"  onsubmit="return CheckEntries()">
				<table height="600">
					<tr>
						<td valign="top" colspan="2">
							<input type="Button" value="NEW CSV IMPORT" onclick="location.href='index.cfm?event=email.csvImportEnter';" />
						</td>
					</tr>
					<tr>
						<td valign="top" width="50%" style="padding-right: 10px;"><strong>Import Name:</strong></td>
						<td valign="top">
							<select name="pk_email_imports_list">
								<option value="">Please Select</option>
								<cfloop query="getImportListAll">
									<option value="#pk_email_imports_list#">#import_name#</option>
								</cfloop>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="Center" valign="top">
						<INPUT type="submit" value="Search">&nbsp;&nbsp;<input type="reset" value="Reset Values">
						</td>
					</tr>
					<tr>
						<td height="400">&nbsp;</td>
					</tr>
				
				</table>
				</FORM>								
		</td>
	</tr>	
</table>

</cfoutput>

