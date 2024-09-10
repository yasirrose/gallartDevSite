<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="pages">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>

	<cffunction name="getPage">
		<cfargument name="id">

		<cfquery name="local.page" datasource="#application.dsource#">
			SELECT *
			FROM pages
			WHERE pk_pages = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
		 </cfquery>

		 <cfreturn page>
	</cffunction>

	<cffunction name="getPages" access="remote">

      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">

		<cfset var qPages='' />

	   	<cfquery name="qPages" datasource="#application.dsource#">
	      	SELECT *
	      	FROM pages
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
	      	</cfif>
	   	</cfquery>

   		<cfreturn queryconvertforgrid(qPages,page,pagesize)/>

   	</cffunction>

	<cffunction name="savePage" access="remote" output="false" returntype="any">
	    <cfargument name="pk_pages" type="numeric" default="0">
	    <cfargument name="page_content" type="string" default="">

	    <cfset var success = "Page Updated" />

		<cfquery name="editPage" datasource="#application.dsource#">
               UPDATE pages SET
               page_content 	= <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.page_content#">
               WHERE pk_pages	= <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.pk_pages#">
           </cfquery>

		<cfreturn success>

	</cffunction>

</cfcomponent>
