<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/exports" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "exports">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfdefaultcase>
	
		<cfinclude template="../views/layout.top.cfm" />
	
		<cfinclude template="#ViewPath#/index.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
		
	</cfdefaultcase>
	
	<cfcase value="artistsXls">
	
		<cfinclude template="../views/layout.top.cfm" />
	
		<cfinclude template="#ViewPath#/export_inventory_artists_xls.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>
	
	<cfcase value="createXlsFile">

		<cfscript>
			getExcelListingsByArtist = application.objectFactoryAdmin.getInstance('art').getExcelListingsByArtist( url.artists );
		</cfscript>	
	
		<cfinclude template="#ViewPath#/create_xls_file.cfm">
	
	</cfcase>

	<cfcase value="createXlsFileSelected">
		
		<cfscript>
			getExcelListingsBySelected = application.objectFactoryAdmin.getInstance('art').getExcelListingsBySelected(url.active);
		</cfscript>
	
		<cfinclude template="#ViewPath#/create_xls_file_selected.cfm">
	
	</cfcase>
	
	<cfcase value="artistsCsv">
	
		<cfinclude template="../views/layout.top.cfm" />
	
		<cfinclude template="#ViewPath#/export_inventory_artists.csv.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>
	
	<cfcase value="selected">
	
		<cfinclude template="../views/layout.top.cfm" />
	
		<cfinclude template="#ViewPath#/export_inventory_selected.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>
	
	<cfcase value="allUsers">
	
		<cfinclude template="../views/layout.top.cfm" />
	
		<cfinclude template="#ViewPath#/export_all_users.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>

	<cfcase value="allUsersPhone">
	
		<cfinclude template="../views/layout.top.cfm" />
	
		<cfinclude template="#ViewPath#/export_all_users_withphone.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>
	
	<cfcase value="mailinglist">
	
		<cfinclude template="../views/layout.top.cfm" />
		
		<cfscript>
			getImportList	 		= application.objectFactoryAdmin.getInstance('email').getImportList();
		</cfscript>
	
		<cfinclude template="#ViewPath#/export_mailinglist.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>
	
	<cfcase value="emailCompile">
	
		<cfinclude template="#ViewPath#/email_compile.cfm">
	
	</cfcase>
	
	<cfcase value="insertLoop">
	
		<cfinclude template="#ViewPath#/insert_loop.cfm">
	
	</cfcase>
	
	<cfcase value="insertMailinglist">
	
		<cfinclude template="#ViewPath#/insert_mailinglist.cfm">
	
	</cfcase>
	
	<cfcase value="compiledEmails">
	
		<cfinclude template="../views/layout.top.cfm" />
	
		<cfinclude template="#ViewPath#/compiled_emails.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>
    
    <cfcase value="exportLeads">
    
    	<cfscript>
			getLeads = application.objectFactoryAdmin.getInstance('leads').getLeadsFromEmployeeId( session.userInfo.pk_employees );
		</cfscript>
	
		<cfinclude template="../views/leads/manage/exportLeads.cfm">
		
	</cfcase>
	
	<cfcase value="phonelist">
	
		<cfinclude template="../views/layout.top.cfm" />
	
		<cfinclude template="#ViewPath#/export_phonelist.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>

	<cfcase value="artistinfo">
	
		<cfinclude template="../views/layout.top.cfm" />

		<cfscript>
			getAllArtists = application.objectFactoryAdmin.getInstance('artists').getAllArtists();
		</cfscript>
	
		<cfinclude template="#ViewPath#/export_artistinfo.cfm">
		
		<cfinclude template="../views/layout.bottom.cfm" />
	
	</cfcase>
	
</cfswitch>

