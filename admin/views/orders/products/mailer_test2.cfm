<!--- <form method="post" action="index.cfm?event=orders.mailTest" name="confirmForm">
<input type="submit" name="test
" value="TEST EMAIL"> 
</form>
 --->
<cfmail to="david@consumergroup.com" 
from="info@gallart.com" 
subject="test" 
server="mail2.onlinegalleryart.com" 
username="gallart@onlinegalleryart.com"
password="re3objeC!P"  
type="HTML">
	Test email
</cfmail>

MAIL SENT