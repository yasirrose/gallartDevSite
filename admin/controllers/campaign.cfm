

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/campaign" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "bios">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfcase value="campaign_manage">

		<!--- include main top layout --->
		<cfinclude template="../views/layout.top.cfm" />
  
    	<cfscript>
			getAllArtists	= application.objectFactoryAdmin.getInstance('artists').getAllArtists();
		</cfscript>

		<cfinclude template="#ViewPath#/campaign_manage.cfm">

		<!--- include main bottom layout --->
		<cfinclude template="../views/layout.bottom.cfm" />
		
	</cfcase>

	
	<cfcase value="show_campaign">
		<cfparam name="url.campaignId" default="" />
		<cfparam name="form.campaignId" default="#url.campaignId#" />
  
		<cfscript>
			getCampaign	= application.objectFactoryAdmin.getInstance('campaign').getCampaign(form.campaignId);
		</cfscript>
		
		<cfinclude template="#ViewPath#/show_campaign.cfm">

	</cfcase>

	<cfcase value="edit_campaign">

		<cfscript>
			editCampaign	= application.objectFactoryAdmin.getInstance('campaign').editCampaign(argumentcollection=form);
		</cfscript>

		<cfif isDefined('form.icon') and form.icon NEQ "">

		
			<!--- <cffile action="upload" nameconflict="OVERWRITE" filefield="icon" destination="#expandpath('.')#\views\campaign\campaign-icon.png" result="fileupload"> --->

			<cffile action="upload" nameconflict="OVERWRITE" filefield="icon" destination="#expandpath('.')#\views\campaign\icons\campaign-icon-#form.pk_campaign#.png" result="fileupload">

		</cfif>
		
		<cflocation addtoken="no" url="./admin/index.cfm?event=campaign.show_campaign&campaignId=#form.pk_campaign#">

	</cfcase>
	

	<cfcase value="campaign_list">

		<cfparam name="url.campaignId" default="" />
		<cfparam name="form.campaignId" default="#url.campaignId#" />

		<cfscript>
			getCampaignListings	= application.objectFactoryAdmin.getInstance('campaign').getCampaignListings(campaignId = url.campaignId);
		</cfscript>

		<cfinclude template="#ViewPath#/campaign_list.cfm">

	</cfcase>

	<cfcase value="update_campaign_list">

		<cfscript>
			updateCampaignListings	= application.objectFactoryAdmin.getInstance('campaign').updateCampaignListings(argumentcollection=form);
		</cfscript>

	</cfcase>

	<cfcase value="delete_campaign_listing">

		<cfscript>
    		deleteCampaignListing	= application.objectFactoryAdmin.getInstance('campaign').deleteCampaignListing(form.delId);
    	</cfscript>

	</cfcase>

	<cfdefaultcase>

		<!--- include main top layout --->
		<cfinclude template="../views/layout.top.cfm" />
    
		<cfinclude template="#ViewPath#/index.cfm">

		<!--- include main bottom layout --->
		<cfinclude template="../views/layout.bottom.cfm" />
		
	</cfdefaultcase>
	
	
</cfswitch>

