<!--- <cfquery name="data" datasource="#dsource#">
	select * from mailer
</cfquery>

<cfoutput>#data.recordcount#</cfoutput>  --->

<!--- <cfquery name="data" datasource="#dsource#">
	sp_mailer
</cfquery> --->

<cfstoredproc procedure="sp_mailer" datasource="#dsource#">

</cfstoredproc>