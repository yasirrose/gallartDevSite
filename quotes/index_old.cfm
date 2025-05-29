<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<cfoutput>
	<title>#companyname# - #titletext#</title>
	</cfoutput>
	
	<cfinclude template="../meta.cfm">
	
	<link href="../stylesheet.css" rel="stylesheet" type="text/css">
	<style>
		td {font-size: 11px; font-weight: bold;}
	</style>
	
	<script language="JavaScript">

		<!--

		function isEmail(string) {
		    if (string.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
		        return true;
		    else
		        return false;
		}
		function CheckEntries()	{
			if (isEmail(document.regForm.email.value) == false) {
		        alert("That's not  a proper email address!  Please try again . . .");
		        document.regForm.email.focus();
		        return false;
		    }
		}
		// -->
	</script>
	
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<cfoutput>
<cfform method="post" action="quote_proc.cfm" onsubmit="return CheckEntries()" name="regForm" enctype="multipart/form-data">
<table id="Table_01" width="700" height="600" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="100%" height="125" valign="top">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="##000000">
				<tr>
					<td align="center">
						<img src="../images/top_01.jpg" width="634" height="123" alt="">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" valign="top" style="font-size: 20px; font-weight: bold; padding-top: 10px; height: 40px;">
			Free Quote Form
		</td>
	</tr>
	<cfif NOT structKeyExists(url,'proc')>
	<tr>
		<td colspan="2" align="center" valign="top" style="padding-bottom:5px;">
			<span style="color:##ff0000;">* Required</span>
		</td>
	</tr>
	
	<tr>
		<td colspan="2" width="100%" valign="top" align="center">
			<table cellspacing="0" cellpadding="5" border="0" width="600">
				<tr>
					<td align="right" valign="top" width="150">
						First Name:
					</td>
					<td width="300" valign="top">
						<cfinput type="Text" name="fname" value="" required="No" message="Please enter your first name." size="40" />
					</td>
				</tr>
				<tr>
					<td align="right">
						Last Name:
					</td>
					<td>
						<cfinput type="Text" name="lname" value="" size="40" required="No" message="Please enter your last name." />
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						<span style="color:##ff0000;">*</span> Email Address:
					</td>
					<td>
						<cfinput type="Text" name="email" value="" size="40" required="Yes" message="Please enter your email address." />
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						Phone Number:
					</td>
					<td>
						<cfinput type="Text" name="phone" value="" size="40" required="No" message="Please enter your phone number." />
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						Artist:
					</td>
					<td>
						<cfinput type="Text" name="artist" value="" size="40" required="No" message="Please enter the artist." />
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						Title:
					</td>
					<td>
						<cfinput type="Text" name="title" value="" size="40" required="No" message="Please enter the title." />
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						Medium:
					</td>
					<td>
						<cfinput type="Text" name="medium" value="" size="40" required="No" message="Please enter the medium." />
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						Unframed Size:
					</td>
					<td>
						<cfinput type="Text" name="size" value="" size="40" required="No" message="Please enter the unframed size." />
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						Year:
					</td>
					<td>
						<cfinput type="Text" name="year" value="" size="40" required="No" message="Please enter the year." />
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td align="right" valign="top">
						Brief Description:
					</td>
					<td>
						<textarea name="description" rows="3" cols="35"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td align="right">
						Upload Picture:
					</td>
					<td>
						<cfinput type="File" name="pictureUpload" required="No" message="You must upload a picture.">
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2" style="padding: 0px 100px 20px 0;" align="center">
						<input type="Submit" value="Submit" style="background-color: ##000000; color: ##ffffff; width: 75px; height: 20px; padding-bottom: 8px; font-weight: bold;">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<cfelse>
	<tr>
		<td valign="top" align="center" height="500" colspan="2" style="padding: 25px; font-size: 13px; font-weight: bold; color: ##ff0000;">Thank you for submitting our Free Quote Form.  We will be in touch with you shortly.<br><br>
		<a href="index.cfm">CLICK TO ADD ANOTHER PIECE</a></td>
	</tr>
	</cfif>
</table>
</cfform>
</cfoutput>

</body>
</html>
