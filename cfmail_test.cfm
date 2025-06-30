<!--- <cfmail
server="mail2.onlinegalleryart.com"
username="onli16@onlinegalleryart.com"
password="re3objec"
to="ruckerstev@hotmail.com"
from="onli16@onlinegalleryart.com "
subject="Gallery Art Test" type="HTML">
	TEST EMAIL
</cfmail> --->


<cftry>
	<h1>Hello World</h1>
	<cfmail
		server="smtp.gmail.com" 
		username="Sales@GallArt.com"
		password="ylzwtvepstcsammm" 
		to="tldz.dev12@gmail.com"
		from="Sales@GallArt.com"
		subject="Gallery Art Test" 
		port="587" 
		usetls="true"
		type="HTML">
			TEST EMAIL from live site check TLS
	</cfmail>

	<cfcatch>
		<cfdump var="#cfcatch#" abort="true">
	</cfcatch>
</cftry>

