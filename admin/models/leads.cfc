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
				SELECT lname + ',	' + fname AS full_lead_name, pk_leads 
				FROM leads 
				WHERE fname != '' AND lname != '' and fname Is not null and lname is not null and fname !='*' and lname!='*' and fname !='?' and lname !='????????' and isdeleted is null and fname != 'Holla See more exposed pics with me by clicking here https://femalyssex.page.link/2hqA'
				GROUP BY EMAIL, pk_leads, lname, fname 
				ORDER BY lname;
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
	      	SELECT CONVERT(CHAR(9),L.datestamp,6) as leadDate,L.email as leadEmail,E.emp_lname + ', ' + E.emp_fname as emp_name,
			CASE WHEN L.name IS NULL OR L.name = '' THEN L.fname + ' ' + L.lname 
			ELSE L.name END AS user_name, L.*
	      	FROM leads L
			LEFT OUTER JOIN employees E ON L.fk_employees = E.pk_employees
			WHERE 0=0 and isdeleted is null
			<cfif arguments.Fname neq '' and arguments.Fname neq 'searchFname'>
	      		AND L.fname like '#arguments.Fname#%'
	      	</cfif>
			<cfif arguments.Lname neq '' and arguments.Lname neq 'searchLname'>
	      		AND L.lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq '' and arguments.Email neq 'searchEmail'>
	      		AND L.email like '%#arguments.Email#%'
	      	</cfif>
			<cfif arguments.Areacode neq '' and arguments.Areacode neq 'searchAreacode'>
	      		AND (
					L.phone like '#arguments.Areacode#%' OR
					L.phone like '(#arguments.Areacode#%' OR
					L.cellphone like '#arguments.Areacode#%' OR
					L.cellphone like '(#arguments.Areacode#%' OR
					L.businessphone like '#arguments.Areacode#%' OR
					L.businessphone like '(#arguments.Areacode#%'
					)
	      	</cfif>
			<cfif arguments.City neq '' and arguments.City neq 'searchCity'>
	      		AND L.city like '#arguments.City#%'
	      	</cfif>
			<cfif arguments.State neq '' and arguments.State neq 'searchState' >
	      		AND L.state like '#arguments.State#%'
	      	</cfif>
			<cfif arguments.EmployeeId neq '' and arguments.EmployeeId neq 'searchEmployeeId'>
	      		AND L.fk_employees = '#arguments.EmployeeId#'
	      	</cfif>
			<cfif arguments.Comments neq '' and arguments.Comments neq 'searchComments' >
				<cfif arguments.Comments eq 1>
					AND L.notes is not null
				<cfelseif arguments.Comments eq 0>
					AND L.notes is null
				</cfif>
			</cfif>
			<cfif arguments.fromDate neq '' and arguments.fromDate neq 'searchFromDate'>
				AND L.datestamp >= '#dateFormat(arguments.fromDate)#'
			</cfif>
			<cfif arguments.toDate neq '' and arguments.toDate neq 'searchtoDate'>
				AND L.datestamp <= '#dateFormat(arguments.toDate)#'
			</cfif>
			<cfif arguments.keywords neq '' and arguments.keywords neq 'searchKeywords'>
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
		<!--- <cfargument name="cellphone" type="string" default="">
		<cfargument name="phone" type="string" default="">
		<cfargument name="businessphone" type="string" default="">
		<cfargument name="otherphone" type="string" default=""> --->
		<cfargument name="besttime" type="string" default="">
		<cfargument name="address" type="string" default="">
		<cfargument name="city" type="string" default="">
		<cfargument name="state" type="string" default="">
		<cfargument name="country" type="string" default="">
		<cfargument name="zip" type="string" default="">
		<cfargument name="company" type="string" default="">
		<cfargument name="website" type="string" default="">
		<cfargument name="theartists" type="string" default="">
		<cfargument name="artists" type="string" default="">
		<cfargument name="titles" type="string" default="">
	    <cfargument name="notes" type="string" default="">
		<cfargument name="password" type="string" default="">
		<cfargument name="maillist" type="string" default="">
		<cfargument name="name" type="string" default="">
		<cfargument name="phoneNumber" type="string" default="">
		<cfargument name="phoneType" type="string" default="">
		<cfargument name="addressType" type="string" default="">
		<cfargument name="State_Outside" type="string" default="">
		<cfargument name="moduleName" type="string" default="">

		<!--- <cfdump var="#arguments#" abort="true"> --->

		<cfif len(trim(arguments.phoneNumber)) AND arguments.phoneType EQ "Home Phone">
			<cfset phone = arguments.phoneNumber>
		<cfelse>
			<cfset phone = "">
		</cfif>

		<cfif len(trim(arguments.phoneNumber)) AND arguments.phoneType EQ "Cell Phone">
			<cfset cellphone = arguments.phoneNumber>
		<cfelse>
			<cfset cellphone = "">
		</cfif>

		<cfif len(trim(arguments.phoneNumber)) AND arguments.phoneType EQ "Business Phone">
			<cfset businessphone = arguments.phoneNumber>
		<cfelse>
			<cfset businessphone = "">
		</cfif>

		<cfif len(trim(arguments.phoneNumber)) AND arguments.phoneType EQ "OutsideUS">
			<cfset otherphone = arguments.phoneNumber>
		<cfelse>
			<cfset otherphone = "">
		</cfif>
	    
	    <cfset var success = true />


		<cfif arguments.addressType EQ "USA">
			<cfset finalState = arguments.state>
		<cfelseif arguments.addressType EQ "Outside">
			<cfset finalState = arguments.state_outside>
			<cfset country = arguments.country>
		<cfelse>
			<cfset finalState = "">
			<cfset country = "">
		</cfif>		
   
	    <cftry>
	    	
	    	<cfif arguments.pk_leads eq ''>
		    	
		    	<cfquery name="addLead" datasource="#application.dsource#"> 
	                INSERT into leads
	                (
						fk_employees,
	                	fname,
	                	lname,
						name,
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
						origin,
						addressType
	                )
	                values
                	(
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fk_employees#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.name#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.leadEmail#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cellphone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#phone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#businessphone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#otherphone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.besttime#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.address#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.city#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#finalState#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#country#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.zip#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.company#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.website#">,
						<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.artists#">,
						<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.titles#">,
						<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.notes#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.origin#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.addressType#">
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
	                name 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.name#">,
					email 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.leadEmail#">,
					cellphone 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cellphone#">,
					phone 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#phone#">,
					businessphone 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#businessphone#">,
					otherphone 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#otherphone#">,
					besttime 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.besttime#">,
					address 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.address#">,
					city 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.city#">,
					state 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#finalState#">,
					country 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#country#">,
					zip 				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.zip#">,
					company 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.company#">,
					website 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.website#">,
					artists 			= <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.theartists#">,
					titles 				= <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.titles#">,
					notes 				= <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.notes#">,
					origin				= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.origin#">,
					addressType			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.addressType#">,
					maillist			= <cfqueryparam cfsqltype="cf_sql_tinyint" value="#maillist_value#">
	                WHERE pk_leads		= '#arguments.pk_leads#'
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
				<cfdump var="#cfcatch#" abort="true">
			</cfcatch>
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

			<cfset moduleName = 'Lead Module'>
			<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
			<cfset date = now()>				
			<cfset action = 'Delete'>

			<cfquery name="addLog" datasource="#application.dsource#" >
				INSERT INTO logs 
					( moduleName, ipAddress, date, action)
					VALUES
					( '#moduleName#', '#ipAddress#', #date#, '#action#')
			</cfquery>
		
			<cfcatch type="any">
				<cfset success = false />
			</cfcatch>
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
		<cfset returnStruct.addressType 	= qLead.addressType />
		<cfset returnStruct.state 	= qLead.state />
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
            WHERE fk_employees = '#arguments.EmployeeId#' and isdeleted is null 
      	</cfquery>
        
        <cfreturn qLeads />
        
  	</cffunction>

	<cffunction name="searchLeadsByName" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 name FROM leads
				WHERE name <> ''
				AND upper(name) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%') and isdeleted is null
				ORDER BY name
	       	</cfquery>
	
		<cfreturn valueList(qListings.name) />
		
	</cffunction>

	<cffunction name="searchLeadsByAddress" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 address FROM leads
				WHERE address <> ''
				AND upper(address) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%') and isdeleted is null
				ORDER BY address
	       	</cfquery>
	
		<cfreturn valueList(qListings.address) />
		
	</cffunction>

	<cffunction name="searchLeadsByCity" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 city FROM leads
				WHERE city <> ''
				AND upper(city) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%') and isdeleted is null
				ORDER BY city
	       	</cfquery>
	
		<cfreturn valueList(qListings.city) />
		
	</cffunction>

	<cffunction name="searchLeadsByZipCode" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 zip FROM leads
				WHERE zip <> ''
				AND upper(zip) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%') and isdeleted is null
				ORDER BY zip
	       	</cfquery>
	
		<cfreturn valueList(qListings.zip) />
		
	</cffunction>

	<!--- <cffunction name="searchLeadsByName" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 name FROM leads
				WHERE name <> ''
				AND upper(name) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY name
	       	</cfquery>
	
		<cfreturn valueList(qListings.name) />
		
	</cffunction> --->
	
</cfcomponent>