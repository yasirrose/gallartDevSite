<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="employees">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getEmployees" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
	
		<cfset var qEmployees='' />
		<cfset var encryptionKey = application.encryptionKey />

	   	<cfquery name="qEmployees" datasource="#application.dsource#">
	      	SELECT emp_fname,emp_lname,emp_email,pk_employees,emp_phone,password,roles,commission_minus,commission_percent
	      	FROM employees E
			LEFT OUTER JOIN employees_roles ER ON E.pk_employees = ER.fk_employees
			WHERE 0=0 and emp_fname !=''
			<cfif arguments.Lname neq '' and arguments.Lname neq 'searchLname'>
	      		AND E.emp_lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq '' and arguments.Email neq 'searchEmail'>
	      		AND E.emp_email like '#arguments.Email#%'
	      	</cfif>
			GROUP BY emp_fname,emp_lname,emp_email,pk_employees,emp_phone,password,roles,commission_minus,commission_percent
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY E.emp_lname,E.emp_fname
	      	</cfif>
	   	</cfquery>
	   	
		<!--- Decrypt any stored passwords so the grid shows plaintext (fall back to plain if not encrypted) --->
		<cfif qEmployees.recordCount gt 0>
			<cfloop query="qEmployees">
				<cfif len(trim(qEmployees.password[qEmployees.currentRow]))>
					<cftry>
						<cfset qEmployees.password[qEmployees.currentRow] = decrypt(qEmployees.password[qEmployees.currentRow], encryptionKey, "AES", "Base64")>
					<cfcatch>
						<cfset qEmployees.password[qEmployees.currentRow] = qEmployees.password[qEmployees.currentRow]>
					</cfcatch>
					</cftry>
				</cfif>
			</cfloop>
		</cfif>
		<cfreturn queryconvertforgrid(qEmployees,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getAllEmployees" access="remote">
	
		<cfset var qEmployees='' />

	   	<cfquery name="qEmployees" datasource="#application.dsource#">
	      	SELECT emp_lname + ', ' + emp_fname as emp_name,*
	      	FROM employees
			ORDER BY emp_name
	   	</cfquery>
	   	
   		<cfreturn qEmployees />
	
   	</cffunction>
	
	<cffunction name="editEmployeeFromForm" access="remote" output="false" returntype="struct">
	    <cfargument name="pk_employees" type="string" default="">
	    <cfargument name="emp_fname" type="string" default="">
	    <cfargument name="emp_lname" type="string" default="">
	    <cfargument name="emp_email" type="string" default="">
		<cfargument name="emp_phone" type="string" default="">
		<cfargument name="password" type="string" default="">
		<cfargument name="roles" type="string" default="">
		<!--- <cfargument name="commission_minus" type="string" default="">
		<cfargument name="commission_percent" type="numeric" default=""> --->
		<cfargument name="moduleName" type="string" default="">
	    
	    <!--- <cfset var success = true /> --->

		<cfset var result = { success = true, message = "" }>
		<cfset var employeeId = "">
		<cfset var action = "">
		<cfset var encryptionKey = application.encryptionKey />
		<cfset var encryptedPassword = ""> 
		
	    	<cftry>

				<cfif len(trim(arguments.password))>
					<cfset encryptedPassword = encrypt(arguments.password, encryptionKey, "AES", "Base64")>
					<cfif len(arguments.pk_employees)>
						<!--- Get current (stored) password for this employee --->
						<cfquery name="currentPasswordQry" datasource="#application.dsource#">
							SELECT password
							FROM employees
							WHERE pk_employees = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.pk_employees#">
						</cfquery>

						<!--- Only check for duplicates if password changed (consider legacy plain-text or encrypted stored passwords) --->
						<cfif currentPasswordQry.recordCount eq 0 OR (encryptedPassword NEQ currentPasswordQry.password AND arguments.password NEQ currentPasswordQry.password)>
							<cfquery name="checkPassword" datasource="#application.dsource#">
								SELECT COUNT(*) AS passwordCount
								FROM employees
								WHERE (password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#encryptedPassword#"> OR password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.password#">)
								AND pk_employees != <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.pk_employees#">
							</cfquery>

							<cfif checkPassword.passwordCount GT 0>
								<cfset result.success = false>
								<cfset result.message = "This password already exists. Please choose a different password.">
								<cfreturn result>
							</cfif>
						</cfif>
					<cfelse>
						<!--- New record: check encrypted password normally --->
						<cfquery name="checkPassword" datasource="#application.dsource#">
							SELECT COUNT(*) AS passwordCount
							FROM employees
							WHERE (password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#encryptedPassword#"> OR password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.password#">)
						</cfquery>

						<cfif checkPassword.passwordCount GT 0>
							<cfset result.success = false>
							<cfset result.message = "This password already exists. Please choose a different password.">
							<cfreturn result>
						</cfif>
					</cfif>
				</cfif>

				
					<cfif arguments.pk_employees eq ''>

						<!--- <cfif checkPassword.passwordCount GT 0>
							<!--- <cfset success = false /> --->
							<cfset result.success = false>
    				    	<cfset result.message = "Your Password is already exist. Please change your password">
							<cfreturn result>
						 <cfelse> --->
		    	
							<cfquery name="addEmployee" datasource="#application.dsource#"> 
								INSERT into employees
								(
									emp_fname,
									emp_lname,
									emp_email,
									emp_phone,
									password
									
								)
								values
								(
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_fname#">,
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_lname#">,
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_email#">,
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_phone#">,
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#encryptedPassword#">
									
								)
								SELECT @@identity as uid 
							</cfquery>
					
							<cfset employeeId = addEmployee.uid />

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
    				    	<cfset result.message = "Record is added successfully.">

						<!--- </cfif> --->

					 <cfelse>
					
						<cfquery name="editEmployee" datasource="#application.dsource#"> 
							UPDATE employees SET 
							emp_fname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_fname#">,
							emp_lname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_lname#">,
							emp_email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_email#">,
							emp_phone = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_phone#">,
							password  = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#encryptedPassword#">
							
							WHERE pk_employees = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.pk_employees#">
						</cfquery>
						
						<cfquery name="deleteEmployeeRoles" datasource="#application.dsource#"> 
							DELETE from employees_roles
							WHERE fk_employees = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.pk_employees#">
						</cfquery>
						
						<cfset employeeId = arguments.pk_employees />

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
    				    <cfset result.message = "Record is Updated successfully.">
					
					</cfif>
					
					<cfif len(arguments.roles)>
						<cfloop list="#arguments.roles#" index="idx">
							<cfquery name="addEmployeeRole" datasource="#application.dsource#"> 
								INSERT into employees_roles
								(
									fk_employees,
									fk_roles
								)
								values
								(
									<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#employeeId#">,
									<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#idx#">
								)
							</cfquery>
						</cfloop>
					</cfif>					    	    	
			
				<cfcatch type="any">
					<!--- <cfset success = false /> --->
					<cfset result.success = false>
                    <cfset result.message = cfcatch.message>
				</cfcatch>
			</cftry>
			
		<cfreturn result> 
	        
	</cffunction>
	
	<cffunction name="deleteEmployee" access="remote" returntype="struct">
		<cfargument name="pk_employees" type="string" default="">
		
		<!--- <cfset var success = true /> --->

		<cfset var result = { success = true, message = "" }>
		
		<cftry>
	
			<cfquery name="deleteEmployee" datasource="#application.dsource#"> 
				DELETE from employees
				WHERE pk_employees = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.pk_employees#">
			</cfquery>
		
			<cfquery name="deleteEmployeeRoles" datasource="#application.dsource#"> 
                DELETE from employees_roles
                WHERE fk_employees = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.pk_employees#">
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

			<cfset result.success = true>
    		<cfset result.message = "Record is Deleted successfully.">
		
			<cfcatch type="any">
				<!--- <cfset success = false /> --->
				<cfset result.success = false>
                <cfset result.message = cfcatch.detail>
			</cfcatch>
		</cftry>
	
		<cfreturn result />
	
	</cffunction>
	
	<cffunction name="getEmployee" access="remote" returntype="any" returnformat="JSON">
		<cfargument name="form" type="struct">
				
		<cfset var success = true />
		<cfset var qEmployees = '' />
		<cfset var encryptionKey = application.encryptionKey />
		<cfset var encryptedPassword = "" />
		<cfif len(trim(form.password))>
			<cfset encryptedPassword = encrypt(form.password, encryptionKey, "AES", "Base64")>
		</cfif>
		
		<cftry>

        <cfquery name="qEmployees" datasource="#application.dsource#"> 
           	SELECT * from employees
           	WHERE (password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#encryptedPassword#"> OR password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.password#">)
        </cfquery>
		
		<cfquery name="qEmployeeRoles" datasource="#application.dsource#"> 
           	SELECT * from employees_roles ER
			INNER JOIN roles R ON ER.fk_roles = R.pk_roles
            WHERE fk_employees = #qEmployees.pk_employees#
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
		
		<cfif qEmployees.recordcount>
			<cfset session.loggedin = true />
			<cfset session.userinfo.pk_employees = qEmployees.pk_employees />
			<cfset session.userinfo.fname = qEmployees.emp_fname />
			<cfset session.userinfo.lname = qEmployees.emp_lname />
			<cfset session.userinfo.password = form.password />
			<cfset session.userinfo.email = qEmployees.emp_email />
			<cfset session.userinfo.emp_email = qEmployees.emp_email />
			<cfset session.userinfo.roles = valueList(qEmployeeRoles.role) />
			<cfset session.userinfo.sa = qEmployees.sa />
		<cfelse>
			<cfset success = false />
		</cfif>
	
		<cfreturn success />
	
	</cffunction>
	
	<cffunction name="getEmployeeFromId" access="remote" returntype="struct">
		<cfargument name="pk_employees" type="numeric">
		
		<cfset var returnStruct = structNew() />

		<cfset var qEmployee = '' />
		<cfset var qEmployeeRoles = '' />
		<cfset var encryptionKey = application.encryptionKey />
		<cfset var decryptedPassword = "" />
		
		<cfquery name="qEmployee" datasource="#application.dsource#"> 
           	SELECT * from employees
            WHERE pk_employees = #arguments.pk_employees#
        </cfquery>
	
		<cfquery name="qEmployeeRoles" datasource="#application.dsource#"> 
           	SELECT * from employees_roles
            WHERE fk_employees = #arguments.pk_employees#
        </cfquery>
		
		<cfset returnStruct.emp_email = qEmployee.emp_email />
		<cfif len(trim(qEmployee.password))>
			<cftry>
				<cfset decryptedPassword = decrypt(qEmployee.password, encryptionKey, "AES", "Base64")>
			<cfcatch>
				<cfset decryptedPassword = qEmployee.password>
			</cfcatch>
			</cftry>
		</cfif>
		<cfset returnStruct.roles = valueList(qEmployeeRoles.fk_roles) />
		<cfset returnStruct.PASSWORD = decryptedPassword />
		<cfset returnStruct.password = decryptedPassword />
		<cfset returnStruct.EMP_EMAIL = qEmployee.emp_email />
		
		<cfreturn returnStruct />
	
	</cffunction>
	
	<cffunction name="checkPassword" access="remote" returntype="any" returnformat="JSON">
		<cfargument name="form" type="struct">
				
		<cfset var success = true />

		<cfset var encryptionKey = application.encryptionKey />
		<cfset var encryptedPassword = "" />
		<cftry>
			<cfif len(trim(form.password))>
				<cfset encryptedPassword = encrypt(form.password, encryptionKey, "AES", "Base64")>
			</cfif>
			<cfquery name="qEmployees" datasource="#application.dsource#"> 
				SELECT * from employees
				WHERE (password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#encryptedPassword#"> OR password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.password#">)
			</cfquery>
			<cfcatch type="any">
				<cfset success = false />
			</cfcatch>
		</cftry>

		<!--- <cfdump var="#qEmployees#" abort="true"> --->
		
		<cfif not qEmployees.recordcount>
			<cfset success = false />
		</cfif>
	
		<cfreturn success />
	
	</cffunction>
	
		
	<cffunction name="changePassword" access="remote" returntype="any" returnformat="JSON">
		<cfargument name="form" type="struct">
				
		<cfset var success = true />
		<cfset var qEmployees='' />

		<cfset var encryptionKey = application.encryptionKey />
		<cfset var encryptedOld = "" />
		<cfset var encryptedNew = "" />
		<cftry>
			<cfif len(trim(form.old_password))>
				<cfset encryptedOld = encrypt(form.old_password, encryptionKey, "AES", "Base64")>
			</cfif>
			<cfif len(trim(form.new_password))>
				<cfset encryptedNew = encrypt(form.new_password, encryptionKey, "AES", "Base64")>
			</cfif>
			<cfquery name="qEmployees" datasource="#application.dsource#"> 
				SELECT * from employees
				WHERE (password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#encryptedOld#"> OR password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.old_password#">)
			</cfquery>
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
		
		<cfif not qEmployees.recordcount>
			<cfset success = false />
		<cfelse>
			<cfquery name="editEmployee" datasource="#application.dsource#"> 
				UPDATE employees SET 
				password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#encryptedNew#">
				WHERE (password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#encryptedOld#"> OR password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.old_password#">)
			</cfquery>
		</cfif>
	
		<cfreturn success />
	
	</cffunction>
	
	<cffunction name="getEmployeeFromPassword" access="remote" returntype="query">
		<cfargument name="password" type="string">
		
		<cfset var qEmployee = '' />
		<cfset var encryptionKey = application.encryptionKey />
		<cfset var encryptedPassword = "" />
		<cfif len(trim(arguments.password))>
			<cfset encryptedPassword = encrypt(arguments.password, encryptionKey, "AES", "Base64")>
		</cfif>
        <cfquery name="qEmployee" datasource="#application.dsource#"> 
           	SELECT * from employees
           	WHERE (password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#encryptedPassword#"> OR password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.password#">)
        </cfquery>
		

		<cfreturn qEmployee />
	
	</cffunction>
	
	
</cfcomponent>