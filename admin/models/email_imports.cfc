<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="email_imports">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getImports" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
	
	
		<cfset var qImports='' />

	   	<cfquery name="qImports" datasource="#application.dsource#">
	      	SELECT *
	      	FROM email_imports
			WHERE 0=0
			<cfif arguments.Lname neq ''>
	      		AND lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND email like '#arguments.Email#%'
	      	</cfif>
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY email
	      	</cfif>
	   	</cfquery>
	   	
   		<cfreturn queryconvertforgrid(qImports,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getImportFromId" access="remote" returntype="struct">
	  	
      	<cfargument name="pk_email_imports" type="string" default="">
		
		<cfset var returnStruct = structNew() />
	
		<cfset var qImports='' />

	   	<cfquery name="qImports" datasource="#application.dsource#">
	      	SELECT *
	      	FROM email_imports
			WHERE pk_email_imports = '#arguments.pk_email_imports#'
	   	</cfquery>
		
		<cfloop list="#qImports.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qImports."&idx) />
		</cfloop>

		<cfreturn returnStruct />
		
   	</cffunction>
	
	<cffunction name="editImportsFromForm" access="remote" output="false" returntype="boolean">
	    <cfargument name="pk_email_imports" type="string" default="">
	    <cfargument name="fk_email_imports_list" type="string" default="">
	    <cfargument name="LNAME" type="string" default="">
		<cfargument name="FNAME" type="string" default="">
		<cfargument name="USER_EMAIL" type="string" default="">
			    
	    <cfset var success = true />
		
	    	<cftry>
	    
	    	<cfif arguments.pk_email_imports eq ''>
		    	
		    	<cfquery name="addImport" datasource="#application.dsource#"> 
	               INSERT into email_imports
					(
						FK_EMAIL_IMPORTS_LIST,	
						LNAME,
						FNAME,
						EMAIL
					)
					values
					(
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FK_EMAIL_IMPORTS_LIST#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LNAME#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FNAME#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.USER_EMAIL#">
					)
	            </cfquery>
		
			
			<cfelse>
			
				<cfquery name="editImports" datasource="#application.dsource#"> 
	                UPDATE email_imports SET 
	                	FK_EMAIL_IMPORTS_LIST = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FK_EMAIL_IMPORTS_LIST#">,
		                LNAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LNAME#">,
						FNAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FNAME#">,
						EMAIL = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.USER_EMAIL#">
	                WHERE pk_email_imports = #arguments.pk_email_imports#
	            </cfquery>
			
			</cfif>
	    
	    			
			<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>
			
		<cfreturn success> 
	        
	</cffunction>
	
	<cffunction name="deleteImport" access="remote">
		<cfargument name="pk_email_imports" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
	
		<cfquery name="deleteImport" datasource="#application.dsource#"> 
           	DELETE from email_imports
            WHERE pk_email_imports = #arguments.pk_email_imports#
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	
</cfcomponent>