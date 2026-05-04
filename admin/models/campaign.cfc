<cfcomponent>

<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="campaign">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>

	<cffunction name="getCampaigns" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		
		<cfset var qCampaigns='' />
		
	   	<cfquery name="qCampaigns" datasource="#application.dsource#">
	      	SELECT title as campaign_title,*
	      	FROM campaign
			<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY pk_campaign
	      	</cfif>
	   	</cfquery>
		
		<cfif qCampaigns.recordcount EQ 0><cfset pagesize = 0 /></cfif>
	   	
   		<cfreturn queryconvertforgrid(qCampaigns,page,pagesize)/>
	
	</cffunction>
	
	
	<cffunction name="getListings" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="modelno" required="no" type="string" default="">
		<cfargument name="name" required="no" type="string" default="">
		<cfargument name="manufacturer" required="no" type="string" default="">
		<cfargument name="showResults" required="no" type="string" default="1">
		
		<cfset var qListings='' />
		
	   	<cfquery name="qListings" datasource="#application.dsource#">
	      	SELECT *
	      	FROM products P
			WHERE 0=0
			<cfif isDefined('arguments.modelno') AND arguments.modelno neq ''>
	      		AND modelno like '#arguments.modelno#%'
	      	</cfif>
			<cfif isDefined('arguments.name') AND arguments.name neq ''>
	      		AND name like '#arguments.name#%'
	      	</cfif>
			<cfif isDefined('arguments.manufacturer') AND arguments.manufacturer neq ''>
	      		AND manufacturer like '#arguments.manufacturer#%'
	      	</cfif>
	      	<cfif isDefined('arguments.showResults') AND arguments.showResults EQ 0>
	      		AND 0=1
	      	</cfif>
			<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY datestamp desc
	      	</cfif>
	   	</cfquery>
		
		<cfif qListings.recordcount EQ 0><cfset pagesize = 0 /></cfif>
	   	
   		<cfreturn queryconvertforgrid(qListings,page,pagesize)/>
	
	</cffunction>

	<cffunction name="getCampaign" access="remote">
		<cfargument name="campaignId" required="yes" type="numeric" default="1">
	
		<cfset var qCampaign='' />
		<cfquery name="qCampaign" datasource="#application.dsource#">
      		SELECT * from campaign C 
      		WHERE pk_campaign = #arguments.campaignId#
      	</cfquery> 

      	<cfreturn qCampaign />

    </cffunction>

    <cffunction name="getCampaignListings" access="remote">
    	<cfargument name="campaignId" required="yes" type="numeric" default="1">
	
		<cfset var qCampaignListings='' />
		<cfquery name="qCampaignListings" datasource="#application.dsource#">
      		SELECT * from campaign_listings CL  
      		INNER JOIN products P on CL.fk_listing = P.uid
      		WHERE CL.fk_campaign = #arguments.campaignId# 
      		ORDER by manufacturer
      	</cfquery> 

      	<cfreturn qCampaignListings />

    </cffunction>

    <cffunction name="updateCampaignListings" access="remote">
    	<cfargument name="campaignId" required="yes">
    	<cfargument name="listingId" required="yes">
	
		<cfquery name="qCampaignListings" datasource="#application.dsource#">
			INSERT INTO campaign_listings 
				(fk_listing,fk_campaign)
				values
				(
					<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.listingId#">,
					<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.campaignId#">
				)
      	</cfquery> 

    </cffunction>

    <cffunction name="deleteCampaignListing" access="remote">
    	<cfargument name="listingId" required="yes">
	
		<cfquery name="qCampaignListings" datasource="#application.dsource#">
			DELETE campaign_listings 
			WHERE fk_listing = <cfqueryparam cfsqltype="cf_sql_numeric" value="#listingId#" /> 
      	</cfquery> 

    </cffunction>

    <cffunction name="addCampaign" access="remote">
    	<cfargument name="pk_campaign" required="yes">
    	<cfargument name="title" required="yes">

		<cfquery name="qCampaign" datasource="#application.dsource#">
			INSERT INTO campaign
			(title,active)
			values
			('#arguments.title#',0)
      	</cfquery>

      	<cfreturn "Campaign Added">

    </cffunction>

    <cffunction name="editCampaign" access="remote">
    	<cfargument name="pk_campaign" required="yes">
    	<cfargument name="title" required="yes">
    	<cfargument name="active" required="no">

    	<cfif isDefined("arguments.active")>

	    	<cfquery name="resetActive" datasource="#application.dsource#">
				UPDATE campaign SET
				 	active =  <cfqueryparam cfsqltype="cf_sql_varchar" value="0">
	      	</cfquery> 

	    </cfif>

    	<cfquery name="qCampaign" datasource="#application.dsource#">
			UPDATE campaign SET
			 	title =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">
			 	<cfif isDefined("arguments.active")>
			 		,active =  <cfqueryparam cfsqltype="cf_sql_varchar" value="1">
			 	<cfelse>
			 		,active =  <cfqueryparam cfsqltype="cf_sql_varchar" value="0">
			 	</cfif>
	      	WHERE pk_campaign = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pk_campaign#" /> 
      	</cfquery> 

    </cffunction>

    <cffunction name="deleteCampaign" access="remote">
    	<cfargument name="pk_campaign" required="yes">

		<cfquery name="qCampaign" datasource="#application.dsource#">
			DELETE campaign
			WHERE pk_campaign = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pk_campaign#" /> 
      	</cfquery>

      	<cfquery name="qCampaignListings" datasource="#application.dsource#">
			DELETE campaign_listings 
			WHERE fk_campaign = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pk_campaign#" /> 
      	</cfquery> 

      	<!--- <cffile action="delete" file="#expandpath('..')#\views\campaign\icons\campaign-icon-#arguments.pk_campaign#.png"> --->

      	<cfreturn "Campaign Deleted">

    </cffunction>
	
	
</cfcomponent>