<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="email">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	
<cffunction name="getEmailTemplates" access="remote" output="false" returntype="any">
   	<cfargument name="page">
   	<cfargument name="pageSize">
   	<cfargument name="gridsortcolumn">
   	<cfargument name="gridsortdirection">
	
	<cfset var ps = pageSize>
    <cfset var qGetEmailTemplates = "" />
    <cfset var totalPages = "" />
	
		<cfquery name="qGetEmailTemplates" datasource="#application.dsource#">
			SELECT * FROM emailtemplate
			<cfif gridsortcolumn neq "" and gridsortdirection neq ""> 
	            order by #gridsortcolumn# #gridsortdirection#
	        </cfif> 
		</cfquery>
		
	 <cfreturn QueryConvertForGrid(qGetEmailTemplates, page, pageSize)>
</cffunction>

<cffunction name="getAllEmailTemplates" access="remote" output="false" returntype="query">
	
		<cfquery name="qTemplates" datasource="#application.dsource#">
			SELECT * FROM emailtemplate
		</cfquery>
		
	 <cfreturn qTemplates>
</cffunction>

<cffunction name="getContactEmailTemplates" access="remote" output="false" returntype="query">
	
		<cfquery name="qTemplates" datasource="#application.dsource#">
			SELECT * FROM emailtemplate
			WHERE email_name like '%contact email%'
		</cfquery>
		
	 <cfreturn qTemplates>
</cffunction>

<cffunction name="getEmailTemplate" access="remote" output="false" returntype="query">
		<cfargument name="pk_emailtemplate" type="numeric" required="true" default="0">
		
		<cfquery name="qTemplate" datasource="#application.dsource#">
			SELECT * FROM emailtemplate
			WHERE pk_emailtemplate = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pk_emailtemplate#"> 
		</cfquery>
		
	 <cfreturn qTemplate>
</cffunction>

<cffunction name="saveEmailTemplate" access="remote">
    <cfargument name="pk_emailtemplate" type="numeric" required="true" default="0">
    <cfargument name="email_name" type="string" required="true">
    <cfargument name="email_content" type="string" required="true">
	
    <cftry>
    <cfif arguments.pk_emailtemplate EQ "0">
	
        <cfquery datasource="#application.dsource#">
	        INSERT INTO emailtemplate
	        (
	            email_name,
	            email_content
	        )
	        VALUES
	        (
	            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email_name#">,
	            <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.email_content#">
	        )
        </cfquery>
        <cfreturn "EmailTemplate Added">
    
    <cfelse>
    
	     <cfquery datasource="#application.dsource#">
	       	UPDATE emailtemplate SET
			 	email_name =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email_name#">,
	            email_content = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#arguments.email_content#">
	      	WHERE pk_emailtemplate = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pk_emailtemplate#" />  
	    </cfquery>
		
		<cfreturn "EmailTemplate Updated">
	</cfif>   
	
	    <cfcatch>
	        <cfreturn cfcatch.detail>
	    </cfcatch>
    </cftry>
	
</cffunction>
	
<cffunction name="deleteEmailTemplate" access="remote">
	<cfargument name="pk_emailtemplate" required="true" type="string">
	<cftry>
		<cfquery datasource="#application.dsource#">
			DELETE  FROM emailtemplate
			WHERE pk_emailtemplate = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pk_emailtemplate#">
		</cfquery>
		<cfreturn "EmailTemplate Deleted">
		<cfcatch>
			<cfreturn cfcatch.detail>
		</cfcatch>
	</cftry>
</cffunction>

<cffunction name="getImportList" access="remote" output="false" returntype="query">
		
		<cfquery name="qImports" datasource="#application.dsource#">
			SELECT count(*) as importCount,import_name,IL.pk_email_imports_list from email_imports_list IL
			INNER JOIN email_imports I
			on IL.pk_email_imports_list = I.fk_email_imports_list
			group by import_name,pk_email_imports_list
		</cfquery>
		
	 <cfreturn qImports>
</cffunction>

<cffunction name="getImportListAll" access="remote" output="false" returntype="query">
		
		<cfquery name="qImports" datasource="#application.dsource#">
			SELECT * from email_imports_list
		</cfquery>
		
	 <cfreturn qImports>
</cffunction>

<cffunction name="getEmailsSent" access="remote" output="false" returntype="string">

		<cfargument name="fk_emailtemplate" required="true" type="string">
		
		<cfset var qEmails='' />
		
		<cfquery name="qEmails" datasource="#application.dsource#">
			SELECT * from email_log
			WHERE fk_emailtemplate = #arguments.fk_emailtemplate#
		</cfquery>
		
	 <cfreturn qEmails.recordcount>
</cffunction>

<cffunction name="getClickins" access="remote" output="false" returntype="string">

		<cfargument name="fk_emailtemplate" required="true" type="string">
		
		<cfset var qClicks='' />
		
		<cfquery name="qClicks" datasource="#application.dsource#">
			SELECT DISTINCT EL.email
			FROM email_tracker AS ET 
			INNER JOIN email_log AS EL ON ET.fk_email_log = EL.pk_email_log
			WHERE EL.fk_emailtemplate = #arguments.fk_emailtemplate#
			ORDER BY EL.email
		</cfquery>
		
	 <cfreturn qClicks.recordcount>
</cffunction>

<!--- temp - pop server --->

<cffunction name="popEmail" access="remote" output="false">

	<cfargument name="page" required="yes">
   	<cfargument name="pageSize" required="yes">
   	<cfargument name="gridsortcolumn" required="yes">
   	<cfargument name="gridsortdirection" required="yes">
<!--- 6598 to 10317 --->
	<cfpop 
	  server = "#application.email_server#"
	  username = "info@onlinegalleryart.us"
	  password = "#application.email_password#"
	  action = "getHeaderOnly"
	  name = "popmail"
	  timeout = "60"
	  startRow = "6598"
	  generateUniqueFilenames = "no"
	  maxrows="100"
	  >
	  
	<cfquery name="qEmail" dbtype="query">
		SELECT * FROM popmail
	</cfquery>
	  
	 <cfreturn queryconvertforgrid(qEmail,page,pagesize)/>
  
 </cffunction>
 
<!--- <cffunction name="getEmployeeContacts" access="remote">
 		<cfargument name="count" required="no">
		<cfargument name="date_from" required="no">
	
		<cfset var qContacts='' />
		
	   	<cfquery name="qContacts" datasource="#application.dsource#">
			SELECT lname,fname,email from orders O
			INNER JOIN employees E on O.fk_employees = E.pk_employees
			WHERE E.pk_employees = #session.userinfo.pk_employees#
			AND email is not null
			AND email <> ''
			UNION
			SELECT lname,fname,email from leads L
			INNER JOIN employees E on L.fk_employees = E.pk_employees
			WHERE E.pk_employees = #session.userinfo.pk_employees#
			AND email is not null
			AND email <> ''
	   	</cfquery>
		
   		<cfreturn qContacts />
	
</cffunction>--->

 <cffunction name="getEmployeeContactsOrders" access="remote">
	<cfargument name="count" required="no">
	<cfargument name="date_from" required="no">

	<cfset var qContacts='' />
	
	<cfquery name="qContacts" datasource="#application.dsource#">
		SELECT lname,fname,email,employee_email from orders O
		INNER JOIN employees E on O.fk_employees = E.pk_employees
		WHERE E.pk_employees = #session.userinfo.pk_employees#
		AND email is not null
		AND email <> ''
		GROUP BY lname,fname,email,employee_email
		ORDER BY email
	</cfquery>
	
	<cfreturn qContacts />
	
</cffunction>

<cffunction name="getEmployeeContactsLeads" access="remote">
	<cfargument name="count" required="no">
	<cfargument name="date_from" required="no">

	<cfset var qContacts='' />
	
	<cfquery name="qContacts" datasource="#application.dsource#">
		SELECT lname,fname,email,employee_email from leads L
		INNER JOIN employees E on L.fk_employees = E.pk_employees
		WHERE E.pk_employees = #session.userinfo.pk_employees#
		AND email is not null
		AND email <> ''
		GROUP BY lname,fname,email,employee_email
		ORDER BY email
	</cfquery>
	
	<cfreturn qContacts />
	
</cffunction>

 <cffunction name="emailEmployeeContactsOrders" access="remote">
	<cfargument name="mailToMe" default="" required="yes">
 	
	<cfset var returnStruct = structNew() />
		
	<cfquery name="qTemplate" datasource="#application.dsource#">
		SELECT top 1 * from employee_email
		WHERE fk_employee = #session.userinfo.pk_employees#
		ORDER BY pk_employee_email desc
	</cfquery>
	
	<cfset latestEmail = getLatestEmployeeOrderEmail().pk_employee_email />

	<cfquery name="qContacts" datasource="#application.dsource#">
		SELECT top 1 * from orders O
		INNER JOIN employees E on O.fk_employees = E.pk_employees
		WHERE E.pk_employees = #session.userinfo.pk_employees#
		AND email is not null
		AND email <> ''
		AND (fk_employee_email <> #latestEmail# OR fk_employee_email IS NULL)
		ORDER by email
	</cfquery>
	
	<cfif arguments.mailToMe NEQ "emailToMe">
	
		<cfquery name="addDatestamp" datasource="#application.dsource#">
			UPDATE orders SET
			employee_email = '#dateFormat(dateAdd("h",3,createODBCDateTime(now())))# #timeFormat(dateAdd("h",3,createODBCDateTime(now())))#',
			fk_employee_email =#qTemplate.pk_employee_email#
			WHERE email = '#qContacts.email#'
		</cfquery>
	
	</cfif>
		
	<cfif qContacts.recordcount>
		<cftry>
			<cfif qContacts.fname NEQ ''>
				<cfset salutation = "Dear #capFirst(qContacts.fname)#," />
			<cfelse>
				<cfset salutation = "Dear Valued Customer," />
			</cfif>
			<cfset recipient = session.userinfo.email />
			<cfif arguments.mailToMe EQ "">
				<cfset recipient = qContacts.email />
			</cfif>
			<cfset closer = "Sincerely,<br>#qContacts.emp_fname# #qContacts.emp_lname#<br><a href='http://www.gallart.com'>Gallart.com</a>" />
			<cfscript>
				sendMail	= application.objectFactoryAdmin.getInstance('mailer').sendMail(
					sender = session.userinfo.email,
					recipient = recipient,
					subject = "Gallart",
					body = qTemplate.emailContent,
					salutation = salutation,
					closer = closer
				);
			</cfscript>

			<cfcatch></cfcatch>
		
		</cftry>

	</cfif>
	
	<cfset returnStruct.recordcount = qContacts.recordcount />
	<cfset returnStruct.email = qContacts.email />
	
	<cfreturn returnStruct />
	
</cffunction>

 <cffunction name="emailEmployeeContactsLeads" access="remote">
 
 		<cfset var returnStruct = structNew() />
 
 		<cfquery name="qContacts" datasource="#application.dsource#">
			SELECT top 1 * from leads L
			INNER JOIN employees E on L.fk_employees = E.pk_employees
			WHERE E.pk_employees = #session.userinfo.pk_employees#
			AND email is not null
			AND email <> ''
			AND (employee_email is null OR employee_email = '')
			order by email
		</cfquery>
		
		<cfif qContacts.recordcount>
			<cfset salutation = "Dear #qContacts.fname#" />
			<!---<cfscript>
				sendMail	= application.objectFactoryAdmin.getInstance('mailer').sendMail(
					sender = qContacts.email,
					recipient = "steverucker@gmail.com",
					subject = "testing",
					body = "test body",
					salutation = salutation 
				);
			</cfscript>--->
			
			<cftry>
			
			<cfquery name="addDatestamp" datasource="#application.dsource#">
				UPDATE leads SET
				employee_email = '#dateFormat(createODBCDate(now()))#'
				WHERE email = '#qContacts.email#'
			</cfquery>
			
			<cfcatch></cfcatch>
			
			</cftry>

		</cfif>
		
		<cfset returnStruct.recordcount = qContacts.recordcount />
		<cfset returnStruct.email = qContacts.email />
		
		<cfreturn returnStruct />
	
</cffunction>

<cffunction name="saveEmployeeEmail" access="remote">
 	<cfargument name="emailContent" type="string" required="yes">
	
		<cfquery name="qTemplate" datasource="#application.dsource#">
			INSERT INTO employee_email
			(
				fk_employee,
				datestamp,
				emailContent
			)
			values
			(
				#session.userinfo.pk_employees#,
				#createODBCDatetime(now())#,
				'#arguments.emailContent#'
			)
		</cfquery>
 
 </cffunction>
 
 <cffunction name="getLatestEmployeeOrderEmail" access="remote" returntype="query">
	
		<cfquery name="qTemplate" datasource="#application.dsource#">
			SELECT top 1 * from employee_email
			WHERE  fk_employee = #session.userinfo.pk_employees#
			ORDER BY pk_employee_email desc
		</cfquery>
		
		<cfreturn qTemplate />
 
 </cffunction>
 
  <cffunction name="getRemainingOrderEmails" access="remote" returntype="query">
  
		<cfset latestEmail = getLatestEmployeeOrderEmail().pk_employee_email />
		
		<cfquery name="qEmailsOrders" datasource="#application.dsource#">
			SELECT * from orders
			WHERE  fk_employees = #session.userinfo.pk_employees#
			AND fk_employee_email = '#latestEmail#' 
		</cfquery>
		
		<cfreturn qEmailsOrders />
 
 </cffunction>

	<cffunction name="capFirst" access="public" output="false" returntype="String">
			<cfargument name="inputString" required="false" type="String" default="" />
			<cfreturn rereplace(lcase(arguments.inputString), "(\b\w)", "\u\1", "all") />
	</cffunction>
	
	<cffunction name="getOptouts" access="remote">
		<cfargument name="email" required="no" type="string" default="">
		
		<cfset var qOptouts='' />
		
	   	<cfquery name="qOptouts" datasource="#application.dsource#">
	      	SELECT *
	      	FROM optout
			WHERE 0=0
			<cfif arguments.email neq ''>
	      		AND email like '#arguments.email#%'
	      	</cfif>
	      	ORDER BY datestamp desc
	   	</cfquery>
	
   		<cfreturn qOptouts />
	
   	</cffunction>

	 
<!--- <cffunction name="getEmployeeContacts" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
	
	
		<cfset var qContacts='' />
		
	   	<cfquery name="qContacts" datasource="#application.dsource#">
			SELECT lname,fname,email from orders O
			INNER JOIN employees E on O.fk_employees = E.pk_employees
			WHERE E.pk_employees = #session.userinfo.pk_employees#
			AND email is not null
			AND email <> ''
			UNION
			SELECT lname,fname,email from leads L
			INNER JOIN employees E on L.fk_employees = E.pk_employees
			WHERE E.pk_employees = #session.userinfo.pk_employees#
			AND email is not null
			AND email <> ''
	   	</cfquery>
		
   		<cfreturn queryconvertforgrid(qContacts,page,pagesize)/>
	
</cffunction>--->


</cfcomponent>