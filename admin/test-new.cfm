<cfsetting requesttimeout="8000000000000000">
<cfquery name="qListings" datasource="#application.dsource#">
	 	SELECT count(*) 
	      	FROM products P
			LEFT OUTER JOIN users U on P.fk_users = U.pk_users
</cfquery>
<cfdump var="#qListings#" >