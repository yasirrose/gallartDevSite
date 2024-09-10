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

	   	<cfquery name="qEmployees" datasource="#application.dsource#">
	      	SELECT emp_fname,emp_lname,emp_email,pk_employees,emp_phone,password,roles,commission_minus,commission_percent
	      	FROM employees E
			LEFT OUTER JOIN employees_roles ER ON E.pk_employees = ER.fk_employees
			WHERE 0=0
			<cfif arguments.Lname neq ''>
	      		AND E.emp_lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND E.emp_email like '#arguments.Email#%'
	      	</cfif>
			GROUP BY emp_fname,emp_lname,emp_email,pk_employees,emp_phone,password,roles,commission_minus,commission_percent
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY E.emp_lname,E.emp_fname
	      	</cfif>
	   	</cfquery>
	   	
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
	
	<cffunction name="editEmployeeFromForm" access="remote" output="false" returntype="boolean">
	    <cfargument name="pk_employees" type="string" default="">
	    <cfargument name="emp_fname" type="string" default="">
	    <cfargument name="emp_lname" type="string" default="">
	    <cfargument name="emp_email" type="string" default="">
		<cfargument name="emp_phone" type="string" default="">
		<cfargument name="password" type="string" default="">
		<cfargument name="roles" type="string" default="">
		<cfargument name="commission_minus" type="string" default="">
		<cfargument name="commission_percent" type="numeric" default="">
	    
	    <cfset var success = true />
		
	    	<cftry>
	    
	    	<cfif arguments.pk_employees eq ''>
		    	
		    	<cfquery name="addEmployee" datasource="#application.dsource#"> 
	                INSERT into employees
	                (
	                	emp_fname,
	                	emp_lname,
	                	emp_email,
						emp_phone,
						password,
						commission_minus,
						commission_percent
	                )
	                values
                	(
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_fname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_lname#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_email#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_phone#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.password#">,
						<cfqueryparam cfsqltype="CF_SQL_MONEY" value="#arguments.commission_minus#">,
						<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.commission_percent#">
					)
					SELECT @@identity as uid 
	            </cfquery>
		
				<cfset employeeId = addEmployee.uid />
			
			<cfelse>
			
				<cfquery name="editEmployee" datasource="#application.dsource#"> 
	                UPDATE employees SET 
	                emp_fname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_fname#">,
	                emp_lname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_lname#">,
					emp_email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_email#">,
					emp_phone = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.emp_phone#">,
					password  = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.password#">,
					commission_minus  = <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#arguments.commission_minus#">,
					commission_percent  = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.commission_percent#">
	                WHERE pk_employees = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.pk_employees#">
	            </cfquery>
				
				<cfquery name="deleteEmployeeRoles" datasource="#application.dsource#"> 
	                DELETE from employees_roles
	                WHERE fk_employees = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.pk_employees#">
	            </cfquery>
				
				<cfset employeeId = arguments.pk_employees />
			
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
			
	    	<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>
			
		<cfreturn success> 
	        
	</cffunction>
	
	<cffunction name="deleteEmployee" access="remote">
		<cfargument name="pk_employees" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
	
		<cfquery name="deleteEmployee" datasource="#application.dsource#"> 
           	DELETE from employees
            WHERE pk_employees = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.pk_employees#">
        </cfquery>
		
		<cfquery name="deleteEmployeeRoles" datasource="#application.dsource#"> 
                DELETE from employees_roles
                WHERE fk_employees = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.pk_employees#">
            </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	<cffunction name="getEmployee" access="remote" returntype="any" returnformat="JSON">
		<cfargument name="form" type="struct">
				
		<cfset var success = true />
		<cfset var qEmployees = '' />
		
		<cftry>
	
		<cfquery name="qEmployees" datasource="#application.dsource#"> 
           	SELECT * from employees
            WHERE password = '#form.password#'
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
			<cfset session.userinfo.password = qEmployees.password />
			<cfset session.userinfo.email = qEmployees.emp_email />
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
		
		<cfquery name="qEmployee" datasource="#application.dsource#"> 
           	SELECT * from employees
            WHERE pk_employees = #arguments.pk_employees#
        </cfquery>
	
		<cfquery name="qEmployeeRoles" datasource="#application.dsource#"> 
           	SELECT * from employees_roles
            WHERE fk_employees = #arguments.pk_employees#
        </cfquery>
		
		<cfset returnStruct.emp_email = qEmployee.emp_email />
		<cfset returnStruct.roles = valueList(qEmployeeRoles.fk_roles) />
		
		<cfreturn returnStruct />
	
	</cffunction>
	
	<cffunction name="checkPassword" access="remote" returntype="any" returnformat="JSON">
		<cfargument name="form" type="struct">
				
		<cfset var success = true />

		<cftry>
	
		<cfquery name="qEmployees" datasource="#application.dsource#"> 
           	SELECT * from employees
            WHERE password = '#form.password#'
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
		
		<cfif not qEmployees.recordcount>
			<cfset success = false />
		</cfif>
	
		<cfreturn success />
	
	</cffunction>
	
		
	<cffunction name="changePassword" access="remote" returntype="any" returnformat="JSON">
		<cfargument name="form" type="struct">
				
		<cfset var success = true />
		<cfset var qEmployees='' />

		<cftry>
	
		<cfquery name="qEmployees" datasource="#application.dsource#"> 
           	SELECT * from employees
            WHERE password = '#form.old_password#'
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
		
		<cfif not qEmployees.recordcount>
			<cfset success = false />
		<cfelse>
			<cfquery name="editEmployee" datasource="#application.dsource#"> 
                UPDATE employees SET 
                password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.new_password#">
                WHERE password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.old_password#">
            </cfquery>
		</cfif>
	
		<cfreturn success />
	
	</cffunction>
	
	<cffunction name="getEmployeeFromPassword" access="remote" returntype="query">
		<cfargument name="password" type="string">
		
		<cfset var qEmployee = '' />
		
		<cfquery name="qEmployee" datasource="#application.dsource#"> 
           	SELECT * from employees
            WHERE password = '#arguments.password#'
        </cfquery>
		

		<cfreturn qEmployee />
	
	</cffunction>
	
	
</cfcomponent>