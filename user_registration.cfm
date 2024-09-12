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
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script>
<script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link href="stylesheet_.css" rel="stylesheet" type="text/css">

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
	<div class="main-container registration-page">
		<div id="Table_01">
			<div class="header-section">
				<div class="top-header">
					<cfinclude template="top_.cfm">
				</div>
				<div class="navbar-section">
					<cfinclude template="navbar_.cfm">
				</div>
			</div>
			<div class="inner-section">
				<div class="container-fluid">
					<div class="main-content">
						<div class="mobile-sidebar-logo">
							<div class="sidebar-Icon">
								<i class="fas fa-bars"></i>
							</div>
						</div>
						<div class="sidebar web-sidebar-modal">	
							<cfinclude template="left_.cfm">
						</div>
						<div class="content-section">
							<div class="bottom-content-sec">
								<div class="banner-section">
									<div class="art-work-content">
										<div class="bottom-content">
											<cfif FORM.submitted>	
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
											<div class="user-registrations">
												<div class="row">
													<div class="col-md-6">
														<cfoutput>
															<div class="user-content">
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
																<p>Get started NOW by completing the form below.</p>
																<p>Please fill out all required fields and click the button "CLICK TO BECOME A SELLER."  You will then be taken to a page where you can list your art.</p>
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
																<CFFORM ACTION="#script_name#?xss=#xss#" METHOD="POST">
																	<input type="hidden" name="submitted" value="1" />
																	<input	type="hidden" name="captcha_check"	value="#FORM.captcha_check#" />
																	<div class="input-form">
																		<div class="input-field">
																			<label><b>First Name:</b></label>
																			<cfinput type="text" name="fname" value="#form.fname#" size="30" required="Yes" message="Please enter your first name.">&nbsp;<span style="color: ##ff0000;">*</span>
																		</div>
																		<div class="input-field">
																			<label><b>Last Name:</b></label>
																			<cfinput type="text" name="lname" value="#form.lname#" size="30" required="Yes" message="Please enter your last name.">&nbsp;<span style="color: ##ff0000;">*</span>
																		</div>
																		<div class="input-field">
																			<label><b>Email:</b></label>
																			<cfinput type="text" name="Email" value="#form.Email#" size="30" required="Yes" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" message="Please enter a proper email." >&nbsp;<span style="color: ##ff0000;">*</span>
																		</div>
																		<div class="input-field">
																			<label><b>Cell Phone:</b></label>
																			<cfinput type="text" name="cellphone" value="#form.cellphone#" size="30" required="Yes"  message="Please enter a cell phone number." mask="(999) 999-9999">&nbsp;<span style="color: ##ff0000;">*</span>
																		</div>
																		<div class="input-field">
																			<label><b>Home Phone:</b></label>
																			<cfinput type="text" name="Phone" value="#form.Phone#" size="30" required="No"  message="Please enter a phone number."  mask="(999) 999-9999">
																		</div>
																		<div class="input-field">
																			<label><b>Business Phone:</b></label>
																			<cfinput type="text" name="businessphone" value="#form.businessphone#" size="30" required="No"  message="Please enter a phone number."  mask="(999) 999-9999">
																		</div>
																		<div class="input-field">
																			<label><b>Phone Number Outside the US:</b></label>
																			<cfinput type="text" name="otherphone" value="#form.otherphone#" size="30" required="No"  message="Please enter a phone number." >
																		</div>
																		<div class="input-field">
																			<label><b>Website:</b></label>
																			<cfinput type="text" name="website" value="#form.website#" size="30" required="No"  message="Please enter a phone number." >
																		</div>
																		<div class="input-field">
																			<label><b>Create a Password:</b></label>
																			<cfinput type="password" name="password" size="30" required="Yes" message="Please enter a password.">&nbsp;<span style="color: ##ff0000;">*</span>
																		</div>
																		<div class="input-field">
																			<label><b>Re-enter Password:</b></label>
																			<cfinput type="password" name="password2" size="30" required="Yes" message="Please re-enter your password.">&nbsp;<span style="color: ##ff0000;">*</span>
																		</div>
																		<div class="input-field">
																			<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low" fonts="verdana,arial,times new roman,courier" fontsize="28"	/>
																			<br><br>
																			<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>Please enter the characters in the image above:</b></FONT><br><br>
																			<cfinput type="text" name="captcha" required="true" message="Please enter the characters in the image.">
																		</div>
																		<div class="input-button">
																			<input type="Hidden" name="proc_reg">
																			<button type="submit" class="SeeMore">Become A Seller</button>
																		</div>
																	</div>
																</cfform>
															</div>
														</cfoutput>
														<div class="bottom-content">
															<cfif isDefined('seller_login_error')>
																<div align="center" style="color: ##dd3a7d; font-weight: bold;">THAT EMAIL AND/OR PASSWORD<br>IS NOT IN OUR SYSTEM.<br>
																PLEASE TRY AGAIN:</div>
																<cfelse>
																	If you have already signed up as a seller, please log in here:
																</cfif>
																<cfoutput>
																<cfform name="loginFrm" method="POST" action="#script_name#?#query_string#">
																<input type="Hidden" name="login">
																<div class="input-form">
																	<div class="input-field">
																		<label><strong>Email:</strong></label>
																		<cfinput type="text" required="Yes" message="Please enter your email address" name="email_login" size="20">
																	</div>
																	<div class="input-field">
																		<label><strong>Password:</strong></label>
																		<cfinput type="password" required="Yes" message="Please enter your password" name="password" size="20">
																	</div>
																	<div class="input-button">
																		<button type="submit" class="SeeMore">Sign In</button>
																	</div>
																	<div class="forget-pass">
																		<a href="forgot_password.cfm?xss=#xss#">Forget your password?</a>
																	</div>
																</div>
																</cfform>
															</cfoutput>
														</div>
													</div>
													<div class="col-md-6">
														<div class="user-content">
															<h4 style="color: #dd3a7d;">WE BUY ART</h4>
															<h5 style="color: #dd3a7d;">Thinking of selling or consigning?</h5>
															<span style="font-size: 10pt;">Get a Free Quote</span>
															<p>We will tell you if your fine art is worth more than you think.</p>
															<p>Call us or fill out the simple form below.</p>
															</cfif>
															<cfif structKeyExists(url,'reachedMax')>
																<p>YOU HAVE REACHED THE MAXIMUM NUMBER OF <br />
																	ENTRIES FOR THIS FORM.  </p>
																<cfelse>
																	<cfif structKeyExists(url,'error')>
																		<p>Sorry, but the file that you are attempting to load is too large.  Please reduce your file size to <cfoutput>#fileSizeLimitKb#</cfoutput>.</p>
																	</cfif>
																	<h5 style="color: #dd3a7d; padding-top: 14px; padding-left: 3px;">PURCHASE/CONSIGNMENT FORM</h5>
																<span style="color: #ff0000;">* required</span><br/>
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
															<div class="input-form">
																<div class="input-field">
																	<label><b>Name:</b></label>
																	<cfinput type="text" name="name" value="#form.name#" size="30" required="Yes" message="Please enter your name.">&nbsp;<span style="color: ##ff0000;">*</span>
																</div>
																<div class="input-field">
																	<label><b>Phone:</b></label>
																	<cfinput type="text" name="phone" value="#form.phone#" size="30" required="No"  message="Please enter a phone number." mask="(999) 999-9999">
																</div>
																<div class="input-field">
																	<label><b>Email:</b></label>
																	<cfinput type="text" name="email_purchase" value="#form.email_purchase#" size="30" required="Yes" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" message="Please enter a proper email." >&nbsp;<span style="color: ##ff0000;">*</span>
																</div>
																<div class="input-field">
																	<label><b>Artist:</b></label>
																	<cfinput type="text" name="artist" value="#form.artist#" size="30" required="Yes"  message="Please enter an artist." >&nbsp;<span style="color: ##ff0000;">*</span>
																</div>
																<div class="input-field">
																	<label><b>Title:</b></label>
																	<cfinput type="text" name="title" value="#form.title#" size="30" required="No"  message="Please enter a title." >
																</div>
																<div class="input-field">
																	<label><b>Medium:</b></label>
																	<Select name="medium" style="width: 171px;">
																		<option value="">Select here ...</option>
																		<cfloop query="cats">
																			<option value="#path#">#ucase(path)#
																		</cfloop>
																	</select>
																</div>
																<div class="input-field">
																	<label><b>Size:</b></label>
																	<cfinput type="text" name="size" value="#form.size#" size="30" required="No"  message="Please enter a size." >
																</div>
																<div class="input-field">
																	<label><b>Additional Details:</b></label>
																	<textarea name="additional_details" cols="50" rows="4">#form.additional_details#</textarea>
																</div>
																<div class="choose-field">
																	<label><b>Upload Photo</b></label>
																	<span style="color: ##ff0000; font-size: 8pt; font-weight: bold;">(THE FILE MUST BE A .JPG, AND MUST BE LESS THAN #fileSizeLimitKb# IN SIZE)</span>*
																	<input type="file" name="thisImage" size="22">
																</div>
																<div class="input-field">
																	<cfimage action="captcha" height="75" width="363" text="#strCaptcha2#" difficulty="low" fonts="verdana,arial,times new roman,courier" fontsize="28"	/>
																	<br><br>
																	<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>Please enter the characters in the image above:</b></FONT><br><br>
																	<cfinput type="text" name="captcha2" required="true" message="Please enter the characters in the image.">
																</div>
																<div class="input-button">
																	<input type="Hidden" name="process_purchase_consignment">
																	<button type="button" class="SeeMore">Send</button> 
																</div>
																<div class="any-question">
																	<p><b>*If you any questions please email <a style="font-size: 10pt;" href="mailto: sales@gallart.com">sales@gallart.com</a> or call 305-932-6166 for further assistance. </b></p>
																</div>
															</div>
															</cfform>						
															</cfoutput>
															</cfif>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<tr>
				<td colspan="2" valign="baseline">
					<cfinclude template="footer_.cfm">
				</td>
			</tr>
		</div>
	</div>


<cfinclude template="frmxss.cfm">

</body>
</html>