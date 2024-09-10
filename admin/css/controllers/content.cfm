<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/content" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "content">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>

<cfswitch expression="#Action#">
	<cfcase value="editor">
		<cfinclude template="#ViewPath#/editor.cfm">
	</cfcase>

	<cfdefaultcase>
		<cfinclude template="../views/layout.top.cfm" />
		<cfinclude template="#ViewPath#/index.cfm">
		<cfinclude template="../views/layout.bottom.cfm" />
	</cfdefaultcase>
</cfswitch>
