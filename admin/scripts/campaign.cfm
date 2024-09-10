

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/campaign" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "bios">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	
	<cfcase value="show_campaign">

		<cfscript>
			getCampaign	= application.objectFactoryAdmin.getInstance('campaign').getCampaign();
		</cfscript>
		
		<cfinclude template="#ViewPath#/show_campaign.cfm">

	</cfcase>

	<cfcase value="update_campaign">

		<cfscript>
			updateCampaign	= application.objectFactoryAdmin.getInstance('campaign').updateCampaign(argumentcollection=form);
		</cfscript>

		<cfif isDefined('form.icon') and form.icon NEQ "">

		
			<cffile action="upload" nameconflict="OVERWRITE" filefield="icon" destination="#expandpath('.')#\views\campaign\campaign-icon.png" result="fileupload">

		</cfif>
		
		<cflocation addtoken="no" url="http://#server_name#/admin/index.cfm?event=campaign.show_campaign">

	</cfcase>
	

	<cfcase value="campaign_list">

		<cfscript>
			getCampaignListings	= application.objectFactoryAdmin.getInstance('campaign').getCampaignListings(campaignId = 1);
		</cfscript>

		<cfinclude template="#ViewPath#/campaign_list.cfm">

	</cfcase>

	<cfcase value="update_campaign_list">

		here

		<cfabort>

		<cfdump var="#form#">

		<cflocation addtoken="no" url="http://#server_name#/admin/index.cfm?event=campaign.campaign_list">

	</cfcase>

	<cfdefaultcase>

		<!--- include main top layout --->
		<cfinclude template="../views/layout.top.cfm" />
    
    	<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
		</cfscript>

		<cfinclude template="#ViewPath#/index.cfm">

		<!--- include main bottom layout --->
		<cfinclude template="../views/layout.bottom.cfm" />
		
	</cfdefaultcase>
	
	
</cfswitch>

