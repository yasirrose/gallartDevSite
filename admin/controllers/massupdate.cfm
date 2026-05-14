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
			getAllArtType = application.objectFactoryAdmin.getInstance('art').getAllArtType();
			getAllArtSize = application.objectFactoryAdmin.getInstance('art').getAllArtSize();
			getAllArtSubject = application.objectFactoryAdmin.getInstance('art').getAllArtSubject();
			getAllSellers 	= application.objectFactoryAdmin.getInstance('users').getUsersListings();
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
		</cfscript>

		<cfinclude template="#ViewPath#/index.cfm">
		
	</cfdefaultcase>
	
	<cfcase value="results">
		
		<cfscript>
			hasSearchFilters = false;
			isChunkedEmptySearch = false;
			chunkStart = 1;

			getAllMedium = application.objectFactoryAdmin.getInstance('art').getAllMedium();
			getAllSellers 	= application.objectFactoryAdmin.getInstance('users').getUsersListings();
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
			getAllArtType = application.objectFactoryAdmin.getInstance('art').getAllArtType();
			getAllArtSize = application.objectFactoryAdmin.getInstance('art').getAllArtSize();
			getAllArtSubject = application.objectFactoryAdmin.getInstance('art').getAllArtSubject();

			if (NOT structKeyExists(form,'groups')) {
				hasSearchFilters =
					(structKeyExists(form,'modelno') AND len(trim(form.modelno))) OR
					(structKeyExists(form,'name') AND len(trim(form.name))) OR
					(structKeyExists(form,'manufacturer') AND len(trim(form.manufacturer))) OR
					(structKeyExists(form,'path') AND len(trim(form.path))) OR
					(structKeyExists(form,'artType') AND len(trim(form.artType))) OR
					(structKeyExists(form,'artTypee') AND len(trim(form.artTypee))) OR
					(structKeyExists(form,'artSize') AND len(trim(form.artSize))) OR
					(structKeyExists(form,'artSubject') AND len(trim(form.artSubject))) OR
					(structKeyExists(form,'year') AND len(trim(form.year))) OR
					(structKeyExists(form,'height') AND len(trim(form.height))) OR
					(structKeyExists(form,'width') AND len(trim(form.width))) OR
					(structKeyExists(form,'caption') AND len(trim(form.caption))) OR
					(structKeyExists(form,'fromPrice') AND len(trim(form.fromPrice))) OR
					(structKeyExists(form,'toPrice') AND len(trim(form.toPrice))) OR
					(structKeyExists(form,'fromDate') AND len(trim(form.fromDate))) OR
					(structKeyExists(form,'toDate') AND len(trim(form.toDate))) OR
					(structKeyExists(form,'fromLastEdit') AND len(trim(form.fromLastEdit))) OR
					(structKeyExists(form,'toLastEdit') AND len(trim(form.toLastEdit))) OR
					(structKeyExists(form,'sellerId') AND len(trim(form.sellerId))) OR
					(structKeyExists(form,'active') AND trim(form.active) NEQ "1") OR
					(NOT structKeyExists(form,'gallery_only')) OR
					(structKeyExists(form,'promotion') AND listFind(trim(form.promotion), '1')) OR
					(structKeyExists(form,'onSale') AND listFind(trim(form.onSale), '1')) OR
					(structKeyExists(form,'trump') AND listFind(trim(form.trump), '1')) OR
					(structKeyExists(form,'auction') AND listFind(trim(form.auction), '1')) OR
					(structKeyExists(form,'slideshow') AND listFind(trim(form.slideshow), '1')) OR
					(structKeyExists(form,'frontshow') AND listFind(trim(form.frontshow), '1')) OR
					(structKeyExists(form,'bottomHome') AND listFind(trim(form.bottomHome), '1'));

				isChunkedEmptySearch =
					(structKeyExists(form,'chunkMode') AND isNumeric(form.chunkMode) AND val(form.chunkMode) EQ 1) OR
					(NOT hasSearchFilters);

				if (isChunkedEmptySearch) {
					if (structKeyExists(form,'chunkStart') AND isNumeric(form.chunkStart) AND val(form.chunkStart) GT 0) {
						chunkStart = val(form.chunkStart);
					} else if (structKeyExists(form,'number_records') AND isNumeric(form.number_records) AND val(form.number_records) GT 0) {
						chunkStart = val(form.number_records);
					}

					form.chunkMode = 1;
					form.chunkStart = chunkStart;
					form.chunkSize = 50;
					form.number_records = chunkStart;
				}
			}

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
				// getAllArtType = application.objectFactoryAdmin.getInstance('art').getAllArtType();
				// getAllArtSize = application.objectFactoryAdmin.getInstance('art').getAllArtSize();
				// getAllArtSubject = application.objectFactoryAdmin.getInstance('art').getAllArtSubject();
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
