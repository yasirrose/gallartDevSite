<cfset jscript = 0>

<!---write a cookie using javascript--->
<script type="text/javascript">
document.cookie = 'JSTEST=1; path=/; ';
</script>

<!---check for the cookie, set the flag for the app, then toggle the variable in the cookie--->
<cfif ISDEFINED('COOKIE.jstest')>
	<cfif COOKIE.jstest EQ 1>
		<cfset jscript = 1>
		<cfcookie name="jstest" value="0">
	</cfif>
</cfif>

<!--- Kill extra output. --->
<cfsilent>
	<cfparam name="form.fname" default="">	
	<cfparam name="form.lname" default="">						
	<cfparam name="form.comments" default="">
	<cfparam name="form.email" default="">
	<cfparam name="form.phone" default="">
	<cfparam name="form.cell" default="">
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
 
	<!--- Check to see if the form has been submitted. --->
	<cfif FORM.submitted>

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
	validateCaptcha = function(){
		var errorMsg = "";
		if(isEmail(document.quoteForm.email.value) == false) errorMsg += "Please enter a proper email.\n"
		//if($("#pictureUpload").val() == "") errorMsg += "Please upload a picture.\n"
		if($("#captcha").val() == "") errorMsg += "Please enter the characters in the image.\n"
		if(errorMsg == ""){
		   $.ajax({
			  url:"quotes/quotes_decrypt.cfm?c=<cfoutput>#FORM.captcha_check#</cfoutput>",  
			  success:function(data) {
				  if(jstrim(data) == $("#captcha").val().toUpperCase()){
					  $("#quoteForm").submit();
				  } else {
					  $("#captchaCopy").hide();
					  $("#captchaError").show();
				  }
			  }
		  });
		  return false;
		} else {
			alert(errorMsg);
			return false;
		}
	}
	// -->
</script>
<!--- thickbox --->
<script language="JavaScript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/jquery-1.3.2.js"></script>
<script type="text/javascript" src="../js/thickbox-compressed.js"></script>
<link rel="stylesheet" href="../css/thickbox.css" type="text/css" media="screen" />
<style>
	#TB_ajaxContent.TB_modal {
	height: 400px !important;
}
</style>

<table cellspacing="0" cellpadding="0" border="0" width="100%">
<cfoutput>
<form method="post" action="#script_name#?xss=#xss#" name="errorFrm">
	<input type="Hidden" name="fname">
	<input type="Hidden" name="lname">
	<input type="Hidden" name="email">
	<input type="Hidden" name="phone">
	<input type="Hidden" name="comments">
	<input type="Hidden" name="captchaError" value="1">
</form>
</cfoutput>
	<tr>
		<td>
			<cfoutput>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2" align="center" valign="top" style="font-size: 20px; font-weight: bold; padding-top: 10px; height: 40px;">
						Free Quote Form
					</td>
				</tr>
			</table>
			<cfif NOT structKeyExists(url,'proc')>
			<cfform method="post" action="quotes/quote_proc.cfm?xss=#xss#" onsubmit="return validateCaptcha()" name="quoteForm" id="quoteForm" enctype="multipart/form-data">
            <input type="hidden" name="jscript" value="#jscript#" />
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2" width="100%" valign="top" align="center">
						<table cellspacing="0" cellpadding="10" border="0" width="600">
							<tr>
								<td align="right" valign="top" width="150">
									First Name:
								</td>
								<td width="500" valign="top">
									<cfinput type="Text" name="fname" value="" required="Yes" message="Please enter your first name." size="40" />&nbsp;<span style="color:##ff0000;">* Required Field</span>
								</td>
							</tr>
							<tr>
								<td align="right">
									Last Name:
								</td>
								<td>
									<cfinput type="Text" name="lname" value="" size="40" required="Yes" message="Please enter your last name." />&nbsp;<span style="color:##ff0000;">* Required Field</span>
								</td>
							</tr>
							<tr>
								<td align="right">
									Email Address:
								</td>
								<td>
									<cfinput type="Text" name="email" value="" size="40" required="Yes" message="Please enter your email address." />&nbsp;<span style="color:##ff0000;">* Required Field</span>
								</td>
							</tr>
			
							<tr>
								<td align="right">
									Phone Number:
								</td>
								<td>
									<cfinput type="Text" name="phone" value="" size="40" required="Yes" message="Please enter your phone number." />&nbsp;<span style="color:##ff0000;">* Required Field</span>
								</td>
							</tr>
							<tr>
								<td align="right">
									Cell Number:
								</td>
								<td>
									<cfinput type="Text" name="cell" value="" size="40" required="No" message="Please enter your cell number." />
								</td>
							</tr>
							<tr>
								<td align="right">
									Artist:
								</td>
								<td>
									<cfinput type="Text" name="artist" value="" size="40" required="Yes" message="Please enter the artist." />&nbsp;<span style="color:##ff0000;">* Required Field</span>
								</td>
							</tr>
							<tr>
								<td align="right">
									Title:
								</td>
								<td>
									<cfinput type="Text" name="title" value="" size="40" required="Yes" message="Please enter the title." />&nbsp;<span style="color:##ff0000;">* Required Field</span>
								</td>
							</tr>
							<tr>
								<td align="right">
									Medium:
								</td>
								<td>
									<cfinput type="Text" name="medium" value="" size="40" required="No" message="Please enter the medium." />&nbsp;&nbsp;<a href="##TB_inline?height=600&width=550&inlineId=medium_help&modal=true" class="thickbox" style="color: ##dd3a7d; text-decoration: underline;">Help?</a>
								</td>
							</tr>
							<tr>
								<td align="right">
									Graphics/Prints:
								</td>
								<td>
									<cfinput type="Text" name="graphics" value="" size="40" required="No" message="Please enter Graphics/Prints." />&nbsp;<input type="Text" name="edition" size="5" />&nbsp;Edition ##
								</td>
							</tr>
							<tr>
								<td align="right">
									Signature:
								</td>
								<td>
									<input type="radio" name="signature" value="Hand Signed" checked>&nbsp;hand signed&nbsp;&nbsp;<input type="radio" name="signature" value="Plate Signed">&nbsp;plate signed&nbsp;&nbsp;<a href="##TB_inline?height=600&width=550&inlineId=signature_help&modal=true" class="thickbox" style="color: ##dd3a7d; text-decoration: underline;">Help?</a>
								</td>
							</tr>
							<tr>
								<td align="right">
									Unframed Size:
								</td>
								<td>
									<cfinput type="Text" name="size" value="" size="40" required="No" message="Please enter the unframed size." />&nbsp;&nbsp;Height x Width
								</td>
							</tr>
							<tr>
								<td align="right">
									Sculpture:
								</td>
								<td>
									<cfinput type="Text" name="sculpture" value="" size="40" required="No" message="Please enter the Sculpture size." />&nbsp;&nbsp;Height x Width x Depth
								</td>
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
								<td align="right" valign="top">
									Brief Description:
								</td>
								<td>
									<textarea name="description" rows="3" cols="35"></textarea>
								</td>
							</tr>
							<tr>
								<td align="right">
									Upload Picture:
								</td>
								<td>
									<cfinput type="File" name="pictureUpload" id="pictureUpload" required="Yes" message="You must upload a picture.">&nbsp;<span style="color:##ff0000;">* Required Field</span>
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low"	fonts="verdana,arial,times new roman,courier" fontsize="28"	/>
                                <br><br>
                                <span id="captchaError" style="color: ##ff0000; font-weight: bold; display:none;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</span>
                                <span id="captchaCopy"><b>Please enter the characters in the image above:</b></span><br><br>
                                <cfinput type="text" name="captcha" id="captcha" required="true" message="Please enter the characters in the image.">
                                
                                </td>
                            </tr>
							<tr>
								<td colspan="2" style="padding: 0px 100px 20px 0;" align="center">
									<input type="Submit" value="Submit" style="background-color: ##000000; color: ##ffffff; width: 75px; height: 20px; padding-bottom: 8px; font-weight: bold;">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td align="center" style="padding: 10px 75px 0px 0px;">
						<a href="quotes/completed_form.cfm" target="_blank" style="font-size: 13px;color: ##dd3a7d; text-decoration: none;">Click here to see a sample form filled out.</a>
					</td>
				</tr>
			</table> 
			</cfform>
			
			<cfelse>
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
						<a href="quotes.cfm?xss=#xss#" style="font-size: 13px;">CLICK TO ADD ANOTHER PIECE</a></td>
					</td>
				</tr>
				
			</table>
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


		</td>
	</tr>
</table>