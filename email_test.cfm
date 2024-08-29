<cfif isDefined('form.sender')>

<CFMAIL
server="#servername#"
from="#form.sender#"
to="ruckerstev@hotmail.com"
subject="Gallart Test Email" type="HTML">
TESTING from #sender# . . .
<br><br>
info@gallart.com
</cfmail>
</cfif>
<!--- <cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="ruckerstev@hotmail.com" from="onli16@onlinegalleryart.com" subject="Gallery Art TEST" type="HTML">

info@gallart.com
</cfmail>
 --->

 
 <form method="post" action="">
 
 
 <input type="text" name="sender">
 
 <input type="Submit">
 
 </form>