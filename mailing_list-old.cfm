<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<!--- get autoemail content --->
<cfquery name="getPages" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * from pages
	WHERE pk_pages = 6
</cfquery>
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
<script language="JavaScript" src="http://#server_name#/js/utils.js"></script>
</cfoutput>

<link href="stylesheet.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="100%" height="125" valign="top" bgcolor="#000000">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="100%" valign="top" height="37" bgcolor="#000000">
			<cfinclude template="navbar.cfm">
		</td>
	</tr>
	<tr height="100%">
		<td valign="top" width="173" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr height="100%">
					<td valign="top" height="100%">	
						<cfinclude template="left.cfm">
					</td>
				</tr>
			</table>
		</td>
		<td valign="top" width="727" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr height="100%">
					<td height="100%" valign="top" align="center">	
						<cfif isDefined('form.process')>					
						<table border="0" cellpadding="0" cellspacing="0" width="90%">
						<tr>
							<td colspan="2"><br><font face="verdana,helvetica,arial" size="-2"><b>Thank you <cfoutput>#form.name#</cfoutput>. <br><br> Your Email has been sent to the respective personnel. <br><br>   We hope that your visit has been a pleasant experience so far.</b></font><br>
							<cfquery name="guests" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
							select email from leads where email = '#form.emailaddress#'
							</cfquery>
							<cfif guests.recordcount lt 1>
							<cfquery name="addguests" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
							insert into leads (name, notes, email, maillist, sgroup, limiter)
								values('#form.name#', '#form.comments#', '#form.emailaddress#', #form.list#, 'A', 'website')
							</cfquery>
							</cfif>
							
							<cfif len(form.this_upload)>
								<cffile action="UPLOAD" filefield="this_upload" destination="#ExpandPath('.')#\uploads\" nameconflict="MAKEUNIQUE">
							</cfif>
							<!--- Mail to admin --->
							<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="#emailsupport#" cc="#emailsupportcc#"  from="onli16@onlinegalleryart.com" subject="Gallery Art Guest Registry Form" type="HTML">
							<font style="font-size: 10pt; font-family: Arial;">
							Client Information:
							<br><br>
							Name: #form.name#<br>
							Email Address:#form.emailaddress#<br>
							Phone Number:#form.phone#
							<br><br>
							Referral:<br>
							#form.referral#
							<br><br>
							Questions / Comments:<br>
							#form.comments#
							<br><br>
							<cfif len(form.this_upload)>
							This Customer has uploaded a file to the server: <a href="http://#server_name#/uploads/#cffile.ServerFile#" target="_blank">[CLICK]</a> to view.
							</cfif>
							<br><br>
							</font>
							</cfmail>	
							<!--- Mail to user --->
							<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="#form.emailaddress#" from="onli16@onlinegalleryart.com" subject="Gallery Art Guest Registry Form" type="HTML">
							<font style="font-size: 10pt; font-family: Arial;">
							Thank you for submitting your name to the Gallery Art mailing list.  We will be in  touch with you very shortly.
							<br><br>
							#getPages.page_content#
							<br><br>
							</font>
							</cfmail>								
							</td>						
						</tr>
						</table>
<cfelse>						
<CFFORM ACTION="#script_name#" METHOD="POST" enctype="multipart/form-data">	
						<table border="0" cellpadding="3" cellspacing="0" width="90%">	
						<tr>
							<td colspan="2" style="padding-top: 10px;">
								<h4>MAILING LIST</h4>
								<cfoutput><p align="justify">Please enter your name into our Guest Registry, and receive discounts, information, and notices about #companyname#. All information is kept confidential, and used for our site alone.</p></cfoutput>
							</td>
						</tr>				
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>NAME</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="name" required="Yes" MESSAGE="Please fill in your full name."></TD>
							<td width="75">&nbsp;</td>
						</TR>
	
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>E-MAIL ADDRESS</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="emailaddress" required="Yes" MESSAGE="Please fill in your email address."></TD>
							<td width="75">&nbsp;</td>
						</TR>
	
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>PHONE NUMBER</b></FONT><br><input type="text" size=40 maxsize=50 name="phone"></TD>
							<td width="75">&nbsp;</td>
						</TR>
						
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>HOW DID YOU HEAR ABOUT US?</b></FONT><br><TEXTAREA NAME="referral" ROWS=5 COLS=35></TEXTAREA></TD>
							<td width="75">&nbsp;</td>
						</TR>						
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>WOULD YOU LIKE TO KNOW ABOUT OUR SPECIALS?</b><br><input type="radio" name="list" value="1" checked>Yes Please <input type="radio" name="list" value="0">No Thank You</font></TD>
							<td width="75">&nbsp;</td>
						</TR>		
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>QUESTIONS OR COMMENTS</b></FONT><br><TEXTAREA NAME="comments" ROWS=10 COLS=35></TEXTAREA></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>UPLOAD IMAGE:</b></FONT><br><input type="file" name="this_upload" style="font-size: 8pt;"></TD>
							<td width="75">&nbsp;</td>
						</TR>
	<!--spacer starts-->
	   				 	<tr><td colspan="2"><br><br></td></tr>
	<!--spacer ends-->
						<TR>
							<TD><input type="Image" src="images/send.gif" style="border: none;"><br>
							<input style="background:url(images/reset.gif) no-repeat; width: 87px; height: 30px; border: none;" type="reset" value="" /></TD>
							<td width="75">&nbsp;</td>
						</TR>
			
						</table>
<br><br></cfform>	
					</td>
					<td width="207" height="100%" bgcolor="ffffff" valign="top"><br>
							<cfoutput>
<font face="verdana, arial, helvetica" size="-2">

							</cfoutput>
</font>		</td>
				</tr>	
				

														
			</table>
			</cfif>	
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer.cfm">
		</td>
	</tr>
</table>

<cfinclude template="frmxss.cfm">

</body>
</html>