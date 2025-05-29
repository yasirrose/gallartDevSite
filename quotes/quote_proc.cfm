<cfif form.jscript EQ 0>
	<cfabort>
</cfif>
<cfparam name="cffile.serverFile" default="" />

<cfif isDefined('form.pictureUpload') and len(form.pictureUpload)>

	<cffile action="UPLOAD" filefield="pictureUpload" destination="#expandpath('.')#/uploads" nameconflict="MAKEUNIQUE"  />
	 
	<cfset strFilePath = ( CFFILE.ServerDirectory & "\" & CFFILE.ServerFile ) />

</cfif>

<cfquery name="addAppraisal" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		INSERT into quotes
			(	
				LNAME,
				FNAME,
				EMAIL,
				PHONE,
				CELL,
				ARTIST,
				TITLE,
				MEDIUM,
				GRAPHICS,
				EDITION,
				SIGNATURE,
				SIZE,
				SCULPTURE,
				YEAR,
				DESCRIPTION,
				PICTUREUPLOAD
			)
			values
			(
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.LNAME#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.FNAME#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.EMAIL#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.PHONE#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.CELL#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.ARTIST#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.TITLE#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.MEDIUM#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.GRAPHICS#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.EDITION#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.SIGNATURE#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.SIZE#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.SCULPTURE#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.YEAR#">,
				<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#FORM.DESCRIPTION#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cffile.serverFile#">
			)
	</cfquery>



<cfsavecontent variable="emailBody">

<cfoutput>

<table id="Table_01" width="800" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="600" valign="top" align="center">
			<table cellspacing="0" cellpadding="5" border="0" width="100%" style="padding-left: 50px;">
				<tr>
					<td colspan="2" valign="top" style="font-size: 16px; font-weight: bold; padding-bottom: 10px;">
						Free Quote Form
					</td>
				</tr>
				<tr>
					<td width="200">
						Name
					</td>
					<td>
						#form.lname# #form.fname#
					</td>
				</tr>
				<tr>
					<td>
						Email
					</td>
					<td>
						#form.email#
					</td>
				</tr>
				<tr>
					<td>
						Phone
					</td>
					<td>
						#form.phone#
					</td>
				</tr>
				<tr>
					<td>
						Cell Phone
					</td>
					<td>
						#form.cell#
					</td>
				</tr>
				<tr>
					<td valign="top">
						Artist
					</td>
					<td>
						#form.artist#
					</td>
				</tr>
				<tr>
					<td valign="top">
						Title
					</td>
					<td>
						#form.title#
					</td>
				</tr>
				<tr>
					<td valign="top">
						Medium
					</td>
					<td>
						#form.medium#
					</td>
				</tr>
				<tr>
					<td valign="top">
						Graphics/Prints:
					</td>
					<td>
						#form.graphics#
					</td>
				</tr>
				<tr>
					<td valign="top">
						Edition:
					</td>
					<td>
						#form.edition#
					</td>
				</tr>
				<tr>
					<td valign="top">
						Signature:
					</td>
					<td>
						#form.signature#
					</td>
				</tr>
				<tr>
					<td valign="top">
						Size
					</td>
					<td>
						#form.size#
					</td>
				</tr>
				<tr>
					<td valign="top">
						Sculpture or Bronze
					</td>
					<td>
						#form.sculpture#
					</td>
				</tr>
				<tr>
					<td valign="top">
						Year
					</td>
					<td>
						#form.Year#
					</td>
				</tr>
				<tr>
					<td valign="top">
						Description
					</td>
					<td>
						#form.description#
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</cfoutput>

</cfsavecontent>
<!--- #emailsupport# --->
<CFMAIL
server="mail2.onlinegalleryart.com" 
username="gallart@onlinegalleryart.com"
password="re3objeC!P" 
from="#form.email#"
to="#emailsupport#"
cc="#emailsupportcc#"
subject="GallArt.com <> We Buy & Sell Fine Art <> Free Quote"
 type="HTML">

	<font style="font-size: 10pt; font-family: Arial;">
	 A Quote Form was received:<br><br>
	#emailBody#
	</font>
	<cfif isDefined('form.pictureUpload') and len(form.pictureUpload)>
		<cfmailparam file="#strFilePath#" />
	</cfif>
</cfmail>


<cflocation url="http://#server_name#/quotes.cfm?xss=#xss#&proc=y" addtoken="No">

