<!---<cfquery
   datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#"
   name="MailList">
   SELECT *
   FROM mailer
</cfquery>
<cfdump var="#MailList#" /><cfabort>--->
<iframe frameborder="1" id="trickler" src=""></iframe>
<br>
<input type="Button" value="SEND EMAILS" onclick="document.getElementById('trickler').src='http://www.gallart.com/admin/views/email/mailtrickler.cfm'" />
<input type="Button" value="CLOSE WINDOW" onclick="document.getElementById('trickler').src=''" />
