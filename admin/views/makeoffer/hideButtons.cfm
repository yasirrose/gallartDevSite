<cfsilent>

<cfif structKeyExists(form,'mo_formval')>
	<cfquery name="makeoffer_buttons" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		UPDATE makeoffer_buttons SET
		show = #form.mo_formval#
		where pk_makeoffer_buttons = 1
	</cfquery>
</cfif>

<cfquery name="makeoffer_buttons" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT show FROM makeoffer_buttons
	WHERE pk_makeoffer_buttons = 1
</cfquery>

<cfif makeoffer_buttons.show EQ 1>
	<cfset mo_formtxt = "HIDE MAKE OFFER BUTTONS" />
	<cfset mo_formval = 0 />
<cfelse>
	<cfset mo_formtxt = "SHOW MAKE OFFER BUTTONS" />
	<cfset mo_formval = 1 />
</cfif>
</cfsilent>
<div style="margin:0;padding:0;border:0;">
<cfoutput>
<form method="post" action="">
	<input type="hidden" name="mo_formval" value="#mo_formval#">
	<input type="submit" value="#mo_formtxt#" style="cursor: pointer;" />
</form>
</cfoutput>
</div>

