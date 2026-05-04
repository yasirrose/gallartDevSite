
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
		TEST EMAIL after 3.15 pm 
	</cfmail>

	<cfcatch>
		<cfdump var="#cfcatch#" abort="true">
	</cfcatch>
</cftry>

