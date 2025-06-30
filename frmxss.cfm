<form name="frmxss" action="" method="post">
	<cfif structKeyExists(session, "xss") AND len(trim(session.xss))>
		<cfoutput>
			<input type="hidden" name="xss" value="#session.xss#">
				<cfif parameterexists(url.cat) and not parameterexists(keywords)>
					<input type="hidden" name="tcat" value="#url.cat#">
				<cfelseif parameterexists(keywords)>
					<input type="hidden" name="keywords" value="#keywords#">
				<cfelseif parameterexists(keywords_artist)>
					<input type="hidden" name="keywords_artist" value="#keywords_artist#">
				<cfelseif parameterexists(fam)>
					<input type="hidden" name="fam" value="#fam#">
				</cfif>
		</cfoutput>
	</cfif>
</form>