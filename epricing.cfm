<!--- Kill extra output. --->
<cfsilent>
	<cfparam name="form.fname" default="">	
	<cfparam name="form.lname" default="">						
	<cfparam name="form.email" default="">
	<cfparam name="form.phone" default="">
	<cfparam name="form.otherphone" default="">
	<cfparam name="form.best_time" default="">
	<cfparam name="form.email_only" default="">
	<cfparam name="form.comments" default="">
	<cfparam name="form.captchaError" default="0">
	<cfparam name="form.errorMsg" default="">
 	<cfparam name="form.errorPhone" default="0">
 	<cfparam name="url.pid" default="0">
 	<cfparam name="form.pid" default="#url.pid#">
	<cfparam
		name="FORM.captcha"	type="string"	default=""	/>
 
	<cfparam
		name="FORM.captcha_check"	type="string" default="" />
 
	<cftry>
		<cfparam
			name="FORM.submitted"	type="numeric"	default="0"	/>
 
		<cfcatch>
			<cfset FORM.submitted = 0 />
		</cfcatch>
	</cftry>
 
	<!--- Set a flag to see if this user is a bot or not. --->
	<cfset blnIsBot = true />
	<cfset phoneError = false />
 
	<!--- Check to see if the form has been submitted. --->
	
	<cfif FORM.submitted>

			<cfset errorMsg = "" />

			<cfif len(form.phone) AND NOT isValid("regex",form.phone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = errorMsg & "Please enter your home phone number in the format (xxx) xxx-xxxx <br/>" />
			</cfif>

			<cfif errorMsg NEQ "">
				<cfset phoneError = true />

			<cfelse>

				


				<cftry>
		 
					<!--- Decrypt the check value. --->
					<cfset strCaptcha = Decrypt( FORM.captcha_check, "gallart-is-the-best", "CFMX_COMPAT", "HEX"	) />

					<cfif (strCaptcha EQ FORM.captcha)>

						<cfset blnIsBot = false />
		 
					</cfif>

					<cfcatch>

						<cfset blnIsBot = true />
		 
					</cfcatch>
				</cftry>

			</cfif>
 
	</cfif>

	<cfset arrValidChars = ListToArray(
		"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
		"2,3,4,5,6,7,8,9"
		) />
 
	<!--- Now, shuffle the array. --->
	<cfset CreateObject( "java", "java.util.Collections"	).Shuffle(	arrValidChars )	/>

	<cfset strCaptcha = (
		arrValidChars[ 1 ] &
		arrValidChars[ 2 ] 
		) />

	<cfset FORM.captcha_check = Encrypt( strCaptcha,"gallart-is-the-best", "CFMX_COMPAT", "HEX" ) />
 
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
<script language="JavaScript" src="./js/utils.js"></script>
<script language="JavaScript" src="http://#server_name#/js/jquery-1.2.6.min.js"></script>
<script language="JavaScript" src="http://#server_name#/js/slimbox2.js"></script>
<link href="http://#server_name#/css/slimbox2.css" rel="stylesheet" type="text/css">
</cfoutput>

<SCRIPT LANGUAGE="JavaScript">
function popUpWin(urlPage){
	var features =	'scrollbars=yes, toolbar=no, status=no, menubar=no,' +
					'resizable=no, location=no, directories=no,' +
					'left=100, top=100, width=793, height=400';

	myWin =	window.open(urlPage,'WinName',features);
}
	
</SCRIPT>

<link href="stylesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-34565365-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<!-- BEGIN ROBLY WIDGET CODE -->
<script type='text/javascript'>
  var _d_site = _d_site || 'ebb8c5f7da7077e127988b3276107648';
  (function(w, d, p, s, s2) {
    w[p] = w[p] || function() { (w[p].q = w[p].q || []).push(arguments) };
    s = d.createElement('script'); s.async = 1; s.src = '//s3.amazonaws.com/roblyimages/accounts/20559/forms/29541/signup_popup.js';
    s2 = d.getElementsByTagName('script')[0]; s2.parentNode.insertBefore(s, s2);
  })(window, document, 'Robly');
</script>
<!-- END ROBLY WIDGET CODE -->

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM products P
	LEFT OUTER JOIN users U on P.fk_users = U.pk_users
	where uid  = '#form.pid#' 
	and active = 1
</cfquery>
<cfquery name="similar" maxrows="3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * 
	FROM products
	WHERE active = 1 and manufacturer <> '#productinfo.manufacturer #' and path like '#productinfo.path#%'
</cfquery>
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<cfoutput>
	<form method="post" action="#script_name#?xss=#xss#" name="errorFrm">
		<input type="Hidden" name="fname">
		<input type="Hidden" name="lname">
		<input type="Hidden" name="email">
		<input type="Hidden" name="phone">
		<input type="Hidden" name="otherphone">
		<input type="Hidden" name="best_time">
		<input type="Hidden" name="email_only">
		<input type="Hidden" name="comments">
		<input type="Hidden" name="errorMsg">
		<input type="Hidden" name="captchaError" value="0">
		<input type="Hidden" name="errorPhone" value="0">
		<input type="Hidden" name="pid">
	</form>
</cfoutput>
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
		<td valign="top">
			<!-- Customer Entry -->
			<table cellpadding="0" cellspacing="0" border="0" width="600">
			<Tr>
				<Td  valign="top">
			<cfif productinfo.recordcount>
			<cfoutput>
			<table cellpadding="5" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="center">
						<div style="color:##dd3a7d; font-size: 20px; font-weight: bold; padding: 10px;">E-PRICING!</div>
					</td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="2" cellspacing="0" border="0" width="100%">
						<tr bgcolor="#centercolor#">
							<td valign="top" colspan="3" width="100%" align="center">
							<cfset imgFile = expandpath('.') & '\img\' & productinfo.uid &'.jpg' />
							<cfif fileExists(imgFile)>
								<img src="http://#server_name#/img/#productinfo.uid#.jpg" border="2" width="300"><br>
								<a href="http://#server_name#/img/#productinfo.uid#.jpg" rel="lightbox">[CLICK]</a> to view large image size in separate window.
							</cfif>
								<table cellpadding="3" cellspacing="0" border="0" width="75%">
									<tr>
										<td colspan=2><br></td>
									</tr>
									<tr>
										<td width="60%"><cfif productinfo.manufacturer gt 0><font size="1" face="arial, helvetica"><h1>Artist: #ucase(productinfo.manufacturer)#</h1></cfif></td>
										<td width="40%"><cfif productinfo.name gt 0><font size="1" face="arial, helvetica">Title: #productinfo.name#</cfif></td>
									</tr>
									
									<tr>
										<td><cfif productinfo.retail_price gt 0><font size="1" face="arial, helvetica">Retail Price: #DollarFormat(productinfo.retail_price)#</cfif></td>
										<td>
											<font size="1" face="arial, helvetica">
											<cfif productinfo.closeout eq 1 and productinfo.special_price gt 0>
												<cfif application.showSalePrice EQ 1><span style="color: ##ff0000;">Sale Price: #DollarFormat(productinfo.special_price)#</span></cfif>
											<cfelseif productinfo.gallery_price gt 0>Gallery Price: #DollarFormat(productinfo.gallery_price)#
											</cfif>
											</font>
										</td>
									</tr>
									
									<tr>
										<td><cfif productinfo.overview gt 0><font size="1" face="arial, helvetica">Size: #productinfo.overview#</cfif></td>
										<td><cfif productinfo.specs gt 0><font size="1" face="arial, helvetica">Year: #productinfo.specs#</cfif></td>
									</tr>
									
									<cfset medium = replace(RemoveChars(productinfo.path,len(productinfo.path), 1),":","/","all")>
									<tr>
										<td><cfif medium gt 0><font size="1" face="arial, helvetica">Medium: #medium#</cfif></td>
										<td><cfif productinfo.edition gt 0><font size="1" face="arial, helvetica">Edition: #productinfo.edition#</cfif></td>
									</tr>
									
									<tr>
										<td colspan=2><cfif productinfo.caption gt 0><font size="1" face="arial, helvetica">Description: #trim(productinfo.caption)#</cfif></td>
									</tr>
								</table>
							</td>
						</tr>
						</table>
						<cfif FORM.submitted>	

							<!--- Check for a bot. --->
							<cfif phoneError>
								<cfoutput>
									<script language="JavaScript">
										document.errorFrm.fname.value = '#form.fname#'
										document.errorFrm.lname.value = '#form.lname#'
										document.errorFrm.email.value = '#form.email#'
										document.errorFrm.phone.value = '#form.phone#'
										document.errorFrm.otherphone.value = '#form.otherphone#'
										document.errorFrm.best_time.value = '#form.best_time#'
										document.errorFrm.email_only.value = '#form.email_only#'
										document.errorFrm.comments.value = '#form.comments#'
										document.errorFrm.errorMsg.value = '#errorMsg#'
										document.errorFrm.errorPhone.value = '1'
										document.errorFrm.pid.value = '#form.pid#'
										document.errorFrm.submit();
									</script>
			 					</cfoutput>
							<cfelseif blnIsBot>
			 					<cfoutput>
									<script language="JavaScript">
										document.errorFrm.fname.value = '#form.fname#'
										document.errorFrm.lname.value = '#form.lname#'
										document.errorFrm.email.value = '#form.email#'
										document.errorFrm.phone.value = '#form.phone#'
										document.errorFrm.otherphone.value = '#form.otherphone#'
										document.errorFrm.best_time.value = '#form.best_time#'
										document.errorFrm.email_only.value = '#form.email_only#'
										document.errorFrm.comments.value = '#form.comments#'
										document.errorFrm.errorMsg.value = '#errorMsg#'
										document.errorFrm.captchaError.value = '1'
										document.errorFrm.pid.value = '#form.pid#'
										document.errorFrm.submit();
									</script>
			 					</cfoutput>
								
							<cfelse>
								<!-- Insert info into customers table if new customer remove this section if not supported -->
								<cfquery name="find_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
									SELECT * from customers where (email = '#trim(email)#')
								</cfquery>
								
								<cfif not find_cust.recordcount>
								
									<cfquery name="insert_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
										INSERT into customers
										(
											FNAME,
											LNAME,
											PHONE,
											EMAIL
										)
										VALUES
										(
											'#form.FNAME#', 
											'#form.LNAME#',
											'#form.PHONE#',
											'#form.EMAIL#'
										)
										SELECT @@identity as uid 
									</cfquery>
									
									<cfset customerId = insert_cust.uid />
									
								<cfelse>

									<cfquery name="update_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
										UPDATE customers SET 
											EMAIL = '#EMAIL#'
											<cfif form.phone NEQ "">
												,PHONE = '#phone#'
											</cfif>
											<cfif form.otherphone NEQ "">
												,OTHERPHONE = '#otherphone#'
											</cfif>
										WHERE id = #find_cust.id#
									</cfquery>
								
									<cfset customerId = find_cust.id />
									
								</cfif>
								
									<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
										INSERT into epricing
										(
											fk_customers,
											fk_products,
											best_time,
											epricing_phone,
											otherphone,
											email,
											comments,
											email_only

										)
										VALUES
										(
											#customerId#, 
											#productinfo.uid#,
											'#form.best_time#',
											'#form.phone#',
											'#form.otherphone#',
											'#form.email#',
											'#form.comments#',
											<cfif isDefined('form.email_only')>
												1
											<cfelse>
												0
											</cfif>
										)
									</cfquery>
									<cfmail server="#servername#" username="gallart@onlinegalleryart.com"
					password="re3objeC!P" to="#emailsupport#" cc="#emailsupportcc#" from="#form.Email#" subject="GallArt.com <> We Buy & Sell Fine Art <> e-Pricing" type="HTML">
										<font style="font-size: 10pt; font-family: Arial;">
										The following user submitted an e-Pricing form:
										<br><br>
										Name: #form.fname# #form.lname#<br>
										Email Address: #form.email#<br>
										Phone: #form.phone#<br>
										Phone Outside US: #form.otherphone#<br>
										<cfif form.email_only EQ 1>
											Email Only<br>
										</cfif>
										<cfif form.best_time NEQ "">
											Best time to call: #form.best_time#<br>
										</cfif>
										Comments: #form.comments#<br>
										Artist: #ucase(productinfo.manufacturer)#<br>
										Title: #productinfo.name#<br>
										Art ID: #productinfo.modelno#<br>
										Retail Price: #dollarFormat(productinfo.retail_price)#<br>
										Gallery Price: #dollarFormat(productinfo.gallery_price)#<br>
										<cfif application.showSalePrice EQ 1>Sale Price: #dollarFormat(productinfo.sale_price)#</cfif>
										<cfif productinfo.fk_users GT 1>
											<br>
											Seller: #productinfo.fname# #productinfo.lname#<br>
											Seller Email: #productinfo.email#<br>
											Seller Phone: #productinfo.phone#
										</cfif>
										<br><br>
										</font>
									</cfmail>
									
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td style="padding-top: 20px;" align="center">
												<span style="color:##dd3a7d; font-size: 16px; font-weight: bold;">THANK YOU FOR CONTACTING E-PRICING!<br>WE WILL BE IN TOUCH WITH YOU SHORTLY<br><br>
												<a href="index.cfm?xss=#xss#" style="color:##dd3a7d; font-size: 16px; font-weight: bold; text-decoration: underline;">CLICK HERE</a> TO MAKE ANOTHER SELECTION</span>
											</td>
										</tr>
									</table>

							</cfif>

						<cfelse>
						<cfform action="" method="post" name="frm1">
						<input type="hidden" name="submitted" value="1" />
						<input	type="hidden" name="captcha_check"	value="#form.captcha_check#" />
						<input	type="hidden" name="pid"	value="#form.pid#" />
						<table cellpadding="2" cellspacing="0" border="0" width="100%">
							<tr>
								<Td colspan="2" align="Center">
									<span style="color:##dd3a7d; font-size: 16px; font-weight: bold;">GET E-PRICING FOR THIS PIECE!<br>SIMPLY SUBMIT THE FORM BELOW:</span>
								</td>
							</tr>
							<tr>
								<td colspan="2" style="padding-top: 10px;">
									<cfif FORM.captchaError EQ 1>
										<span style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</span><br><br>
									</cfif>
									<cfif FORM.errorPhone EQ 1>
										<span style="color: ##ff0000; font-weight: bold;">
											#form.errorMsg#
										</span><br><br>
									</cfif>
								</td>
							</tr>
							<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>FIRST NAME</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="fname" value="#form.fname#" required="Yes" MESSAGE="Please fill in your first name."></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>LAST NAME</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="lname" value="#form.lname#" required="Yes" MESSAGE="Please fill in your last name."></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>E-MAIL ADDRESS</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="email" value="#form.email#" required="Yes" MESSAGE="Please fill in a proper email address." validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$"></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>HOME PHONE (xxx) xxx-xxxx</b></FONT><br><cfinput type="text" size=40 maxsize=50 name="phone" value="#form.phone#" required="No" MESSAGE="Please fill in your home phone with a proper number." mask="(999) 999-9999"></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>PHONE NUMBER OUTSIDE THE US<b></FONT><br><cfinput type="text" size=40 maxsize=50 name="otherphone" value="#form.otherphone#" required="No" ></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>BEST TIME TO CALL<b></FONT><br><cfinput type="text" size=40 maxsize=50 name="best_time" value="#form.best_time#" required="No" ></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>OR EMAIL ONLY<b></FONT><br><input type="checkbox" name="email_only" value="1" <cfif form.email_only EQ 1>checked</cfif> /></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD><FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>COMMENTS</b></FONT><br><TEXTAREA NAME="comments" ROWS=10 COLS=35>#form.comments#</TEXTAREA></TD>
							<td width="75">&nbsp;</td>
						</TR>
						<TR>
							<TD>
								<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low"	fonts="verdana,arial,times new roman,courier,tahoma" fontsize="28"	/>
							<br><br>
							<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>Please enter the characters in the image above:</b></FONT><br><br>
							<cfinput type="text" name="captcha" required="true" message="Please enter the characters in the image.">
							
							</TD>
							<td width="75">&nbsp;</td>
						</TR>
	<!--spacer starts-->
	   				 	<tr><td colspan="2"><br></td></tr>
	<!--spacer ends-->
						<TR>
							<TD><input type="Image" src="images/submit.gif" style="border: none;"><br>
							<input style="background:url(images/reset.gif) no-repeat; width: 87px; height: 30px; border: none; cursor: pointer;" type="reset" value="" /></TD>
							<td width="75">&nbsp;</td>
						</TR>
						</table>
						</cfform>
						</cfif>
					</td>
				</tr>
			</table>
			</cfoutput>
			</cfif>
			
			<td valign="top" style="padding-top: 5px;">
				<cfoutput>
				<cfif #similar.recordcount# gt 0>
					
					<table cellspacing="2" cellpadding="2" border="0" align="center">
						<Tr>
							<td colspan="#similar.recordcount#" align="center">
						<font face="arial,helvetica" size="2"><b>You Might Also Like:</b></font>
							</td>
						</tr>
						<cfloop query="similar">
							
							<cfset thisFile = "#expandpath('.')#\img\#similar.uid#.jpg" />
						
							<cfif listlen(manufacturer) gt 1>
								<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
								<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
							<cfelse>
								<cfset artist_name = manufacturer />
								<cfset artist_name_url = manufacturer />
							</cfif>
						
							<tr>
						
								<td valign="top" align="center">

									<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
									<cfif fileExists(thisFile)>
									<img src="http://#server_name#/img/thumbnails/#similar.uid#.jpg" alt="#ucase(similar.manufacturer)# - #similar.name#" border="1">
									<cfelse>
									#ucase(similar.manufacturer)# - #similar.name#
									</cfif>
										<Br>
										<font size="1" face="verdana, arial">#name#</a>
								</td>
						
							</tr>
						</cfloop>
					</table>
					<br>
					</cfif>

					<input type="image" src="images/other_listings.gif" style="border: none;" onClick="location.href='index.cfm?xss=#xss#'">
			</cfoutput>
			
			</td>
			</td>
			</tr>
			</table>
			
		<!--- content ends --->
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