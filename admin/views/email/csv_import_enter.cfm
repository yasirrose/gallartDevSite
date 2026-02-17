<cfoutput>
	<table border="0" cellpadding="0" cellspacing="0" width="50%" class="editBox" style="margin-top: 20px; margin-right: auto; width: max-content; margin-left: 100px;">
		<tr>
			<td valign="top"><br>
				<h3>CSV IMPORT</h3><br><br>
				<span style="font-size: 11px;">
					Excel file must contain 3 fields in this order: lname, fname, email<br>
					All blank fields must be replaced by ~<br><br>
					In Excel, select all 3 columns and delete rest<br><br>
					click F5, then Special, click "blanks" radio button, click OK<br />
					type ~<br />
					press Ctrl + Enter <br><br>
					save as csv file<br><br>
					to delete rows without email address:<br /><br>
					select email row, then sort<br /><br>
					delete empty rows
				</span>

				<cfif isDefined('form.importCsv')>
					<cfif isDefined('form.pk_email_imports_list') and form.pk_email_imports_list GT 0>
						<cfquery name="getImports" datasource="#application.dsource#">
							DELETE from email_imports
							WHERE fk_email_imports_list = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.pk_email_imports_list#">
						</cfquery>
					
						<cfif isDefined('form.delete')>
						
							<cfquery name="deleteImports" datasource="#application.dsource#">
									DELETE from email_imports_list
									WHERE pk_email_imports_list = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.pk_email_imports_list#">
							</cfquery>
							
							<cflocation url="index.cfm?event=email.csvImportSearch" addtoken="No">
						
						</cfif>
						<cfset session.importID = pk_email_imports_list />
					 <cfelse>
						<cfquery name="getImportID" datasource="#application.dsource#">
							INSERT into email_imports_list
								(import_name)
								VALUES
								('#form.import_name#')
							SELECT @@identity as uid 
						</cfquery>
						<cfset session.importID = getImportID.uid />
					</cfif>

					<cffile action="UPLOAD" filefield="csvFile" destination="#expandpath('.')#" nameconflict="OVERWRITE">
					<cfset temp = structDelete(session,'csvArray') />

					<cfif NOT isDefined('session.csvArray')>
						<!--- get and read the CSV-TXT file --->
						<cffile action="read" file="#expandpath('.')#/#clientfile#" variable="csvList">
						<cfset session.csvArray = listToArray(csvList,"#chr(10)##chr(13)#") />
						<cffile action="DELETE" file="#expandpath('.')#/#clientfile#" />
					</cfif>
						
					<table cellspacing="0" cellpadding="5" border="0" width="400" height="600">
						<tr>
							<td valign="top">
								<iframe src="http://#server_name#/admin/views/email/csv_import_proc.cfm" frameborder="0" width="450" height="250"></iframe>
							</td>
						</tr>
					</table>		
				
				 <cfelse>
					<form method="post" action="index.cfm?event=email.csvImportEnter" enctype="multipart/form-data">
						<input type="Hidden" name="importCsv">
						<table cellspacing="0" cellpadding="5" border="0" width="400" >
							<cfif isDefined('form.pk_email_imports_list')>
								<input type="Hidden" name="pk_email_imports_list" value="#form.pk_email_imports_list#">
								<cfquery name="getImportList" datasource="#application.dsource#">
									SELECT * from email_imports_list IL
									INNER JOIN email_imports I
									on IL.pk_email_imports_list = I.fk_email_imports_list
									WHERE pk_email_imports_list = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.pk_email_imports_list#">
								</cfquery>
								<tr>
									<td>
										IMPORT LIST: #getImportList.import_name#
									</td>
								</tr>
								<tr>
									<td>
										#getImportList.recordcount# RECORDS
									</td>
								</tr>
							<cfelse>
								<input type="Hidden" name="pk_email_imports_list" value="0">
								<tr>
									<td><font face="verdana,arial,helvetica" size="2">Name of import:
										<input type="Text" name="import_name" maxlength="30" size="30">
									</td>
								</tr>
							</cfif>
						
							<tr>
								<td>
									UPLOAD CSV FILE:
								</td>
							</tr>
								
							<tr>
								<td>
									<input type="File" name="csvFile" accept=".csv">
								</td>
							</tr>
							<tr>
								<td>
									<cfif isDefined('form.pk_email_imports_list')>
										<input type="Submit" value="UPLOAD CSV" onClick="return validateCSV() && confirm('THIS WILL DELETE THE EXISTING IMPORTED RECORDS -- ARE YOU SURE?')" />
										<input type="Submit" value="DELETE IMPORT" name="delete" onClick="javascript:return confirm('THIS WILL DELETE THE EXISTING IMPORTED RECORDS -- ARE YOU SURE?')" />
									<cfelse>
										<input type="Submit" value="UPLOAD CSV" onclick="return validateCSV()"/>
									</cfif>
								</td>
							</tr>
							<tr>
								<td  valign="top">
									<br><br>
									<input type="Button" value="Back" onclick="location.href='index.cfm?event=email.csvImportSearch'">
								</td>
							</tr>
						</table>
					</form>				
				</cfif>				
			</td>
		</tr>	
	</table>

</cfoutput>


<script>
	function validateCSV() {
		// Get the file input element
		var fileInput = document.querySelector('input[name="csvFile"]');
		var importName = document.querySelector('input[name="import_name"]');
		var filePath = fileInput.value.trim();

		if (importName && importName.offsetParent !== null && importName.value.trim() === "") {
			alert("Please enter the import name before uploading the CSV.");
			importName.focus();
			return false;
		}

		// Check if no file selected
		if (!fileInput.value || fileInput.value.trim() === '') {
			alert('Please select the CSV file.');
			return false; // stop form submission
		}

		var fileExt = filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase();
		if (fileExt !== "csv") {
			alert("Invalid file type. Please upload only a CSV file (.csv).");
			fileInput.value = ""; // clear invalid file
			fileInput.focus();
			return false;
		}

		return true; // allow submission
	}
</script>

