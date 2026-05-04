<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="bios">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>

	<cffunction name="getBio">
		<cfargument name="id">

		<cfquery name="local.bio" datasource="#application.dsource#">
			SELECT *
			FROM bios
			WHERE pk_bios = <cfqueryparam cfsqltype="cf_sql_numeric" value="#id#">
		 </cfquery>

		 <cfreturn bio>
	</cffunction>

	<cffunction name="getBios" access="remote">

      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="artist" required="no" type="string" default="">

		<!--- <cfdump var="#arguments#" abort="true"> --->

		<cfset var qBios='' />

	   	<cfquery name="qBios" datasource="#application.dsource#">
	      	SELECT * from bios
			WHERE 0=0
			<cfif arguments.artist neq '' and arguments.artist neq 'searchArtist'>
	      		AND artist like '#arguments.artist#%'
	      	</cfif>
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY artist
	      	</cfif>
	   	</cfquery>

   		<cfreturn queryconvertforgrid(qBios,page,pagesize)/>

   	</cffunction>

	<cffunction name="saveBio" access="remote" returntype="struct" output="false">
		<cfargument name="pk_bios" type="numeric" required="true">
		<cfargument name="artist" type="string" required="true">
		<cfargument name="bio" type="string" required="true">

		<cfset var result = { success=false, message="" }>

		<cftry>

			<cfif arguments.pk_bios EQ 0>

				<cfif arguments.artist EQ "" OR arguments.bio EQ "">
					<cfset result.message = "Please select the artist or add Bio">
					<cfreturn result>
				</cfif>

				<cfquery datasource="#application.dsource#">
					INSERT INTO bios (artist, bio)
					VALUES (
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.artist#">,
						<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.bio#">
					)
				</cfquery>

				<cfset result.success = true>
				<cfset result.message = "Bio Added">
				<cfreturn result>

			<cfelse>

				<cfif arguments.bio EQ "">
					<cfset result.message = "Bio cannot be empty">
					<cfreturn result>
				</cfif>

				<cfquery datasource="#application.dsource#">
					UPDATE bios
					SET
						artist = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.artist#">,
						bio    = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.bio#">
					WHERE pk_bios = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pk_bios#">
				</cfquery>

				<cfset result.success = true>
				<cfset result.message = "Bio Updated">
				<cfreturn result>

			</cfif>

			<cfcatch>
				<cfset result.success = false>
				<cfset result.message = cfcatch.detail>
				<cfreturn result>
			</cfcatch>

		</cftry>
	</cffunction>


<cffunction name="deleteBio" access="remote">
	<cfargument name="pk_bios" required="true" type="string">
	<cftry>
		<cfquery datasource="#application.dsource#">
			DELETE  FROM bios
			WHERE pk_bios = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pk_bios#">
		</cfquery>

		<cfset moduleName = 'Bios Module'>
		<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
		<cfset date = now()>				
		<cfset action = 'Insert'>

		<cfquery name="addLog" datasource="#application.dsource#" >
			INSERT INTO logs 
				( moduleName, ipAddress, date, action)
				VALUES
				( '#moduleName#', '#ipAddress#', #date#, '#action#')
		</cfquery>

		<cfreturn "Bio Deleted">
		<cfcatch>
			<cfreturn cfcatch.detail>
		</cfcatch>
	</cftry>
</cffunction>


</cfcomponent>
