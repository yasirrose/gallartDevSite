<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/ebay" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "ebay">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>

		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	<cfcase value="details">
	
		<cfscript>
			getEbay = application.objectFactoryAdmin.getInstance('ebay').getEbay( pk_ebay );
			getEbayUploads = application.objectFactoryAdmin.getInstance('ebay').getEbayUploads( pk_ebay );
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
		</cfscript>
	
		<cfinclude template="#ViewPath#/details.cfm">
	
	</cfcase>
	
	<cfcase value="process">
	
		<cfif structKeyExists(form,'delete')>
		
			<cfscript>
				deleteEbay = application.objectFactoryAdmin.getInstance('ebay').deleteEbay( argumentcollection = form );
			</cfscript>
			
			<cflocation url="index.cfm?event=ebay" addtoken="no">
		
		<cfelse>
	
			<cfscript>
				processEbay = application.objectFactoryAdmin.getInstance('ebay').processEbay( argumentcollection = form );
			</cfscript>
			
			<cflocation url="index.cfm?event=ebay.details&pk_ebay=#processEbay.ebayId#" addtoken="no">
			
		</cfif>
		
		
	
	</cfcase>
	
	<cfcase value="deleteUpload">
	
		<cfscript>
			deleteFile = application.objectFactoryAdmin.getInstance('ebay').deleteFile( uploadId );
		</cfscript>
		
		<cflocation url="index.cfm?event=ebay.details&pk_ebay=#url.ebayId#" addtoken="no">
	
	</cfcase>
	
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />