<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="epricing">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getEpricing" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
		<cfargument name="Title" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">
	
	
		<cfset var qEpricing='' />
	
	   	<cfquery name="qEpricing" datasource="#application.dsource#">
	      	SELECT u.lname as seller_lname,u.fname as seller_fname,u.email as seller_email,u.phone as seller_phone,c.lname as customer_lname,c.fname as customer_Fname,c.email as customer_email,c.otherphone as epricing_otherphone,*
	      	FROM epricing ep
			INNER JOIN customers c on ep.fk_customers = c.id
			INNER JOIN products p on ep.fk_products = p.uid
			LEFT OUTER JOIN users u on p.fk_users = u.pk_users
			WHERE 0=0
			<cfif arguments.Lname neq ''>
	      		AND c.lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND c.email like '#arguments.Email#%'
	      	</cfif>
			<cfif arguments.Title neq ''>
	      		AND p.name like '#arguments.Title#%'
	      	</cfif>
			<cfif arguments.fromDate neq ''>
				AND ep.datestamp >= #arguments.fromDate#
			</cfif>
			<cfif arguments.toDate neq ''>
				AND ep.datestamp <= #arguments.toDate#
			</cfif>
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY ep.datestamp DESC
	      	</cfif>
	   	</cfquery>
	   	
   		<cfreturn queryconvertforgrid(qEpricing,page,pagesize)/>
	
   	</cffunction>
	
		
	<cffunction name="deleteEpricing" access="remote">
		<cfargument name="pk_epricing" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
	
		<cfquery name="deleteEpricing" datasource="#application.dsource#"> 
           	DELETE from epricing
            WHERE pk_epricing = '#arguments.pk_epricing#'
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	
</cfcomponent>