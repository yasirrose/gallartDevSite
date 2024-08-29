<!--- Kill extra output. --->
<cfsilent>
	<!--- REGISTRATION FORM CAPTCHA --->
	<cfparam name="form.fname" default="">	
	<cfparam name="form.lname" default="">						
	<cfparam name="form.email" default="">
	<cfparam name="form.cellphone" default="">
	<cfparam name="form.phone" default="">
	<cfparam name="form.businessphone" default="">
	<cfparam name="form.otherphone" default="">
	<cfparam name="form.website" default="">
	<cfparam name="form.captchaError" default="0">
	<cfparam name="form.errorMsg" default="">
 	<cfparam name="form.errorPhone" default="0">
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

			<cfif len(form.cellphone) AND NOT isValid("regex",form.cellphone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = "Please enter your cell phone number in the format (xxx) xxx-xxxx <br/>" />
			</cfif>
			<cfif len(form.phone) AND NOT isValid("regex",form.phone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = errorMsg & "Please enter your home phone number in the format (xxx) xxx-xxxx <br/>" />
			</cfif>
			<cfif len(form.businessphone) AND NOT isValid("regex",form.businessphone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = errorMsg & "Please enter your business phone number in the format (xxx) xxx-xxxx <br/>" />
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

	<!--- PURCHASE/CONSIGNMENT FORM CAPTCHA --->

	<cfparam name="form.name" default="">	
	<cfparam name="form.phone" default="">						
	<cfparam name="form.email_purchase" default="">
	<cfparam name="form.artist" default="">
	<cfparam name="form.title" default="">
	<cfparam name="form.size" default="">
	<cfparam name="form.additional_details" default="">
	<cfparam name="form.captchaError2" default="0">
	<cfparam
		name="FORM.captcha2" type="string"	default=""	/>
 
	<cfparam
		name="FORM.captcha_check2" type="string" default="" />

 
	<!--- Set a flag to see if this user is a bot or not. --->
	<cfset blnIsBot2 = true />
 
	<!--- Check to see if the form has been submitted. --->
	
	<cfif isDefined('process_purchase_consignment')>

		<cftry>
 
			<!--- Decrypt the check value. --->
			<cfset strCaptcha2 = Decrypt( FORM.captcha_check2, "gallart-is-the-best", "CFMX_COMPAT", "HEX"	) />

			<cfif (strCaptcha2 EQ FORM.captcha2)>

				<cfset blnIsBot2 = false />
 
			</cfif>

			<cfcatch>

				<cfset blnIsBot2 = true />
 
			</cfcatch>
		</cftry>
 
	</cfif>

	<cfset arrValidChars = ListToArray(
		"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
		"2,3,4,5,6,7,8,9"
		) />
 
	<!--- Now, shuffle the array. --->
	<cfset CreateObject( "java", "java.util.Collections"	).Shuffle(	arrValidChars )	/>

	<cfset strCaptcha2 = (
		arrValidChars[ 1 ] &
		arrValidChars[ 2 ] 
		) />

	<cfset FORM.captcha_check2 = Encrypt( strCaptcha2,"gallart-is-the-best", "CFMX_COMPAT", "HEX" ) />
 
</cfsilent>

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
<script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>

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

<cfif IsDefined( "form.login" )>
	<cfquery name="ValidUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT * from users
		where email = '#form.email_login#'
		and password = '#form.password#'
	</cfquery>
	
	<cfif ValidUser.recordcount>
	
	<cfset session.sellerinfo.pk_users = ValidUser.pk_users>
	<cfset session.sellerinfo.fname = ValidUser.fname>
	<cfset session.sellerinfo.lname = ValidUser.lname>
	<cfset session.sellerinfo.email = ValidUser.email>
	<cfset session.sellerinfo.login = 1 />
	
	<cfif isDefined('xss')>
		<cfset url_string = "user_listing_detail.cfm?xss="&xss />
	<cfelse>
		<cfset url_string = "user_listing_detail.cfm" />
	</cfif>
	
	
	<cflocation addtoken="No" url="#url_string#">
	
	<cfelse>
		<cfset seller_login_error = 1 />
	</cfif>
	

</cfif>


<cfset fileSizeLimit = 200000 />
<cfset fileSizeLimitKb = '200KB' />


<cfif isDefined('process_purchase_consignment')>

	<cfquery name="getPreviousEntries" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT * FROM purchases_consignments
        where email = '#form.email_purchase#'
    </CFQUERY>

    <cfoutput>
	<form method="post" action="#script_name#?xss=#xss#&processed=true&entryCount=#getPreviousEntries.recordcount#" name="errorFrm2">
		<input type="Hidden" name="name">
		<input type="Hidden" name="phone">
		<input type="Hidden" name="email_purchase">
		<input type="Hidden" name="artist">
		<input type="Hidden" name="title">
		<input type="Hidden" name="size">
		<input type="Hidden" name="additional_details">
		<input type="Hidden" name="captchaError2" value="1">
	</form>
	</cfoutput>

	<cfif blnIsBot2>
			<cfoutput>
			<script language="JavaScript">
				document.errorFrm2.name.value = '#form.name#'
				document.errorFrm2.phone.value = '#form.phone#'
				document.errorFrm2.email_purchase.value = '#form.email_purchase#'
				document.errorFrm2.artist.value = '#form.artist#'
				document.errorFrm2.title.value = '#form.title#'
				document.errorFrm2.size.value = '#form.size#'
				document.errorFrm2.additional_details.value = '#form.additional_details#'
				document.errorFrm2.submit();
			</script>
			</cfoutput>
		
	<cfelse>

	    <cfif (getPreviousEntries.recordcount + 1) GTE 5>
	        <cflocation url="#script_name#?xss=#xss#&reachedMax=true" addtoken="No">
	    <cfelse>
	    
	    	<cfif cgi.content_length LTE fileSizeLimit>
	            
	            <cfparam name="cffile.serverfile" default="" />
	            <cfparam name="Uploaded_File_Name" default="" />

	            <cfif len(thisImage)>
	                <cffile action="UPLOAD" filefield="thisImage" destination="#expandpath('.')#/purchases_consignments/images" nameconflict="MAKEUNIQUE">
	                <cfset Uploaded_File_Name = CFFile.ClientFile>
	            </cfif>
	            
	            
	            <cfquery name="insertListing" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	                INSERT INTO purchases_consignments 
	                (
	                    NAME,
	                    PHONE,
	                    EMAIL,
	                    IMAGE_NAME,
	                    ARTIST,
	                    TITLE,
	                    MEDIUM,
	                    SIZE,
	                    ADDITIONAL_DETAILS
	                )
	                VALUES
	                (
	                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.NAME#">,
	                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.PHONE#">,
	                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.EMAIL_PURCHASE#">,
	                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cffile.serverFile#">,
	                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.ARTIST#">,
	                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.TITLE#">,
	                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.MEDIUM#">,
	                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.SIZE#">,
	                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.ADDITIONAL_DETAILS#">
	                )
	                SELECT @@identity as uid 
	            </cfquery>
	            

	            
	            <cftry>
	        
	        	 <cfmail server="#application.mailserver#" username="#application.mailserver_un#" password="#application.mailserver_pw#" to="#emailsupport#" cc="#emailsupportcc#" from="#form.email_purchase#" subject="GallArt.com <> Buying & Selling Fine Art <> Purchases/Consignments Form" type="HTML">
	            <!--- <cfmail server="#application.mailserver#" username="#application.mailserver_un#" password="#application.mailserver_pw#" to="steverucker@gmail.com" from="#form.email_purchase#" subject="GallArt.com <> Buying & Selling Fine Art <> Purchases/Consignments Form" type="HTML"> --->
	                <font style="font-size: 10pt; font-family: Arial;">
	                <strong>#form.name#</strong> entered a new product on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
	                Phone: #form.phone#<br>
	                Email: #form.email_purchase#<br>
	                Artist: #form.artist#<br>
	                Title: #form.title#<br>
	                Medium: #form.medium#<br>
	                Size: #form.size#<br>
	                Additional Details: #form.additional_details#<br>
	                <cfmailparam 
	                    file="#expandpath('.')#/purchases_consignments/images/#Uploaded_File_Name#"
	                    contentid="purchase_consignment_image" 
	                    disposition="inline"
	                />
	                <br><br>
	            </cfmail>
	            
	            <cfcatch type="Any">ERROR!!<cfabort></cfcatch>
	            
	            </cftry>
	            
	            <cflocation url="#script_name#?xss=#xss#&processed=true&entryCount=#getPreviousEntries.recordcount#" addtoken="No">
	            
	     	<cfelse>
	        	<cflocation url="#script_name#?xss=#xss#&error=filetoolarge" addtoken="No">
	    	</cfif>

	    </cfif>
    </cfif>

</cfif>

<!-- End processing -->

<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT path FROM products
	group by path
	order by path
</CFQUERY>


<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<cfoutput>
<form method="post" action="#script_name#?xss=#xss#" name="errorFrm">
	<input type="Hidden" name="fname">
	<input type="Hidden" name="lname">
	<input type="Hidden" name="email">
	<input type="Hidden" name="cellphone">
	<input type="Hidden" name="phone">
	<input type="Hidden" name="businessphone">
	<input type="Hidden" name="otherphone">
	<input type="Hidden" name="website">
	<input type="Hidden" name="errorMsg">
	<input type="Hidden" name="captchaError" value="0">
	<input type="Hidden" name="errorPhone" value="0">
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
		<td valign="top" width="727" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr height="100%">
					<td height="100%" valign="top" align="center" style="padding-top: 10px;">
						<cfif FORM.submitted>	
							<!--- Check for a bot. --->
							<cfif phoneError>
								<cfoutput>
									<script language="JavaScript">
										document.errorFrm.fname.value = '#form.fname#'
										document.errorFrm.lname.value = '#form.lname#'
										document.errorFrm.email.value = '#form.email#'
										document.errorFrm.cellphone.value = '#form.cellphone#'
										document.errorFrm.phone.value = '#form.phone#'
										document.errorFrm.businessphone.value = '#form.businessphone#'
										document.errorFrm.otherphone.value = '#form.otherphone#'
										document.errorFrm.website.value = '#form.website#'
										document.errorFrm.errorMsg.value = '#errorMsg#'
										document.errorFrm.errorPhone.value = '1'
										document.errorFrm.submit();
									</script>
			 					</cfoutput>
							<cfelseif blnIsBot>
			 					<cfoutput>
									<script language="JavaScript">
										document.errorFrm.fname.value = '#form.fname#'
										document.errorFrm.lname.value = '#form.lname#'
										document.errorFrm.email.value = '#form.email#'
										document.errorFrm.cellphone.value = '#form.cellphone#'
										document.errorFrm.phone.value = '#form.phone#'
										document.errorFrm.businessphone.value = '#form.businessphone#'
										document.errorFrm.otherphone.value = '#form.otherphone#'
										document.errorFrm.website.value = '#form.website#'
										document.errorFrm.errorMsg.value = '#errorMsg#'
										document.errorFrm.captchaError.value = '1'
										document.errorFrm.submit();
									</script>
			 					</cfoutput>
								
							<cfelse>

								<cfquery name="CheckDups" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
										select pk_users from users where email =  <cfqueryparam value="#trim(form.email)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
								</cfquery>
								
									<cfif CheckDups.recordcount gt 0>
										<script language="JavaScript">
											alert('The email you selected is taken. If you are already a member please log in.');
											history.go(-1);
										</script>
										<cfabort>
									</cfif>
									
									<cfif form.password neq form.password2>
										<script language="JavaScript">
											alert('Password missmatch. Please retype your password.');
											history.go(-1);
										</script>
										<cfabort>
									</cfif>
									
									<cflock name="insertuser" timeout="10">
									
									<cfquery name="insertUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
										INSERT into users
										(
											fname,
											lname,
											email,
											password,
											cellphone,
											phone,
											businessphone,
											otherphone,
											website
										)
										values
										(
											<cfqueryparam value="#form.fname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
											<cfqueryparam value="#form.lname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
											<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
											<cfqueryparam value="#form.password#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
											<cfqueryparam value="#form.cellphone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
											<cfqueryparam value="#form.phone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
											<cfqueryparam value="#form.businessphone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
											<cfqueryparam value="#form.otherphone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
											<cfqueryparam value="#form.website#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
										)
									</cfquery>
									
									<!--- getting the last input UID --->
									<cfquery name="lastUID" datasource="#dsource#" username="#uname#" password="#pword#">
										SELECT @@identity as uid FROM users
									</cfquery>
									
									<cfset session.sellerinfo.pk_users = lastUID.uid>
									<cfset session.sellerinfo.fname = form.fname>
									<cfset session.sellerinfo.lname = form.lname>
									<cfset session.sellerinfo.login = 1 />
									
									</cflock>
									
									<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
								password="re3objec" to="#emailsupport#" cc="#emailsupportcc#" from="#form.email#" subject="GallArt.com <> Buying & Selling Fine Art <> New Member Registration <> Seller" type="HTML">
										<font style="font-size: 10pt; font-family: Arial;">
										<strong>#session.sellerinfo.fname# #session.sellerinfo.lname#</strong> registered as a new Member on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
										<br><br>
									</cfmail>
									
									<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
								password="re3objec" to="#form.email#" from="onli16@onlinegalleryart.com" subject="Gallery Art - Welcome New Member" type="HTML">
										<font style="font-size: 10pt; font-family: Arial;">
										Thank you, #session.sellerinfo.fname# #session.sellerinfo.lname#, for registering as a Member at www.gallart.com. <br><br>
										Your password is:<br>
										#form.password#<br><br>
										Please keep it in a safe place.<br><br>
										You are now ready to list your artwork!<br><br>
										#getPages.page_content#
										<br><br>
									</cfmail>
									
									<cflocation url="user_listing_detail.cfm?xss=#xss#" addtoken="No">
							</cfif>	

						<cfelse>
						
						
						<table cellpadding="2" cellspacing="0" border="0" width="100%">
							<tr>
								<td width="425" style="border-right: 1px solid #000000;">
									<cfoutput>
									<table width="100%" cellpadding="0" cellspacing="0">
										<tr>
											<td colspan="2">
												<h4 style="color: ##dd3a7d">SELL YOUR ART ON <a style="color: ##dd3a7d; font-size: 12pt; font-weight: bold;" href="http://gallart.com?xss=#xss#">GallArt.com</a></h4>
												<h5 style="color: ##dd3a7d">YOU can be a seller on <a style="color: ##dd3a7d; font-size: 10pt;" href="http://gallart.com?xss=#xss#">GallArt.com</a>!</h5>
												Here's how it works:<br>
													<ul>
														<li>Fill out and submit the registration form below.</li>
														<li>You will immediately become a seller on GALLART.COM</li>
														<li>List your art using our simple form.</li>
														<li>Please don't use any personal information in your description, or watermarks in the images.</li>
														<li>GALLART.COM will charge a 20% fee when you sell your art</li>
													</ul>
											</td>
										</tr> 
										<tr>
											<td>
												Get started NOW by completing the form below.<br><br>
											</td>
										</tr>
										<tr>
											<td>
												Please fill out all required fields and click the button "CLICK TO BECOME A SELLER."  You will then be taken to a page where you can list your art.
											</td>
										</tr>
										<tr>
											<Td colspan="2" style="padding-top: 12px;">
												<h5 style="color: ##dd3a7d">REGISTRATION FORM</h5>
												<span style="color: ##ff0000;">* required</span><br/>
												<cfif FORM.captchaError>
													<span style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</span><br><br>
												</cfif>
												<cfif FORM.errorPhone EQ 1>
													<span style="color: ##ff0000; font-weight: bold;">
														#form.errorMsg#
													</span><br><br>
												</cfif>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<CFFORM ACTION="#script_name#?xss=#xss#" METHOD="POST">
												<input type="hidden" name="submitted" value="1" />
												<input	type="hidden" name="captcha_check"	value="#FORM.captcha_check#" />
												<table cellspacing="0" cellpadding="5" border="0" width="100%">
													<tr>
														<td><b>First Name:</b>
														</td>
														<td><cfinput type="text" name="fname" value="#form.fname#" size="30" required="Yes" message="Please enter your first name.">&nbsp;<span style="color: ##ff0000;">*</span>
														</td>
													</tr>
													<tr>
														<td><b>Last Name:</b>
														</td>
														<td><cfinput type="text" name="lname" value="#form.lname#" size="30" required="Yes" message="Please enter your last name.">&nbsp;<span style="color: ##ff0000;">*</span>
														</td>
													</tr>
													<tr>
														<td><b>Email:</b>
														</td>
														<td><cfinput type="text" name="Email" value="#form.Email#" size="30" required="Yes" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" message="Please enter a proper email." >&nbsp;<span style="color: ##ff0000;">*</span>
														</td>
													</tr>
													<tr>
														<td><b>Cell Phone:</b>
														</td>
														<td><cfinput type="text" name="cellphone" value="#form.cellphone#" size="30" required="Yes"  message="Please enter a cell phone number." mask="(999) 999-9999">&nbsp;<span style="color: ##ff0000;">*</span>
														</td>
													</tr>
													<tr>
														<td><b>Home Phone:</b>
														</td>
														<td><cfinput type="text" name="Phone" value="#form.Phone#" size="30" required="No"  message="Please enter a phone number."  mask="(999) 999-9999">
														</td>
													</tr>
													<tr>
														<td><b>Business Phone:</b>
														</td>
														<td><cfinput type="text" name="businessphone" value="#form.businessphone#" size="30" required="No"  message="Please enter a phone number."  mask="(999) 999-9999">
														</td>
													</tr>
													<tr>
														<td><b>Phone Number Outside the US:</b>
														</td>
														<td><cfinput type="text" name="otherphone" value="#form.otherphone#" size="30" required="No"  message="Please enter a phone number." >
														</td>
													</tr>
													<tr>
														<td><b>Website:</b>
														</td>
														<td><cfinput type="text" name="website" value="#form.website#" size="30" required="No"  message="Please enter a phone number." >
														</td>
													</tr>
													<tr>
														<td><b>Create a Password:</b>
														</td>
														<td><cfinput type="password" name="password" size="30" required="Yes" message="Please enter a password.">&nbsp;<span style="color: ##ff0000;">*</span>
														</td>
													</tr>
													<tr>
														<td><b>Re-enter Password:</b>
														</td>
														<td><cfinput type="password" name="password2" size="30" required="Yes" message="Please re-enter your password.">&nbsp;<span style="color: ##ff0000;">*</span>
														</td>
													</tr>
													<tr>
														<td colspan="2">
															<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low" fonts="verdana,arial,times new roman,courier" fontsize="28"	/>
														<br><br>
														<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>Please enter the characters in the image above:</b></FONT><br><br>
														<cfinput type="text" name="captcha" required="true" message="Please enter the characters in the image.">
														
														</td>
													</tr>
													<tr>
														<td colspan="2" align="center">
															<input type="Hidden" name="proc_reg">
															<input type="image" src="images/become_a_seller.gif" style="border: none;">								
														</td>
													</tr>
												</table>
												</cfform>
											</td>
										</tr>
									</table>
									</cfoutput>
									</cfif>
									<cfif isDefined('seller_login_error')>
										<div align="center" style="color: ##dd3a7d; font-weight: bold;">THAT EMAIL AND/OR PASSWORD<br>IS NOT IN OUR SYSTEM.<br>
										PLEASE TRY AGAIN:</div>
									<cfelse>
										If you have already signed up as a seller, please log in here:
									</cfif>
									<cfoutput>
									<cfform name="loginFrm" method="POST" action="#script_name#?#query_string#">
									<input type="Hidden" name="login">
									<table cellspacing="0" cellpadding="5" border="0" width="100%">
										<tr>
											<td>
												<strong>Email:</strong>
											</td>
											<td>
												<cfinput type="text" required="Yes" message="Please enter your email address" name="email_login" size="20">
											</td>
										</tr>
										<tr>
											<td>
												<strong>Password:</strong>
											</td>
											<td>
												<cfinput type="password" required="Yes" message="Please enter your password" name="password" size="20">
											</td>
										</tr>
										<tr>
											<td colspan="2" style="padding-left: 68px;  padding-bottom: 7px;">
												<input type="image" src="images/signin.jpg" alt="Sign In." style="border: 1px solid ##ffffff;">
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<a href="forgot_password.cfm?xss=#xss#">Forget your password?</a>
											</td>
										</tr>
									</table>
									</cfform>
									</cfoutput>
								</td>
								<td valign="top" style="padding-left: 20px; padding-top: 20px;">
									
									<table>
										<tr>
											<td>
												<h4 style="color: #dd3a7d;">WE BUY ART</h4>
												<h5 style="color: #dd3a7d;">Thinking of selling or consigning?</h5>
												<span style="font-size: 10pt;">Get a Free Quote</span>
											</td>
										</tr>
										<tr>
											<td style="padding-top: 31px;">
												We will tell you if your fine art is worth more than you think.
											</td>
										</tr>
										<tr>
											<td style="padding-top: 43px;">
												Call us or fill out the simple form below. 
											</td>
										</tr>
									</table>
									<table cellspacing="0" cellpadding="0" border="0" width="400">
						                <cfif structKeyExists(url,'reachedMax')>
						                <tr>
						                    <td align="center" style="color: #ff0000; font-size: 13px;">
						                        YOU HAVE REACHED THE MAXIMUM NUMBER OF <br />
						                        ENTRIES FOR THIS FORM.  
						                    </td>
						                </tr>
						                <cfelse>
						                    <cfif structKeyExists(url,'error')>
						                    <tr>
						                    	<td align="center" style="color: #ff0000; font-size: 13px;">
						                        	Sorry, but the file that you are attempting to load is too large.  Please reduce your file size to <cfoutput>#fileSizeLimitKb#</cfoutput>.
						                        </td>
						                    </tr>
						                    </cfif>
						                    <tr>
						                    	<td>
						                    		<h5 style="color: #dd3a7d; padding-top: 44px; padding-left: 3px;">PURCHASE/CONSIGNMENT FORM</h5>
						                    		<span style="color: #ff0000;">* required</span><br/>
						                    	</td>
						                    </tr>
						    				<tr>
						    					<td style="padding: 0 0 25px;">
						                            <cfif structKeyExists(url,'processed')>
						                            	<span style="color: #ff0000; font-size: 13px;">
						                            	<cfif FORM.captchaError2>
															<span style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</span><br><br>
														<cfelse>
							                                <cfset remainingEntries = 5 - (entryCount + 1)>
							                                YOUR LISTING HAS BEEN ENTERED SUCCESSFULLY.<br />
							                                <cfif remainingEntries LT 5 AND remainingEntries GT 0>
							                                    YOU MAY ENTER <cfoutput>#remainingEntries#</cfoutput> MORE ITEMS
							                                <cfelse>
							                                    YOU HAVE REACHED THE MAXIMUM NUMBER OF ENTRIES <br />
							                                    FOR THIS FORM
							                                </cfif>
							                            </cfif>
							                            </span>
						                                <br /><br />
						                            </cfif>
						    						<cfoutput>
						    						<cfform name="frm1" action="#script_name#?xss=#xss#" method="post" enctype="multipart/form-data">
						    						<input	type="hidden" name="captcha_check2"	value="#FORM.captcha_check2#" />
						    						<table cellspacing="0" cellpadding="5" border="0" width="100%" class="purchases-consignments">
						                                <tr>
						                                    <td><b>Name:</b>
						                                    </td>
						                                    <td><cfinput type="text" name="name" value="#form.name#" size="30" required="Yes" message="Please enter your name.">&nbsp;<span style="color: ##ff0000;">*</span>
						                                    </td>
						                                </tr>
						                                <tr>
						                                    <td><b>Phone:</b>
						                                    </td>
						                                    <td><cfinput type="text" name="phone" value="#form.phone#" size="30" required="No"  message="Please enter a phone number." mask="(999) 999-9999">
						                                    </td>
						                                </tr>
						                                <tr>
						                                    <td><b>Email:</b>
						                                    </td>
						                                    <td><cfinput type="text" name="email_purchase" value="#form.email_purchase#" size="30" required="Yes" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" message="Please enter a proper email." >&nbsp;<span style="color: ##ff0000;">*</span>
						                                    </td>
						                                </tr>
						                                <tr>
						                                    <td><b>Artist:</b>
						                                    </td>
						                                    <td><cfinput type="text" name="artist" value="#form.artist#" size="30" required="Yes"  message="Please enter an artist." >&nbsp;<span style="color: ##ff0000;">*</span>
						                                    </td>
						                                </tr>
						                                <tr>
						                                    <td><b>Title:</b>
						                                    </td>
						                                    <td><cfinput type="text" name="title" value="#form.title#" size="30" required="No"  message="Please enter a title." >
						                                    </td>
						                                </tr>
						                                <tr>
						                                    <td colspan="2"><b>Medium:</b>
						                                        <Select name="medium">
						                                            <option value="">Select here ...</option>
						                                            <cfloop query="cats">
						                                                <option value="#path#">#ucase(path)#
						                                            
						                                        </cfloop></select>
						                                    </td>
						                                </tr>
						                                <tr>
						                                    <td><b>Size:</b>
						                                    </td>
						                                    <td><cfinput type="text" name="size" value="#form.size#" size="30" required="No"  message="Please enter a size." >
						                                    </td>
						                                </tr>
						                                <tr>
						                                    <td colspan="2"><b>Additional Details:</b></td>
						                                </tr>
						                                <tr>
						                                    <td colspan="2"><textarea name="additional_details" cols="50" rows="4">#form.additional_details#</textarea></td>
						                                </tr>
						                                <tr>
						                                    <td colspan="2">
						                                    <b>Upload Photo</b> <br /><span style="color: ##ff0000; font-size: 8pt; font-weight: bold;">(THE FILE MUST BE A .JPG, AND MUST BE LESS THAN #fileSizeLimitKb# IN SIZE)</span>*<br><br>
						                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
						                                            <tr>
						                                                <td valign="top" width="50%">
						                                                    <input type="file" name="thisImage" size="22">
						                                                </td>
						                                            </tr>
						                                        </table>
						                                    </td>
						                                </tr>
						                                <tr>
															<td colspan="2">
																<cfimage action="captcha" height="75" width="363" text="#strCaptcha2#" difficulty="low" fonts="verdana,arial,times new roman,courier" fontsize="28"	/>
															<br><br>
															<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>Please enter the characters in the image above:</b></FONT><br><br>
															<cfinput type="text" name="captcha2" required="true" message="Please enter the characters in the image.">
															
															</td>
														</tr>
						                                <tr>
						                                    <td colspan="2" align="center">
						                                        <input type="Hidden" name="process_purchase_consignment">
						                                        <input type="Image" src="images/send.gif" style="border: none;">                          
						                                    </td>
						                                </tr>
						                                <tr>
						                                    <td colspan="2" style="font-size: 10pt;"><b>*If you any questions please email <a style="font-size: 10pt;" href="mailto: sales@gallart.com">sales@gallart.com</a> or call 305-932-6166 for further assistance. </b></td>
						                                </tr>
						                            </table>
						    						</cfform>						
						    						</cfoutput>
						    					</td>
						    				</tr>
		
						                </cfif>
									</table>
								</td>
							</tr>
									
						</table>
						
						
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