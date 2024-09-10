<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="quotes">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getQuotes" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
		<cfargument name="Title" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">
	
	
		<cfset var qQuotes='' />
		
		
	   	<cfquery name="qQuotes" datasource="#application.dsource#">
	      	SELECT datestamp as quoteDate,email as quote_email,*
	      	FROM quotes 
			WHERE 0=0
			<cfif arguments.Lname neq ''>
	      		AND lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND email like '#arguments.Email#%'
	      	</cfif>
			<cfif arguments.Title neq ''>
	      		AND title like '#arguments.Title#%'
	      	</cfif>
			<cfif arguments.fromDate neq ''>
				AND datestamp >= '#dateFormat(arguments.fromDate)#'
			</cfif>
			<cfif arguments.toDate neq ''>
				AND datestamp <= '#dateFormat(arguments.toDate)#'
			</cfif>
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY datestamp desc
	      	</cfif>
	   	</cfquery>
		
		<cfif qQuotes.recordcount EQ 0><cfset pagesize = 0 /></cfif>
	   	
   		<cfreturn queryconvertforgrid(qQuotes,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getQuoteFromId" access="remote" returntype="struct">
		<cfargument name="pk_quotes" type="numeric">
		
		<cfset var returnStruct = structNew() />

		<cfset var qQuote = '' />
		
		<cfquery name="qQuote" datasource="#application.dsource#"> 
           	SELECT email as quote_email,* from quotes
            WHERE pk_quotes = #arguments.pk_quotes#
        </cfquery>
	
		 <cfloop list="#qQuote.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qQuote."&idx) />
		</cfloop>
		
		<cfreturn returnStruct />
	
	</cffunction>
	
		
	<cffunction name="deleteQuotes" access="remote">
		<cfargument name="pk_quotes" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
	
		<cfquery name="deleteGuest" datasource="#application.dsource#"> 
           	DELETE from quotes
            WHERE pk_quotes = '#arguments.pk_quotes#'
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	
</cfcomponent>