<cfif isDefined('form.table_name')>

	<cfif listfind(form.table_name,'sellers')>
	
		<cfquery name="getUsers" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * FROM users
			WHERE email is not null and email <>''
		</cfquery>
		
		<cfset session.qSellers = getUsers />
	
	</cfif>
	
	<cfif listfind(form.table_name,'customers')>
	
		<cfquery name="getCustomers" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * FROM customers
			WHERE email is not null and email <>''
		</cfquery>
		
		<cfset session.qCustomers = getCustomers />
		
	</cfif>
	
	<cfif listfind(form.table_name,'leads')>
	
		<cfquery name="getLeads" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * FROM leads
			WHERE email is not null and email <>''
			AND maillist = 1
		</cfquery>
		
		<cfset session.qLeads = getLeads />
		
	</cfif>

	<cfif listfind(form.table_name,'appraisals')>
	
		<cfquery name="getAppraisals" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * FROM appraisal
			WHERE email is not null and email <>''
			AND maillist = 1
		</cfquery>
		
		<cfset session.qAppraisals = getAppraisals />
		
	</cfif>

	<cfif listfind(form.table_name,'quotes')>
	
		<cfquery name="getQuotes" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * FROM quotes
			WHERE email is not null and email <>''
			AND maillist = 1
		</cfquery>
		
		<cfset session.qQuotes = getQuotes />
		
	</cfif>

</cfif>

	
<cfif isDefined('form.imports') and len(form.imports)>

	<cfquery name="getImports" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT * FROM email_imports
		WHERE fk_email_imports_list in(#form.imports#)
	</cfquery>
	
	<cfset session.qImports = getImports />
	
</cfif>



<cfparam name="url.listName" default="delete">

<cfswitch expression="#url.listName#">

	<cfcase value="delete">
	
		<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			DELETE FROM mailinglist_export
		</cfquery>
		
		<cflocation url="index.cfm?event=exports.emailCompile&listName=sellers" addtoken="No">
	
	</cfcase>

	<cfcase value="sellers">
	
		<cfif structKeyExists(session,'qSellers')>
			
			<cfset session.currQuery = session.qSellers />
			<cfset temp = structDelete(session,'qSellers') />
			<cfset session.emailTable = 'seller' />
			
			<cflocation url="index.cfm?event=exports.insertLoop" addtoken="No">
			
		<cfelse>
		
			<cflocation url="index.cfm?event=exports.emailCompile&listName=customers" addtoken="No">
			
		</cfif>
	
	</cfcase>
	
	<cfcase value="customers">
	
		<cfif structKeyExists(session,'qCustomers')>
			
			<cfset session.currQuery = session.qCustomers />
			<cfset temp = structDelete(session,'qCustomers') />
			<cfset session.emailTable = 'customer' />
			
			<cflocation url="index.cfm?event=exports.insertLoop" addtoken="No">
			
		<cfelse>
		
			<cflocation url="index.cfm?event=exports.emailCompile&listName=leads" addtoken="No">
			
		</cfif>
	
	</cfcase>
	
	<cfcase value="leads">
	
		<cfif structKeyExists(session,'qLeads')>
			
			<cfset session.currQuery = session.qLeads />
			<cfset temp = structDelete(session,'qLeads') />
			<cfset session.emailTable = 'lead' />
			
			<cflocation url="index.cfm?event=exports.insertLoop" addtoken="No">
			
		<cfelse>
		
			<cflocation url="index.cfm?event=exports.emailCompile&listName=appraisals" addtoken="No">
			
		</cfif>
	
	</cfcase>

	<cfcase value="appraisals">
	
		<cfif structKeyExists(session,'qAppraisals')>
			
			<cfset session.currQuery = session.qAppraisals />
			<cfset temp = structDelete(session,'qAppraisals') />
			<cfset session.emailTable = 'appraisal' />
			
			<cflocation url="index.cfm?event=exports.insertLoop" addtoken="No">
			
		<cfelse>
		
			<cflocation url="index.cfm?event=exports.emailCompile&listName=quotes" addtoken="No">
			
		</cfif>
	
	</cfcase>

	<cfcase value="quotes">
	
		<cfif structKeyExists(session,'qQuotes')>
			
			<cfset session.currQuery = session.qQuotes />
			<cfset temp = structDelete(session,'qQuotes') />
			<cfset session.emailTable = 'quote' />
			
			<cflocation url="index.cfm?event=exports.insertLoop" addtoken="No">
			
		<cfelse>
		
			<cflocation url="index.cfm?event=exports.emailCompile&listName=imports" addtoken="No">
			
		</cfif>
	
	</cfcase>

	
	<cfcase value="imports">
	
		<cfif structKeyExists(session,'qImports')>
			
			<cfset session.currQuery = session.qImports />
			<cfset temp = structDelete(session,'qImports') />
			<cfset session.emailTable = 'import' />
			
			<cflocation url="index.cfm?event=exports.insertLoop" addtoken="No">
			
		<cfelse>
		
			<cflocation url="index.cfm?event=exports.emailCompile&listName=end" addtoken="No">
			
		</cfif>
	
	</cfcase>
	
	<cfcase value="end">
	
		<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			DELETE FROM mailinglist_export
			WHERE pk_mailinglist_export NOT IN 
		          (SELECT Min(pk_mailinglist_export)
		           FROM mailinglist_export
		           GROUP BY email)
		</cfquery>

		<cflocation addtoken="No" url="index.cfm?event=exports.compiledEmails">
	
	</cfcase>
	
	
</cfswitch>




