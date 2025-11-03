<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="purchases_consignments">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getPurchasesConsignments" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="name" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">
	
	
		<cfset var qPurchasesConsignments='' />

	   	<cfquery name="qPurchasesConsignments" datasource="#application.dsource#">
	      	SELECT email as customer_email, CASE WHEN name IS NULL OR name = '' THEN fname + ' ' + lname 
			ELSE name END AS user_name, *
	      	FROM purchases_consignments
			WHERE 0=0 and isdeleted is null
			<cfif arguments.name neq '' and arguments.name neq 'searchName'>
	      		AND name like '%#arguments.name#%'
	      	</cfif>
			<cfif arguments.fromDate neq '' and arguments.fromDate neq 'searchfromDate'>
				AND datestamp >= '#dateFormat(arguments.fromDate)#'
			</cfif>
			<cfif arguments.toDate neq '' and arguments.toDate neq 'searchtoDate'>
				AND datestamp <= '#dateFormat(arguments.toDate)#'
			</cfif>
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY datestamp desc
	      	</cfif>
	   	</cfquery>
	   	
   		<cfreturn queryconvertforgrid(qPurchasesConsignments,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getPurchasesConsignmentsFromId" access="remote" returntype="struct">
	  	
      	<cfargument name="pk_purchases_consignments" type="string" default="">
		
		<cfset var returnStruct = structNew() />
	
		<cfset var qPurchasesConsignments='' />

	   	<cfquery name="qPurchasesConsignments" datasource="#application.dsource#">
	      	SELECT *
	      	FROM purchases_consignments
			WHERE pk_purchases_consignments = '#arguments.pk_purchases_consignments#'
	   	</cfquery>
		
		<cfloop list="#qPurchasesConsignments.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qPurchasesConsignments."&idx) />
		</cfloop>

		<cfreturn returnStruct />
		
   	</cffunction>
	
	<cffunction name="editPurchasesConsignmentsFromForm" access="remote" output="false" returntype="boolean">
	    <cfargument name="pk_purchases_consignments" type="string" default="">
	    <cfargument name="NAME" type="string" default="">
	    <cfargument name="FNAME" type="string" default="">
	    <cfargument name="LNAME" type="string" default="">
		<cfargument name="PHONE" type="string" default="">
		<cfargument name="CUSTOMER_EMAIL" type="string" default="">
		<cfargument name="ARTIST" type="string" default="">
		<cfargument name="TITLE" type="string" default="">
		<cfargument name="MEDIUM" type="string" default="">
		<cfargument name="SIZE" type="string" default="">
		<cfargument name="ADDITIONAL_DETAILS" type="string" default="">
		<cfargument name="PHONETYPE" type="string" default="">
		<cfargument name="moduleName" type="string" default="">
	    
	    <cfset var success = true />
		
	    <!--- <cfparam name="cffile.serverfile" default="" />
		<cfif len(arguments.THISIMAGE)>
			<cffile action="UPLOAD" filefield="thisImage" destination="#expandpath('../../../')#purchases_consignments\images" nameconflict="MAKEUNIQUE">
		</cfif> --->
		
	    	<cftry>
	    
				<cfif arguments.pk_purchases_consignments eq ''>
					
					<cfquery name="addPurchasesConsignments" datasource="#application.dsource#"> 
					INSERT into purchases_consignments
						(	
							NAME,
							PHONE,
							CUSTOMER_EMAIL,
							<!---IMAGE_NAME,--->
							ARTIST,
							TITLE,
							MEDIUM,
							SIZE,
							ADDITIONAL_DETAILS
						)
						values
						(
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NAME#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PHONE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CUSTOMER_EMAIL#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cffile.serverFile#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ARTIST#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.TITLE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.MEDIUM#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIZE#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ADDITIONAL_DETAILS#">
						)
					</cfquery>

					<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
					<cfset date = now()>				
					<cfset action = 'Insert'>

					<cfquery name="addLog" datasource="#application.dsource#" >
						INSERT INTO logs 
							( moduleName, ipAddress, date, action)
							VALUES
							( '#arguments.moduleName#', '#ipAddress#', #date#, '#action#')
					</cfquery>
			
				
				 <cfelse>
				
					<cfquery name="editPurchasesConsignments" datasource="#application.dsource#"> 
						UPDATE purchases_consignments SET 
							NAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NAME#">,
							FNAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FNAME#">,
							LNAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LNAME#">,
							PHONE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PHONE#">,
							EMAIL = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CUSTOMER_EMAIL#">,
							<!---<cfif len(arguments.THISIMAGE)>
								IMAGE_NAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cffile.serverFile#">,
							</cfif>--->
							ARTIST = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ARTIST#">,
							TITLE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.TITLE#">,
							MEDIUM = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.MEDIUM#">,
							SIZE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIZE#">,
							PHONETYPE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PHONETYPE#">,
							ADDITIONAL_DETAILS = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ADDITIONAL_DETAILS#">
						WHERE pk_purchases_consignments = #arguments.pk_purchases_consignments#
					</cfquery>

					<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
					<cfset date = now()>				
					<cfset action = 'Update'>

					<cfquery name="addLog" datasource="#application.dsource#" >
						INSERT INTO logs 
							( moduleName, ipAddress, date, action)
							VALUES
							( '#arguments.moduleName#', '#ipAddress#', #date#, '#action#')
					</cfquery>
				
				</cfif>
	    
	    			
				<cfcatch type="any">
					<cfset success = false />
				</cfcatch>
			</cftry>
			
		<cfreturn success> 
	        
	</cffunction>
	
	<cffunction name="deletePurchasesConsignments" access="remote">
		<cfargument name="pk_purchases_consignments" type="string" default="">
		<cfargument name="moduleName" type="string" default="">
		
		
		<cfset var success = true />
		
		<cftry>
	
			<cfquery name="deletePurchasesConsignments" datasource="#application.dsource#"> 
				DELETE from purchases_consignments
				WHERE pk_purchases_consignments = #arguments.pk_purchases_consignments#
			</cfquery>

			<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
			<cfset date = now()>				
			<cfset action = 'Delete'>

			<cfquery name="addLog" datasource="#application.dsource#" >
				INSERT INTO logs 
					( moduleName, ipAddress, date, action)
					VALUES
					( '#arguments.moduleName#', '#ipAddress#', #date#, '#action#')
			</cfquery>
			
			<cfcatch type="any">
				<cfset success = false />
			</cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	
</cfcomponent>