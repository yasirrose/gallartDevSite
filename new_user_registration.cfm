<!--- Kill extra output. --->
<cfsilent>
	<!--- REGISTRATION FORM CAPTCHA --->
	<cfparam name="form.fname" default="">	
	<cfparam name="form.lname" default="">						
	<cfparam name="form.email" default="">
	<cfparam name="form.cellphone" default="">
	<cfparam name="form.phone" default="">
	<cfparam name="form.phoneType" default="">
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

	<cfset hasError = false />
 
	<!--- Check to see if the form has been submitted. --->
	
	<!--- <cfif FORM.submitted>

			<cfset errorMsg = "" />

			<!--- <cfif len(form.cellphone) AND NOT isValid("regex",form.cellphone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = "Please enter your cell phone number in the format (xxx) xxx-xxxx <br/>" />
			</cfif>
			<cfif len(form.phone) AND NOT isValid("regex",form.phone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = errorMsg & "Please enter your home phone number in the format (xxx) xxx-xxxx <br/>" />
			</cfif>
			<cfif len(form.businessphone) AND NOT isValid("regex",form.businessphone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = errorMsg & "Please enter your business phone number in the format (xxx) xxx-xxxx <br/>" />
			</cfif> --->

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
 
	</cfif> --->

	<!--- <cfset arrValidChars = ListToArray(
		"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
		"2,3,4,5,6,7,8,9"
		) />
 
	<!--- Now, shuffle the array. --->
	<cfset CreateObject( "java", "java.util.Collections"	).Shuffle(	arrValidChars )	/>

	<cfset strCaptcha = (
		arrValidChars[ 1 ] &
		arrValidChars[ 2 ] 
		) />

	<cfset FORM.captcha_check = Encrypt( strCaptcha,"gallart-is-the-best", "CFMX_COMPAT", "HEX" ) /> --->

	<!--- PURCHASE/CONSIGNMENT FORM CAPTCHA --->

	<cfparam name="form.name" default="">	
	<cfparam name="form.phone" default="">						
	<cfparam name="form.phoneType" default="">						
	<cfparam name="form.email_purchase" default="">
	<cfparam name="form.artist" default="">
	<cfparam name="form.title" default="">
	<cfparam name="form.size" default="">
	<cfparam name="form.additional_details" default="">
	<cfparam name="form.captchaError2" default="0">
	<cfparam name="FORM.captcha2" type="string"	default=""	/>
 
	<cfparam name="FORM.captcha_check2" type="string" default="" />

 
	<!--- Set a flag to see if this user is a bot or not. --->
	<!--- <cfset blnIsBot2 = true />
 
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

	<cfset FORM.captcha_check2 = Encrypt( strCaptcha2,"gallart-is-the-best", "CFMX_COMPAT", "HEX" ) /> --->



	

 
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
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
			<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
			<!--- <script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script> --->
			<script language="JavaScript" src="/js/utils.js"></script>
		</cfoutput>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<link href="/stylesheet_.css" rel="stylesheet" type="text/css">
		<style>
			.custom-radio .form-check-input:checked {
				background-color: #0d6efd;
				border-color: #0d6efd;
			}
			.custom-radio .form-check-input {
				height: 1.5rem;
				width: 1.5rem;
				border-radius: 50%;
			} 
			.form-sectiom {
				background: #f2f2f2;
				border-radius: 10px;
				padding: 50px;
			}
			.registration-page .content-section .banner-section .art-work-content input, 
			.registration-page .content-section .banner-section .art-work-content select,
			.registration-page .content-section .banner-section .art-work-content .user-registrations .form-sectiom textarea {
				background-color: #fff; 
				border-radius: 10px !important;
				border: 1px solid lightgray !important;
			}
			.registration-page .content-section .banner-section .art-work-content .user-registrations .form-sectiom input, 
			.registration-page .content-section .banner-section .art-work-content .user-registrations .form-sectiom select, 
			.registration-page .content-section .banner-section .art-work-content .user-registrations .form-sectiom textarea {
				border: 1px solid #000;
				padding-inline: 20px;
			}
			.user-registrations .input-form .input-field input, .user-registrations .input-form .input-field select {
				width: 100% !important;
				height: 45px !important;
			}
			.user-registrations .input-form .input-field textarea {
				width: 100% !important; 
				padding: 20px !important;
			}
			.user-registrations .input-form .input-field img {
				width: 100% !important; 
				border-radius: 10px;
			}
			.registration-page .content-section .banner-section .art-work-content .tabs-dropdown  select.form-select {
				height: 45px;
				margin-bottom: 20px;
				margin-top: 15px;
			} 
			.main-content-description p {
				font-size: 16px;
				line-height: 1.2;
			}
			.main-content-description {
				padding: 30px 0px;
			}
			.registration-page .content-section h5 {
			margin-bottom: 30px;
			}
			.registration-page .user-content {
				font-size: 16px;
				line-height: 1.2;
			}
			.registration-page .main-content-description h2 {
				margin-bottom: 20px;
			}
			.file-upload-wrapper {
			width: 100%;
			padding: 20px;
				background-color: white;
				border: 2px dashed lightgray;
				border-radius: 8px;
				text-align: center;
				cursor: pointer;
				color: #000;
				margin-bottom: 30px;
				margin-top: 15px;
			}

			.file-upload-label {
			display: block;
			cursor: pointer;
			}

			.file-upload-input {
			display: none;
			}

			.file-upload-icon {
			margin-bottom: 10px;
			}

			.file-upload-icon svg {
			width: 40px;
			height: 40px;
			fill: #666;
			}

			.file-upload-text strong {
			font-size: 16px;
			color: #333;
			}

			.file-upload-text p {
			font-size: 14px;
			color: #666;
			margin: 5px 0 0;
			}
			.user-registrations .input-form .input-button {
				justify-content: center;
			border-top: 1px solid #000000;
			padding-top: 30px;
			}
			.input-field.image-upload ul {
				padding: 0;
				margin: 0;
			}
			.input-field.image-upload ul li {
				list-style: none;
			}
			@media (max-width: 767px) {
				.form-sectiom { 
					padding: 40px 20px;
				}
			}
		</style>
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
		<script>
			function togglePanels(showId, hideId) {
				// Add the 'show' class to the panel to display
				document.getElementById(showId).classList.add('show');
				
				// Remove the 'show' class from the panel to hide
				document.getElementById(hideId).classList.remove('show');
			}
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


		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

		<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

	</head>
	<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<!--- <cfif IsDefined( "form.login" )>
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
				<cfset url_string = "user_listing_detail" />
			<cfelse>
				<cfset url_string = "user_listing_detail" />
			</cfif>
			
			
			<cflocation addtoken="No" url="#url_string#">
			
			<cfelse>
				<cfset seller_login_error = 1 />
			</cfif>
			
		
		</cfif> --->
		
		
		<cfset fileSizeLimit = 2000000 />
		<cfset fileSizeLimitKb = '2MB' />
		
		
		<cfif isDefined('process_purchase_consignment')>

			<cfif structKeyExists(FORM, "g-recaptcha-response")>

				<cfset apikey="6LddEiMrAAAAAJdkOFhc6RFcBOQ4Ol15oaRHRwJb">

				<cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="post">
					<cfhttpparam type="formField" name="secret" value="#apikey#">
					<cfhttpparam type="formField" name="response" value="#FORM['g-recaptcha-response']#">
					<cfhttpparam type="formField" name="remoteip" value="#CGI.REMOTE_ADDR#">
				</cfhttp>
					
				<cfset captchaResponse = DeserializeJSON(cfhttp.FileContent)>
				
				

				<cfquery name="getPreviousEntries" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					SELECT * FROM purchases_consignments
					where email = '#form.email_purchase#'
				</CFQUERY>
			
				<cfoutput>
					<form method="post" action="/sell-your-art/true/#getPreviousEntries.recordcount#" name="errorFrm2">
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
		
				
			
				<cfif NOT captchaResponse.success>
					
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
						<cflocation url="#script_name#?reachedMax=true" addtoken="No">
					<cfelse>
						
							<!--- <cfdump var="#cgi.content_length#">
							<cfdump var="#fileSizeLimit#" abort="true"> --->
		
						<!--- <cfif cgi.content_length LTE fileSizeLimit> --->
							
							<!--- <cfparam name="cffile.serverfile" default="" />
							<cfparam name="Uploaded_File_Name" default="" />
			
							<cfif len(thisImage)>
								<cffile action="UPLOAD" filefield="thisImage" destination="#expandpath('.')#/purchases_consignments/images" nameconflict="MAKEUNIQUE">
								<cfset Uploaded_File_Name = CFFile.ClientFile>
							</cfif> --->
							
							
							
							<!--- <cfdump var="#form#" abort="true"> --->
							<cfset maxFileSize = 5 * 1024 * 1024 /> <!--- 5MB in bytes --->
							<cfset fileTooLarge = false />
							<cfset oversizedImages = "">
		
							

							<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
							<cfset date = now()>
							<cfset moduleName = 'purchase_consignment'>
							<cfset action = 'Insert'>
							
							<!--- <cfdump var="#ipAddress#" ><br>
							<cfdump var="#date#" ><br>
							<cfdump var="#CGI.HTTP_X_FORWARDED_FOR#" abort="true"> --->

							<cfquery name="getLogs" datasource="#application.dsource#">
								SELECT * From logs where ipAddress = '#ipAddress#' and moduleName = '#moduleName#' and CAST([date] AS DATE) = #date#
							</cfquery>					

							<cfif getlogs.recordCount LT 2>
			
								<cfif 
									form.fname NEQ '' 
									and form.PHONE NEQ '' 
									and form.EMAIL_PURCHASE NEQ '' 
									and form.lname NEQ '' 
									and form.size NEQ '' >
			
										<!--- <cfdump var="#form#" abort="true"> --->
			
										<cfloop collection="#form#" item="idx">
											<cfif left(idx,9) EQ "addImage_">
												<cfset thisFilefield = idx />
												
												<!--- Temporarily upload the file to check size --->
												<cffile action="upload" nameconflict="overwrite" filefield="#thisFilefield#" 
														destination="#expandpath('.')#/purchases_consignments/images/" result="fileCheck">
												
												<cfif LCase(fileCheck.clientFileExt) NEQ "jpg">
													<cfset fileTooLarge = true />
													<cfset oversizedImages = listAppend(oversizedImages, fileCheck.ClientFileName & " (Invalid extension)") />
													<cffile action="delete" file="#fileCheck.ServerDirectory#/#fileCheck.ServerFile#" />

												<cfelseif fileCheck.FileSize GT maxFileSize>
													<cfset fileTooLarge = true />
													<cfset oversizedImages = listAppend(oversizedImages, fileCheck.ClientFileName & " (Too large)") />
													<cffile action="delete" file="#fileCheck.ServerDirectory#/#fileCheck.ServerFile#" />
												</cfif>
											</cfif>
										</cfloop>
											
										<cfif NOT fileTooLarge>
											<cftry>
												<!--- <cfdump var="#cffile.serverFile#" abort="true"> --->
												<cfquery name="insertListing" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
													INSERT INTO purchases_consignments 
													(
														fname,
														PHONE,
														phoneType,
														EMAIL,
														lname,
														TITLE,
														SIZE,
														ADDITIONAL_DETAILS
														
													)
													VALUES
													(
														<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.fname#">,
														<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.PHONE#">,
														<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.phoneType#">,
														<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.EMAIL_PURCHASE#">,
														<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.lname#">,
														<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.TITLE#">,
														<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.SIZE#">,
														<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.ADDITIONAL_DETAILS#">
														
													)
													SELECT @@identity as pk_purchases_consignments 
												</cfquery>
												
												<cfset thisId = insertListing.pk_purchases_consignments />
								
												<cfset additionalImages = "" />
												<!--- <cfset uploaddir = "#application.uploaddir#" /> --->
												<cfset addImageIdx = 1 />
						
						
												<!--- <cfif thisId NEQ 0> --->
						
													<cfquery name="getAdditional" datasource="#application.dsource#">
														SELECT IMAGE_NAME from purchases_consignments
														WHERE pk_purchases_consignments = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#thisId#">
													</cfquery>
													<cfif getAdditional.IMAGE_NAME NEQ "">
														<cfset addImageIdx = listFirst(listLast(listLast(getAdditional.IMAGE_NAME),'_'),'.') + 1 />
														<cfset additionalImages = getAdditional.IMAGE_NAME />
													</cfif>
												<!--- </cfif> --->
						
						
												<cfloop collection="#form#" item="idx">
													<cfif left(idx,9) EQ "addImage_">
														<cfset currImage = evaluate("form." & idx) />
														<cfset thisFilefield = idx />
														<cfset thisImageId = "#thisId#_#addImageIdx#.jpg" />
														<cfset additionalImages = listAppend(additionalImages,thisImageId) />
														<cffile action="upload" nameconflict="overwrite" filefield="#thisFilefield#" destination="#expandpath('.')#/purchases_consignments/images/#thisImageId#" result="fileupload">
														<cfset addImageIdx = addImageIdx + 1 />
													</cfif>
									
												</cfloop>
					
					
												<cfif additionalImages NEQ "">
													<cfquery name="editListing" datasource="#application.dsource#">
														UPDATE purchases_consignments SET
														IMAGE_NAME 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#additionalImages#">
														WHERE pk_purchases_consignments = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#thisId#">
													</cfquery>
												</cfif>

												<cfquery name="addLogs" datasource="#application.dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
														INSERT INTO logs 
														(
															moduleName,
															ipAddress,
															date,
															action
														)
														VALUES
														(
															'#moduleName#',
															'#ipAddress#',
															#date#,
															'#action#'
														)
												</cfquery>														
											
												<cfmail 
													server="#application.mailserver#"
													username="#application.mailserver_un#" 
													password="#application.mailserver_pw#"
													to="#emailsupport#" cc="#emailsupportcc#" 
													from="#form.email_purchase#"
													subject="GallArt.com <> Buying & Selling Fine Art <> Purchases/Consignments Form" 
													type="HTML"
													>
													<!--- <cfmail server="#application.mailserver#" username="#application.mailserver_un#" password="#application.mailserver_pw#" to="steverucker@gmail.com" from="#form.email_purchase#" subject="GallArt.com <> Buying & Selling Fine Art <> Purchases/Consignments Form" type="HTML"> --->
													<font style="font-size: 10pt; font-family: Arial;">
													<strong>#form.name#</strong> entered a new product on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
													Phone: #form.phone#<br>
													Email: #form.email_purchase#<br>
													Artist: #form.artist#<br>
													Title: #form.title#<br>
													<!--- Medium: #form.medium#<br> --->
													Size: #form.size#<br>
													Additional Details: #form.additional_details#<br>
													<!--- <cfmailparam 
														file="#expandpath('.')#/purchases_consignments/images/#Uploaded_File_Name#"
														contentid="purchase_consignment_image" 
														disposition="inline"
													/> --->
													<br><br>
												</cfmail>

												<cfset session.limitReached = true>
												<cflocation url="/sell-your-art/true/#getPreviousEntries.recordcount#" addtoken="No">

												<cfcatch type="Any">
													<cfoutput>
														<script language="JavaScript">
															alert('#JSStringFormat(cfcatch.detail)#');
															
														</script>
													</cfoutput>
												</cfcatch>
												
											</cftry>
			
										 <cfelse>
											<cfoutput>
												<!--- <p style="color:red;">Error: The following images exceed 2MB and were not uploaded: <strong>#oversizedImages#</strong></p> --->
		
												<script>
													var oversizedImages = "#JSStringFormat(oversizedImages)#";
													alert("The following images were not uploaded due to errors:\n" + oversizedImages + "\n\n(Only JPG files under 5MB are allowed)");
												</script>
		
											</cfoutput>
										</cfif>
			
									
								 <cfelse>
									<cfoutput>
										<p style="color: red;">Error: Please fill out all required fields before submitting the form.</p>
									</cfoutput>
								</cfif>


							 <cfelse>
								<cfoutput>
									<script>
										// toastr.error('You cannnot add record more than 2 times');
										alert('You cannnot add record more than 2 times')
									</script>
								</cfoutput>
							</cfif>						
																									
							<!--- <cfelse>
							<cflocation url="#script_name#?xss=#xss#&error=filetoolarge" addtoken="No">
						</cfif> --->
			
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
			<form method="post" action="/sell-your-art" name="errorFrm">
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
							<!--- <div class="sidebar web-sidebar-modal">	
								<cfinclude template="left_.cfm">
							</div> --->
							<div class="content-section">
								<div class="bottom-content-sec">
									<div class="banner-section">
										<div class="art-work-content">

											<div aria-label="breadcrumb">
												<ol class="breadcrumb">
												<li class="breadcrumb-item"><a href="/" style="color:black;" >Home</a></li>
												<li class="breadcrumb-item active" aria-current="page">Sell Your Art</li>
												</ol>
											</div>

											<div class="bottom-content">
												<cfif FORM.submitted>	

													<cfset apikey="6LddEiMrAAAAAJdkOFhc6RFcBOQ4Ol15oaRHRwJb">

													<cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="post">
														<cfhttpparam type="formField" name="secret" value="#apikey#">
														<cfhttpparam type="formField" name="response" value="#FORM['g-recaptcha-response']#">
														<cfhttpparam type="formField" name="remoteip" value="#CGI.REMOTE_ADDR#">
													</cfhttp>
														
													<cfset captchaResponse = DeserializeJSON(cfhttp.FileContent)>

													<!--- <cfdump var="#captchaResponse#" abort="true"> --->

													<cfif phoneError>
														<cfoutput>
															<!--- <cfdump var="testing 1" abort="true"> --->
															<script language="JavaScript">
																document.errorFrm.fname.value = '#form.fname#'
																document.errorFrm.lname.value = '#form.lname#'
																document.errorFrm.email.value = '#form.email#'
																document.errorFrm.cellphone.value = '#form.cellphone#'
																document.errorFrm.phone.value = '#form.phone#'
																document.errorFrm.S_phoneType.value = '#form.S_phoneType#'
																document.errorFrm.businessphone.value = '#form.businessphone#'
																document.errorFrm.otherphone.value = '#form.otherphone#'
																document.errorFrm.website.value = '#form.website#'
																document.errorFrm.errorMsg.value = '#errorMsg#'
																document.errorFrm.errorPhone.value = '1'
																document.errorFrm.submit();
															</script>
															</cfoutput>

													 <cfelseif captchaResponse.success NEQ 'YES'>
															<cfoutput>
																<!--- <cfdump var="testing 2" abort="true"> --->
																<script language="JavaScript">
																	document.errorFrm.fname.value = '#form.fname#'
																	document.errorFrm.lname.value = '#form.lname#'
																	document.errorFrm.email.value = '#form.email#'
																	document.errorFrm.cellphone.value = '#form.cellphone#'
																	document.errorFrm.phone.value = '#form.phone#'
																	document.errorFrm.S_phoneType.value = '#form.S_phoneType#'
																	document.errorFrm.businessphone.value = '#form.businessphone#'
																	document.errorFrm.otherphone.value = '#form.otherphone#'
																	document.errorFrm.website.value = '#form.website#'
																	document.errorFrm.errorMsg.value = '#errorMsg#'
																	document.errorFrm.captchaError.value = '1'
																	document.errorFrm.submit();
																</script>
															</cfoutput>
														
													 <cfelse>

														<cftry>

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

															<!--- <cfdump var="testing 3" abort="true"> --->

															<cfif len(trim(form.cellphone)) AND form.S_phoneType EQ "Home Phone">
																<cfset phone = form.cellphone>
															<cfelse>
																<cfset phone = "">
															</cfif>

															<cfif len(trim(form.cellphone)) AND form.S_phoneType EQ "Cell Phone">
																<cfset cellphone = form.cellphone>
															<cfelse>
																<cfset cellphone = "">
															</cfif>

															<cfif len(trim(form.cellphone)) AND form.S_phoneType EQ "Business Phone">
																<cfset businessphone = form.cellphone>
															<cfelse>
																<cfset businessphone = "">
															</cfif>

															<cfif len(trim(form.cellphone)) AND form.S_phoneType EQ "OutsideUS">
																<cfset otherphone = form.cellphone>
															<cfelse>
																<cfset otherphone = "">
															</cfif>

															<cfif form.fname neq '' and form.lname neq '' and form.email neq '' and form.password neq '' and form.cellphone neq '' >
																<cflock name="insertuser" timeout="10">
																	<!--- <cfdump var="test data" abort="true"> --->

																	<cfset encryptionKey = application.encryptionKey>

																	<cfif len(trim(form.password))>
																		<cfset encryptedPassword = encrypt(
																			form.password, encryptionKey, "AES", "Base64"
																		)>
																	 <cfelse>
																		<cfset encryptedPassword = "">
																	</cfif>

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
																			datestamp
																			
																		)
																		values
																		(
																			<cfqueryparam value="#form.fname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
																			<cfqueryparam value="#form.lname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
																			<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
																			<cfqueryparam value="#encryptedPassword#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
																			<cfqueryparam value="#cellphone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
																			<cfqueryparam value="#phone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
																			<cfqueryparam value="#businessphone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
																			<cfqueryparam value="#otherphone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
																			<cfqueryparam value="#now()#" cfsqltype="CF_SQL_TIMESTAMP" maxlength="100">
																			
																		)
																	</cfquery>																
																	
																	<!--- getting the last input UID --->
																	<cfquery name="lastUID" datasource="#dsource#" username="#uname#" password="#pword#">
																		SELECT @@identity as uid FROM users
																	</cfquery>
																	
																	<cfset session.sellerinfo.pk_users = lastUID.uid>
																	<cfset session.sellerinfo.fname = form.fname>
																	<cfset session.sellerinfo.lname = form.lname>
																	<cfset session.sellerinfo.email = form.email>
																	<cfset session.sellerinfo.login = 1 />

																	<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
																	<cfset date = now()>
																	<cfset moduleName = 'Become a Seller'>
																	<cfset action = 'Insert'>
																	
																	<cfquery name="addLog" datasource="#application.dsource#" >
																		INSERT INTO logs 
																			( moduleName, ipAddress, date, action, sellerUser)
																			VALUES
																			( '#moduleName#', '#ipAddress#', #date#, '#action#', #session.sellerinfo.pk_users#)
																	</cfquery>
																	
																</cflock>
																
																<cfmail 
																	server="#servername#" 
																	username="onli16@onlinegalleryart.com"
																	password="re3objec" 
																	to="#emailsupport#" 
																	cc="#emailsupportcc#" 
																	from="#form.email#" 
																	subject="GallArt.com <> Buying & Selling Fine Art <> New Member Registration <> Seller" 
																	type="HTML"
																	>
																	<font style="font-size: 10pt; font-family: Arial;">
																	<strong>#session.sellerinfo.fname# #session.sellerinfo.lname#</strong> registered as a new Member on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
																	<br><br>
																</cfmail>
															
																<cfmail 
																	server="#servername#" 
																	username="onli16@onlinegalleryart.com"
																	password="re3objec" 
																	to="#form.email#" 
																	from="onli16@onlinegalleryart.com"
																	subject="Gallery Art - Welcome New Member" 
																	type="HTML"
																	>
																	<font style="font-size: 10pt; font-family: Arial;">
																	Thank you, #session.sellerinfo.fname# #session.sellerinfo.lname#, for registering as a Member at www.gallart.com. <br><br>
																	Your password is:<br>
																	#form.password#<br><br>
																	Please keep it in a safe place.<br><br>
																	You are now ready to list your artwork!<br><br>
																	#getPages.page_content#
																	<br><br>
																</cfmail>

																<script>
																	$(document).ready(function() {
																		toastr.options = {
																			'closeButton': true,
																			'debug': false,
																			'newestOnTop': false,
																			'progressBar': true,
																			'positionClass': 'toast-top-right',
																			'preventDuplicates': false,
																			'showDuration': '1000',
																			'hideDuration': '1000',
																			'timeOut': '5000',
																			'extendedTimeOut': '1000',
																			'showEasing': 'swing',
																			'hideEasing': 'linear',
																			'showMethod': 'fadeIn',
																			'hideMethod': 'fadeOut',
																		}
																	});

																	toastr.success('Your Record is added successfully.');
																</script>

																	<cflocation url="overView" addtoken="No">
															 <cfelse>
																<cfoutput>
																	<p style="color: red;">Error: Your data is not added. Please fill out all required fields before submitting the form.</p>
																</cfoutput>
															</cfif>

															<cfcatch>
																<cfset hasError = true>
																<cfoutput>
																	 <script language="JavaScript">
																	 alert('Error occurred: #JSStringFormat(cfcatch.detail)#');
																		document.errorFrm.fname.value = '#form.fname#';
																		document.errorFrm.lname.value = '#form.lname#';
																		document.errorFrm.email.value = '#form.email#';
																		document.errorFrm.cellphone.value = '#form.cellphone#';
																		document.errorFrm.phone.value = '#form.phone#';
																		document.errorFrm.businessphone.value = '#form.businessphone#';
																		document.errorFrm.otherphone.value = '#form.otherphone#';
																		document.errorFrm.website.value = '#form.website#';
																		document.errorFrm.errorMsg.value = '#JSStringFormat(cfcatch.detail)#';																		
																		document.errorFrm.submit();
																	</script>
																</cfoutput>
																<!--- <cfabort> --->
															</cfcatch>

														</cftry>																													
															
													</cfif>	
												 <cfelse>
													<div class="main-content-description">
														<div class="row">
															<div class="col-md-12">
																<div>
																	<h2>Sell with Gallery Art</h2>
																	<h4>Direct Purchase:</h4>
																	<p>
																		Gallery Art is always looking to add artworks by auction tracked artists to our collection. We offer immediate payment when buying outright. Please note that all purchases are subject to first-hand inspection.
																	</p>
																	<p>Select "<b>Direct Purchase</b>" from the drop down box below and fill out the form. </p>
																	<h4>Become a Seller:</h4>
																	<p>
																		List up to 5 artworks on GallArt.com for FREE! Gallery Art will charge a 20% fee when you sell your art. Upon being notified of a sale, the seller is responsible for shipping or delivering the artwork to our gallery.
																	</p>
																	<p>
																		Select "<b>Become a Seller</b>" from the drop down box below and fill out the form.
																	</p>
																</div>
															</div>
														</div>
													</div>
													<div class="user-registrations new-user-form">
														<div class="row">
															<!---  <div class="col-md-6"> 
																<div class="main-banner-image">
																	<img src="http://23.20.226.157/img/12478.jpg" alt="image" style="width: 100%;" />
																</div>
															</div> --->
															<div class="col-md-12">
																<div class="form-sectiom">
																	<div class="main-heading">
																		<h3>Type of Sale</h3>
																	</div>
																	<div class="general-saller-tabs">
																		
																		<div class="tabs-dropdown">
																			<select class="form-select" id="tabSelector" onchange="setActiveTab(this.value)">
																				<option value="general" selected>Direct Sale</option>
																				<option value="seller">Become a Seller</option>
																			</select>
																		</div>
																		<div>
																			<div id="content-general" class="tab-content" style="display: block;">
																				<div class="general-salaer-form">
																					<div class="user-content"> 
																						<cfif structKeyExists(url,'processed')>
																							<span style="color: #ff0000; font-size: 13px;">
																								<cfif FORM.captchaError2>
																									<!---<span style="color: ##ff0000; font-weight: bold;">
																										PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM
																									</span>--->
																									<br><br>
																								<cfelse>
																									<!--- <cfset remainingEntries = 5 - (entryCount + 1)> --->

																									
																									
																									<br />
																									<!--- <cfif remainingEntries LT 5 AND remainingEntries GT 0> --->

																										<!--- <script>
																											toastr.success('Sent');
																										</script> --->

																										<!--- YOU MAY ENTER <cfoutput>#remainingEntries#</cfoutput> MORE ITEMS
																									<cfelse>
																										YOU HAVE REACHED THE MAXIMUM NUMBER OF ENTRIES <br />
																										FOR THIS FORM
																									</cfif> --->
																								</cfif>
																							</span>
																							<br /><br />
																						</cfif>
																						<cfoutput>
																							<cfform name="frm1" action="/sell-your-art" method="post" enctype="multipart/form-data" id="generalForm" onsubmit="return validateGeneralForm(event)">
																								<input	type="hidden" name="captcha_check2"	value="#FORM.captcha_check2#" />
																								<div class="input-form">
																									<div class="row">
																										<!--- <div class="col-md-12">
																											<div class="input-field">
																												<label><b>Your Name:<span style="color: ##ff0000;">*</span></b></label> 
																											</div>
																										</div> --->
																										<div class="col-md-4">
																											<div class="input-field"> 
																												<label><b> First Name<span style="color: ##ff0000;">*</span></b></label>
																												<cfinput type="text" name="fname" id="fname" value="#form.fname#" size="30" maxlength="30" >
																												<span class="error-message" id="G_fnameError"></span>
																											</div>
																										</div>
																										<div class="col-md-4">
																											<div class="input-field"> 
																												<label><b>Last Name<span style="color: ##ff0000;">*</span></b></label>
																												<cfinput type="text" name="lname" id="lname" value="#form.lname#" size="30" maxlength="30" >
																												<span class="error-message" id="G_lnameError"></span>
																											</div>
																										</div>
																										<div class="col-md-4">
																											<div class="input-field">
																												<label><b>Email<span style="color: ##ff0000;">*</span></b></label>
																												<cfinput type="text" name="email_purchase" id="email_purchase" value="#form.email_purchase#" size="30" maxlength="20"  validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$"  >
																												<span class="error-message" id="G_email_purchaseError"></span>
																											</div>
																										</div>

																										<div class="col-md-4 pt-4">
																											<div class="input-field">
																												<label><b>Phone Type <span style="color: ##ff0000;">*</span></b></label>
																												<select name="phoneType" id="phoneType" >
																													<option value="Cell Phone">Cell Phone</option>
																													<option value="Home Phone">Home Phone</option>
																													<option value="Business Phone">Business Phone</option>
																													<option value="OutsideUS">Outside US Phone</option>
																												</select>
																												<span class="error-message" id="G_phoneTypeError"></span>
																											</div>
																										</div>

																										<div class="col-md-4 pt-4">
																											<div class="input-field">
																												<label><b>Phone Number <span style="color: ##ff0000;">*</span></b></label>
																												<cfinput type="text" name="phone" id="phone" value="#form.phone#" size="30" maxlength="20" >
																												<!--- <span id="formatSign">(xxx) xxx-xxxx</span> --->
																												<span class="error-message" id="G_phoneError"></span>
																											</div>
																										</div>
																										<div class="col-md-4 pt-4">
																											<div class="input-field pb-3">
																												<label><b>Price Desired<span style="color: ##ff0000;">*</span></b></label>
																												<cfinput type="text" name="size" value="#form.size#" maxlength="6" size="30" id="size" placeholder="e.g $2000">
																												<span class="error-message" id="G_sizeError"></span>
																											</div>
																										</div>
																										<div class="col-md-12">
																											<div class="input-field">
																												<label><b>Tell us About the Artwork<span style="color: ##ff0000;">*</span></b></label>
																												<textarea name="additional_details" id="additional_details" maxlength="500" cols="50" rows="4" placeholder="Artist Name, Artwork Title, Medium, Edition, Year, Size, Artwork Location ">#form.additional_details#</textarea>
																												<span class="error-message" id="G_additional_details"></span>
																												<div id="charCount" class="mb-3">0 / 500 characters</div>
																											</div>
																										</div>
																										
																										<div class="col-md-12">
																											<div class="input-field image-upload pb-2"> 
																												<h3>
																													UPLOAD IMAGES
																												</h3>
																												<ul>
																													<li>- Please attach an image of the entire artwork/(s) </li>
																													<li>- Up close images of the artist signature, edition, watermark or stamp (if applicable). </li>
																													<li>- Image of the artwork verso if there is anything there by the artist, studio or publisher. </li>
																													<li>- Image of the frame verso if there is a provenance label. </li>
																													<li>- Images of any certificates, documentation or provenance. </li> 
																													<li>- Image size maximum <b>5MB</b>. </li> 
																												</ul>
																											</div>

																											<!--- <div class="file-upload-wrapper">
																												<label for="file-upload" class="file-upload-label">
																												<div class="file-upload-icon">
																													<!-- Example SVG icon -->
																													<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
																													<path d="M12 2C11.45 2 11 2.45 11 3V13H8L12 17L16 13H13V3C13 2.45 12.55 2 12 2ZM5 19H19C19.55 19 20 18.55 20 18V16C20 15.45 19.55 15 19 15H5C4.45 15 4 15.45 4 16V18C4 18.55 4.45 19 5 19Z" />
																													</svg>
																												</div>
																												<div class="file-upload-text">
																													<strong>Browse Files</strong>
																													<p>Drag and drop files here</p>
																												</div>
																												</label>
																												<input type="file"  name="thisImage" id="file-upload" class="file-upload-input" >
																											</div> --->

																												<div class="col-md-12">
																													<div class="input-field sm-input-field pb-3">
																														<input type="button" value="Add Additional Image" id="addImageButton" class="img-btn" />

																													</div>
																													<div id="addImageContainer" class="flex-img-container"></div>
																												</div>

																											<!--- <div class="input-field">
																												<cfimage action="captcha" height="75" width="363" text="#strCaptcha2#" difficulty="low" fonts="verdana,arial,times new roman,courier" fontsize="28"	/>
																												<br><br>
																												<FONT face="verdana,arial,helvetica" color="000000" size="-2"><b>Please enter the characters in the image above:</b></FONT><br><br>
																												<cfinput type="text" name="captcha2" id="captcha2">
																												<span class="error-message" id="G_captcha2Error"></span>
																											</div> --->

																											<div class="input-field pt-3">
																												<div class="g-recaptcha" id="gRecaptchaGeneral" data-sitekey="6LddEiMrAAAAAOnJRd03TsT_vYkEbebkW0T3u_ne"></div>
																												<span class="error-message" id="G_recaptchaError"></span>
																											</div>

																										</div>
																									</div>
																									<div class="input-button">
																										<input type="Hidden" name="process_purchase_consignment">
																										<button type="submit" class="SeeMore"  id="G_submitbtn">Send</button> 
																									</div>
																									<!-- <div class="any-question">
																										<p><b>*If you any questions please email <a href="mailto: sales@gallart.com">sales@gallart.com</a> or call 305-932-6166 for further assistance. </b></p>
																									</div> -->
																								</div>
																							</cfform>						
																						</cfoutput>
																					</cfif>

																					</div>
																				</div>
																			</div>
																			<div id="content-seller" class="tab-content" style="display: none;"> 
																				<div class="general-salaer-form">
																					<cfoutput>
																						<div class="user-content" id="sellerFormStart"> 
																							<h3>Create an Account</h3>
																							<h4> Already have an account? <a href="login" style="color: ##EC008C"> <b>Log in </b></a> </h4>

																							<br><br>

																							<cfif FORM.captchaError>
																								<!---	<span style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</span><br><br>--->
																							</cfif>
																							<cfif FORM.errorPhone EQ 1>
																								<span style="color: ##ff0000; font-weight: bold;">
																									#form.errorMsg#
																								</span><br><br>
																							</cfif>
																							<!--- onsubmit="return validateSellerForm()" --->
																							<CFFORM ACTION="#script_name#" METHOD="POST"  id="submitSellerForm">
																								<input type="hidden" name="submitted" value="1" />
																								<input	type="hidden" name="captcha_check"	value="#FORM.captcha_check#" />
																								<div class="input-form">
																									<div class="row">
																										<div class="col-md-6">
																											<div class="input-field">
																												<label><b>First Name:<span style="color: ##ff0000;">*</span></b></label>
																												<cfinput type="text" name="fname" id="S_fname" value="#form.fname#" size="30" maxlength="30" >
																												<span class="error-message" id="S_fnameError"></span>
																											</div>
																										</div>
																										<div class="col-md-6">
																											<div class="input-field">
																												<label><b>Last Name:<span style="color: ##ff0000;">*</span></b></label>
																												<cfinput type="text" name="lname" id="S_lname" value="#form.lname#" size="30" maxlength="30">
																												<span class="error-message" id="S_lnameError"></span>
																											</div>
																										</div>
																										<div class="col-md-4">
																											<div class="input-field">
																												<label><b>Email:<span style="color: ##ff0000;">*</span></b></label>
																												<cfinput type="text" name="Email" id="S_Email" value="#form.Email#" size="30" maxlength="30" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$">
																												<span class="error-message" id="S_EmailError"></span>
																											</div>
																										</div>

																										<div class="col-md-4">
																											<div class="input-field">
																												<label><b>Phone Type <span style="color: ##ff0000;">*</span></b></label>
																												<select name="S_phoneType" id="S_phoneType" >
																													<option value="Cell Phone">Cell Phone</option>
																													<option value="Home Phone">Home Phone</option>
																													<option value="Business Phone">Business Phone</option>
																													<option value="OutsideUS">Outside US Phone</option>
																												</select>
																												<span class="error-message" id="S_phoneTypeError"></span>
																											</div>
																										</div>

																										<div class="col-md-4">
																											<div class="input-field">
																												<label><b>Phone Number:<span style="color: ##ff0000;">*</span></b></label>
																												<cfinput type="text" name="cellphone" id="S_cellphone" value="#form.cellphone#" maxlength="20"  size="30">
																												<!--- <span id="S_formatSign">(xxx) xxx-xxxx</span> --->
																												<span class="error-message" id="S_cellphoneError"></span>
																											</div>
																										</div>
																									
																										<div class="col-md-6">
																											<div class="input-field">
																												<label><b>Create a Password:<span style="color: ##ff0000;">*</span></b></label>
																												<cfinput type="password" name="password" id="S_password" size="30" maxlength="15" >
																												<span class="error-message" id="S_passwordError"></span>
																											</div>
																										</div>
																										<div class="col-md-6">
																											<div class="input-field">
																												<label><b>Re-enter Password:<span style="color: ##ff0000;">*</span></b></label>
																												<cfinput type="password" name="password2" id="S_password2" size="30" maxlength="15" >
																												<span class="error-message" id="S_password2Error"></span>
																											</div>
																										</div>
																									</div>

																									<!--- <div class="input-field">
																										<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low" fonts="verdana,arial,times new roman,courier" fontsize="28"	/>
																										<br><br>
																										<FONT face="verdana,arial,helvetica" color="000000"><b>Please enter the characters in the image above:</b></FONT><br><br>
																										<cfinput type="text" name="captcha" id="S_captcha">
																										<span class="error-message" id="S_captchaError"></span>
																									</div> --->

																									<div class="input-field pt-3">
																										<div class="g-recaptcha" id="gRecaptchaSeller" data-sitekey="6LddEiMrAAAAAOnJRd03TsT_vYkEbebkW0T3u_ne"></div>
																										<span class="error-message" id="S_recaptchaError"></span>
																									</div>

																									<div class="input-button mt-3">
																										
																										<cfif NOT structKeyExists(session, 'sellerinfo') >
																											<input type="Hidden" name="proc_reg">																								
																											<button type="button" class="SeeMore" id="S_submitbtn" onclick="validateSellerForm()">Create an account</button>
																										<cfelse>
																											<p>
																												You are already logged in. If you want to add listings, please <b><a href="user_listing_detail">click here</a></b>.
																											</p>
																										</cfif>
																										
																										<br>
																										
																									</div>
																									<!--- <p style="text-align: center;">
																										If you have already signed up as a seller, please <a href="user_login_page.cfm?xss=#xss#"> <b>Sign In </b></a>
																									</p> --->
																								</div>
																							</cfform>
																						</div>
																					</cfoutput>
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


		
		<!--- <script src="https://www.google.com/recaptcha/api.js" async defer></script> --->

		<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>


		<script>

			<cfif structKeyExists(session, "limitReached") and session.limitReached>
				alert('Record is Added');
				<cfset structDelete(session, "limitReached")>
			</cfif>

			

				var addImageIndex = 1;

				function buildAdditionalImageField(index) {
					return $(
						"<div class='additionalImage' style='position: relative; margin-bottom:10px;'>" +
							"<div class='file-upload-wrapper sm-file-upload-wrapper'>" +
								"<label for='addImage_" + index + "' class='file-upload-label'>" +
									"<div class='file-upload-icon'><svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'>" +
									"<path d='M12 2C11.45 2 11 2.45 11 3V13H8L12 17L16 13H13V3C13 2.45 12.55 2 12 2ZM5 19H19C19.55 19 20 18.55 20 18V16C20 15.45 19.55 15 19 15H5C4.45 15 4 15.45 4 16V18C4 18.55 4.45 19 5 19Z' />" +
									"</svg></div>" +
									"<div class='file-upload-text'><strong>Browse Files</strong></div>" +
								"</label>" +
								"<input type='file' accept='image/jpeg,image/png' name='addImage_" + index + "' id='addImage_" + index + "' />" +
							"</div>" +
							"<span class='removeImage' style='position:absolute; top:0; right:0; cursor:pointer; color:red; font-weight:bold; font-size:18px;'>&times;</span>" +
						"</div>"
					);
				}

				function updateMaxImageMessage() {
					if ($(".additionalImage").length < 4) {
						$("#maxImageMessage").remove();
					} else if ($("#maxImageMessage").length === 0) {
						$("#addImageContainer").after("<p id='maxImageMessage' style='color: red;'>You can upload a maximum of 4 images.</p>");
					}
				}

				$("#addImageButton").click(function () {
					if ($(".additionalImage").length < 4) {
						$("#addImageContainer").append(buildAdditionalImageField(addImageIndex));
						addImageIndex++;
						updateMaxImageMessage();
					} else {
						updateMaxImageMessage();
					}
				});

				$(document).on("click", ".removeImage", function () {
					var $imageBlock = $(this).closest(".additionalImage");
					var $fileInput = $imageBlock.find("input[type='file']");

					if ($fileInput.length) {
						$fileInput.val("");
					}

					$imageBlock.remove();
					updateMaxImageMessage();
				});


				function setActiveTab(tabName) {
					console.log(`Active tab: ${tabName}`);

					// Store active tab in localStorage
					localStorage.setItem("activeTab", tabName);

					// Show/hide the correct tab content
					setTabVisibility(tabName);
				}

				function setTabVisibility(tabName) {
					const generalForm = document.getElementById("content-general");
					const sellerForm = document.getElementById("content-seller");

					if (tabName === "general") {
						generalForm.style.display = "block";
						sellerForm.style.display = "none";
					} else if (tabName === "seller") {
						generalForm.style.display = "none";
						sellerForm.style.display = "block";
					}
				}

				// Load the saved tab from localStorage on page load
				document.addEventListener("DOMContentLoaded", function () {
					const savedTab = localStorage.getItem("activeTab") || "general";
					document.getElementById("tabSelector").value = savedTab;
					setTabVisibility(savedTab);
				});

				var generalWidgetId, sellerWidgetId;

				var onloadCallback = function() {
					generalWidgetId = grecaptcha.render('gRecaptchaGeneral', {
						'sitekey': '6LddEiMrAAAAAOnJRd03TsT_vYkEbebkW0T3u_ne'
					});

					sellerWidgetId = grecaptcha.render('gRecaptchaSeller', {
						'sitekey': '6LddEiMrAAAAAOnJRd03TsT_vYkEbebkW0T3u_ne'
					});

					// console.log(sellerWidgetId);
				};

				function validateGeneralForm(e){
					let isValid = true;
					let firstInvalidField = null;

					function setFirstInvalidField(field) {
						if (!firstInvalidField && field) {
							firstInvalidField = field;
						}
					}

					document.querySelectorAll("#addImageContainer input[type='file']").forEach(function (input) {
						if (input.files.length === 0) {
							input.value = "";
						}
					});

					document.querySelectorAll('.error-message').forEach(error => error.textContent = '');

					const fname = document.getElementById('fname').value.trim();
					const lname = document.getElementById('lname').value.trim();
					const email_purchase = document.getElementById('email_purchase').value.trim();
					const phone = document.getElementById('phone').value.trim();
					const phoneType = document.querySelector("[name='phoneType']").value;
					// const title = document.getElementById('title').value.trim();
					const size = document.getElementById('size').value.trim();
					// const additional_details = document.getElementById('additional_details').value.trim();
					// const captcha2 = document.getElementById('captcha2').value.trim();

					const phoneRegex = /^\(\d{3}\) \d{3}-\d{4}$/;
					const integerRegex = /^[0-9]+$/;
					
					// var recaptcha = grecaptcha.getResponse();

					let recaptcha = grecaptcha.getResponse(generalWidgetId);

					const submitButton = document.getElementById('G_submitbtn');

					console.log(phoneType);

					if (!fname) {
						document.getElementById('G_fnameError').textContent = 'Please fill in your first name.';
						setFirstInvalidField(document.getElementById('fname'));
						isValid = false;
					}

					// Validate LAST NAME
					if (!lname) {
						document.getElementById('G_lnameError').textContent = 'Please fill in your last name.';
						setFirstInvalidField(document.getElementById('lname'));
						isValid = false;
					}

					// Validate EMAIL
					if (!email_purchase) {
						document.getElementById('G_email_purchaseError').textContent = 'Please fill in your email address.';
						setFirstInvalidField(document.getElementById('email_purchase'));
						isValid = false;
					} else if (!/\S+@\S+\.\S+/.test(email_purchase)) {
						document.getElementById('G_email_purchaseError').textContent = 'Please enter a valid email address.';
						setFirstInvalidField(document.getElementById('email_purchase'));
						isValid = false;
					}

					// Validate CAPTCHA
					// if (!phone) {
					// 	document.getElementById('G_phoneError').textContent = 'Please enter a phone number.';
					// 	isValid = false;
					// }else if (phone.length < 5) {
					// 	document.getElementById('G_phoneError').textContent = 'Please enter a complete phone number digits.';
					// 	isValid = false;
					// }

					if (!phone) {
						document.getElementById('G_phoneError').textContent = 'Please enter a phone number.';
						setFirstInvalidField(document.getElementById('phone'));
						isValid = false;
					}

					if (!phoneType) {
						document.getElementById('G_phoneTypeError').textContent = 'Please select phone type';
						setFirstInvalidField(document.getElementById('phoneType'));
						isValid = false;
					}

					if(phoneType){
					if(phoneType === "Home Phone" || phoneType === "Cell Phone" || phoneType === "Business Phone"){
						if (phone && !phoneRegex.test(phone)) {
							document.getElementById('G_phoneError').textContent = 'Please enter phone number in format: (xxx) xxx-xxxx ';
							setFirstInvalidField(document.getElementById('phone'));
							isValid = false;
						}
					} else if (phoneType === "OutsideUS") {
						if (phone && !/^\+?\d+$/.test(phone)) {
							document.getElementById('G_phoneError').textContent = 'Please enter numbers only for Outside US phone.';
							setFirstInvalidField(document.getElementById('phone'));
							isValid = false;
						}
					}
					}

					// if (phone && !phoneRegex.test(phone)) {
					// 	document.getElementById('G_phoneError').textContent = 'Please enter a valid phone number in the format (xxx) xxx-xxxx.';
					// 	isValid = false;
					// }

					// if (!title) {
					// 	document.getElementById('G_titleError').textContent = 'Please enter the title.';
					// 	isValid = false;
					// }

					if (!size) {
						document.getElementById('G_sizeError').textContent = 'Please enter the Price.';
						setFirstInvalidField(document.getElementById('size'));
						isValid = false;
					} else if (!integerRegex.test(size)) {
						document.getElementById('G_sizeError').textContent = 'Please enter a dollar amount number (no decimals or special characters).';
						setFirstInvalidField(document.getElementById('size'));
						isValid = false;
					} else if (parseInt(size, 10) === 0) {
						document.getElementById('G_sizeError').textContent = 'Please enter an offer price greater than 0.';
						setFirstInvalidField(document.getElementById('size'));
						isValid = false;
					}

					if (recaptcha.length == 0) {
						document.getElementById("G_recaptchaError").innerText = "Please confirm you are not a robot.";
						setFirstInvalidField(document.querySelector("#gRecaptchaGeneral iframe") || document.getElementById("gRecaptchaGeneral"));
						isValid = false;
					}

					// if (!additional_details) {
					// 	document.getElementById('G_additional_details').textContent = 'Please enter the description.';
					// 	isValid = false;
					// }

					// if (!captcha2) {
					// 	document.getElementById('G_captcha2Error').textContent = 'Please enter the characters in the image.';
					// 	isValid = false;
					// }

					// if (isValid) {
					// 	// Submit the form
					// 	document.getElementById('generalForm').submit();
					// }

					if (!isValid) {		
						if (firstInvalidField) {
							firstInvalidField.scrollIntoView({ behavior: 'smooth', block: 'center' });
							if (typeof firstInvalidField.focus === "function") {
								firstInvalidField.focus({ preventScroll: true });
							}
						}
						return false;
					} else {
						
						submitButton.disabled = true;
						submitButton.innerText = "Sending...";

						// prevent default submit first
						e.preventDefault();

						// Now submit form manually after disabling button
						setTimeout(() => {
							document.forms['frm1'].submit();
						}, 10);

						return false; // stop default submit
					}


					return isValid;
				}


				

				function validateSellerForm(){
				// alert('test');
					document.querySelectorAll('.error-message').forEach(error => error.textContent = '');

					let isValid = true;
					let firstInvalidField = null;

					function setFirstInvalidField(field) {
						if (!firstInvalidField && field) {
							firstInvalidField = field;
						}
					}

					const S_fname = document.getElementById('S_fname').value.trim();
					const S_lname = document.getElementById('S_lname').value.trim();
					const S_email = document.getElementById('S_Email').value.trim();
					const S_phone = document.getElementById('S_cellphone').value.trim();
					const S_phoneType = document.querySelector("[name='S_phoneType']").value;
					const S_password = document.getElementById('S_password').value.trim();
					const S_password2 = document.getElementById('S_password2').value.trim();
					// const S_captcha = document.getElementById('S_captcha').value.trim();

					const phoneRegex = /^\(\d{3}\) \d{3}-\d{4}$/;

					// var recaptcha = grecaptcha.getResponse();

					let recaptcha = grecaptcha.getResponse(sellerWidgetId);

					const S_submitBtn = document.getElementById('S_submitbtn');
					const sellerFormStart = document.getElementById('sellerFormStart');

					S_submitBtn.disabled = true;
					S_submitBtn.textContent = "Processing..."; 

					console.log('test type: ' + S_phoneType);
					
					if (recaptcha.length == 0) {
						document.getElementById("S_recaptchaError").innerText = "Please confirm you are not a robot.";
						setFirstInvalidField(document.querySelector("#gRecaptchaSeller iframe") || document.getElementById("gRecaptchaSeller"));
						isValid = false;
					}

					if (!S_fname) {
						document.getElementById('S_fnameError').textContent = 'Please fill in your first name.';
						setFirstInvalidField(document.getElementById('S_fname'));
						isValid = false;
					}

					// Validate LAST NAME
					if (!S_lname) {
						document.getElementById('S_lnameError').textContent = 'Please fill in your last name.';
						setFirstInvalidField(document.getElementById('S_lname'));
						isValid = false;
					}

					// Validate EMAIL
					if (!S_email) {
						document.getElementById('S_EmailError').textContent = 'Please fill in your email address.';
						setFirstInvalidField(document.getElementById('S_Email'));
						isValid = false;
					} else if (!/\S+@\S+\.\S+/.test(S_email)) {
						document.getElementById('S_EmailError').textContent = 'Please enter a valid email address.';
						setFirstInvalidField(document.getElementById('S_Email'));
						isValid = false;
					}

					// Validate CAPTCHA
					if (!S_phone) {
						document.getElementById('S_cellphoneError').textContent = 'Please enter a phone number.';
						setFirstInvalidField(document.getElementById('S_cellphone'));
						isValid = false;
					} 

					if (!S_phoneType) {
						document.getElementById('S_phoneTypeError').textContent = 'Please select phone type';
						setFirstInvalidField(document.getElementById('S_phoneType'));
						isValid = false;
					}

					if(S_phoneType){
						if(S_phoneType === "Home Phone" || S_phoneType === "Cell Phone" || S_phoneType === "Business Phone"){
							if (S_phone && !phoneRegex.test(S_phone)) {
								document.getElementById('S_cellphoneError').textContent = 'Please enter phone number in format: (xxx) xxx-xxxx ';
								setFirstInvalidField(document.getElementById('S_cellphone'));
								isValid = false;
							}
						} else if (S_phoneType === "OutsideUS") {
							if (S_phone && !/^\+?\d+$/.test(S_phone)) {
								document.getElementById('S_cellphoneError').textContent = 'Please enter numbers only for Outside US phone.';
								setFirstInvalidField(document.getElementById('S_cellphone'));
								isValid = false;
							}
						}
					}

					// else if (!phoneRegex.test(S_phone)) {
					// 	document.getElementById('S_cellphoneError').textContent = 'Please enter your phone number in the format (xxx) xxx-xxxx';
					// 	isValid false; // Prevent form submission
					// }

					// if (S_phone && !phoneRegex.test(S_phone)) {
					// 	document.getElementById('S_cellphoneError').textContent = 'Please enter a valid phone number in the format (xxx) xxx-xxxx.';
					// 	isValid = false;
					// }

					if (!S_password) {
						document.getElementById('S_passwordError').textContent = 'Please enter your password.';
						setFirstInvalidField(document.getElementById('S_password'));
						isValid = false;
					} else{
						const strongPasswordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$/;

						if (!strongPasswordPattern.test(S_password)) {
							document.getElementById('S_passwordError').textContent =
								'Password must be at least 8 characters long, contain uppercase, lowercase, a number, and a special character.';
							setFirstInvalidField(document.getElementById('S_password'));
							isValid = false;
						}
					}

					if (!S_password2) {
						document.getElementById('S_password2Error').textContent = 'Please re-enter your password.';
						setFirstInvalidField(document.getElementById('S_password2'));
						isValid = false;
					}

					if (S_password && S_password2 && S_password !== S_password2) {
						document.getElementById('S_password2Error').textContent = 'Passwords do not match.';
						setFirstInvalidField(document.getElementById('S_password2'));
						isValid = false;
					}

					// if (!S_captcha) {
					// 	document.getElementById('S_captchaError').textContent = 'Please enter the characters in the image.';
					// 	isValid = false;
					// }

					if (isValid) {
						// Submit the form
						document.getElementById('submitSellerForm').submit();
					} else {
						if (firstInvalidField) {
							if (sellerFormStart) {
								const sellerFormTop = sellerFormStart.getBoundingClientRect().top + window.pageYOffset - 20;
								window.scrollTo({ top: sellerFormTop, behavior: 'smooth' });
							}
							if (typeof firstInvalidField.focus === "function") {
								setTimeout(function () {
									firstInvalidField.focus({ preventScroll: true });
								}, 250);
							}
						}
						// Re-enable button if validation fails
						S_submitBtn.disabled = false;
						S_submitBtn.textContent = "Create an account";
					}

					return isValid;
				}

		</script>


		<script>
			document.addEventListener("DOMContentLoaded", function() {
				const textarea = document.getElementById("additional_details");
				const counter = document.getElementById("charCount");
				const maxLength = 500;

				if (textarea && counter) {
				function updateCount() {
						const currentLength = textarea.value.length;
						counter.textContent = `${currentLength} / ${maxLength} characters`;
				}

				// Update counter initially
				updateCount();

				// Update on input
				textarea.addEventListener("input", updateCount);
			}
			});
		</script>


		<script>

			document.addEventListener("DOMContentLoaded", function() {
				const phoneInput = document.getElementById("phone");
				const phoneType = document.getElementById("phoneType");
				// const formatSign = document.getElementById("formatSign");

				// function toggleFormatSign() {
				// 	if (phoneType.value === "OutsideUS") {
				// 		formatSign.style.display = "none";
				// 	} else {
				// 		formatSign.style.display = "inline";
				// 	}
				// }

				// run on load (in case form already has value)
				// toggleFormatSign();

				// run on change
				// phoneType.addEventListener("change", toggleFormatSign);

				phoneType.addEventListener("change", function() {
					if (this.value === "OutsideUS") {
						phoneInput.value = "+1"; 
					} else {
						
						if (phoneInput.value.startsWith("+1")) {
							phoneInput.value = "";
						}
					}
				});


				phoneInput.addEventListener("input", function(e) {
					// If type is OutsideUS → skip formatting
					if (phoneType.value === "OutsideUS") {
						let sanitized = e.target.value.replace(/[^\d+]/g, "");
						let hasLeadingPlus = sanitized.charAt(0) === "+";
						sanitized = sanitized.replace(/\+/g, "");
						e.target.value = hasLeadingPlus ? ("+" + sanitized) : sanitized;
						return;
					}

					let value = e.target.value.replace(/\D/g, ""); // only digits
					if (value.length > 10) value = value.substring(0, 10);

					// Apply formatting as user types
					if (value.length > 6) {
						e.target.value = `(${value.substring(0,3)}) ${value.substring(3,6)}-${value.substring(6)}`;
					} else if (value.length > 3) {
						e.target.value = `(${value.substring(0,3)}) ${value.substring(3)}`;
					} else if (value.length > 0) {
						e.target.value = `(${value}`;
					} else {
						e.target.value = "";
					}
				});
			});

			document.addEventListener("DOMContentLoaded", function() {
				const phoneInput = document.getElementById("S_cellphone");
				const phoneType = document.getElementById("S_phoneType");
				// const formatSign = document.getElementById("S_formatSign");

				// function toggleFormatSign() {
				// 	if (phoneType.value === "OutsideUS") {
				// 		formatSign.style.display = "none";
				// 	} else {
				// 		formatSign.style.display = "inline";
				// 	}
				// }

				// run on load (in case form already has value)
				// toggleFormatSign();

				// run on change
				// phoneType.addEventListener("change", toggleFormatSign);

				phoneType.addEventListener("change", function() {
					if (this.value === "OutsideUS") {
						phoneInput.value = "+1"; 
					} else {
						
						if (phoneInput.value.startsWith("+1")) {
							phoneInput.value = "";
						}
					}
				});


				phoneInput.addEventListener("input", function(e) {
					// If type is OutsideUS → skip formatting
					if (phoneType.value === "OutsideUS") {
						let sanitized = e.target.value.replace(/[^\d+]/g, "");
						sanitized = sanitized.replace(/(?!^)\+/g, "");
						e.target.value = sanitized;
						return;
					}

					let value = e.target.value.replace(/\D/g, ""); // only digits
					if (value.length > 10) value = value.substring(0, 10);

					// Apply formatting as user types
					if (value.length > 6) {
						e.target.value = `(${value.substring(0,3)}) ${value.substring(3,6)}-${value.substring(6)}`;
					} else if (value.length > 3) {
						e.target.value = `(${value.substring(0,3)}) ${value.substring(3)}`;
					} else if (value.length > 0) {
						e.target.value = `(${value}`;
					} else {
						e.target.value = "";
					}
				});
			});

		</script>

		<style>
			.error-message {
				color: #ff0000;
				font-size: 0.9em;
				margin-top: 5px;
				display: block;
			}
			.input-field {
			margin-bottom: 15px;
			}

			.sm-input-field {
				text-align: center;
				margin-bottom: 15px;
				border-bottom: 1px solid gray;
			}
			.sm-input-field .img-btn {
				max-width: 250px;
			}
			.flex-img-container {
				width: 100%;
				display: flex;
				flex-wrap: wrap;
				gap: 4px;
			}
			.flex-img-container .additionalImage {
				width: 32%;
				float: none;
				margin: 0 2px;
			}
			.flex-img-container .additionalImage .sm-file-upload-wrapper {
				width: 100%;
				margin: 10px 0;
			}
			.flex-img-container .additionalImage .sm-file-upload-wrapper input {
				width: 100%;
				margin-top: 10px;
			}

			@media (max-width: 767.5px) {
				.flex-img-container .additionalImage {
					width: 48%;
				}
			}
			@media (max-width: 450px) {
				.flex-img-container .additionalImage {
					width: 100%;
				}
			}
		</style>


		<cfinclude template="frmxss.cfm">

	</body>
</html>
