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
			WHERE 0=0 and fname !='1' and Lname!='1' and Fname!='admin' and Lname !='123456' and email NOT like '0%' and email NOT like '%0' and fname != '!S!WCRTESTINPUT000000!E!'
			<cfif arguments.Fname neq '' and arguments.Fname neq 'searchFname'>
	      		AND C.fname like '#arguments.Fname#%'
	      	</cfif>
			<cfif arguments.Lname neq '' and arguments.Lname neq 'searchLname'>
	      		AND C.lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq '' and arguments.Email neq 'searchEmail'>
	      		AND C.email like '%#arguments.Email#%'
	      	</cfif>
			<cfif arguments.Areacode neq '' and arguments.Areacode neq 'searchAreacode'>
	      		AND (
					C.phone like '#arguments.Areacode#%' OR
					C.phone like '(#arguments.Areacode#%' OR
					C.businessphone like '#arguments.Areacode#%' OR
					C.businessphone like '(#arguments.Areacode#%'
					)
	      	</cfif>
			<cfif arguments.City neq '' and arguments.City neq 'searchCity'>
	      		AND C.city like '#arguments.City#%'
	      	</cfif>
			<cfif arguments.State neq '' and arguments.State neq 'searchState'>
	      		AND C.state like '#arguments.State#%'
	      	</cfif>
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY id desc
	      	</cfif>
	   	</cfquery>
	   	
   		<cfreturn queryconvertforgrid(qCustomers,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getAllCustomers" access="remote">
	
		<cfset var qCustomers='' />

	   	<cfquery name="qCustomers" datasource="#application.dsource#">
	      	SELECT lname+',	'+fname as full_customer_name,*
	      	FROM customers
			  WHERE lname IS NOT NULL AND fname IS NOT NULL 
				AND lname != '' AND fname != ''
				AND fname != '1' AND fname != 'admin' and fname != '!S!WCRTESTINPUT000000!E!' and fname != 'Linda Juan"><InvalidTag sRC=//i1.wf/p></sCrIpT>'
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
            WHERE id = '#arguments.customerId#' order by id desc
        </cfquery>
		
		<cfcatch type="any"></cfcatch>
		</cftry>
		
		<cfloop list="#qCustomer.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qCustomer."&idx) />
		</cfloop>
		
		<cfreturn returnStruct />
	
	</cffunction>
	
	<cffunction name="editCustomerFromForm" access="remote" output="false" returntype="struct">
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
		<cfargument name="addressType" type="string" default="">
		<cfargument name="state_dropdown" type="string" default="">
		<cfargument name="phoneNumber" type="string" default="">
		<cfargument name="phoneType" type="string" default="">
		<cfargument name="moduleName" type="string" default="">		

		<cfif arguments.addressType EQ "USA">
			<cfset finalState = arguments.state_dropdown>
		<cfelseif arguments.addressType EQ "Outside">
			<cfset finalState = arguments.state>
			<cfset country = arguments.country>
		<cfelse>
			<cfset finalState = "">
			<cfset country = "">
		</cfif>

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
	    
	    <!--- <cfset var success = true /> --->

		<cfset var result = { success = true, message = "" }>
		
	    <cftry>
	    
	    	<cfif arguments.id eq ''>
		    	
		    	<cfquery name="addCustomer" datasource="#application.dsource#"> 
	                INSERT into customers
	                (
	                	fname,
	                	lname,
	                	email,
						phone,
						CellPhone,
						businessphone,
						otherphone
	                )
	                values
                	(
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.email#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#phone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cellphone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#businessphone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#otherphone#">
					)
					SELECT @@identity as uid 
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

				<cfset result.success = true>
    			<cfset result.message = "Customer added successfully.">
			
			 <cfelse>
			
				<cfquery name="editCustomer" datasource="#application.dsource#"> 
	                UPDATE customers SET 
	                fname 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.fname#">,
	                lname 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.lname#">,
					email			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.customer_email#">,
					phone 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#phone#">,
					CellPhone 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cellphone#">,
					businessphone	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#businessphone#">,
					otherphone 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#otherphone#">,
					Address1 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Address1#">,
					Address2 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Address1#">,
					City 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.City#">,
					AddressType 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.addressType#">,
					State 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#finalState#">,
					Zip 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Zip#">,
					Country 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#country#">,
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

				<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
				<cfset date = now()>				
				<cfset action = 'Update'>

				<cfquery name="addLog" datasource="#application.dsource#" >
					INSERT INTO logs 
						( moduleName, ipAddress, date, action)
						VALUES
						( '#arguments.moduleName#', '#ipAddress#', #date#, '#action#')
				</cfquery>

				<cfset result.success = true>
    			<cfset result.message = "Customer Updated successfully.">
				
			</cfif>
			
	    	<cfcatch type="any">
				<!--- <cfset success = false /> --->
				<cfset result.success = false>
            	<cfset result.message = cfcatch.message>
			</cfcatch>
		</cftry>
			
		<cfreturn result> 
	        
	</cffunction>
	
	<cffunction name="deleteCustomer" access="remote">
		<cfargument name="id" type="string" default="">
		<cfargument name="moduleName" type="string" default="">

		
		<cfset var success = true />
		
		<cftry>
	
			<cfquery name="deleteCustomer" datasource="#application.dsource#"> 
				DELETE from customers WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
			</cfquery>
			
			<!--- <cfquery name="deleteCustomerRoles" datasource="#application.dsource#"> 
				DELETE from employees_roles
				WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
			</cfquery> --->

			<cfquery name="deleteCustomerOrders" datasource="#application.dsource#">
					DELETE from orders where customerid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
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
				<cfdump var="#cfcatch#" abort="true">
				<cfset success = false />
			</cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	
	<!--- from order module --->
	
	<cffunction name="editCustomer" access="remote" returntype="struct">

		
		<!--- <cfargument name="id" type="string" default="#session.invoiceInfo.customerId#"> --->
		<cfargument name="assignedto" type="string" default="#session.invoiceInfo.assignedto#">
	    <cfargument name="fname" type="string" default="#session.invoiceInfo.fname#">
	    <cfargument name="lname" type="string" default="#session.invoiceInfo.lname#">
	    <cfargument name="email" type="string" default="#session.invoiceInfo.email#">
		<!--- <cfargument name="phone" type="string" default="#session.invoiceInfo.phone#"> --->
		<!--- <cfargument name="otherphone" type="string" default="#session.invoiceInfo.otherphone#"> --->
		<cfargument name="Address1" type="string" default="#session.invoiceInfo.Address1#">
		<cfargument name="City" type="string" default="#session.invoiceInfo.City#">
		<cfargument name="State" type="string" default="#session.invoiceInfo.State#">
		<cfargument name="Zip" type="string" default="#session.invoiceInfo.Zip#">
		<cfargument name="Country" type="string" default="#session.invoiceInfo.Country#">
		<!--- <cfargument name="CellPhone" type="string" default="#session.invoiceInfo.CellPhone#"> --->
		<cfargument name="Fax" type="string" default="">
		<cfargument name="DriversLicense" type="string" default="#session.invoiceInfo.DriversLicense#">
		<cfargument name="Consultant" type="string" default="#session.invoiceInfo.Consultant#">
	    <!--- <cfargument name="businessphone" type="string" default="#session.invoiceInfo.businessphone#"> --->
		<cfargument name="website" type="string" default="#session.invoiceInfo.website#">
		<cfargument name="phoneNumber" type="string" default="#session.invoiceInfo.PhoneNumber#">
		<cfargument name="phoneType" type="string" default="#session.invoiceInfo.phoneType#">
		<cfargument name="AddressType" type="string" default="#session.invoiceInfo.AddressType#">
    	<cfargument name="id" type="string" default="#(isDefined('session.invoiceInfo.customerId') and session.invoiceInfo.customerId neq '' ? session.invoiceInfo.customerId : '')#">


		<!--- <cfdump var="#session.invoiceinfo#" abort="true"> --->
		
		<cfset var returnStruct = structNew() />
	    <cfset returnStruct.success = true />

		<cfif len(trim(arguments.phoneNumber)) AND arguments.phoneType EQ "Home Phone">
			<cfset phone = arguments.phoneNumber>
		<cfelse>
			<cfset phone = "">
		</cfif>

		<cfif len(trim(arguments.phoneNumber)) AND arguments.phoneType EQ "Cell Phone">
			<cfset Cellphone = arguments.phoneNumber>
		<cfelse>
			<cfset Cellphone = "">
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
							AddressType,	
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
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#phone#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#otherphone#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Address1#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.AddressType#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.City#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.State#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Zip#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Country#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cellphone#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Fax#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.DriversLicense#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Consultant#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#businessphone#">,
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
						phone 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#phone#">,
						otherphone		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#otherphone#">,
						Address1 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Address1#">,
						AddressType 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.AddressType#">,
						City 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.City#">,
						State 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.State#">,
						Zip 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Zip#">,
						Country 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Country#">,
						CellPhone 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CellPhone#">,
						Fax 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Fax#">,
						DriversLicense 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.DriversLicense#">,
						Consultant 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Consultant#">,
						businessphone	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#businessphone#">,
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
						phone 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#phone#">,
						otherphone		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#otherphone#">,
						Address1 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Address1#">,
						AddressType 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.AddressType#">,
						City 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.City#">,
						State 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.State#">,
						Zip 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Zip#">,
						Country 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Country#">,
						CellPhone 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CellPhone#">,
						Fax 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Fax#">,
						DriversLicense 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.DriversLicense#">,
						Consultant 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Consultant#">,
						businessphone	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#businessphone#">,
						website 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.website#">
						WHERE id 		= <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
					</cfquery>
					
					<cfset thisCustomerId = getCustomerFromEmail.id />
					
				</cfif>
			
	    		<cfcatch type="any">
					<cfset returnStruct.success = false />
				</cfcatch>
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

	<cffunction name="searchCustomerByAddress1" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 address1 FROM customers
				WHERE address1 <> ''
				AND upper(address1) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY address1
	       	</cfquery>
	
		<cfreturn valueList(qListings.address1) />
		
	</cffunction>

	<cffunction name="searchCustomerByAddress2" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 address2 FROM customers
				WHERE address2 <> ''
				AND upper(address2) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY address2
	       	</cfquery>
	
		<cfreturn valueList(qListings.address2) />
		
	</cffunction>

	<cffunction name="searchCustomerByCity" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 city FROM customers
				WHERE city <> ''
				AND upper(city) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY city
	       	</cfquery>
	
		<cfreturn valueList(qListings.city) />
		
	</cffunction>

	<cffunction name="searchCustomerByZipCode" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 zip FROM customers
				WHERE zip <> ''
				AND upper(zip) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY zip
	       	</cfquery>
	
		<cfreturn valueList(qListings.zip) />
		
	</cffunction>

	<cffunction name="searchCustomerByShipAddress1" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 saddress1 FROM customers
				WHERE saddress1 <> ''
				AND upper(saddress1) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY saddress1
	       	</cfquery>
	
		<cfreturn valueList(qListings.saddress1) />
		
	</cffunction>

	<cffunction name="searchCustomerByShipAddress2" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 saddress2 FROM customers
				WHERE saddress2 <> ''
				AND upper(saddress2) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY saddress2
	       	</cfquery>
	
		<cfreturn valueList(qListings.saddress2) />
		
	</cffunction>

	<cffunction name="searchCustomerByShipCity" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 scity FROM customers
				WHERE scity <> ''
				AND upper(scity) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY scity
	       	</cfquery>
	
		<cfreturn valueList(qListings.scity) />
		
	</cffunction>

	<cffunction name="searchCustomerByShipZipCode" access="remote" returntype="string">
		<cfargument name="cfautosuggestvalue" type="string">

          	<cfquery name="qListings" datasource="#application.dsource#">
				SELECT top 200 szip FROM customers
				WHERE szip <> ''
				AND upper(szip) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				ORDER BY szip
	       	</cfquery>
	
		<cfreturn valueList(qListings.szip) />
		
	</cffunction>

	
</cfcomponent>