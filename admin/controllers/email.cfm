<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/email" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "email">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>

<cfswitch expression="#Action#">

	<!--- DEFAULT HOME PAGE --->

	<cfdefaultcase>

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/index.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfdefaultcase>

	<!--- IMPORT CSV FILE --->

	<cfcase value="csvImportSearch">

		<cfinclude template="../views/layout.top.cfm" />

		<cfscript>
			getImportListAll	= application.objectFactoryAdmin.getInstance('email').getImportListAll();
		</cfscript>

		<cfinclude template="#ViewPath#/csv_import_search.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<cfcase value="csvImportEnter">

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/csv_import_enter.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<cfcase value="csvImportProc">

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/csv_import_proc.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<cfcase value="csvImportInsert"><cfdump var="##"><cfabort>

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/csv_import_insert.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<!--- MANAGE EMAIL TEMPLATES --->

	<cfcase value="emailTemplates">

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/email_templates.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<!--- EMAIL BLAST PROCESS --->

	<cfcase value="selectTemplate">

		<cfinclude template="../views/layout.top.cfm" />

		<cfparam name="form.pk_emailtemplate" default="0">

		<cfset temp = structDelete(session,'massEmail') />
		<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			DELETE FROM mailer
		</cfquery>

		<cfscript>
			getAllEmailTemplates 	= application.objectFactoryAdmin.getInstance('email').getAllEmailTemplates();
			pk_emailtemplate	 	= application.objectFactoryAdmin.getInstance('email').getEmailTemplate( form.pk_emailtemplate );
			getImportList	 		= application.objectFactoryAdmin.getInstance('email').getImportList();
		</cfscript>

		<cfinclude template="#ViewPath#/select_template.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<cfcase value="editor">
		<cfinclude template="#ViewPath#/editor.cfm" />
	</cfcase>

	<cfcase value="editorEmailTemplate">
		<cfinclude template="#ViewPath#/editorEmailTemplate.cfm" />
	</cfcase>

	<cfcase value="emailCompile">

		<cfinclude template="#ViewPath#/email_compile.cfm">

	</cfcase>

	<cfcase value="insertLoop">

		<cfinclude template="#ViewPath#/insert_loop.cfm">

	</cfcase>

	<cfcase value="insertMailinglist">

		<cfinclude template="#ViewPath#/insert_mailinglist.cfm">

	</cfcase>

	<!--- MAIL TRICKLER --->

	<cfcase value="insertMailinglist2">

		<cfinclude template="#ViewPath#/insert_mailinglist2.cfm">

	</cfcase>

	<cfcase value="mailtrickler">

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/mailtrickler_container.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<!--- END MAIL TRICKLER --->

	<cfcase value="compiledEmails">

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/compiled_emails.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<cfcase value="sendtoTestemail">

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/sendto_testemail.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<cfcase value="viewCompiledList">

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/view_compiled_list.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<cfcase value="sendEmails">

		<cfinclude template="#ViewPath#/send_emails.cfm">

	</cfcase>

	<!--- CLICK REPORT --->

	<cfcase value="clickReport">

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/click_report.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<cfcase value="popEmail">

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/email_pop.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<cfcase value="emailContactsFrame">

		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/email_contacts_frame.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />

	</cfcase>

	<cfcase value="emailContacts">

		<cfscript>
			getEmployeeContactsOrders	= application.objectFactoryAdmin.getInstance('email').getEmployeeContactsOrders();
			getEmployeeContactsLeads		= application.objectFactoryAdmin.getInstance('email').getEmployeeContactsLeads();
			getContactEmailTemplates		= application.objectFactoryAdmin.getInstance('email').getContactEmailTemplates();
			getLatestEmployeeOrderEmail	= application.objectFactoryAdmin.getInstance('email').getLatestEmployeeOrderEmail();
			getRemainingOrderEmails			= application.objectFactoryAdmin.getInstance('email').getRemainingOrderEmails();
		</cfscript>

		<cfinclude template="#ViewPath#/email_contacts.cfm">

	</cfcase>

	<cfcase value="saveEmailTemplate">
		<cfscript>
			saveEmployeeEmail	= application.objectFactoryAdmin.getInstance('email').saveEmployeeEmail(form.emailContent);
		</cfscript>

		<script>
			ColdFusion.Window.hide('emailTemplateWin');
		</script>

	</cfcase>



</cfswitch>

<!--- include main bottom layout --->
