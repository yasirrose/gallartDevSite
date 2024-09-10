<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="customers">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getCustomers" access="remote">
	  	
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
		
		<cfset var qCustomers='' />
		
		<cfset session.qCustomers.Fname = arguments.Fname />
		<cfset session.qCustomers.Lname = arguments.Lname />
		<cfset session.qCustomers.Email = arguments.Email />
		<cfset session.qCustomers.Areacode = arguments.Areacode />
		<cfset session.qCustomers.City = arguments.City />
		<cfset session.qCustomers.State = arguments.State />

	   	<cfquery name="qCustomers" datasource="#application.dsource#">
	      	SELECT email as customer_email, *
	      	FROM customers C
			WHERE 0=0
			<cfif arguments.Fname neq ''>
	      		AND C.fname like '#arguments.Fname#%'
	      	</cfif>
			<cfif arguments.Lname neq ''>
	      		AND C.lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND C.email like '%#arguments.Email#%'
	      	</cfif>
			<cfif arguments.Areacode neq ''>
	      		AND (
					C.phone like '#arguments.Areacode#%' OR
					C.phone like '(#arguments.Areacode#%' OR
					C.businessphone like '#arguments.Areacode#%' OR
					C.businessphone like '(#arguments.Areacode#%'
					)
	      	</cfif>
			<cfif arguments.City neq ''>
	      		AND C.city like '#arguments.City#%'
	      	</cfif>
			<cfif arguments.State neq ''>
	      		AND C.state like '#arguments.State#%'
	      	</cfif>
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY C.lname,C.fname
	      	</cfif>
	   	</cfquery>
	   	
   		<cfreturn queryconvertforgrid(qCustomers,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getAllCustomers" access="remote">
	
		<cfset var qCustomers='' />

	   	<cfquery name="qCustomers" datasource="#application.dsource#">
	      	SELECT UPPER(lname)+','+UPPER(fname) as full_customer_name,*
	      	FROM customers
			ORDER BY lname
	   	</cfquery>
	   	
   		<cfreturn qCustomers />
	
   	</cffunction>
	
	<!--- for order form dropdown --->
	<cffunction name="getCustomer" access="remote" returntype="struct">
		<cfargument name="customerId" type="string">

		<cfset var qCustomer= "" />
		<cfset var returnStruct = structNew() />
		
		<cftry>
	
		<cfquery name="qCustomer" datasource="#application.dsource#"> 
           	SELECT email as customer_email,* from customers
            WHERE id = '#arguments.customerId#'
        </cfquery>
		
		<cfcatch type="any"></cfcatch>
		</cftry>
		
		<cfloop list="#qCustomer.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qCustomer."&idx) />
		</cfloop>
		
		<cfreturn returnStruct />
	
	</cffunction>
	
	<cffunction name="editCustomerFromForm" access="remote" output="false" returntype="boolean">
	    <cfargument name="id" type="string" default="">
	    <cfargument name="fname" type="string" default="">
	    <cfargument name="lname" type="string" default="">
	    <cfargument name="customer_email" type="string" default="">
		<cfargument name="phone" type="string" default="">
		<cfargument name="CellPhone" type="string" default="">
		<cfargument name="WorkPhone" type="string" default="">
		<cfargument name="otherphone" type="string" default="">
		<cfargument name="Address1" type="string" default="">
		<cfargument name="Address2" type="string" default="">
		<cfargument name="City" type="string" default="">
		<cfargument name="State" type="string" default="">
		<cfargument name="Zip" type="string" default="">
		<cfargument name="Country" type="string" default="">
		<cfargument name="saddress1" type="string" default="">
		<cfargument name="saddress2" type="string" default="">
		<cfargument name="scity" type="string" default="">
		<cfargument name="sstate" type="string" default="">
		<cfargument name="szip" type="string" default="">
		<cfargument name="Fax" type="string" default="">
		<cfargument name="DriversLicense" type="string" default="">
		<cfargument name="maillist" type="string" default="">
		<cfargument name="optout" type="string" default="">
		<cfargument name="comments" type="string" default="">
	    
	    <cfset var success = true />
		
	    <cftry>>
	    
	    	<cfif arguments.id eq ''>
		    	
		    	<cfquery name="addCustomer" datasource="#application.dsource#"> 
	                INSERT into customers
	                (
	                	fname,
	                	lname,
	                	email,
						phone
	                )
	                values
                	(
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.email#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.phone#">
					)
					SELECT @@identity as uid 
	            </cfquery>
			
			<cfelse>
			
				<cfquery name="editCustomer" datasource="#application.dsource#"> 
	                UPDATE customers SET 
	                fname 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fname#">,
	                lname 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lname#">,
					email			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.customer_email#">,
					phone 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.phone#">,
					CellPhone 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CellPhone#">,
					businessphone	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.WorkPhone#">,
					otherphone 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.otherphone#">,
					Address1 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Address1#">,
					Address2 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Address1#">,
					City 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.City#">,
					State 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.State#">,
					Zip 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Zip#">,
					Country 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Country#">,
					saddress1 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.saddress1#">,
					saddress2 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.saddress2#">,
					scity 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.scity#">,
					sstate 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.sstate#">,
					szip 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.szip#">,
					Fax 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Fax#">,
					DriversLicense	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.DriversLicense#">,
					maillist		= <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#arguments.maillist#">,
					optout 			= <cfqueryparam cfsqltype="CF_SQL_DATE" value="#iif(arguments.maillist EQ 0,DE(createodbcdate(now())),DE(''))#">,
					comments		= <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.comments#">
	                WHERE id 		= <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
	            </cfquery>
				
			</cfif>
			
	    	<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>
			
		<cfreturn success> 
	        
	</cffunction>
	
	<cffunction name="deleteCustomer" access="remote">
		<cfargument name="id" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
	
		<cfquery name="deleteCustomer" datasource="#application.dsource#"> 
           	DELETE from customers
            WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
        </cfquery>
		
		<cfquery name="deleteCustomerRoles" datasource="#application.dsource#"> 
                DELETE from employees_roles
                WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
            </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	
	<!--- from order module --->
	
	<cffunction name="editCustomer" access="remote" returntype="struct">
		<cfargument name="id" type="string" default="#session.invoiceInfo.customerId#">
		<cfargument name="assignedto" type="string" default="#session.invoiceInfo.assignedto#">
	    <cfargument name="fname" type="string" default="#session.invoiceInfo.fname#">
	    <cfargument name="lname" type="string" default="#session.invoiceInfo.lname#">
	    <cfargument name="email" type="string" default="#session.invoiceInfo.email#">
		<cfargument name="phone" type="string" default="#session.invoiceInfo.phone#">
		<cfargument name="otherphone" type="string" default="#session.invoiceInfo.otherphone#">
		<cfargument name="Address1" type="string" default="#session.invoiceInfo.Address1#">
		<cfargument name="City" type="string" default="#session.invoiceInfo.City#">
		<cfargument name="State" type="string" default="#session.invoiceInfo.State#">
		<cfargument name="Zip" type="string" default="#session.invoiceInfo.Zip#">
		<cfargument name="Country" type="string" default="#session.invoiceInfo.Country#">
		<cfargument name="CellPhone" type="string" default="#session.invoiceInfo.CellPhone#">
		<cfargument name="Fax" type="string" default="#session.invoiceInfo.Fax#">
		<cfargument name="DriversLicense" type="string" default="#session.invoiceInfo.DriversLicense#">
		<cfargument name="Consultant" type="string" default="#session.invoiceInfo.Consultant#">
	    <cfargument name="businessphone" type="string" default="#session.invoiceInfo.businessphone#">
		<cfargument name="website" type="string" default="#session.invoiceInfo.website#">
		
		<cfset var returnStruct = structNew() />
	    <cfset returnStruct.success = true />
		
			<cfscript>
				getCustomerIdFromEmail = application.objectFactoryAdmin.getInstance('customers').getCustomerIdFromEmail(arguments.email);
			</cfscript>
			
		
	    	<cftry>
	    
	    	<cfif arguments.id EQ '' AND getCustomerIdFromEmail EQ ''>
		    	
		    	<cfquery name="addCustomer" datasource="#application.dsource#"> 
	                INSERT into customers
	                (
						assignedto,
	                	fname,
	                	lname,
	                	email,
						phone,
						otherphone,
						Address1,	
						City,	
						State,	
						Zip,	
						Country,	
						CellPhone,	
						Fax,	
						DriversLicense,	
						Consultant,
						businessphone,
						website
	                )
	                values
                	(
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.assignedto#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.email#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.phone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.otherphone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Address1#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.City#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.State#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Zip#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Country#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CellPhone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Fax#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.DriversLicense#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Consultant#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.businessphone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.website#">
					)
					SELECT @@identity as uid 
	            </cfquery>
				
				<cfset thisCustomerId = addCustomer.uid />
			
			<cfelseif getCustomerIdFromEmail NEQ ''>
			
				<cfquery name="editCustomer" datasource="#application.dsource#"> 
	                UPDATE customers SET 
	                fname 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fname#">,
	                lname 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lname#">,
					email 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.email#">,
					phone 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.phone#">,
					otherphone		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.otherphone#">,
					Address1 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Address1#">,
					City 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.City#">,
					State 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.State#">,
					Zip 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Zip#">,
					Country 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Country#">,
					CellPhone 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CellPhone#">,
					Fax 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Fax#">,
					DriversLicense 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.DriversLicense#">,
					Consultant 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Consultant#">,
					businessphone	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.businessphone#">,
					website 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.website#">
	                WHERE id 		= <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#getCustomerIdFromEmail#">
	            </cfquery>
				
				<cfset thisCustomerId = getCustomerIdFromEmail />
				
			<cfelse>
			
				<cfquery name="editCustomer" datasource="#application.dsource#"> 
	                UPDATE customers SET 
	                fname 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fname#">,
	                lname 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lname#">,
					email 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.email#">,
					phone 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.phone#">,
					otherphone		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.otherphone#">,
					Address1 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Address1#">,
					City 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.City#">,
					State 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.State#">,
					Zip 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Zip#">,
					Country 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Country#">,
					CellPhone 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CellPhone#">,
					Fax 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Fax#">,
					DriversLicense 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.DriversLicense#">,
					Consultant 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Consultant#">,
					businessphone	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.businessphone#">,
					website 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.website#">
	                WHERE id 		= <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
	            </cfquery>
				
				<cfset thisCustomerId = getCustomerFromEmail.id />
				
			</cfif>
			
	    	<cfcatch type="any"><cfset returnStruct.success = false /></cfcatch>
			</cftry>
			
		<cfset returnStruct.thisCustomerId = thisCustomerId />
			
		<cfreturn returnStruct> 
	
	</cffunction>
	
	<cffunction name="getCustomerIdFromEmail" access="remote" returntype="string">
		<cfargument name="email" type="string">

		<cfset var qCustomer= "" />
	
		<cfquery name="qCustomer" datasource="#application.dsource#"> 
           	SELECT id from customers
            WHERE email = '#arguments.email#'
        </cfquery>
		
		<cfreturn qCustomer.id />
	
	</cffunction>
	
	<!--- /////////////  FOR AUTOSUGGEST ///////////////// --->
	
	<cffunction name="searchCustomersByFname" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 100 fname FROM customers
				WHERE fname <> ''
				AND upper(fname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY fname
	       	</cfquery>
	
		<cfreturn valueList(qListings.fname) />
		
	</cffunction>
	
	<cffunction name="searchCustomersByLname" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 100 lname FROM customers
				WHERE lname <> ''
				AND upper(lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY lname
	       	</cfquery>
	
		<cfreturn valueList(qListings.lname) />
		
	</cffunction>

	<cffunction name="searchCustomersByEmail" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 100 email FROM customers
				WHERE email <> ''
				AND upper(email) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY email
	       	</cfquery>

		<cfreturn valueList(qListings.email) />

	</cffunction>
	
</cfcomponent>