<!--- include main top layout --->
<cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/reports" />

<cfif session.loggedin EQ false AND listFirst(event,'.') eq "reports">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>
	
<cfswitch expression="#Action#">

	<cfcase value="orderReportSearch">
	
		<cfscript>
			getAllEmployees = application.objectFactoryAdmin.getInstance('employees').getAllEmployees();
		</cfscript>
	
		<cfinclude template="#ViewPath#/order_report_search.cfm">
		
	</cfcase>

	<cfcase value="orderReportResults">
	
		<cfset thisDate = createODBCDate(now()) />
		<cfif (4 - dayofweek(thisDate)) EQ 0>
			<cfset form.prevWednesday = dateFormat(thisDate) />
		<cfelseif (4 - dayofweek(thisDate)) LT 0>
			<cfset form.prevWednesday = dateFormat(dateAdd('d',4 - dayofweek(thisDate),thisDate)) />
		<cfelseif (4 - dayofweek(thisDate)) GT 0>
			<cfset form.prevWednesday = dateFormat(dateAdd('d',4 - dayofweek(thisDate)-7,thisDate)) />
		</cfif>
	
		<cfscript>
			getOrderReport	= application.objectFactoryAdmin.getInstance('reports').getOrderReport( argumentcollection=form );
		</cfscript>
	
		<cfinclude template="#ViewPath#/order_report_results.cfm">
		
	</cfcase>
	
	
</cfswitch>

<!--- include main bottom layout --->
<cfinclude template="../views/layout.bottom.cfm" />