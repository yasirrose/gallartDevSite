<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/mail_log" />
	
<cfswitch expression="#Action#">

	<!--- DEFAULT PAGE --->

	<cfdefaultcase>
	
		<cfscript>
			getMail = application.objectFactoryAdmin.getInstance('mail_log').getMail(#url.pk_employees#,#url.pk_modules#,#url.moduleId#);
		</cfscript>

		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	<cfcase value="replyMail">
	
	<div style="float: right;">
		<a href="#" onclick="parent.closeReplyMail()" style="font-family: Arial; font-size: .7em; font-weight: bold; color: #000;">CLOSE</a><br><br>
	</div>
	<div style="clear: both;">
		Subject: <input type="Text" name="replyMailSubject" size="40"><br><br>
	</div>
	<div>
		<textarea name="replyMailBody" rows="15" cols="38"></textarea>
	</div>
	<div style="clear: both; text-align: center;">
		<input type="Button" value="SUBMIT" onclick="parent.closeReplyMail()">
	</div>
	</cfcase>
	
</cfswitch>

<!--- include main bottom layout --->
