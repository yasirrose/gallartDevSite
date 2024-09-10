

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/cameras" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "bios">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">


	<cfdefaultcase>

		<!--- include main top layout --->
		<cfinclude template="../views/layout.top.cfm" />

		<cfscript>
			getCameras = application.objectFactoryAdmin.getInstance('cameras').getCameras();
		</cfscript>
    
		<cfinclude template="#ViewPath#/index.cfm">

		<!--- include main bottom layout --->
		<cfinclude template="../views/layout.bottom.cfm" />
		
	</cfdefaultcase>

	<cfcase value="edit">

		<cfscript>
			editCameras = application.objectFactoryAdmin.getInstance('cameras').editCameras( argumentcollection=form );
		</cfscript>

		<cflocation url="index.cfm?event=cameras" addtoken="no">

	</cfcase>
	
	
</cfswitch>

