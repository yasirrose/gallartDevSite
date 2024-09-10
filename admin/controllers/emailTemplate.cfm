<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/emailTemplate" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "emailTemplate">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

    <cfcase value="emailContactsFrame">
        <cfscript>
            getEmployeeContactsOrders = application.objectFactoryAdmin.getInstance('email').getEmployeeContactsOrders();
            getEmployeeContactsLeads = application.objectFactoryAdmin.getInstance('email').getEmployeeContactsLeads();
            getContactEmailTemplates = application.objectFactoryAdmin.getInstance('email').getContactEmailTemplates();
            getLatestEmployeeOrderEmail = application.objectFactoryAdmin.getInstance('email').getLatestEmployeeOrderEmail();
            getRemainingOrderEmails = application.objectFactoryAdmin.getInstance('email').getRemainingOrderEmails();
        </cfscript>
        <cfinclude template="#ViewPath#/emailContactsFrame.cfm">
    </cfcase>
    
    <cfcase value="editorEmailTemplate">
        <cfinclude template="#ViewPath#/editorEmailTemplate.cfm">
    </cfcase>
    
    <cfdefaultcase>
        <cfscript>
            getStates = application.objectFactoryAdmin.getInstance('orders').getStates();
        </cfscript>
        <cfinclude template="#ViewPath#/index.cfm">
    </cfdefaultcase>

</cfswitch>



<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />