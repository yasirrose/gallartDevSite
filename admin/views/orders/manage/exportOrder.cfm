<!--- <cfcomponent>
    <cffunction name="getOrdersGridData" access="public" returntype="void"> --->
        

        <!-- Your existing code for the query and CSV output goes here -->
        <!--- <cfset var qOrders = '' /> --->

        <!--- <cfdump var="#form#" abort="true"> --->

        <cfquery name="getGridData" datasource="#application.dsource#">
           
		  SELECT 'A' + CAST (row_number() OVER(ORDER BY O.orderuid) as varchar) as a_orders,'B' + CAST (row_number() OVER(ORDER BY O.orderuid) as varchar) as b_orders, O.orderuid,'C' + CAST (row_number() OVER(ORDER BY O.orderuid) as varchar) as c_orders, C.fname as customer_fname, C.lname as customer_lname, CONVERT(CHAR(9),O.date,6) as orderDate,C.email as customer_email,C.address1, C.city, C.state,C.country, C.zip, C.phone as customer_phone, C.otherphone as customer_otherphone, C.cellphone as customer_cellphone,C.businessphone as customer_businessphone,C.website as customer_website,C.fax as customer_fax,C.driverslicense as customer_driverslicense,L.name as location_name, E.emp_lname + ', ' + E.emp_fname as emp_name,A.emp_lname + ', ' + A.emp_fname as assignedto_name,O.orderuid,O.customerid,O.consultant as order_consultant,O.date,O.saleCode,O.percentMarkdown,O.shipCost,O.insurance,O.discount,O.CardNumber,O.CardExpiry,O.shipMethod,O.tax,O.amountSale,O.Total,O.amountPaid,O.balanceDue,O.framingAmount,O.company as order_company,O.tracking_number,O.estimate,O.incomplete, P.price as product_price, P.name as Title_name
		  FROM   orders AS O
		  INNER JOIN Customers AS C ON C.ID = O.customerid
		  INNER JOIN locations AS L ON O.fk_locations = L.pk_locations
		  INNER JOIN items AS I ON O.OrderID = I.Order_ID
		  LEFT OUTER JOIN products AS P ON I.productUID = P.UID
		  LEFT OUTER JOIN employees AS E ON O.fk_employees = E.pk_employees
		  LEFT OUTER JOIN employees AS A ON C.assignedTo = A.pk_employees
		  WHERE 0=0
		  	
          <cfif form.searchLname neq ''>
				AND C.lname like '#form.searchLname#%'
			</cfif>
			<cfif form.searchCompany neq ''>
				AND O.company like '#form.searchCompany#%'
			</cfif>
			<cfif form.searchFname neq ''>
				AND C.fname like '#form.searchFname#%'
			</cfif>
			<cfif form.searchcountry neq ''>
				AND C.country like '#form.searchcountry#%'
			</cfif>
			<cfif form.searchprice neq ''>
				AND P.price like '#form.searchprice#%'
			</cfif>
			<cfif form.searchAmountSale neq ''>
				AND O.amountSale = '#form.searchAmountSale#'
			</cfif>
		  <cfif form.searchEmail neq ''>
				AND C.email like '#form.searchEmail#%'
			</cfif>
		  <cfif form.searchEmployeeId neq ''>
				AND O.fk_employees = '#form.searchEmployeeId#'
			</cfif>
		  <cfif form.searchTitle neq ''>
				AND P.name like '%#form.searchTitle#%'
			</cfif>
		  <cfif form.searchArtist neq ''>
				AND (P.manufacturer like '%#form.searchArtist#%' OR I.artist like '%#form.searchArtist#%')
			</cfif>
		  <cfif isDefined('form.searchBalancedue') AND form.searchBalancedue EQ 1>
			  AND balancedue > 0
		  </cfif>
		  <cfif form.searchOrigin neq ''>
			  AND origin = '#form.searchOrigin#'
		  </cfif>
		  <cfif form.searchFromDate neq ''>
			  AND cast(O.date as datetime) >= '#dateFormat(form.searchFromDate)#'
		  </cfif>
		  <cfif form.searchToDate neq ''>
			  AND cast(O.date as datetime) <= '#dateFormat(form.searchToDate)#'
		  </cfif>
		  <cfif form.searchStates neq 0>
			  AND UPPER(C.state) = '#ucase(form.searchStates)#'
		  </cfif>
		  <cfif form.searchLexy neq 0>
			  -- AND o.lexy = 1
		  </cfif>
		  <cfif listFindNoCase(session.userinfo.roles,'international')>
			  AND o.lexy = 1
		  <cfelse>
			  AND (o.lexy <> 1 OR o.lexy is null)
		  </cfif>
		  <cfif listFindNoCase(session.userinfo.roles,'b orders')>
			  AND o.B_ORDER = 1
		  <cfelse>
			  AND (o.B_ORDER <> 1 OR o.B_ORDER is null)
		  </cfif>
		 
		  GROUP BY O.orderuid, C.fname, C.lname, C.Email, O.date, C.email, C.address1, C.city, C.state,C.country,C.zip,C.phone,C.otherphone,C.cellphone,C.businessphone,C.website,C.fax,C.driverslicense,L.name, E.emp_lname, E.emp_fname, A.emp_lname, A.emp_fname,O.orderuid,O.customerid,O.consultant,O.date,O.saleCode,O.percentMarkdown,O.shipCost,O.insurance,O.discount,O.CardNumber,O.CardExpiry,O.shipMethod,O.tax,O.amountSale,O.Total,O.amountPaid,O.balanceDue,O.framingAmount,O.company,O.tracking_number,O.businessphone,O.estimate,O.incomplete,P.price, P.name
			
		 
        </cfquery>

        <!--- <cfdump var="#getGridData#" abort="true"> --->
        
        <cfheader name="Content-Disposition" value='attachment; filename="Order_Report#DateFormat(createodbcdate(now()), "yyyymmdd")#.csv"'>
        <cfcontent type="application/csv">
        
        "Order ID","First Name","Last Name","Email","OrderDate","State","Tell","Country","Consultant","Title","Price"
        <cfoutput>
        <cfloop query="getGridData">
            "#getGridData.A_ORDERS#","#getGridData.customer_fname#","#getGridData.customer_lname#","#getGridData.customer_email#","#getGridData.orderDate#","#getGridData.state#","#getGridData.customer_phone#","#getGridData.country#","#getGridData.ORDER_CONSULTANT#","#getGridData.Title_name#","#getGridData.product_price#"
        </cfloop>
        </cfoutput>
        </cfcontent>
    <!--- </cffunction>
</cfcomponent> --->
