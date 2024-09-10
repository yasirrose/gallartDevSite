<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/massupdate" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "massupdate">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>
	
		<cfscript>
			getAllMedium = application.objectFactoryAdmin.getInstance('art').getAllMedium();
			getAllSellers 	= application.objectFactoryAdmin.getInstance('users').getUsersListings();
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
		</cfscript>

		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	<cfcase value="results">
		
		<cfscript>
			getAllMedium = application.objectFactoryAdmin.getInstance('art').getAllMedium();
			getAllSellers 	= application.objectFactoryAdmin.getInstance('users').getUsersListings();
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
			if ( structKeyExists(form,'groups')) {
					form.alphaChar = chr(alphaCharNum);
					form.page = form.page;
					form.active = 1;
					form.gallery_only = 1;
					// set required fields
					form.displayFields = 'ModelNo,Artist,Medium,Low,High,Retail,Gallery,Sale,Thumbnail';
			}
			/*else if ( structKeyExists(form,'alphaCharNum')) {
				form.alphaChar = chr(alphaCharNum);
				form.active = 1;
				form.gallery_only = 1;
				// set required fields
				form.displayFields = 'ModelNo,Artist,Medium,Low,High,Retail,Gallery,Sale,Thumbnail';
			}*/
			</cfscript>
			<!---<cfdump var="#form#"><cfabort>--->
			<cfscript>
				
			
			
			getListingsMassUpdate = application.objectFactoryAdmin.getInstance('art').getListingsMassUpdate( argumentcollection=form );
		</cfscript>

		<cfinclude template="#ViewPath#/results.cfm">
	
	</cfcase>
	
	<cfcase value="massUpdateProc">

		
		<cfscript>
			massUpdateProc = application.objectFactoryAdmin.getInstance('art').massUpdateProc( argumentcollection=form );
		</cfscript>

    	<cfif structKeyExists(form,'alphaCharNum')>
        	<cfscript>
				getAllMedium = application.objectFactoryAdmin.getInstance('art').getAllMedium();
				getAllSellers 	= application.objectFactoryAdmin.getInstance('users').getUsersListings();
				getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
				if ( structKeyExists(form,'groups')) {
					form.alphaChar = chr(alphaCharNum);
					if ( structKeyExists(form,'next')){
						form.page = form.page+1;
					}
					if ( structKeyExists(form,'prev')){
						form.page = form.page-1;
					}
					form.active = 1;
					form.gallery_only = 1;
					// set required fields
					form.displayFields = 'ModelNo,Artist,Medium,Low,High,Retail,Gallery,Sale,Thumbnail';
				}
				/*else if ( structKeyExists(form,'alphaCharNum')) {
					form.alphaChar = chr(alphaCharNum);
					form.active = 1;
					form.gallery_only = 1;
					// set required fields
					form.displayFields = 'ModelNo,Artist,Medium,Low,High,Retail,Gallery,Sale,Thumbnail';
				}*/
				getListingsMassUpdate = application.objectFactoryAdmin.getInstance('art').getListingsMassUpdate( argumentcollection=form );
			</cfscript>
        	
        	<cfinclude template="#ViewPath#/results.cfm">
        <cfelse>
        	<cflocation url="index.cfm?event=massupdate" addtoken="No">
        </cfif>
			
	</cfcase>

	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />
