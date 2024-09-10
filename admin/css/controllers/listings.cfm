<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/listings" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "listings">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>

		<cfscript>
			getAllMedium = application.objectFactoryAdmin.getInstance('art').getAllMedium();
			getAllSellers 	= application.objectFactoryAdmin.getInstance('users').getUsersListings();
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
		</cfscript>
		
		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/index.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
		
	</cfdefaultcase>
	
	<cfcase value="loadEditForm">
	
		<cfif structKeyExists(url,'gridRefresh')>
			<script type="text/javascript">
				top.refreshGrid();
			</script>
		</cfif>
		
		<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
			getAllMedium 	= application.objectFactoryAdmin.getInstance('art').getAllMedium();
		</cfscript>
	
		<cfinclude template="#ViewPath#/editForm.cfm">
	
	</cfcase>
	
	<cfcase value="procListing">
    	<cfset fileSizeLimit = 200000 />
	
		<cfif structKeyExists(form,'Edit')>
		
			<cfif form.Edit EQ 'Delete'>
			
				<cfscript>
					deleteListing = application.objectFactoryAdmin.getInstance('art').deleteListing( argumentcollection = form );
				</cfscript>
				
				<cfif deleteListing EQ false>
				
					<script type="text/javascript">
						alert('There was a problem with the processing.');
					</script>
				
				</cfif>
			
			<cfelse>
            
            	<cfif cgi.content_length GT fileSizeLimit>
        
					<script type="text/javascript">
                        alert('Please limit your file image file upload to 200KB. Please use your browser back button to return to the listing form.');
                    </script>
                    <cfabort>
                    
                </cfif>
			
				<cfscript>
					editListingsFromForm = application.objectFactoryAdmin.getInstance('art').editListingsFromForm( argumentcollection = form );
				</cfscript>
				
				<cfif editListingsFromForm EQ false>
				
					<script type="text/javascript">
						alert('There was a problem with the processing.');
					</script>
				
				</cfif>
			
			</cfif>
			
			<cflocation url="index.cfm?event=listings.loadEditForm&gridRefresh=1" addtoken="No">
		
		</cfif>
	
	</cfcase>
	
	<cfcase value="spreadsheet">
	
		<cfscript>
			getAllMedium = application.objectFactoryAdmin.getInstance('art').getAllMedium();
			getAllSellers 	= application.objectFactoryAdmin.getInstance('users').getUsersListings();
		</cfscript>
	
		<cfinclude template="../views/layout.top.cfm" />
		
		<cfinclude template="#ViewPath#/spreadsheet.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>
	
	<cfcase value="remove_dups">
	
		<cfscript>
			getDups = application.objectFactoryAdmin.getInstance('art').getDups();
		</cfscript>
	
		<cfinclude template="../views/layout.top.cfm" />
		
		<cfinclude template="#ViewPath#/remove_dups.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>
	
	<cfcase value="remove_noimage">
	
		<cfscript>
			getNoimage 	= application.objectFactoryAdmin.getInstance('art').getNoimage();
		</cfscript>
		
		<cfinclude template="../views/layout.top.cfm" />
		
		<cfinclude template="#ViewPath#/remove_noimage.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>
    
    <cfcase value="image_sheets">
    	
        <cfparam name="form.artist" default="" >
	
		<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
			getImagesByArtist 	= application.objectFactoryAdmin.getInstance('art').getImagesByArtist(argumentcollection=form);
		</cfscript>
		
		<cfinclude template="../views/layout.top.cfm" />
		
		<cfinclude template="#ViewPath#/image_sheets.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>
    
    <cfcase value="listings_dev">

		<cfscript>
			getAllMedium = application.objectFactoryAdmin.getInstance('art').getAllMedium();
			getAllSellers 	= application.objectFactoryAdmin.getInstance('users').getUsersListings();
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
		</cfscript>
		
		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/index_dev.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
		
	</cfcase>
    
    <cfcase value="loadEditForm_dev">
	
		<cfif structKeyExists(url,'gridRefresh')>
			<script type="text/javascript">
				top.refreshGrid();
			</script>
		</cfif>
		
		<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
			getAllMedium 	= application.objectFactoryAdmin.getInstance('art').getAllMedium();
		</cfscript>
	
		<cfinclude template="#ViewPath#/editForm_dev.cfm">
	
	</cfcase>
    
    <cfcase value="procListing_dev">
	
		<cfif structKeyExists(form,'Edit')>
		
			<cfif form.Edit EQ 'Delete'>
			
				<cfscript>
					deleteListing = application.objectFactoryAdmin.getInstance('art').deleteListing( argumentcollection = form );
				</cfscript>
				
				<cfif deleteListing EQ false>
				
					<script type="text/javascript">
						alert('There was a problem with the processing.');
					</script>
				
				</cfif>
			
			<cfelse>
			
				<cfscript>
					editListingsFromForm = application.objectFactoryAdmin.getInstance('art').editListingsFromFormDev( argumentcollection = form );
				</cfscript>
				
				<cfif editListingsFromForm EQ false>
				
					<script type="text/javascript">
						alert('There was a problem with the processing.');
					</script>
				
				</cfif>
			
			</cfif>
			
			<cflocation url="index.cfm?event=listings.loadEditForm_dev&gridRefresh=1" addtoken="No">
		
		</cfif>
	
	</cfcase>
    
</cfswitch>

