<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="all_contacts">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getAllContacts" access="remote" output="false" returntype="any">
	  	
		<cfargument name="allcontacts_lname" required="no" type="string" default="">
		<cfargument name="allcontacts_email" required="no" type="string" default="">
	
		<cfset var returnStruct = structNew() />
		

		   	<cfquery name="qContacts" datasource="#application.dsource#">
		      	SELECT lname,fname,email
		      	FROM users U
				<cfif arguments.allcontacts_lname EQ '' AND arguments.allcontacts_email EQ ''>
					WHERE 0=1
				<cfelse>
					WHERE 0=0
					<cfif arguments.allcontacts_lname NEQ ''>
		      			AND U.lname like '#arguments.allcontacts_lname#%'
					</cfif>
					<cfif arguments.allcontacts_email NEQ ''>
						U.email like '#arguments.allcontacts_lname#%'
					</cfif>
		      	</cfif>
				UNION ALL
				SELECT lname,fname,email 
				FROM leads L
				<cfif arguments.allcontacts_lname EQ '' AND arguments.allcontacts_email EQ ''>
					WHERE 0=1
				<cfelse>
					WHERE 0=0
					<cfif arguments.allcontacts_lname NEQ ''>
		      			AND L.lname like '#arguments.allcontacts_lname#%'
					</cfif>
					<cfif arguments.allcontacts_email NEQ ''>
						L.email like '#arguments.allcontacts_lname#%'
					</cfif>
		      	</cfif>
				UNION ALL
				SELECT lname,fname,email 
				FROM guests G
				<cfif arguments.allcontacts_lname EQ '' AND arguments.allcontacts_email EQ ''>
					WHERE 0=1
				<cfelse>
					WHERE 0=0
					<cfif arguments.allcontacts_lname NEQ ''>
		      			AND G.lname like '#arguments.allcontacts_lname#%'
					</cfif>
					<cfif arguments.allcontacts_email NEQ ''>
						G.email like '#arguments.allcontacts_lname#%'
					</cfif>
		      	</cfif>
				UNION ALL
				SELECT lname,fname,email 
				FROM customers C
				<cfif arguments.allcontacts_lname EQ '' AND arguments.allcontacts_email EQ ''>
					WHERE 0=1
				<cfelse>
					WHERE 0=0
					<cfif arguments.allcontacts_lname NEQ ''>
		      			AND C.lname like '#arguments.allcontacts_lname#%'
					</cfif>
					<cfif arguments.allcontacts_email NEQ ''>
						C.email like '#arguments.allcontacts_lname#%'
					</cfif>
		      	</cfif>
				UNION ALL
				SELECT emp_lname,emp_fname,emp_email 
				FROM employees E
				<cfif arguments.allcontacts_lname EQ '' AND arguments.allcontacts_email EQ ''>
					WHERE 0=1
				<cfelse>
					WHERE 0=0
					<cfif arguments.allcontacts_lname NEQ ''>
		      			AND E.emp_lname like '#arguments.allcontacts_lname#%'
					</cfif>
					<cfif arguments.allcontacts_email NEQ ''>
						E.emp_email like '#arguments.allcontacts_lname#%'
					</cfif>
		      	</cfif>
				UNION ALL
				SELECT lname,fname,email 
				FROM email_imports EI
				<cfif arguments.allcontacts_lname EQ '' AND arguments.allcontacts_email EQ ''>
					WHERE 0=1
				<cfelse>
					WHERE 0=0
					<cfif arguments.allcontacts_lname NEQ ''>
		      			AND EI.lname like '#arguments.allcontacts_lname#%'
					</cfif>
					<cfif arguments.allcontacts_email NEQ ''>
						EI.email like '#arguments.allcontacts_lname#%'
					</cfif>
		      	</cfif>
		   	</cfquery>
			
			<cfsavecontent variable="contactsTable">
			<cfif qContacts.recordcount>
			<table cellspacing="0" cellpadding="2" border="0" width="100%">
				<tr>
					<td colspan="2"><cfoutput>#qContacts.recordcount#</cfoutput> results</td>
				</tr>
				<tr>
					<td style="font-size: 12px;">
						<strong>Name</strong>
					</td>
					<td style="font-size: 12px;">
						<strong>Email</strong>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="font-size: 12px; color: #ff0000;">Click contact to fill fields</td>
				</tr>
				<cfoutput query="qContacts">
				<tr>
					<td style="font-size: 12px;">
						<a href="##" onclick="getContact('#email#');">#lname#</a>, <a href="##" onclick="getContact('#email#');">#fname#</a>
					</td>
					<td style="font-size: 12px;">
						<a href="##" onclick="getContact('#email#');">#email#</a>
					</td>
				</tr>
				</cfoutput>
			</table>
			<cfelse>
				NO RECORDS FOUND
			</cfif>
			</cfsavecontent>

		<cfset returnStruct.qContacts = qContacts />
	   	
   		<cfreturn contactsTable />
	
   	</cffunction>
	
	<!--- for autosuggest --->
	
	<!--- <cffunction name="getAllContactsFromLname" access="remote" output="false" returntype="string">
	  	
		<cfargument name="cfautosuggestvalue" type="string">

		   	<cfquery name="qContacts" datasource="#application.dsource#" maxrows="100">
		      	SELECT lname + '   -   ' + email as lname_email
		      	FROM users U
				WHERE U.lname <> ''
					AND upper(U.lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION
				SELECT lname + '   -   ' + email as lname_email 
				FROM leads L
				WHERE L.lname <> ''
					AND upper(L.lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION
				SELECT lname + '   -   ' + email as lname_email 
				FROM guests G
				WHERE G.lname <> ''
					AND upper(G.lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION
				SELECT lname + '   -   ' + email as lname_email 
				FROM customers C
				WHERE C.lname <> ''
					AND upper(C.email) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION
				SELECT emp_lname + '   -   ' + emp_email as lname_email
				FROM employees E
				WHERE E.emp_lname <> ''
					AND upper(E.emp_lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION
				SELECT lname + '   -   ' + email as lname_email 
				FROM email_imports EI
				WHERE EI.lname <> ''
					AND upper(EI.lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
		   	</cfquery>
			
		<cfreturn valueList(qContacts.lname_email) />
	
   	</cffunction> --->
	
	<cffunction name="getAllContactsFromLname" access="remote" output="false" returntype="string">
	  	
		<cfargument name="cfautosuggestvalue" type="string">

		   	<cfquery name="qContacts" datasource="#application.dsource#" maxrows="100">
		      	SELECT lname + '|' + CAST(pk_users AS varchar(50)) + '|' + 'U' as contactInfo
		      	FROM users U
				WHERE U.lname <> ''
					AND upper(U.lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION ALL
				SELECT lname + '|' + CAST(pk_leads AS varchar(50)) + '|' + 'L' as contactInfo
				FROM leads L
				WHERE L.lname <> ''
					AND upper(L.lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION ALL
				SELECT lname + '|' + CAST(entrynumber AS varchar(50)) + '|' + 'G' as contactInfo
				FROM guests G
				WHERE G.lname <> ''
					AND upper(G.lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION ALL
				SELECT lname + '|' + CAST(id AS varchar(50)) + '|' + 'C' as contactInfo
				FROM customers C
				WHERE C.lname <> ''
					AND upper(C.email) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION ALL
				SELECT emp_lname + '|' + CAST(pk_employees AS varchar(50)) + '|' + 'E' as contactInfo
				FROM employees E
				WHERE E.emp_lname <> ''
					AND upper(E.emp_lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION ALL
				SELECT lname + '|' + CAST(pk_email_imports AS varchar(50)) + '|' + 'I' as contactInfo
				FROM email_imports EI
				WHERE EI.lname <> ''
					AND upper(EI.lname) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
		   	</cfquery>
			
		<cfreturn valueList(qContacts.contactInfo) />
	
   	</cffunction>
	
	<cffunction name="getAllContactsFromEmail" access="remote" output="false" returntype="string">
	  	
		<cfargument name="cfautosuggestvalue" type="string">

		   	<cfquery name="qContacts" datasource="#application.dsource#" maxrows="100">
		      	SELECT email + '|' + CAST(pk_users AS varchar(50)) + '|' + 'U' as contactInfo
		      	FROM users U
				WHERE U.email <> ''
					AND upper(U.email) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION ALL
				SELECT email + '|' + CAST(pk_leads AS varchar(50)) + '|' + 'L' as contactInfo
				FROM leads L
				WHERE L.email <> ''
					AND upper(L.email) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION ALL
				SELECT email + '|' + CAST(entrynumber AS varchar(50)) + '|' + 'G' as contactInfo
				FROM guests G
				WHERE G.email <> ''
					AND upper(G.email) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION ALL
				SELECT email + '|' + CAST(id AS varchar(50)) + '|' + 'C' as contactInfo
				FROM customers C
				WHERE C.email <> ''
					AND upper(C.email) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION ALL
				SELECT emp_email + '|' + CAST(pk_employees AS varchar(50)) + '|' + 'E' as contactInfo
				FROM employees E
				WHERE E.emp_email <> ''
					AND upper(E.emp_email) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
				UNION ALL
				SELECT email + '|' + CAST(pk_email_imports AS varchar(50)) + '|' + 'I' as contactInfo
				FROM email_imports EI
				WHERE EI.email <> ''
					AND upper(EI.email) LIKE upper('#ARGUMENTS.cfautosuggestvalue#%')
		   	</cfquery>
			
		<cfreturn valueList(qContacts.contactInfo) />
	
   	</cffunction>
	
	<cffunction name="getContact" access="remote" returntype="struct">
		<cfargument name="email" type="string">
		
		<cfset var returnStruct = structNew() />

		<cfset var qUser = '' />
		
		<cfquery name="qContact" datasource="#application.dsource#"> 
           	SELECT lname,fname,email,phone,'' as address,'' as city,'' as state,'' as country,'' as zip,cellphone,businessphone,website
		      	FROM users U
				WHERE U.email = '#arguments.email#'
				UNION
				SELECT lname,fname,email,phone,address,city,state,country,zip,cellphone,businessphone,website
				FROM leads L
				WHERE L.email = '#arguments.email#'
				UNION
				SELECT lname,fname,email,'' as phone,'' as address,'' as city,'' as state,'' as country,'' as zip,'' as cellphone,'' as businessphone,'' as website
				FROM guests G
				WHERE G.email = '#arguments.email#'
				UNION
				SELECT lname,fname,email,phone,address1 as address,city,state,country,zip,cellphone,businessphone,website
				FROM customers C
				WHERE C.email = '#arguments.email#'
				UNION
				SELECT emp_lname as lname,emp_fname as fname,emp_email as email,emp_phone as phone,'' as address,'' as city,'' as state,'' as country,'' as zip,'' as cellphone,'' as businessphone,'' as website
				FROM employees E
				WHERE E.emp_email = '#arguments.email#'
				UNION
				SELECT lname,fname,email,'' as phone,'' as address,'' as city,'' as state,'' as country,'' as zip,'' as cellphone,'' as businessphone,'' as website   
				FROM email_imports EI
				WHERE EI.email = '#arguments.email#'
        </cfquery>
		
		<cfloop list="#qContact.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qContact."&idx) />
		</cfloop>
		
		<cfreturn returnStruct />
	
	</cffunction>
	
	<cffunction name="getContactById" access="remote" returntype="struct">
		<cfargument name="thisId" type="string">
		<cfargument name="thisTable" type="string">
		
		<cfset var returnStruct = structNew() />

		<cfset var qUser = '' />
		
		<cfif arguments.thisTable EQ 'U'>
			<cfquery name="qContact" datasource="#application.dsource#"> 
	           	SELECT lname,fname,email,phone,'' as address,'' as city,'' as state,'' as country,'' as zip,cellphone,businessphone,website
			      	FROM users U
					WHERE U.pk_users = #arguments.thisId#
			</cfquery>
		</cfif>
		<cfif arguments.thisTable EQ 'L'>
			<cfquery name="qContact" datasource="#application.dsource#">
					SELECT lname,fname,email,phone,address,city,state,country,zip,cellphone,businessphone,website
					FROM leads L
					WHERE L.pk_leads = #arguments.thisId#
			</cfquery>
		</cfif>
		<cfif arguments.thisTable EQ 'G'>
			<cfquery name="qContact" datasource="#application.dsource#">
					SELECT lname,fname,email,'' as phone,'' as address,'' as city,'' as state,'' as country,'' as zip,'' as cellphone,'' as businessphone,'' as website
					FROM guests G
					WHERE G.entrynumber = #arguments.thisId#
			</cfquery>
		</cfif>
		<cfif arguments.thisTable EQ 'C'>
			<cfquery name="qContact" datasource="#application.dsource#">
					SELECT lname,fname,email,phone,address1 as address,city,state,country,zip,cellphone,businessphone,website
					FROM customers C
					WHERE C.id = #arguments.thisId#
			</cfquery>
		</cfif>
		<cfif arguments.thisTable EQ 'E'>
			<cfquery name="qContact" datasource="#application.dsource#">
					SELECT emp_lname as lname,emp_fname as fname,emp_email as email,emp_phone as phone,'' as address,'' as city,'' as state,'' as country,'' as zip,'' as cellphone,'' as businessphone,'' as website
					FROM employees E
					WHERE E.pk_employees = #arguments.thisId#
			</cfquery>
		</cfif>
		<cfif arguments.thisTable EQ 'I'>
			<cfquery name="qContact" datasource="#application.dsource#">
					SELECT lname,fname,email,'' as phone,'' as address,'' as city,'' as state,'' as country,'' as zip,'' as cellphone,'' as businessphone,'' as website   
					FROM email_imports EI
					WHERE EI.pk_email_imports = #arguments.thisId#
	        </cfquery>
		</cfif>
		
		<cfloop list="#qContact.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qContact."&idx) />
		</cfloop>
		
		<cfreturn returnStruct />
	
	</cffunction>
	
	
	
</cfcomponent>