<!--- Kill extra output. --->
<cfsilent>
	<cfparam name="form.fname" default="">
	<cfparam name="form.lname" default="">
	<cfparam name="form.name" default="">
	<cfparam name="form.email" default="">
	<cfparam name="form.phone" default="">
	<cfparam name="form.otherphone" default="">
	<cfparam name="form.best_time" default="">
	<cfparam name="form.email_only" default="">
	<cfparam name="form.comments" default="">
	<cfparam name="form.Offer" default="">
	<cfparam name="form.captchaError" default="0">
	<cfparam name="form.errorMsg" default="">
	<cfparam name="form.errorPhone" default="0">
	<cfparam name="form.errorGeneral" default="0">
	<cfparam name="success" default="false">
	<cfparam name="url.pid" default="0">
	<cfparam name="form.pid" default="#url.pid#">
	<cfparam name="FORM.captcha" type="string" default="" />
	<cfparam name="FORM.captcha_check" type="string" default="" />
	<cftry>
	   <cfparam name="FORM.submitted" type="numeric" default="0" />
	   <cfcatch>
		  <cfset FORM.submitted=0 />
	   </cfcatch>
	</cftry>
	<!--- Set a flag to see if this user is a bot or not. --->
	<cfset blnIsBot=true />
	<cfset phoneError=false />
	<!--- Check to see if the form has been submitted. --->
	<cfif FORM.submitted>
	   <cfset errorMsg="" />
	   <!--- <cfif len(form.phone) AND NOT isValid("regex",form.phone,"^([\(]{1}[0-9]{3}[\)]{1}[
	   		]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
	   		<cfset errorMsg=errorMsg & "Please enter your home phone number in the format (xxx) xxx-xxxx <br/>" />
		</cfif> --->
		<cfif errorMsg NEQ "">
			<cfset phoneError=true />
		<cfelse>
			<cftry>
				<!--- Decrypt the check value. --->
				<cfset strCaptcha=Decrypt( FORM.captcha_check, "gallart-is-the-best" , "CFMX_COMPAT" , "HEX" ) />
				<cfif (strCaptcha EQ FORM.captcha)>
					<cfset blnIsBot=false />
				</cfif>
				<cfcatch>
					<cfset blnIsBot=true />
				</cfcatch>
			</cftry>
		</cfif>
	</cfif>
	<cfset arrValidChars=ListToArray( "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
	"2,3,4,5,6,7,8,9" ) />
	<!--- Now, shuffle the array. --->
	<cfset CreateObject( "java" , "java.util.Collections" ).Shuffle( arrValidChars ) />
	<cfset strCaptcha=( arrValidChars[ 1 ] & arrValidChars[ 2 ] ) />
	<cfset FORM.captcha_check=Encrypt( strCaptcha,"gallart-is-the-best", "CFMX_COMPAT" , "HEX" ) />
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
		  <script language="JavaScript" src="/js/utils.js"></script>
		  <script language="JavaScript" src="http://#server_name#/js/jquery-1.2.6.min.js"></script>
		  <script language="JavaScript" src="http://#server_name#/js/slimbox2.js"></script>
		  <link href="http://#server_name#/css/slimbox2.css" rel="stylesheet" type="text/css">
		  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
		  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
		  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
		  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
	   </cfoutput>
	   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	   <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
	   <SCRIPT LANGUAGE="JavaScript">
		  function popUpWin(urlPage) {
			  var features = 'scrollbars=yes, toolbar=no, status=no, menubar=no,' +
				  'resizable=no, location=no, directories=no,' +
				  'left=100, top=100, width=793, height=400';
		  
			  myWin = window.open(urlPage, 'WinName', features);
		  }
		  
	   </SCRIPT>
	   <link href="/stylesheet_.css" rel="stylesheet" type="text/css">
	   <script type="text/javascript">
		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-34565365-1']);
		  _gaq.push(['_trackPageview']);
		  
		  (function () {
			  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
			  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();
		  
	   </script>
	   <!-- BEGIN ROBLY WIDGET CODE -->
	   <script type='text/javascript'>
		  var _d_site = _d_site || 'ebb8c5f7da7077e127988b3276107648';
		  (function (w, d, p, s, s2) {
			  w[p] = w[p] || function () { (w[p].q = w[p].q || []).push(arguments) };
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
		  where uid = '#form.pid#'
		  and active = 1
	   </cfquery>
	   <cfquery name="similar" maxrows="3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		  SELECT *
		  FROM products
		  WHERE active = 1 and manufacturer <> '#productinfo.manufacturer #' and path like '#productinfo.path#%'
	   </cfquery>
	   <div class="main-container registration-page">
		  <div id="Table_01">
			 <cfoutput>
				<form method="post" action="#script_name#" name="errorFrm">
				   <input type="Hidden" name="fname">
				   <input type="Hidden" name="lname">
				   <input type="Hidden" name="name">
				   <input type="Hidden" name="email">
				   <input type="Hidden" name="phone">
				   <input type="Hidden" name="otherphone">
				   <input type="Hidden" name="best_time">
				   <input type="Hidden" name="email_only">
				   <input type="Hidden" name="comments">
				   <input type="Hidden" name="Offer">
				   <input type="Hidden" name="errorMsg">
				   <input type="Hidden" name="captchaError" value="0">
				   <input type="Hidden" name="errorPhone" value="0">
				   <input type="Hidden" name="pid">
				</form>
			 </cfoutput>
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
								  <div class="bottom-content">
									 <div class="user-registrations row">
										<div class="col-md-12">
											<div>
												<cfif productinfo.recordcount>
													<cfoutput>
														<div class="top-heading text-left">
															<h3>Make an Offer</h3>
														</div>
													
														<cfif FORM.submitted>

															<cfset apikey="6LddEiMrAAAAAJdkOFhc6RFcBOQ4Ol15oaRHRwJb">

															<cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="post">
																<cfhttpparam type="formField" name="secret" value="#apikey#">
																<cfhttpparam type="formField" name="response" value="#FORM['g-recaptcha-response']#">
																<cfhttpparam type="formField" name="remoteip" value="#CGI.REMOTE_ADDR#">
															</cfhttp>
																	
															<cfset captchaResponse = DeserializeJSON(cfhttp.FileContent)>

															<cfif phoneError>
																<cfoutput>
																	<script language="JavaScript">
																	// document.errorFrm.fname.value = '#form.fname#'
																	// document.errorFrm.lname.value = '#form.lname#'
																	document.errorFrm.name.value = '#form.name#'
																	document.errorFrm.email.value = '#form.email#'
																	document.errorFrm.phone.value = '#form.phone#'
																	document.errorFrm.otherphone.value = '#form.otherphone#'
																	document.errorFrm.best_time.value = '#form.best_time#'
																	document.errorFrm.email_only.value = '#form.email_only#'
																	document.errorFrm.comments.value = '#form.comments#'
																	document.errorFrm.Offer.value = '#form.Offer#'
																	document.errorFrm.errorMsg.value = '#errorMsg#'
																	document.errorFrm.errorPhone.value = '1'
																	document.errorFrm.pid.value = '#form.pid#'
																	document.errorFrm.submit();
																	</script>
																</cfoutput>
															 <cfelseif captchaResponse.success NEQ 'YES'>
																<cfoutput>
																	<script language="JavaScript">
																	// document.errorFrm.fname.value = '#form.fname#'
																	// document.errorFrm.lname.value = '#form.lname#'
																	document.errorFrm.name.value = '#form.name#'
																	document.errorFrm.email.value = '#form.email#'
																	document.errorFrm.phone.value = '#form.phone#'
																	document.errorFrm.otherphone.value = '#form.otherphone#'
																	document.errorFrm.best_time.value = '#form.best_time#'
																	document.errorFrm.email_only.value = '#form.email_only#'
																	document.errorFrm.comments.value = '#form.comments#'
																	document.errorFrm.Offer.value = '#form.Offer#'
																	document.errorFrm.errorMsg.value = '#errorMsg#'
																	document.errorFrm.captchaError.value = '1'
																	document.errorFrm.pid.value = '#form.pid#'
																	document.errorFrm.submit();
																	</script>
																</cfoutput>
															 <cfelse>
																
																<cftry>
																	<cfif len(trim(form.phone)) AND form.phoneType EQ "Home Phone">
																		<cfset phone = form.phone>
																	<cfelse>
																		<cfset phone = "">
																	</cfif>

																	<cfif len(trim(form.phone)) AND form.phoneType EQ "Cell Phone">
																		<cfset cellphone = form.phone>
																	<cfelse>
																		<cfset cellphone = "">
																	</cfif>

																	<cfif len(trim(form.phone)) AND form.phoneType EQ "Business Phone">
																		<cfset businessphone = form.phone>
																	<cfelse>
																		<cfset businessphone = "">
																	</cfif>

																	<cfif len(trim(form.phone)) AND form.phoneType EQ "OutsideUS">
																		<cfset otherphone = form.phone>
																	<cfelse>
																		<cfset otherphone = "">
																	</cfif>

																	<cfif form.name neq ''  and form.Offer neq '' >
																		<cfquery name="find_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
																			SELECT * from customers where (email = '#trim(email)#')
																		</cfquery>

																		<cfif form.email eq ''>

																			<cfquery name="insert_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
																				INSERT into customers
																				(
																					NAME,
																					PHONE,
																					cellphone,
																					businessphone,
																					otherphone,
																					EMAIL
																				)
																				VALUES
																				(
																					'#form.NAME#',
																					'#phone#',
																					'#cellphone#',
																					'#businessphone#',
																					'#otherphone#',
																					'#form.EMAIL#'
																				)
																				SELECT @@identity as uid
																			</cfquery>
																			<cfset customerId=insert_cust.uid />

																		<cfelse>
																			<cfif not find_cust.recordcount>
																				<cfquery name="insert_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
																					INSERT into customers
																					(
																						NAME,
																						PHONE,
																						cellphone,
																						businessphone,
																						otherphone,
																						EMAIL
																					)
																					VALUES
																					(
																						'#form.NAME#',
																						'#phone#',
																						'#cellphone#',
																						'#businessphone#',
																						'#otherphone#',
																						'#form.EMAIL#'
																					)
																					SELECT @@identity as uid
																				</cfquery>
																				<cfset customerId=insert_cust.uid />
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
																				<cfset customerId=find_cust.id />
																			</cfif>

																		</cfif>
																		<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
																			INSERT into makeoffer
																			(
																				fk_customers,
																				fk_products,
																				offer,
																				makeoffer_phone,
																				best_time
																			)
																			VALUES
																			(
																				#customerId#,
																				#productinfo.uid#,
																				'#form.Offer#',
																				'#form.phone#',
																				'#form.best_time#'
																				)
																		</cfquery>

																		<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
																		<cfset date = now()>
																		<cfset moduleName = 'Make Offer'>
																		<cfset action = 'Insert'>

																		<cfquery name="addLog" datasource="#application.dsource#" >
																			INSERT INTO logs
																				( moduleName, ipAddress, date, action)
																				VALUES
																				( '#moduleName#', '#ipAddress#', #date#, '#action#')
																		</cfquery>

																		

																			<cfmail
																				server="#application.mailserver#"
																				username="#application.mailserver_un#"
																				password="#application.mailserver_pw#"
																				to="tldz.dev12@gmail.com"
																				from="sales@gallart.com"
																				subject="GallArt.com <> We Buy & Sell Fine Art <> Make An Offer"
																				port="587" type="HTML"
																				>
																					<font style="font-size: 10pt; font-family: Arial;">
																						The following user made an offer on the piece below:
																						<br><br>
																						<!--- Name: #form.FNAME# #form.LNAME#<br> --->
																						Name: #form.NAME#<br>
																						Email Address: #form.Email#<br>
																						Phone: #form.phone#<br>
																						<cfif form.best_time NEQ "">
																							Best time to call: #form.best_time#<br>
																						</cfif>
																						Offer: $#form.Offer#<br>
																						Artist: #ucase(productinfo.manufacturer)#<br>
																						Title: #productinfo.name#<br>
																						Art ID: #productinfo.modelno#<br>
																						Retail Price: #dollarFormat(productinfo.retail_price)#<br>
																						Gallery Price: #dollarFormat(productinfo.gallery_price)#<br>
																						<!--- removed for make offer 5/6/15 --->
																						<!--- Sale Price: #dollarFormat(productinfo.sale_price)# --->
																						<cfif productinfo.fk_users GT 1>
																							<br>
																							Seller: #productinfo.fname# #productinfo.lname#<br>
																							Seller Email: #productinfo.email#<br>
																							Seller Phone: #productinfo.phone#
																						</cfif>
																						<br><br>
																					</font>
																			</cfmail>

																		

																			<span style="color:##dd3a7d; font-size: 16px; font-weight: bold;">
																				THANK YOU FOR MAKING YOUR OFFER!<br>WE WILL BE IN TOUCH WITH YOU SHORTLY
																				<br><br>
																				<a href="/" style="color:##dd3a7d; font-size: 16px; font-weight: bold; text-decoration: underline;">
																					CLICK HERE
																				</a> TO MAKE ANOTHER OFFER
																			</span>

																			<cfset success = true />

																	</cfif>

																	<cfcatch type="any">
																		<!--- <cfdump var="#cfcatch.detail#" abort="true"> --->
																		<cfoutput>
																			<script language="JavaScript">
																				alert('Error occurred: #JSStringFormat(cfcatch.detail)#');
																			</script>
																		</cfoutput>
																	</cfcatch>
																	
																</cftry>
																																

															</cfif>
														</cfif>
														<cfif not success>
															<div class="form-section flex-form-section">
																<cfform action="" method="post" name="frm1" onsubmit="return setFormActionAndValidate(event)">
																	<div class="row top-row">
																		<div class="col-lg-5 col-md-6 col-sm-12">
																			<div class="img-sec">
																				<!--- <img src="images/Gallery-Art-Map-V2.jpg" alt="image"> --->

																				<cfif fileexists("http://#server_name#/img/thumbnails/#productInfo.uid#.jpg")> 
																					<IMG SRC="/img/#productInfo.uid#.jpg?x=randrange(1,99)"   width="100" BORDER="0" ALT="#trim(productInfo.modelno)#" align="Center">
																					<cfelse>
																						
																						<img src="http://#server_name#/img/thumbnails/noImage.jfif.jpeg">
																				</cfif>

																			</div>
																		</div>
																		<div class="col-lg-7 col-md-6 col-sm-12 border-left">
																			<input type="hidden" name="submitted" value="1" />
																			<input type="hidden" name="captcha_check" value="#form.captcha_check#" />
																			<input type="hidden" name="pid" id="pid" value="#form.pid#" />
																			<cfif FORM.captchaError EQ 1>
																				<span style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE
																				EXACTLY AS YOU SEE THEM</span>
																			</cfif>
																			<cfif FORM.errorPhone EQ 1>
																				<span style="color: ##ff0000; font-weight: bold;">
																				#form.errorMsg#
																				</span>
																			</cfif>
																			<div class="input-form">

																				<cfif listlen(productinfo.manufacturer) gt 1>
																					<cfset artist_name = "#listlast(productinfo.manufacturer)# #listfirst(productinfo.manufacturer)#" />
																					<cfset artist_name_url = "#listlast(productinfo.manufacturer)#_#listfirst(productinfo.manufacturer)#" />
																				<cfelse>
																					<cfset artist_name = productinfo.manufacturer />
																					<cfset artist_name_url = productinfo.manufacturer />
																				</cfif>
																				
																				<h2 class="title">
																					

																					<cfset words = ListToArray(productinfo.name, " ")>
																					<cfset updatedName = "">

																					<cfloop index="word" array="#words#">
																						<cfset cleanWord = REReplace(word, "[^a-zA-Z]", "", "ALL")>

																						<cfif cleanWord EQ "FS">
																							<!--- Preserve "FS" in uppercase --->
																							<cfset updatedName = updatedName & " " & UCase(word)>
																						<cfelse>
																							<!--- Keep the original case of other words --->
																							<cfset updatedName = updatedName & " " & word>
																						</cfif>
																					</cfloop>

																					<cfset updatedName = Trim(updatedName)>

																					<b>#artist_name# '#updatedName#' </b> - 
																					<span>
																						<!--- <cfif productinfo.retail_price gt 0 > --->

																							
																							<cfif productinfo.closeout eq 1 and productinfo.special_price gt 0>
																								<cfif application.showSalePrice EQ 1>
																									<!--- #DollarFormat(productinfo.special_price)#  &nbsp; --->
																									<!--- <b> --->
																										<cfif productinfo.gallery_price gt 0 and productinfo.gallery_price LTE productinfo.special_price >
																											#DollarFormat(productinfo.gallery_price)#  &nbsp;
																										<cfelse>
																											<span style="color: ##ff0000;">
																												#DollarFormat(productinfo.special_price)# 
																											</span>
																										</cfif>	
																									<!--- </b> --->
																								</cfif>
																							 <cfelseif productinfo.gallery_price gt 0>
																								#DollarFormat(productinfo.gallery_price)#  &nbsp;
																								<!--- <b> #DollarFormat(productinfo.gallery_price)# </b> --->
																							</cfif>


																							<cfset actualPrice = 0>
																							<cfif productinfo.closeout eq 1 and productinfo.special_price gt 0 and application.showSalePrice EQ 1>
																								<cfset actualPrice = productinfo.special_price>
																							<cfelseif productinfo.gallery_price gt 0>
																								<cfset actualPrice = productinfo.gallery_price>
																							</cfif>

																							<input type="hidden" id="actualPrice" value="#actualPrice#">
									
																						
																						<!--- </cfif> --->


																					</span> 
																				</h2>
																				<div class="row">																	
																					<span style="color: ##ff0000;">* Required</span> <br><br>

																					<div class="col-md-12">
																						<div class="input-field">
																							<cfinput type="text" size=40 maxsize=50 maxlength="30" placeholder="Enter your Name*" name="name" id="name" value="#form.name#" >
																							<span class="error-message" id="nameError"></span>
																						</div>
																					</div>

																					<div class="col-md-12">
																						<div class="input-field">
																							<cfinput type="text" size=40 maxsize=50 maxlength="30" name="email" placeholder="Enter your Email Address*" id="email" value="#form.email#"  >
																							<span class="error-message" id="emailError"></span>
																						</div>
																					</div>
																					
																					<div class="col-md-12">
																						<div class="input-field">
																							<select name="phoneType" id="phoneType" class="form-control" style="width:100% !important;">
																								<option value="Cell Phone">Cell Phone</option>
																								<option value="Home Phone">Home Phone</option>
																								<option value="Business Phone">Business Phone</option>
																								<option value="OutsideUS">Outside US Phone</option>
																							</select>
																						</div>
																					</div>

																					<div class="col-md-12">
																						<div class="input-field">
																							<cfinput type="text" size=40 maxlength="20" name="phone" placeholder="Enter your Phone Number" id="phone" value="#form.phone#" required="No">
																							<!--- <span id="formatSign">(xxx) xxx-xxxx</span> --->
																							<span class="error-message" id="phoneError"></span>
																						</div>
																					</div>																		
																					
																					<div class="col-md-12">
																						<div class="input-field">
																							<cfinput type="text" name="Offer" size="5" maxlength="6" id="Offer" message="Enter a Dollar amount, no $ or decimal." placeholder="Enter a Dollar amount, no $ or decimal.*"  >
																							<span class="error-message" id="OfferError"></span>
																						</div>
																					</div>
																				
																					<div class="input-field pt-3">
																						<div class="g-recaptcha" id="gRecaptchaGeneral" data-sitekey="6LddEiMrAAAAAOnJRd03TsT_vYkEbebkW0T3u_ne"></div>
																						<span class="error-message" id="m_recaptchaError"></span>
																					</div>

																					<div class="col-md-12 mt-3">
																						<div class="input-button">
																							<button type="submit" class="SeeMore" id="submitBtn">Submit</button>
																							<button type="reset" class="SeeMore" id="resetBtn-captcha">Reset</button>
																						</div>
																					</div>
																				</div>
																			</div>
																		</div>
																	</div>														
																</cfform>
															</div>
														</cfif>
														
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
	   </div>
	   <tr>
		  <td colspan="2" valign="baseline">
			 <cfinclude template="footer_.cfm">
		  </td>
	   </tr>
	   <cfinclude template="frmxss.cfm">

	   <script src="https://www.google.com/recaptcha/api.js" async defer></script>

	   <script>

			function setFormActionAndValidate(event) {
				document.getElementById('frm1').action = '/epricing/' + document.getElementById('pid').value.trim();
				return validateEpricingForm(event);
			}

			function validateEpricingForm(e) {
				let isValid = true;

				document.querySelectorAll('.error-message').forEach(el => el.textContent = '');

				const name = document.getElementById('name').value.trim();
				const email = document.getElementById('email').value.trim();
				const phone = document.getElementById('phone').value.trim();
				const phoneType = document.querySelector("[name='phoneType']").value;
				const Offer = document.getElementById('Offer').value.trim();
				const actualPrice = parseInt(document.getElementById('actualPrice').value.trim(), 10);
				const submitButton = document.getElementById('submitBtn');

				const phoneRegex = /^\(\d{3}\) \d{3}-\d{4}$/;
				const integerRegex = /^[0-9]+(\.[0-9]{1,2})?$/;
				const emailRegex = /\S+@\S+\.\S+/;
				const recaptcha = grecaptcha.getResponse();

				console.log('test: ' + name)

				if (!recaptcha) {
					document.getElementById("m_recaptchaError").textContent = "Please confirm you are not a robot.";
					isValid = false;
				}

				if (!name) {
					document.getElementById('nameError').textContent = 'Please enter your name.';
					isValid = false;
				}

				if (!email || !emailRegex.test(email)) {
					document.getElementById('emailError').textContent = !email ? 'Please enter an email address.' : 'Please enter a valid email address.';
					isValid = false;
				}

				if (["Home Phone", "Cell Phone", "Business Phone"].includes(phoneType) && !phoneRegex.test(phone)) {
					document.getElementById('phoneError').textContent = 'Please enter phone number in format: (xxx) xxx-xxxx.';
					document.getElementById('phone').focus();
					isValid = false;
				}

				const offerNum = parseFloat(Offer);
				if (!Offer || !integerRegex.test(Offer) || offerNum <= 0 || offerNum >= actualPrice) {
					document.getElementById('OfferError').textContent = !Offer ? 'Please make an offer - enter a dollar amount, no $ or decimal.' :
						!integerRegex.test(Offer) ? 'Please enter a dollar amount number (no decimals or special characters).' :
						offerNum <= 0 ? 'Please enter an offer price greater than 0.' : 'Offer price must be less than the sale or gallery price.';
					isValid = false;
				}

				if (!isValid) {		
					return false;
				} else {
					
					submitButton.disabled = true;
					submitButton.innerText = "Submitting…";

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
	   </script>


	   <script>
			document.addEventListener("DOMContentLoaded", function() {
				const phoneInput = document.getElementById("phone");
				const phoneType = document.getElementById("phoneType");
				// const formatSign = document.getElementById("formatSign");

				 if (!phoneInput || !phoneType ) {
					// Elements not on this page → exit
					return;
				}

				// function toggleFormatSign() {
				// 	if (phoneType.value === "OutsideUS") {
				// 		formatSign.style.display = "none";
				// 	} else {
				// 		formatSign.style.display = "inline";
				// 	}
				// }

				// // run on load (in case form already has value)
				// toggleFormatSign();

				// // run on change
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
				margin-top: -5px;
				display: block;
			}
			.input-field {
				margin-bottom: 15px;
				position: relative;
			}
			.star{
				color: red;
				position: absolute;
				top: -10;
				right: 0
			}
			input, select, textarea {
				border: 1px solid #bbbbbb;
				background-color: #ffffff;
			}
			.flex-form-group {
				display: flex;
				align-items: center;
			}
			.flex-form-group label {
				color: #bbbbbb;
				margin-left: 6px;
			}
			.registration-page .content-section .banner-section .flex-form-section .input-field input, 
			.registration-page .content-section .banner-section .flex-form-section .input-field textarea, 
			.registration-page .content-section .banner-section .flex-form-section .input-field img {
				width: 100% !important;
			}
			.flex-form-section .input-field label {
				font-weight: 400 !important;
				margin-bottom: 0;
			}
			.flex-form-section .input-field label, .flex-form-section .input-field .checkbox-field input {
				font-weight: 400 !important;
				margin-bottom: 0 !important;
			}
			.flex-form-section .checkbox-form-group {
				margin-bottom: 10px !important;
			}
			.border-left {
				border-left: 1px solid #bbbbbb;
			}
			.flex-form-section input::placeholder, .flex-form-section textarea::placeholder {
				color: #bbbbbb !important;
			}
			.flex-form-section .img-sec {
				padding: 20px;
				width: 100%;
				background-color: #fff;
				box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
				height: 400px;
			}
			.flex-form-section .img-sec img {
				width: 100%;
				height: 100%;
				object-fit: contain;
			}
			.flex-form-section .row .col-lg-5 {
				padding: 0 25px 0 12px !important;
			}
			.flex-form-section .row .col-lg-7 {
				padding: 0 12px 0 25px !important;
			}

			.flex-form-section h2.title {
				font-size: 28px;
				line-height: normal;
				color: black;
				margin-bottom: 10px;
			}
			/* .flex-form-section h2.title span {
				color: #ff0000;
			} */
			.flex-form-section .top-row {
				padding-bottom: 20px;
			}
			.flex-form-section .bottom-row {
				padding-top: 30px;
				border-top: 1px solid #bbbbbb;
			}
			.flex-form-section .bottom-row .content-sec {
				display: flex;
				align-items: center;
				justify-content: space-between;
				width: 100%;
				gap: 10px;
				margin-bottom: 20px;
			}
			.flex-form-section .bottom-row .content-sec p {
				width: 80%;
				color: #000;
				line-height: 1.2;
			}
			.flex-form-section .bottom-row .content-sec .input-button button {
				margin: 0 !important;
				min-width: 120px;
				border-radius: 4px !important;
			}
			.flex-form-section .bottom-row .privacy-field {
				display: flex;
				align-items: center;
				justify-content: end;
			}
			.flex-form-section .bottom-row .privacy-field label {
				color: #000 !important;
				font-size: 16px !important;
			}
			.flex-form-section .bottom-row .privacy-field label a {
				color: blue !important;
			}

			@media (max-width: 767.5px) {
				.flex-form-section .row .col-lg-5 {
					padding: 0 12px 30px 12px !important;
				}
				.flex-form-section .row .col-lg-7 {
					padding: 30px 12px 0 !important;
				}
				.border-left {
					border-top: 1px solid #bbbbbb;
					border-left: none;
				}
			}

			@media (max-width: 480px) {
				.flex-form-section .bottom-row .content-sec {
					flex-direction: column;
				}
				.flex-form-section .bottom-row .content-sec p {
					width: 100%;
				}
				.flex-form-section h2.title {
					font-size: 24px;
				}
			}
		 </style>
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				const resetBtn = document.getElementById("resetBtn-captcha");

				if (resetBtn) {
					resetBtn.addEventListener("click", function() {
						if (typeof grecaptcha !== "undefined") {
							grecaptcha.reset(); // Reset the reCAPTCHA
						}

						// Also clear error messages if needed
						document.querySelectorAll('.error-message').forEach(function(el) {
							el.innerText = '';
						});
					});
				}
			});
		</script>
	</body>
 </html>