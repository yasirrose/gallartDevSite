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
	   <cfif len(form.phone) AND NOT isValid("regex",form.phone,"^([\(]{1}[0-9]{3}[\)]{1}[
	   ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
	   <cfset errorMsg=errorMsg & "Please enter your home phone number in the format (xxx) xxx-xxxx <br/>" />
	</cfif>
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
		  <script language="JavaScript" src="./js/utils.js"></script>
		  <script language="JavaScript" src="http://#server_name#/js/jquery-1.2.6.min.js"></script>
		  <script language="JavaScript" src="http://#server_name#/js/slimbox2.js"></script>
		  <link href="http://#server_name#/css/slimbox2.css" rel="stylesheet" type="text/css">
		  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
		  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
		  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
		  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
	   </cfoutput>
	   <SCRIPT LANGUAGE="JavaScript">
		  function popUpWin(urlPage) {
			  var features = 'scrollbars=yes, toolbar=no, status=no, menubar=no,' +
				  'resizable=no, location=no, directories=no,' +
				  'left=100, top=100, width=793, height=400';
		  
			  myWin = window.open(urlPage, 'WinName', features);
		  }
		  
	   </SCRIPT>
	   <link href="stylesheet_.css" rel="stylesheet" type="text/css">
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
													<!--- <cfdump var="#productinfo.manufacturer#" > --->
													<div class="top-heading text-left">
														<h3>E-PRICING!</h3>
												 	</div>
													<div class="row">
														<div class="col-md-6">
															
														 <cfset imgFile=expandpath('.') & '\img\' & productinfo.uid &'.jpg' />
														 <cfif fileExists(imgFile)>
																<img src="http://#server_name#/img/#productinfo.uid#.jpg" border="2" width="300">
																<a href="http://#server_name#/img/#productinfo.uid#.jpg" rel="lightbox">[CLICK]</a> to view 
																large image size in separate window.
														 </cfif>
														 <cfif productinfo.manufacturer gt 0>
																<font size="1" face="arial, helvetica">
																 <h4>Artist: #ucase(productinfo.manufacturer)#</h4>
																</font>
														 </cfif>
														 <!--- <cfif productinfo.name gt 0>
																<font size="1" face="arial, helvetica">Title: #productinfo.name#</font>
														 </cfif>
														 <cfif productinfo.retail_price gt 0>
																<font size="1" face="arial, helvetica">Retail Price:
																#DollarFormat(productinfo.retail_price)#</font>
														 </cfif>
														 <font size="1" face="arial, helvetica">
																<cfif productinfo.closeout eq 1 and productinfo.special_price gt 0>
																 <cfif application.showSalePrice EQ 1><span style="color: ##ff0000;">Sale Price:
																	#DollarFormat(productinfo.special_price)#</span>
																 </cfif>
																 <cfelseif productinfo.gallery_price gt 0>
																 Gallery Price:
																 #DollarFormat(productinfo.gallery_price)#
																</cfif>
														 </font>
														 <cfif productinfo.overview gt 0>
																<font size="1" face="arial, helvetica">Size: #productinfo.overview#</font>
														 </cfif>
														 <cfif productinfo.specs gt 0>
																<font size="1" face="arial, helvetica">Year: #productinfo.specs#</font>
														 </cfif>
														 <cfset medium=replace(RemoveChars(productinfo.path,len(productinfo.path), 1),":","/","all")>
														 <cfif medium gt 0>
																<font size="1" face="arial, helvetica">Medium: #medium#</font>
														 </cfif>
														 <cfif productinfo.edition gt 0>
																<font size="1" face="arial, helvetica">Edition: #productinfo.edition#</font>
														 </cfif>
														 <cfif productinfo.caption gt 0>
																<font size="1" face="arial, helvetica">Description: #trim(productinfo.caption)#</font>
														 </cfif> --->
														 <div class="table-responsive">
																<table class=" table table-bordered" style="border: 1px solid black;">
																	<tr style="background: ##ec008c; color: white;">
																		<th>Title</th>
																		<th>Retail Price</th>
																		<th>
																			<cfif productinfo.closeout eq 1 and productinfo.special_price gt 0>
																				<cfif application.showSalePrice EQ 1>
																					<span style="color: black;">Sale Price</span>
																				</cfif>
																			<cfelseif productinfo.gallery_price gt 0>
																				Gallery Price
																			</cfif>
																		</th>
																		<th>Size</th>
																		<th>Year</th>
																		<th>Medium</th>
																		<th>Edition</th>
																		<!--- <th>Description</th> --->
																	</tr>
																	<tr>
																		<td>
																			<cfif productinfo.name gt 0>
																		 <cfset name = REReplace(productinfo.name, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")>
																				#name#
																			</cfif>
																		</td>
																		<td>
																			<cfif productinfo.retail_price gt 0>
																				#DollarFormat(productinfo.retail_price)#
																			</cfif>
																		</td>
																		<td>
																			<cfif productinfo.closeout eq 1 and productinfo.special_price gt 0>
																				<cfif application.showSalePrice EQ 1>
																					<span style="color: ##ff0000;">#DollarFormat(productinfo.special_price)#</span>
																				</cfif>
																			<cfelseif productinfo.gallery_price gt 0>
																				#DollarFormat(productinfo.gallery_price)#
																			</cfif>
																		</td>
																		<td>
																			<cfif productinfo.overview gt 0>
																				#productinfo.overview#
																			</cfif>
																		</td>
																		<td>
																			<cfif productinfo.specs gt 0>
																				#productinfo.specs#
																			</cfif>
																		</td>
																		<td>
																	 <cfset medium=replace(RemoveChars(productinfo.path,len(productinfo.path), 1),":","/","all")>
																	 <cfset c_medium = REReplace(medium, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")>
	 
																			<cfif medium gt 0>
																				#c_medium#
																			</cfif>
																		</td>
																		<td>
																			<cfif productinfo.edition gt 0>
																				#productinfo.edition#
																			</cfif>
																		</td>
																		<!--- <td>
																			<cfif productinfo.caption gt 0>
																			 <p>
																			 #trim(productinfo.caption)#
																			 </p> 
																			</cfif>
																		</td> --->
																	</tr>
																</table>
	 
																<p>
															 <b>Description: </b> #trim(productinfo.caption)#
																</p>
																
																
														 </div>
														</div>
														<div class="col-md-6">
															<div>
															 <cfoutput>
																<cfif #similar.recordcount# gt 0>
																<font face="arial,helvetica" size="3"><b>You Might Also Like:</b></font>
																<br><br>
																<cfloop query="similar">
																 <cfset thisFile="#expandpath('.')#\img\#similar.uid#.jpg" />
																 <cfif listlen(manufacturer) gt 1>
																 <cfset artist_name="#listlast(manufacturer)# #listfirst(manufacturer)#" />
																 <cfset artist_name_url="#listlast(manufacturer)#_#listfirst(manufacturer)#" />
																 <cfelse>
																 <cfset artist_name=manufacturer />
																 <cfset artist_name_url=manufacturer />
																 </cfif>
																 <A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#'
																 )">
																 <ul>
																	 <li>
																 <cfif fileExists(thisFile)>
																		<img src="http://#server_name#/img/thumbnails/#similar.uid#.jpg" alt="#ucase(similar.manufacturer)# - #similar.name#"
																		 border="1">
																		<cfelse>
																		#ucase(similar.manufacturer)# - #similar.name#
																 </cfif>
																 <!--- <font size="1" face="verdana, arial">#name#</font> --->
																	 
																			#name# 
																		 </li>
																	 </ul>
																 </a>
																</cfloop>
																</cfif>
																<!-- <input type="image" src="images/other_listings.gif" style="border: none;" onClick="location.href='index.cfm?xss=#xss#'"> -->
																<button type="submit" class="SeeMore" style="max-width: 260px; margin:20px 0 0;" onClick="location.href='index.cfm?xss=#xss#'">Click Here for other listings</button>
															 </cfoutput>
															</div>
														 </div>
													</div>
													<cfif FORM.submitted>
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
														  <cfif form.fname neq '' and form.lname neq '' and form.email neq ''>
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
														  <cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
															 INSERT into epricing
															 (
															 fk_customers,
															 fk_products,
															 best_time,
															 epricing_phone,
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
															 '#form.email#',
															 '#form.comments#',
															 <cfif isDefined('form.email_only')>
															 1
															 <cfelse>
															 0
													   </cfif>
													   )
													   </cfquery>
													   <cfmail server="#servername#" username="gallart@onlinegalleryart.com" password="re3objeC!P" to="#emailsupport#"
														  cc="#emailsupportcc#" from="#form.Email#" subject="GallArt.com <> We Buy & Sell Fine Art <> e-Pricing"
														  type="HTML">
														  <font style="font-size: 10pt; font-family: Arial;">
															 The following user submitted an e-Pricing form:
															 Name: #form.fname# #form.lname#
															 Email Address: #form.email#
															 Phone: #form.phone#
															 <!--- Phone Outside US: #form.otherphone# --->
															 <cfif form.email_only EQ 1>
																Email Only
															 </cfif>
															 <cfif form.best_time NEQ "">
																Best time to call: #form.best_time#
															 </cfif>
															 Comments: #form.comments#
															 Artist: #ucase(productinfo.manufacturer)#
															 Title: #productinfo.name#
															 Art ID: #productinfo.modelno#
															 Retail Price: #dollarFormat(productinfo.retail_price)#
															 Gallery Price: #dollarFormat(productinfo.gallery_price)#
															 <cfif application.showSalePrice EQ 1>Sale Price: #dollarFormat(productinfo.sale_price)#</cfif>
															 <cfif productinfo.fk_users GT 1>
																Seller: #productinfo.fname# #productinfo.lname#
																Seller Email: #productinfo.email#
																Seller Phone: #productinfo.phone#
															 </cfif>
														  </font>
													   </cfmail>
													   <span style="color:##dd3a7d; font-size: 16px; font-weight: bold;">
													   THANK YOU FOR CONTACTING E-PRICING!WE WILL BE IN TOUCH WITH YOU SHORTLY
													   <a href="index.cfm?xss=#xss#" style="color:##dd3a7d; font-size: 16px; font-weight: bold; text-decoration: underline;">CLICK
													   HERE</a> TO MAKE ANOTHER SELECTION
													   </span>
													</cfif>
													</cfif>
													<cfelse>
													<div class="form-section">
													   <cfform action="" method="post" name="frm1" onsubmit="return validateEpricingForm()">
														  <input type="hidden" name="submitted" value="1" />
														  <input type="hidden" name="captcha_check" value="#form.captcha_check#" />
														  <input type="hidden" name="pid" value="#form.pid#" />
														  <h5 style="mt-2 mb-4 font-size: 16px; font-weight: bold;">
															 GET E-PRICING FOR THIS PIECE!SIMPLY SUBMIT THE FORM BELOW:
														  </h5>
														  <span style="color: ##ff0000;">* Required</span>
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
																 <div class="row">
																	<div class="col-md-6">
																		<div class="input-field">
																			<label><FONT face="" color="000000"><b>FIRST NAME</b></FONT></label>
																			<cfinput type="text" size=40 maxsize=50 name="fname" id="fname" value="#form.fname#" >&nbsp;<span style="color:##ff0000;">*</span>
																				<span class="error-message" id="fnameError"></span>
																		</div>
																	</div>
																	<div class="col-md-6">
																		<div class="input-field">
																			<label>
																			<FONT face="" color="000000"><b>LAST NAME</b></FONT>
																			</label>
																			<cfinput type="text" size=40 maxsize=50 name="lname" id="lname" value="#form.lname#" >
																			&nbsp;<span style="color:##ff0000;">*</span>
																				<span class="error-message" id="lnameError"></span>
																		</div>
																	</div>
																	<div class="col-md-6">
																		<div class="input-field">
																			<label><FONT face="" color="000000"><b>E-MAIL ADDRESS</b></FONT></label>
																			<cfinput type="text" size=40 maxsize=50 name="email" id="email" value="#form.email#"  >
																			&nbsp;<span style="color:##ff0000;">*</span>
																				<span class="error-message" id="emailError"></span>
																		</div>
																	</div>
																	<div class="col-md-6">
																		<div class="input-field">
																			<label>
																			<FONT face="" color="000000"><b>HOME PHONE (xxx) xxx-xxxx</b></FONT>
																			</label>
																			<cfinput type="text" size=40 maxsize=50 name="phone" id="phone" value="#form.phone#" required="No"
																				 mask="(999) 999-9999">
																				 <span class="error-message" id="phoneError"></span>
																		</div>
																	</div>
																	 <!--- <div class="input-field">
																		<label><FONT face="" color="000000"><b>PHONE NUMBER OUTSIDE THE US</b></FONT></label>
																		<cfinput type="text" size=40 maxsize=50 name="otherphone" value="#form.otherphone#" required="No">
																		</div> --->
																	<div class="col-md-6">
																		<div class="input-field">
																			<label>
																			<FONT face="" color="000000"><b>BEST TIME TO CALL</b></FONT>
																			</label>
																			<cfinput type="text" size=40 maxsize=50 name="best_time" value="#form.best_time#" required="No">
																		</div>
																	</div>
																	<div class="col-md-6">
																	 <div class="input-field">
																		<label><FONT face="" color="000000"><b>OR EMAIL ONLY</b></FONT></label>
																		<div class="checkbox">
																			 <div class="checkbox-field">
																				<input
																				type="checkbox" name="email_only" value="1" 
																				<cfif form.email_only EQ 1>checked
																				</cfif>
																				/>
																			 </div>
																		</div>
																	 </div>
																	</div>
																</div>
															 <div class="input-field">
																<label><FONT face="" color="000000"><b>COMMENTS</b></FONT></label>
																<TEXTAREA NAME="comments" ROWS=10 COLS=35>#form.comments#</TEXTAREA>
															 </div>
															 <div class="input-field">
																<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low" fonts="verdana,arial,times new roman,courier,tahoma"
																   fontsize="28" />
																<label><FONT face="" color="000000"><b>Please enter the characters in the
																image above:</b></FONT></label>
																<cfinput type="text" name="captcha" id="captcha" >
																&nbsp;<span style="color:##ff0000;">*</span>
																<span class="error-message" id="captchaError"></span>
															 </div>
															 <div class="input-button">
																<button type="submit" class="SeeMore">Submit</button>
																<button type="button" class="SeeMore">Reset</button>
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

	   <script>
		function validateEpricingForm() {
         let isValid = true;
         
         // Clear previous error messages
         document.querySelectorAll('.error-message').forEach(error => error.textContent = '');
         
         // Get form field values
         const fname = document.getElementById('fname').value.trim();
         const lname = document.getElementById('lname').value.trim();
         const email = document.getElementById('email').value.trim();
         const captcha = document.getElementById('captcha').value.trim();
         const phone = document.getElementById('phone').value.trim();

		 const phoneRegex = /^\(\d{3}\) \d{3}-\d{4}$/;
         
         // Validate FIRST NAME
         if (!fname) {
            document.getElementById('fnameError').textContent = 'Please fill in your first name.';
            isValid = false;
         }
         
         // Validate LAST NAME
         if (!lname) {
            document.getElementById('lnameError').textContent = 'Please fill in your last name.';
            isValid = false;
         }
         
         // Validate EMAIL
         if (!email) {
            document.getElementById('emailError').textContent = 'Please fill in your email address.';
            isValid = false;
         } else if (!/\S+@\S+\.\S+/.test(email)) {
            document.getElementById('emailError').textContent = 'Please enter a valid email address.';
            isValid = false;
         }

		 if (phone && !phoneRegex.test(phone)) {

			document.getElementById('phoneError').textContent = 'Please enter your home phone number in the format (xxx) xxx-xxxx';
			isValid = false;
		}
         
         // Validate CAPTCHA
         if (!captcha) {
            document.getElementById('captchaError').textContent = 'Please enter the characters in the image.';
            isValid = false;
         }
         
         return isValid;
         }
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
		 </style>

	</body>
 </html>