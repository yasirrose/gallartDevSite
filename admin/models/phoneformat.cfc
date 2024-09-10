<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="phoneformat">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>

	<cfset customers_table = "customers" />
	<cfset leads_table = "leads" />
	<cfset users_table = "users" />

	<cffunction name="getUnformattedCustomers" access="remote">
	
	   	<cfquery name="qPhone" datasource="#application.dsource#">	
	   		SELECT phone
	   		from #customers_table# 
	   		where phone <> ''
	   		and phone_formatted is null
	   	</cfquery>
	   	<cfquery name="qCellphone" datasource="#application.dsource#">	
	   		SELECT cellphone
	   		from #customers_table# 
	   		where cellphone <> ''
	   		and cellphone_formatted is null
	   	</cfquery>
	   	<cfquery name="qBusinessphone" datasource="#application.dsource#">	
	   		SELECT businessphone
	   		from #customers_table# 
	   		where businessphone <> ''
	   		and businessphone_formatted is null
	   	</cfquery>

   		<cfset tot_count = qPhone.recordcount + qCellphone.recordcount + qBusinessphone.recordcount />
	   	
   		<cfreturn tot_count />
	
   	</cffunction>

   	<cffunction name="getUnformattedLeads" access="remote">
	
	   	<cfquery name="qPhone" datasource="#application.dsource#">	
	   		SELECT phone
	   		from #leads_table# 
	   		where phone <> ''
	   		and phone_formatted is null
	   	</cfquery>
	   	<cfquery name="qCellphone" datasource="#application.dsource#">	
	   		SELECT cellphone
	   		from #leads_table# 
	   		where cellphone <> ''
	   		and cellphone_formatted is null
	   	</cfquery>
	   	<cfquery name="qBusinessphone" datasource="#application.dsource#">	
	   		SELECT businessphone
	   		from #leads_table# 
	   		where businessphone <> ''
	   		and businessphone_formatted is null
	   	</cfquery>

   		<cfset tot_count = qPhone.recordcount + qCellphone.recordcount + qBusinessphone.recordcount />
	   	
   		<cfreturn tot_count />
	
   	</cffunction>

   	<cffunction name="getUnformattedSellers" access="remote">
		<cfquery name="qPhone" datasource="#application.dsource#">	
	   		SELECT phone
	   		from #users_table# 
	   		where phone <> ''
	   		and phone_formatted is null
	   	</cfquery>
	   	<cfquery name="qCellphone" datasource="#application.dsource#">	
	   		SELECT cellphone
	   		from #users_table# 
	   		where cellphone <> ''
	   		and cellphone_formatted is null
	   	</cfquery>
	   	<cfquery name="qBusinessphone" datasource="#application.dsource#">	
	   		SELECT businessphone
	   		from #users_table# 
	   		where businessphone <> ''
	   		and businessphone_formatted is null
	   	</cfquery>

   		<cfset tot_count = qPhone.recordcount + qCellphone.recordcount + qBusinessphone.recordcount />
	   	
   		<cfreturn tot_count />
	
   	</cffunction>
	

	<cffunction name="getNumbers" access="remote">
	  	
      	<cfargument name="db" required="yes">

      	<cfset var qNumbers='' />
      	<cfset var phonetype='' />
      	<cfset var tableKey='' />
      	<cfset var tableName='' />
	
		
		<cfif arguments.db EQ "customers">
			<cfset tableKey = "id" />
			<cfset tableName = "customers" />
			<cfquery name="qPhone" datasource="#application.dsource#">
		   		SELECT top 20 id as primaryKey, phone
		   		from #arguments.db#
		   		WHERE phone_formatted is null
		   	</cfquery>

		   	<cfif qPhone.recordcount>
		   		<cfset qNumbers = qPhone />
		   		<cfset phonetype = "phone" />
		   	<cfelse>
		   		<cfquery name="qCellphone" datasource="#application.dsource#">
			   		SELECT top 20 id as primaryKey, cellphone as phone
			   		from #arguments.db#
			   		WHERE cellphone_formatted is null
			   	</cfquery>
			   	<cfif qCellphone.recordcount>
			   		<cfset qNumbers = qCellphone />
			   		<cfset phonetype = "cellphone" />
			   	<cfelse>
			   		<cfquery name="qBusinessphone" datasource="#application.dsource#">
				   		SELECT top 20 id as primaryKey, businessphone as phone 
				   		from #arguments.db#
				   		WHERE businessphone_formatted is null
				   	</cfquery>
				   	<cfif qBusinessphone.recordcount>
			   			<cfset qNumbers = qBusinessphone />
			   			<cfset phonetype = "businessphone" />
			   		<cfelse>
			   			<cfquery name="qEmpty" datasource="#application.dsource#">
					   		SELECT * from #arguments.db# 
					   		WHERE 0=1
					   	</cfquery>
					   	<cfset qNumbers = qEmpty />
			   		</cfif>
			   	</cfif>
		   	</cfif>
		<cfelseif arguments.db EQ "leads">
			<cfset tableKey = "pk_leads" />
			<cfset tableName = "leads" />
			<cfquery name="qPhone" datasource="#application.dsource#">
		   		SELECT top 20 pk_leads as primaryKey, phone from #arguments.db#
		   		WHERE phone_formatted is null
		   	</cfquery>

		   	<cfif qPhone.recordcount>
		   		<cfset qNumbers = qPhone />
		   		<cfset phonetype = "phone" />
		   	<cfelse>
		   		<cfquery name="qCellphone" datasource="#application.dsource#">
			   		SELECT top 20 pk_leads as primaryKey, cellphone as phone from #arguments.db#
			   		WHERE cellphone_formatted is null
			   	</cfquery>
			   	<cfif qCellphone.recordcount>
			   		<cfset qNumbers = qCellphone />
			   		<cfset phonetype = "cellphone" />
			   	<cfelse>
			   		<cfquery name="qBusinessphone" datasource="#application.dsource#">
				   		SELECT top 20 pk_leads as primaryKey, businessphone as phone from #arguments.db#
				   		WHERE businessphone_formatted is null
				   	</cfquery>
				   	<cfif qBusinessphone.recordcount>
			   			<cfset qNumbers = qBusinessphone />
			   			<cfset phonetype = "businessphone" />
			   		<cfelse>
			   			<cfquery name="qEmpty" datasource="#application.dsource#">
					   		SELECT * from #arguments.db# 
					   		WHERE 0=1
					   	</cfquery>
					   	<cfset qNumbers = qEmpty />
			   		</cfif>
			   	</cfif>
		   	</cfif>
		<cfelseif arguments.db EQ "users">
			<cfset tableKey = "pk_users" />
			<cfset tableName = "users" />
			<cfquery name="qPhone" datasource="#application.dsource#">
		   		SELECT top 20 pk_users as primaryKey, phone from #arguments.db#
		   		WHERE phone_formatted is null
		   	</cfquery>

		   	<cfif qPhone.recordcount>
		   		<cfset qNumbers = qPhone />
		   		<cfset phonetype = "phone" />
		   	<cfelse>
		   		<cfquery name="qCellphone" datasource="#application.dsource#">
			   		SELECT top 20 pk_users as primaryKey, cellphone as phone from #arguments.db#
			   		WHERE cellphone_formatted is null
			   	</cfquery>
			   	<cfif qCellphone.recordcount>
			   		<cfset qNumbers = qCellphone />
			   		<cfset phonetype = "cellphone" />
			   	<cfelse>
			   		<cfquery name="qBusinessphone" datasource="#application.dsource#">
				   		SELECT top 20 pk_users as primaryKey, businessphone as phone from #arguments.db#
				   		WHERE businessphone_formatted is null
				   	</cfquery>
				   	<cfif qBusinessphone.recordcount>
			   			<cfset qNumbers = qBusinessphone />
			   			<cfset phonetype = "businessphone" />
			   		<cfelse>
			   			<cfquery name="qEmpty" datasource="#application.dsource#">
					   		SELECT * from #arguments.db# 
					   		WHERE 0=1
					   	</cfquery>
					   	<cfset qNumbers = qEmpty />
			   		</cfif>
			   	</cfif>
		   	</cfif>
		</cfif>

		<cfif qNumbers.recordcount>
			<cfset phonetypeArr = arrayNew( 1 ) />
			<cfset phonetypeArr[1] = phonetype />
			<cfset QueryAddColumn(qNumbers, 'phonetype', 'cf_sql_varchar', phonetypeArr)/>
			<cfset tableNameArr = arrayNew( 1 ) />
		   	<cfset tableNameArr[1] = tableName />
		   	<cfset QueryAddColumn(qNumbers, 'tableName', 'cf_sql_varchar', tableNameArr)/>
		   	<cfset tableKeyArr = arrayNew( 1 ) />
		   	<cfset tableKeyArr[1] = tableKey />
		   	<cfset QueryAddColumn(qNumbers, 'tableKey', 'cf_sql_varchar', tableKeyArr)/>
		   	<cfloop query="qNumbers">
		   		<cfset QuerySetCell(qNumbers, 'phonetype', phonetype)/>
		   		<cfset QuerySetCell(qNumbers, 'tableName', tableName) />
		   		<cfset QuerySetCell(qNumbers, 'tableKey', tableKey) />
		   	</cfloop>

		</cfif>
			
   		<cfreturn qNumbers />
	
   	</cffunction>

		
</cfcomponent>