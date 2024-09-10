<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="leads">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="getAllLeads" access="remote" returntype="query">

		<cfset var qLeads = '' />
		
		<cftry>
	
		<cfquery name="qLeads" datasource="#application.dsource#"> 
           	SELECT UPPER(lname)+','+UPPER(fname) as full_lead_name,pk_leads from leads
			GROUP BY EMAIL,pk_leads,LNAME,FNAME
			order by lname
        </cfquery>
		
		<cfcatch type="any"></cfcatch>
		</cftry>
		
	
		<cfreturn qLeads />
	
	</cffunction>
	

	<cffunction name="getLeads" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="Fname" required="no" type="string" default="">
		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
		<cfargument name="Areacode" required="no" type="string" default="">
		<cfargument name="City" required="no" type="string" default="">
		<cfargument name="State" required="no" type="string" default="">
		<cfargument name="EmployeeId" required="no" type="string" default="">
		<cfargument name="Comments" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">
		<cfargument name="keywords" required="no" type="string" default="">
	
	
		<cfset var qLeads='' />
		
		<cfset session.qLeads.Fname = arguments.Fname />
		<cfset session.qLeads.Lname = arguments.Lname />
		<cfset session.qLeads.Email = arguments.Email />
		<cfset session.qLeads.Areacode = arguments.Areacode />
		<cfset session.qLeads.City = arguments.City />
		<cfset session.qLeads.State = arguments.State />
		<cfset session.qLeads.EmployeeId = arguments.EmployeeId />
		<cfset session.qLeads.Comments = arguments.Comments />
		<cfset session.qLeads.fromDate = arguments.fromDate />
		<cfset session.qLeads.toDate = arguments.toDate />
		<cfset session.qLeads.keywords = arguments.keywords />
		
	   	<cfquery name="qLeads" datasource="#application.dsource#">
	      	SELECT CONVERT(CHAR(9),L.datestamp,6) as leadDate,L.email as leadEmail,E.emp_lname + ', ' + E.emp_fname as emp_name,*
	      	FROM leads L
			LEFT OUTER JOIN employees E ON L.fk_employees = E.pk_employees
			WHERE 0=0
			<cfif arguments.Fname neq ''>
	      		AND L.fname like '#arguments.Fname#%'
	      	</cfif>
			<cfif arguments.Lname neq ''>
	      		AND L.lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND L.email like '%#arguments.Email#%'
	      	</cfif>
			<cfif arguments.Areacode neq ''>
	      		AND (
					L.phone like '#arguments.Areacode#%' OR
					L.phone like '(#arguments.Areacode#%' OR
					L.cellphone like '#arguments.Areacode#%' OR
					L.cellphone like '(#arguments.Areacode#%' OR
					L.businessphone like '#arguments.Areacode#%' OR
					L.businessphone like '(#arguments.Areacode#%'
					)
	      	</cfif>
			<cfif arguments.City neq ''>
	      		AND L.city like '#arguments.City#%'
	      	</cfif>
			<cfif arguments.State neq ''>
	      		AND L.state like '#arguments.State#%'
	      	</cfif>
			<cfif arguments.EmployeeId neq ''>
	      		AND L.fk_employees = '#arguments.EmployeeId#'
	      	</cfif>
			<cfif arguments.Comments neq ''>
				<cfif arguments.Comments eq 1>
					AND L.notes is not null
				<cfelseif arguments.Comments eq 0>
					AND L.notes is null
				</cfif>
			</cfif>
			<cfif arguments.fromDate neq ''>
				AND L.datestamp >= '#dateFormat(arguments.fromDate)#'
			</cfif>
			<cfif arguments.toDate neq ''>
				AND L.datestamp <= '#dateFormat(arguments.toDate)#'
			</cfif>
			<cfif arguments.keywords neq ''>
				<cfset keyArray = listtoarray(arguments.keywords,' ') />
				AND (
					(<cfloop from="1" to="#arraylen(keyArray)#" index="idx">
						artists like '%#keyArray[idx]#%' <cfif idx lt arraylen(keyArray)>AND</cfif>
					</cfloop>)
					OR
					(<cfloop from="1" to="#arraylen(keyArray)#" index="idx">
						titles like '%#keyArray[idx]#%' <cfif idx lt arraylen(keyArray)>AND</cfif>
					</cfloop>)
					OR
					(<cfloop from="1" to="#arraylen(keyArray)#" index="idx">
						notes like '%#keyArray[idx]#%' <cfif idx lt arraylen(keyArray)>AND</cfif>
					</cfloop>)
				)
			</cfif>
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY L.datestamp desc
	      	</cfif>
	   	</cfquery>
	   	
   		<cfreturn queryconvertforgrid(qLeads,page,pagesize)/>
	
   	</cffunction>
	
	<!--- for order form dropdown --->
	<cffunction name="getLead" access="remote" returntype="struct">
		<cfargument name="leadId" type="string">

		<cfset var qLead = "" />
		<cfset var returnStruct = structNew() />
		
		<cftry>
	
		<cfquery name="qLead" datasource="#application.dsource#"> 
           	SELECT * from leads
            WHERE pk_leads = '#arguments.leadId#'
        </cfquery>
		
		<cfcatch type="any"></cfcatch>
		</cftry>
		
		<cfloop list="#qLead.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qLead."&idx) />
		</cfloop>
		
		<cfreturn returnStruct />
		
	</cffunction>
	
	<cffunction name="editLeadFromForm" access="remote" output="false" returntype="boolean">
	    <cfargument name="pk_leads" type="string" default="">
		<cfargument name="fk_employees" type="string" default="">
	    <cfargument name="fname" type="string" default="">
	    <cfargument name="lname" type="string" default="">
	    <cfargument name="leadEmail" type="string" default="">
		<cfargument name="cellphone" type="string" default="">
		<cfargument name="phone" type="string" default="">
		<cfargument name="businessphone" type="string" default="">
		<cfargument name="otherphone" type="string" default="">
		<cfargument name="besttime" type="string" default="">
		<cfargument name="address" type="string" default="">
		<cfargument name="city" type="string" default="">
		<cfargument name="state" type="string" default="">
		<cfargument name="country" type="string" default="">
		<cfargument name="zip" type="string" default="">
		<cfargument name="company" type="string" default="">
		<cfargument name="website" type="string" default="">
		<cfargument name="theartists" type="string" default="">
		<cfargument name="titles" type="string" default="">
	    <cfargument name="notes" type="string" default="">
		<cfargument name="password" type="string" default="">
		<cfargument name="maillist" type="string" default="">
	    
	    <cfset var success = true />
   
	    <cftry>
	    	
	    	<cfif arguments.pk_leads eq ''>
		    	
		    	<cfquery name="addLead" datasource="#application.dsource#"> 
	                INSERT into leads
	                (
						fk_employees,
	                	fname,
	                	lname,
	                	email,
						cellphone,
						phone,
						businessphone,
						otherphone,
						besttime,
						address,
						city,
						state,
						country,
						zip,
						company,
						website,
						artists,
						titles,
						notes,
						origin
	                )
	                values
                	(
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fk_employees#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.leadEmail#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.cellphone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.phone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.businessphone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.otherphone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.besttime#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.address#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.city#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.state#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.country#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.zip#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.company#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.website#">,
						<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.theartists#">,
						<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.titles#">,
						<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.notes#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.origin#">
					)
	            </cfquery>
		
			
			<cfelse>

				<cfif len(arguments.maillist)>
					<cfset maillist_value = 1 />
				<cfelse>
					<cfset maillist_value = 0 />
				</cfif>
			
				<cfquery name="editLead" datasource="#application.dsource#"> 
	                UPDATE leads SET 
					fk_employees 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fk_employees#">,
	                fname 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fname#">,
	                lname 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lname#">,
					email 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.leadEmail#">,
					cellphone 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.cellphone#">,
					phone 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.phone#">,
					businessphone 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.businessphone#">,
					otherphone 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.otherphone#">,
					besttime 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.besttime#">,
					address 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.address#">,
					city 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.city#">,
					state 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.state#">,
					country 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.country#">,
					zip 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.zip#">,
					company 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.company#">,
					website 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.website#">,
					artists 			= <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.theartists#">,
					titles 				= <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.titles#">,
					notes 				= <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.notes#">,
					origin				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.origin#">,
					maillist			= <cfqueryparam cfsqltype="cf_sql_tinyint" value="#maillist_value#">
	                WHERE pk_leads		 = '#arguments.pk_leads#'
	            </cfquery>
			
			</cfif>
	    
	    	<cfcatch type="any"></cfcatch>
		</cftry>
			
		<cfreturn success> 
	        
	</cffunction>
	
	<cffunction name="deleteLead" access="remote">
		<cfargument name="pk_leads" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
	
		<cfquery name="deleteLead" datasource="#application.dsource#"> 
           	DELETE from leads
            WHERE pk_leads = '#arguments.pk_leads#'
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	

	<cffunction name="getLeadFromId" access="remote" returntype="struct">
		<cfargument name="pk_leads" type="numeric">
		
		<cfset var returnStruct = structNew() />

		<cfset var qLead = '' />
		
		<cfquery name="qLead" datasource="#application.dsource#"> 
           	SELECT E.emp_lname + ', ' + E.emp_fname as emp_name,* from leads L
			LEFT OUTER JOIN EMPLOYEES E on L.fk_employees = E.pk_employees
            WHERE pk_leads = #arguments.pk_leads#
        </cfquery>
	
		<cfset returnStruct.empDisplay 	= qLead.emp_name />
		<cfset returnStruct.email 		= qLead.email />
		<cfset returnStruct.empId 		= qLead.fk_employees />
		<cfset returnStruct.origin 		= qLead.origin />
		<cfset returnStruct.maillist 	= qLead.maillist />
		<cfset returnStruct.resultset	= qLead />
		
		<cfreturn returnStruct />
	
	</cffunction>
	
	<cffunction name="assignLead" access="remote" returntype="void">
		<cfargument name="assignLeadId" type="numeric">
		<cfargument name="assignEmpId" type="numeric">

		<cfset var qLead = '' />
		
		<cfquery name="qLead" datasource="#application.dsource#"> 
           	UPDATE leads SET
			fk_employees = #arguments.assignEmpId#
			WHERE pk_leads = #arguments.assignLeadId#
        </cfquery>
	
	</cffunction>
	
	<!--- /////////////  FOR AUTOSUGGEST ///////////////// --->
	
	<cffunction name="searchLeadsByFname" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 fname + '   -   ' + email as fname_email FROM leads
				WHERE fname <> ''
				AND upper(fname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY fname
	       	</cfquery>
	
		<cfreturn valueList(qListings.fname_email) />
		
	</cffunction>
	
	<cffunction name="searchLeadsByLname" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 lname FROM leads
				WHERE lname <> ''
				AND upper(lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY lname
	       	</cfquery>
	
		<cfreturn valueList(qListings.lname) />
		
	</cffunction>

	<cffunction name="searchLeadsByEmail" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 email FROM leads
				WHERE email <> ''
				AND upper(email) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY email
	       	</cfquery>

		<cfreturn valueList(qListings.email) />

	</cffunction>
    
    <cffunction name="getLeadsFromEmployeeId" access="remote" returntype="query">
	
		<cfargument name="EmployeeId" required="no" type="string" default="">
	
		<cfset var qLeads='' />
		
	   	<cfquery name="qLeads" datasource="#application.dsource#">
        	SELECT * from leads
            WHERE fk_employees = '#arguments.EmployeeId#'
      	</cfquery>
        
        <cfreturn qLeads />
        
  	</cffunction>
	
</cfcomponent>