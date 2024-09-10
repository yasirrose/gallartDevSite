<!--- include main top layout --->

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/leads" />

<cfif session.loggedin EQ false AND event eq "leads.manageLeads">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>

<cfswitch expression="#Action#">

	<cfdefaultcase>
		<cfinclude template="../views/layout.top.cfm" />

		<cfscript>
			getAllLeads = application.objectFactoryAdmin.getInstance('leads').getAllLeads();
			getStates	 = application.objectFactoryAdmin.getInstance('orders').getStates();
		</cfscript>

		<cfinclude template="#ViewPath#/index.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfdefaultcase>


	<cfcase value="manageLeads">
		<cfinclude template="../views/layout.top.cfm" />

		<cfparam name="url.searchEmployeeId" default="" />
		<cfparam name="form.searchEmployeeId" default="#url.searchEmployeeId#" />

		<cfscript>
			getStates	 = application.objectFactoryAdmin.getInstance('orders').getStates();
			getEmployees = application.objectFactoryAdmin.getInstance('employees').getAllEmployees();
		</cfscript>

		<cfinclude template="#ViewPath#/manage/index.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfcase>

	<cfcase value="sendEmailToLead">
		<!--- <cfparam name="url.searchEmployeeId" default="" />
		<cfparam name="form.searchEmployeeId" default="#url.searchEmployeeId#" />

		<cfscript>
			getStates	 = application.objectFactoryAdmin.getInstance('orders').getStates();
			getEmployees = application.objectFactoryAdmin.getInstance('employees').getAllEmployees();
		</cfscript> --->
		<cfinclude template="#ViewPath#/manage/sendEmailToLead.cfm">
	</cfcase>

	<cfcase value="insertLead">
		<cfinclude template="../views/layout.top.cfm" />

		<cfscript>
			getEmployee = application.objectFactoryAdmin.getInstance('employees').getEmployeeFromPassword( form.password );
			form.fk_employees = getEmployee.pk_employees;
			insertLead = application.objectFactoryAdmin.getInstance('leads').editLeadFromForm( argumentcollection = form );
		</cfscript>

		<cflocation url="index.cfm?event=leads&leadInserted=1" addtoken="No" />

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfcase>

	<cfcase value="emailLead">
		<cfinclude template="../views/layout.top.cfm" />

		<cfparam name="form.sender" default="info@gallart.com" />

		<cfsavecontent variable="emailBody">
			<cfoutput>
			Dear #form.recipientFname# #form.recipientLname#,<br><br>
			#form.leadEmailBody#
			<br><br>
			Sincerely,<br>
			#session.userinfo.fname# #session.userinfo.lname#<br>
			<a href="http://www.gallart.com">www.gallart.com</a>
			</cfoutput>
		</cfsavecontent>


		<cfif LEN(session.userinfo.email)>
			<cfset form.sender = session.userinfo.email />
		</cfif>
		<cfset form.recipient = form.recipientEmail />
		<cfset form.subject = form.leadEmailSubject />
		<cfset form.body = emailBody />

		<cfscript>
			emailLead = application.objectFactoryAdmin.getInstance('mailer').sendMail( argumentcollection = form );
		</cfscript>

		<cfif form.existingEmpId EQ 0>

			<cfscript>
				assignLead = application.objectFactoryAdmin.getInstance('leads').assignLead( pk_leads = form.emailLeadId, fk_employees = form.emailEmpId );
			</cfscript>

			<script>
				parent.refreshMe();
			</script>

		</cfif>

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfcase>


</cfswitch>

<!--- include main bottom layout --->

