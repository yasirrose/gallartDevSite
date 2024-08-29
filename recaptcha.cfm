<cfsetting enablecfoutputonly="true">
<!---
	Use the reCAPTCHA API to verify human input.

	reCAPTCHA improves the process of digitizing books by sending words that
    cannot be read by computers to the Web in the form of CAPTCHAs for
    humans to decipher. More specifically, each word that cannot be read
    correctly by OCR is placed on an image and used as a CAPTCHA. This is
    possible because most OCR programs alert you when a word cannot be read
    correctly.

	You will need a key pair from http://recaptcha.net/api/getkey to use this tag.


	Sample 1 - Combined check/render
	--------------------------------

		<html>
		<body>

		<cfform>

			<cf_recaptcha
				privateKey="6LdiMeMSAAAAABVPOug3h-XN2gOgd2nSHDqN_8Oh"
				publicKey="6LdiMeMSAAAAACuh0m6028qJYkiASml7UC_MaW8T">

			<cfinput type="submit" name="submit">

		</cfform>

		<cfif isDefined("form.submit")>
			<cfoutput>recaptcha says #form.recaptcha#</cfoutput>
		</cfif>

		</body>
		</html>


	Sample 2 - Separate check/render
	--------------------------------

		<html>
		<body>

		<cf_recaptcha
				privateKey="6LdiMeMSAAAAABVPOug3h-XN2gOgd2nSHDqN_8Oh"
				publicKey="6LdiMeMSAAAAACuh0m6028qJYkiASml7UC_MaW8T">

		<cfif isDefined("form.submit")>
			<cfoutput>recaptcha says #form.recaptcha#</cfoutput>
		</cfif>

		<cfform>

			<cf_recaptcha
				privateKey="...your private key..."
				publicKey="...your public key...">

			<cfinput type="submit" name="submit">

		</cfform>

		</body>
		</html>


	@param publicKey 	Public key sent from browser with request for a challenge string.
						Note that if this is wrong you will not get a ColdFusion error and
						an error message will appear in place of the reCAPTCHA form controls.

	@param privateKey   Private key sent from ColdFusion server to reCAPTCHA's verification service.

	@param action 		render|check default render.
						"render" checks the submitted form and renders the reCAPTCHA form field.
						"check" checks the submitted form but does not render the form field.

	@param ssl 			set true if form on ssl page to use secured version of reCAPTCHA API and
						avoid browser complaints.

	@param theme 		red|white|blackgrass default red.  Changes look of reCAPTCHA form field.

	@param tabIndex		tabIndex of entry field on form.

	@return				sets form.recaptcha to true/false

	@throws				RECAPTCHA_ATTRIBUTE				Missing or invalid attribute
						RECAPTCHA_NO_SERVICE			Cannot contact verification service
						RECAPTCHA_VERIFICATION_FAILURE	Verification service responded with an error

	@see 				http://recaptcha.net/apidocs/captcha/

	(c) 2008 RocketBoots Pty Ltd
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.

	@version $Id$

--->

<cfscript>
	CHALLENGE_URL = "http://api.recaptcha.net";
	SSL_CHALLENGE_URL = "https://api-secure.recaptcha.net";
	VERIFY_URL = "http://api-verify.recaptcha.net/verify";
</cfscript>

<cfif not structKeyExists(attributes, "publicKey")>
	<cfthrow type="RECAPTCHA_ATTRIBUTE"
		message="recaptcha: required attribute 'publicKey' is missing">
</cfif>

<cfif not structKeyExists(attributes, "privateKey")>
	<cfthrow type="RECAPTCHA_ATTRIBUTE"
		message="recaptcha: required attribute 'privateKey' is missing">
</cfif>

<cftry>
	
	<cfparam name="attributes.action" default="render">
	
	<cfif not listContains("render,check", attributes.action)>
		<cfset sInvalidAttr="action not render|check">
		<cfthrow>
	</cfif>
	
	<cfset sInvalidAttr="ssl not true|false">
	<cfparam name="attributes.ssl" type="boolean" default="false">
	
	<cfparam name="attributes.theme" type="regex" pattern="(red|white|blackglass)" default="blackglass">
	
	<cfif not listContains("red,white,blackglass", attributes.theme)>
		<cfset sInvalidAttr="theme not red|white|blackglass">
		<cfthrow>
	</cfif>
	
	<cfset sInvalidAttr="tabIndex not numeric">
	<cfparam name="attributes.tabIndex" type="numeric" default="0">
	
<cfcatch type="any">
	<cfthrow type="RECAPTCHA_ATTRIBUTE"
		message="recaptcha: attribute #sInvalidAttr#">
</cfcatch>
</cftry>

<cfif isDefined("form.recaptcha_challenge_field") and isDefined("form.recaptcha_response_field")>

	<cftry>
		<cfhttp url="#VERIFY_URL#" method="post" timeout="5" throwonerror="true">
			<cfhttpparam type="formfield" name="privatekey" value="#attributes.privateKey#">
			<cfhttpparam type="formfield" name="remoteip" value="#cgi.REMOTE_ADDR#">
			<cfhttpparam type="formfield" name="challenge" value="#form.recaptcha_challenge_field#">
			<cfhttpparam type="formfield" name="response" value="#form.recaptcha_response_field#">
		</cfhttp>
	<cfcatch>
		<cfthrow  type="RECAPTCHA_NO_SERVICE"
			message="recaptcha: unable to contact recaptcha verification service on url '#VERIFY_URL#'">
	</cfcatch>
	</cftry>

	<cfset aResponse = listToArray(cfhttp.fileContent, chr(10))>
	<cfset form.recaptcha = aResponse[1]>
	<cfset structDelete(form, "recaptcha_challenge_field")>
	<cfset structDelete(form, "recaptcha_response_field")>

	<cfif aResponse[1] eq "false" and aResponse[2] neq "incorrect-captcha-sol">
		<cfthrow type="RECAPTCHA_VERIFICATION_FAILURE"
			message="recaptcha: the verification service responded with error '#aResponse[2]#'. See http://recaptcha.net/apidocs/captcha/ for error meanings.">
	</cfif>

<cfelse>

	<cfset form.recaptcha = false>

</cfif>

<cfif attributes.action eq "render">

	<cfif attributes.ssl>
		<cfset challengeURL = SSL_CHALLENGE_URL>
	<cfelse>
		<cfset challengeURL = CHALLENGE_URL>
	</cfif>

	<cfoutput>
	<script type="text/javascript">
	<!--
		var RecaptchaOptions = {
		   theme : '#attributes.theme#',
		   tabindex : #attributes.tabIndex#
		};
	//-->
	</script>
	<script type="text/javascript"
	   src="#challengeURL#/challenge?k=#attributes.publicKey#">
	</script>
	<noscript>
	   <iframe src="#challengeURL#/noscript?k=#attributes.publicKey#"
	       height="300" width="500" frameborder="0"></iframe><br>
	   <textarea name="recaptcha_challenge_field" rows="3" cols="40">
	   </textarea>
	   <input type="hidden" name="recaptcha_response_field"
	       value="manual_challenge">
	</noscript>
	</cfoutput>

</cfif>

<cfsetting enablecfoutputonly="false">