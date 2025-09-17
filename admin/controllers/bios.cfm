<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/bios" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "bios">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>

<cfset getAllGallartArtists	= application.objectFactoryAdmin.getInstance('artists').getAllGallartArtists()>

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
