<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="reports">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getOrderReport" access="remote">
	  	
		<cfargument name="employeeId" required="no" type="string" default="">
		<cfargument name="previous" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">
		<cfargument name="prevWednesday" required="no" type="string" default="">
		
		<cfset var qOrders='' />

	   	<cfquery name="qOrders" datasource="#application.dsource#">
	      	SELECT 
			O.orderuid,
			O.total,
			O.amountsale,
			O.balancedue,
			O.fk_employees,
			E.emp_fname,
			E.emp_lname,
			E.commission_minus,
			E.commission_percent,
			SUM(CASE productuid WHEN 0 THEN CAST (I.unit_price as money) * I.quantity ELSE P.gallery_price * I.quantity END) AS total_gallery,
			SUM(CASE productuid WHEN 0 THEN CAST (I.unit_price as money) * I.quantity ELSE P.retail_price * I.quantity END) AS total_retail
			FROM orders O
			INNER JOIN items I ON O.OrderID = I.Order_ID 
			INNER JOIN employees AS E ON O.fk_employees = E.pk_employees
			LEFT OUTER JOIN products P ON I.ProductUID = P.UID
			WHERE 0=0
			<cfif arguments.employeeId neq ''>
	      		AND O.fk_employees = '#arguments.employeeId#'
	      	</cfif>
			<cfif arguments.fromDate neq '' AND NOT isDefined('arguments.previous')>
				AND cast(O.date as datetime) >= '#dateFormat(arguments.fromDate)#'
			</cfif>
			<cfif arguments.toDate neq '' AND NOT isDefined('arguments.previous')>
				AND cast(O.date as datetime) <= '#dateFormat(arguments.toDate)#'
			</cfif>
			<cfif isDefined('arguments.previous') AND arguments.previous EQ 'wednesday'>
				AND (cast(O.date as datetime) < '#arguments.prevWednesday#'
				AND cast(O.date as datetime) >= '#dateFormat(dateAdd('d',-7,form.prevWednesday))#')
			</cfif>
			<cfif isDefined('arguments.previous') AND arguments.previous EQ 'week'>
				AND (cast(O.date as datetime) <= '#dateFormat(createODBCDate(now()))#'
				AND cast(O.date as datetime) > '#dateFormat(dateAdd('d',-7,createODBCDate(now())))#')
			</cfif>
			<cfif isDefined('arguments.previous') AND arguments.previous EQ 'month'>
				AND (cast(O.date as datetime) <= '#dateFormat(createODBCDate(now()))#'
				AND cast(O.date as datetime) > '#dateFormat(dateAdd('d',-28,createODBCDate(now())))#')
			</cfif>
			<cfif isDefined('arguments.previous') AND arguments.previous EQ 'year'>
				AND (cast(O.date as datetime) <= '#dateFormat(createODBCDate(now()))#'
				AND cast(O.date as datetime) > '#dateFormat(dateAdd('d',-365,createODBCDate(now())))#')
			</cfif>
			GROUP by O.fk_employees,O.orderuid,O.total,O.amountsale,O.balancedue,E.emp_fname,E.emp_lname,			E.commission_minus,E.commission_percent
			ORDER by O.fk_employees
	   	</cfquery>
	   	
   		<cfreturn qOrders />
	
   	</cffunction>
	
</cfcomponent>