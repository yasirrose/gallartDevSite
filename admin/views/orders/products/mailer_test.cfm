<!--- <form method="post" action="index.cfm?event=orders.mailTest" name="confirmForm">
<input type="submit" name="test
" value="TEST EMAIL"> 
</form>
 --->
<cfmail to="steverucker@gmail.com" 
from="info@gallart.com" 
subject="test" 
server="#application.mailserver#" 
username="#application.mailserver_un#"
password="#application.mailserver_pw#"  
type="HTML">
	Test email 2
</cfmail>

MAIL SENT