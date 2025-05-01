<!--- Kill extra output. --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfsilent>
	<cfparam name="form.fname" default="">	
	<cfparam name="form.lname" default="">						
	<cfparam name="form.email" default="">
	<cfparam name="form.phone" default="">
	<cfparam name="form.cell" default="">
	<cfparam name="form.otherphone" default="">
	<cfparam name="form.artist" default="">
	<cfparam name="form.title" default="">
	<cfparam name="form.medium" default="">
    <cfparam name="form.graphics" default="">
    <cfparam name="form.edition" default="">
    <cfparam name="form.signature" default="">
    <cfparam name="form.size" default="">
    <cfparam name="form.sculpture" default="">
    <cfparam name="form.year" default="">
    <cfparam name="form.description" default="">
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

			
			<cfif len(form.phone) AND NOT isValid("regex",form.phone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = errorMsg & "Please enter your phone number in the format (xxx) xxx-xxxx <br/>" />
			</cfif>
			<cfif len(form.cell) AND NOT isValid("regex",form.cell,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
				<cfset errorMsg = "Please enter your cell phone number in the format (xxx) xxx-xxxx <br/>" />
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
	
<script language="JavaScript">

	<!--

	function isEmail(string) {
	    if (string.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
	        return true;
	    else
	        return false;
	}
	validateFrm = function(){
		var errorMsg = "";
		if(document.quoteForm.fname.value == "") errorMsg += "Please enter your first name.\n";
		if(document.quoteForm.lname.value == "") errorMsg += "Please enter your last name.\n";
		if(isEmail(document.quoteForm.email.value) == false) errorMsg += "Please enter a proper email.\n";
		if( document.quoteForm.phone.value == "" &&
			document.quoteForm.cell.value == "" &&
			document.quoteForm.otherphone.value == "") errorMsg += "Please enter a phone number.\n";
		if(document.quoteForm.artist.value == "") errorMsg += "Please enter an artist name.\n";
		if(document.quoteForm.title.value == "") errorMsg += "Please enter a title.\n";
		if(document.quoteForm.pictureUpload.value == "") errorMsg += "You must upload a picture.\n";
		if(document.quoteForm.captcha.value == "") errorMsg += "Please enter the characters in the image.\n";
		
		if (errorMsg != "") {
			alert(errorMsg);
			return false;
		} else {
			document.quoteForm.submit();
		}
		
	}
	// -->
</script>
<!--- thickbox --->
<script language="JavaScript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/jquery-1.3.2.js"></script>
<script type="text/javascript" src="../js/thickbox-compressed.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../css/thickbox.css" type="text/css" media="screen" />
<link href="../stylesheet_.css" rel="stylesheet" type="text/css">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<style>
	#TB_ajaxContent.TB_modal {
	height: 400px !important;
}
</style>

<div class="main-container registration-page">
	<cfoutput>
		<form method="post" action="#script_name#?xss=#xss#" name="errorFrm">
			<input name="fname" type="Hidden">	
			<input name="lname" type="Hidden">						
			<input name="email" type="Hidden">
			<input name="phone" type="Hidden">
			<input name="cell" type="Hidden">
			<input name="otherphone" type="Hidden">
			<input name="artist" type="Hidden">
			<input name="title" type="Hidden">
			<input name="medium" type="Hidden">
			<input name="graphics" type="Hidden">
			<input name="edition" type="Hidden">
			<input name="signature" type="Hidden">
			<input name="size" type="Hidden">
			<input name="sculpture" type="Hidden">
			<input name="year" type="Hidden">
			<input name="description" type="Hidden">
			<input type="Hidden" name="errorMsg">
			<input type="Hidden" name="captchaError" value="0">
			<input type="Hidden" name="errorPhone" value="0">

		</form>
	</cfoutput>

	
	<div id="Table_01">
		<div class="header-section text-center py-4 px-4">
			<img src="../images/top_01.jpg" style="width: 100%; max-width: 634px; height: auto;" alt="image">
		</div>
		<div class="inner-section">
			<div class="container">
				<div class="main-content">
					<div class="content-section">
						<div class="bottom-content-sec">
							<div class="banner-section">
								<div class="art-work-content">
									<div class="bottom-content">
										<div class="user-registrations quotes-page">
											<cfoutput>

												<div class="top-heading">
													<h3>Free Quote Form</h3>
												</div>

												<cfif FORM.submitted>	
													<!--- Check for a bot. --->
													<cfif phoneError>
														<cfoutput>
															<script language="JavaScript">
																document.errorFrm.fname.value = '#form.fname#'
																document.errorFrm.lname.value = '#form.lname#'
																document.errorFrm.email.value = '#form.email#'
																document.errorFrm.phone.value = '#form.phone#'
																document.errorFrm.cell.value = '#form.cell#'
																document.errorFrm.otherphone.value = '#form.otherphone#'
																document.errorFrm.artist.value = '#form.artist#'
																document.errorFrm.title.value = '#form.title#'
																document.errorFrm.medium.value = '#form.medium#'
																document.errorFrm.graphics.value = '#form.graphics#'
																document.errorFrm.edition.value = '#form.edition#'
																document.errorFrm.signature.value = '#form.signature#'
																document.errorFrm.size.value = '#form.size#'
																document.errorFrm.sculpture.value = '#form.sculpture#'
																document.errorFrm.year.value = '#form.year#'
																document.errorFrm.description.value = '#form.description#'
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
																document.errorFrm.phone.value = '#form.phone#'
																document.errorFrm.cell.value = '#form.cell#'
																document.errorFrm.otherphone.value = '#form.otherphone#'
																document.errorFrm.artist.value = '#form.artist#'
																document.errorFrm.title.value = '#form.title#'
																document.errorFrm.medium.value = '#form.medium#'
																document.errorFrm.graphics.value = '#form.graphics#'
																document.errorFrm.edition.value = '#form.edition#'
																document.errorFrm.signature.value = '#form.signature#'
																document.errorFrm.size.value = '#form.size#'
																document.errorFrm.sculpture.value = '#form.sculpture#'
																document.errorFrm.year.value = '#form.year#'
																document.errorFrm.description.value = '#form.description#'
																document.errorFrm.errorMsg.value = '#errorMsg#'
																document.errorFrm.captchaError.value = '1'
																document.errorFrm.submit();
															</script>
															</cfoutput>
														
													<cfelse>
									
														<cfparam name="cffile.serverFile" default="" />
														
														<cfif isDefined('form.pictureUpload') and len(form.pictureUpload)>
															
															<cffile action="UPLOAD" filefield="pictureUpload" destination="#expandPath('/quotes/uploads')#" nameconflict="MAKEUNIQUE"  />
															
															<cfset strFilePath = ( CFFILE.ServerDirectory & "/" & CFFILE.ServerFile ) />
									
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
																			<td>
																				Phone Outside the US
																			</td>
																			<td>
																				#form.otherphone#
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
														username="onli16@onlinegalleryart.com"
														password="r3eOteC" 
														to="#emailsupport#"
														cc="#emailsupportcc#"
														from="#form.email#"
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
														<div class="table-responsive">
															<table cellspacing="0" cellpadding="0" border="0" width="100%">
																<tr>
																	<td valign="top" colspan="2" style="padding: 25px; font-size: 13px; font-style: italic;">
																	<br><br>
																	Gallery Art, a full service upscale gallery has been assisting art lovers with their fine art needs within the 20 years that we've been in business.  Ken Hendel, owner and curator of Gallery Art, has always been passionate about buying and selling everything from original oils, mixed medias, limited edition graphics, bronzes and glass sculptures.  Featuring well known artists such as Andy Warhol, Roy Lichtenstein, Tom Wesselmann, Robert Indiana, Peter Max, Salvador Dali, and Leroy Neiman, Gallery Art offers you a courteous and knowledgeable art consultant to assist you with all your art buying needs, including purchases, custom framing, complimentary home viewings and installations, art appraisals and Certificates of Authenticity.
																	<br><br>
																	We will be in touch with you shortly about your quote.
																	<br><br>
																	Sincerely,<br>
																	Ken Hendel
																	</td>
																</tr>
																<tr>
																	<td valign="top" align="center" colspan="2" style="padding: 10px;">
																		<a href="index.cfm?xss=#xss#" style="font-size: 13px;">CLICK TO ADD ANOTHER PIECE</a></td>
																	</td>
																</tr>
																
															</table>
														</div>
													</cfif>
												<cfelse>

												<cfform method="post" action="#script_name#?xss=#xss#" name="quoteForm" enctype="multipart/form-data" onsubmit="return validateFrm()">
													<input type="hidden" name="submitted" value="1" />
													<input	type="hidden" name="captcha_check"	value="#FORM.captcha_check#" />
													<div class="top-heading">
														<h3>GUEST LIST</h3>
													</div>
													<cfif FORM.captchaError EQ 1>
														<span style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</span><br><br>
													</cfif>
													<cfif FORM.errorPhone EQ 1>
														<span style="color: ##ff0000; font-weight: bold;">
															#form.errorMsg#
														</span><br><br>
													</cfif>
													<p>Please sign our Guest Book for upcoming shows and information, and to be placed on our Mailing List.</p>

													<div class="input-form">
														<div class="input-field">
															<label>First Name:</label>
															<input type="Text" name="fname"  value="#form.fname#" size="40" />&nbsp;<span style="color:##ff0000;">* Required</span>
														</div>
														<div class="input-field">
															<label>Last Name:</label>
															<input type="Text" name="lname"  value="#form.lname#" size="40" />&nbsp;<span style="color:##ff0000;">* Required</span>
														</div>
														<div class="input-field">
															<label>Email Address:</label>
															<input type="Text" name="email"  value="#form.email#" size="40" />&nbsp;<span style="color:##ff0000;">* Required</span>
														</div>
														<div class="input-field">
															<span style="color:##ff0000; margin-bottom: 5px; display: block;">One phone number is required:</span>
															<label>Phone Number:</label>
															<cfinput type="Text" name="phone" value="#form.phone#" size="40" mask="(999) 999-9999" /> <span>(xxx) xxx-xxxx</span>
														</div>
														<div class="input-field">
															<label>Cell Number:</label>
															<cfinput type="Text" name="cell" value="#form.cell#" size="40" mask="(999) 999-9999" /> <span>(xxx) xxx-xxxx</span>
														</div>
														<div class="input-field">
															<label>Number Outside the US:</label>
															<input type="Text" name="otherphone" value="#form.otherphone#" size="40" />
														</div>
														<div class="input-field">
															<label>Artist:</label>
															<input type="Text" name="artist" value="#form.artist#" size="40" />&nbsp;<span style="color:##ff0000;">* Required</span>
														</div>
														<div class="input-field">
															<label>Title:</label>
															<input type="Text" name="title" value="#form.title#" size="40" />&nbsp;<span style="color:##ff0000;">* Required</span>
														</div>
														<div class="input-field">
															<label>Medium:</label>
															<input type="Text" name="medium" value="#form.medium#" size="40" />&nbsp;&nbsp;<a href="##TB_inline?height=600&width=550&inlineId=medium_help&modal=true" class="thickbox" style="color: ##dd3a7d; text-decoration: underline;">Help?</a>
														</div>
														<div class="input-field">
															<label>Graphics/Prints:</label>
															<input type="Text" name="graphics" value="#form.graphics#" size="40" />
															<input type="Text" name="edition" value="#form.edition#" size="5" />&nbsp;<span>Edition ##</span>
														</div>
														<div class="input-field">
															<label>Signature:</label>
															<cfif form.signature EQ "Hand Signed">
																<div class="checkbox">
																	<div class="checkbox-field">
																		<input type="radio" name="signature" value="Hand Signed" checked><label>hand signed</label>
																	</div>
																	<div class="checkbox-field">
																		<input type="radio" name="signature" value="Plate Signed"><label>plate signed</label>
																	</div>
																</div>
															<cfelseif form.signature EQ "Plate Signed">
																<div class="checkbox">
																	<div class="checkbox-field">
																		<input type="radio" name="signature" value="Hand Signed"><label>hand signed</label>
																	</div>
																	<div class="checkbox-field">
																		<input type="radio" name="signature" value="Plate Signed" checked><label>plate signed</label>
																	</div>
																</div>
															<cfelse>
																<div class="checkbox">
																	<div class="checkbox-field">
																		<input type="radio" name="signature" value="Hand Signed" checked><label>hand signed</label>
																	</div>
																	<div class="checkbox-field">
																		<input type="radio" name="signature" value="Plate Signed"><label>plate signed</label>
																	</div>
																	
																	
																</div>
															</cfif>
															<label><a href="##TB_inline?height=600&width=550&inlineId=signature_help&modal=true" class="thickbox" style="color: ##dd3a7d; text-decoration: underline;">Help?</a>
														</div>
														<div class="input-field">
															<label>Unframed Size: <span>(Height x Width)</span></label>
															<input type="Text" name="size" value="#form.size#" size="40" />
														</div>
														<div class="input-field">
															<label>Sculpture: <span>(Height x Width x Depth)</span></label>
															<input type="Text" name="sculpture" value="#form.sculpture#" size="40" />
														</div>
														<div class="input-field">
															<label>Year:</label>
															<input type="Text" name="year" value="#form.year#" size="40" />
														</div>
														<div class="input-field">
															<label>Brief Description:</label>
															<textarea name="description" rows="3" cols="35">#form.description#</textarea>
														</div>
														<div class="choose-field input-field">
															<label>Upload Picture:</label>
															<input type="File" name="pictureUpload" id="pictureUpload" />&nbsp;<span style="color:##ff0000;">* Required</span>
														</div>
														<div class="input-field">
															<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low"	fonts="verdana,arial,times new roman,courier" fontsize="28"	/>
															<span id="captchaError" style="color: ##ff0000; font-weight: bold; display:none;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</span>
															<label><b>Please enter the characters in the image above:</b></label>
															<span id="captchaCopy"></span><br>
															<input type="text" name="captcha" id="captcha" />&nbsp;<span style="color:##ff0000;">* Required</span>
														</div>
														<div class="input-button">
															<button type="submit" class="SeeMore" style="cursor: pointer;">Send</button>
														</div>
														<div>
															<a href="completed_form.cfm" target="_blank" class="SeeMore" 
																style=" text-align: center; max-width: max-content;margin: auto;padding: 0 10px;"
																>
																Click here to see a sample form filled out.
															</a>
														</div>
													</div>
												</cfform>

												</cfif>
											</cfoutput>

											<div id="medium_help" style="display: none;">
												<div style="float: right;"><a href="#" onclick="tb_remove();" style="color: #dd3a7d; font-weight: bold; font-size: 11px; text-decoration: none;">CLOSE</a><br><br></div>
												<div style="clear: both; overflow-y: scroll; height: 350px;">
													<p>
														<cfinclude template="art_terminology.html">
													</p>
												</div>
											</div>
											<div id="signature_help" style="display: none;">
												<div style="float: right;"><a href="#" onclick="tb_remove();" style="color: #dd3a7d; font-weight: bold; font-size: 11px; text-decoration: none;">CLOSE</a><br><br></div>
												<div style="clear: both; padding-top: 10px; overflow-y: scroll; height: 350px;">
													<p>
														<cfinclude template="signature_help.html">
													</p>
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