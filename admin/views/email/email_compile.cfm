<cfif NOT structKeyExists(session,'massEmail')>
	<cfset session.massEmail.subject = form.subject />
	<cfset session.massEmail.pk_emailtemplate = form.pk_emailtemplate />
</cfif>

<cfif isDefined('form.table_name')>

	<cfif listfind(form.table_name,'sellers')>
	
		<cfquery name="getUsers" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT pk_users as db_keyvalue,* FROM users
			WHERE email is not null and email <>''
		</cfquery>
		
		<cfset session.qSellers = getUsers />
	
	</cfif>
	
	<cfif listfind(form.table_name,'customers')>
	
		<cfquery name="getCustomers" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT id as db_keyvalue,* FROM customers
			WHERE email is not null and email <>''
		</cfquery>
		
		<cfset session.qCustomers = getCustomers />
		
	</cfif>
	
	<cfif listfind(form.table_name,'leads')>
	
		<cfquery name="getLeads" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT pk_leads as db_keyvalue,* FROM leads
			WHERE email is not null and email <>''
			AND maillist = 1
		</cfquery>
		
		<cfset session.qLeads = getLeads />
		
	</cfif>

</cfif>

	
<cfif isDefined('form.imports') and len(form.imports)>

	<cfquery name="getImports" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT pk_email_imports as db_keyvalue,* FROM email_imports
		WHERE fk_email_imports_list in(#form.imports#)
	</cfquery>
	
	<cfset session.qImports = getImports />
	
</cfif>



<cfparam name="url.listName" default="delete">

<cfswitch expression="#url.listName#">

	<cfcase value="delete">
	
		<!--- <cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			DELETE FROM mailinglist
		</cfquery> --->
		
		<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			DELETE FROM mailer
		</cfquery>
		
		<cflocation url="index.cfm?event=email.emailCompile&listName=sellers" addtoken="No">
	
	</cfcase>

	<cfcase value="sellers">
	
		<cfif structKeyExists(session,'qSellers')>
			
			<cfset session.currQuery = session.qSellers />
			<cfset temp = structDelete(session,'qSellers') />
			<cfset session.emailTable = 'seller' />
			<cfset session.db_table = 'users' />
			<cfset session.db_keyname = 'pk_users' />
			
			<cflocation url="index.cfm?event=email.insertLoop" addtoken="No">
			
		<cfelse>
		
			<cflocation url="index.cfm?event=email.emailCompile&listName=customers" addtoken="No">
			
		</cfif>
	
	</cfcase>
	
	<cfcase value="customers">
	
		<cfif structKeyExists(session,'qCustomers')>
			
			<cfset session.currQuery = session.qCustomers />
			<cfset temp = structDelete(session,'qCustomers') />
			<cfset session.emailTable = 'customer' />
			<cfset session.db_table = 'customers' />
			<cfset session.db_keyname = 'id' />
			
			<cflocation url="index.cfm?event=email.insertLoop" addtoken="No">
			
		<cfelse>
		
			<cflocation url="index.cfm?event=email.emailCompile&listName=leads" addtoken="No">
			
		</cfif>
	
	</cfcase>
	
	<cfcase value="leads">
	
		<cfif structKeyExists(session,'qLeads')>
			
			<cfset session.currQuery = session.qLeads />
			<cfset temp = structDelete(session,'qLeads') />
			<cfset session.emailTable = 'lead' />
			<cfset session.db_table = 'leads' />
			<cfset session.db_keyname = 'pk_leads' />
			
			<cflocation url="index.cfm?event=email.insertLoop" addtoken="No">
			
		<cfelse>
		
			<cflocation url="index.cfm?event=email.emailCompile&listName=imports" addtoken="No">
			
		</cfif>
	
	</cfcase>
	
	<cfcase value="imports">
	
		<cfif structKeyExists(session,'qImports')>
			
			<cfset session.currQuery = session.qImports />
			<cfset temp = structDelete(session,'qImports') />
			<cfset session.emailTable = 'import' />
			<cfset session.db_table = 'email_imports' />
			<cfset session.db_keyname = 'pk_email_imports' />
			
			<cflocation url="index.cfm?event=email.insertLoop" addtoken="No">
			
		<cfelse>
		
			<cflocation url="index.cfm?event=email.emailCompile&listName=end" addtoken="No">
			
		</cfif>
	
	</cfcase>
	
	<cfcase value="end">
	
		<!--- <cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			DELETE FROM mailinglist
			WHERE pk_mailinglist NOT IN 
		          (SELECT Min(pk_mailinglist)
		           FROM mailinglist
		           GROUP BY email)
		</cfquery>
		<cflocation addtoken="No" url="index.cfm?event=email.compiledEmails&subject=#session.massEmail.subject#&pk_emailtemplate=#session.massEmail.pk_emailtemplate#"> --->

		<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			DELETE FROM mailer
			WHERE id NOT IN 
		          (SELECT Min(id)
		           FROM mailer
		           GROUP BY EmailAddr)
		</cfquery>
		
		<cflocation addtoken="No" url="index.cfm?event=email.mailtrickler">
	
		<!--- <cflocation addtoken="No" url="index.cfm?event=email.mailtrickler"> --->
	
	</cfcase>
	
	
</cfswitch>




