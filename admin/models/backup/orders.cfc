<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="orders">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>

	<cffunction name="processNewOrder" access="remote" returntype="struct">

		<cfset var returnStruct = structNew() />
		<cfset var orderId = 0 />

		<cfset returnStruct.thisOrderId = 0 />
		<cfset returnStruct.success = true />
		<cfset returnStruct.error = "" />

		<cftry>

			<cfscript>
				getEmployee = application.objectFactoryAdmin.getInstance('employees').getEmployeeFromPassword( session.invoiceinfo.password );
				editCustomer = application.objectFactoryAdmin.getInstance('customers').editCustomer();
			</cfscript>

			<cfset returnStruct.editCustomer = editCustomer />

			<cfif editCustomer.success EQ true>

				<!--- Set orderid for cc processing --->
				<cfset orderid='#lsdateformat(now(), 'yymmdd')##lstimeformat(now(), 'hhmmss')#' />
				<cfset orderid= trim(orderid) />
				<cfset FK_LOCATIONS = 1 />
				<cfset FK_EMPLOYEES = getEmployee.pk_employees />
				<CFSET IPADDRESS = '' />
				<CFSET REFERRINGPAGE = '' />
				<CFSET ENTRYPOINT = '' />
				<CFSET LINKFROM = '' />
				<CFSET WARNING = '' />
				<CFSET PARTNER = '' />


				<CFSET SHIPNAME = session.invoiceinfo.fname&' '&session.invoiceinfo.lname />
				<CFSET SHIPADDRESS1 = session.invoiceinfo.address1 />
				<CFSET SHIPADDRESS2 = '' />
				<CFSET SHIPCITY = session.invoiceinfo.city />
				<CFSET SHIPSTATE = session.invoiceinfo.state />
				<CFSET SHIPCOUNTRY = session.invoiceinfo.country />
				<CFSET SHIPZIP = session.invoiceinfo.zip />
				<CFSET SHIPPHONE = session.invoiceinfo.phone />
				<CFSET SHIPMETHOD = '' />
				<CFSET INSURANCE = 0 />
				<CFSET BILLNAME = session.invoiceinfo.fname&' '&session.invoiceinfo.lname />
				<CFSET FNAME = session.invoiceinfo.fname />
				<CFSET LNAME = session.invoiceinfo.lname />
				<CFSET BILLADDRESS1 = session.invoiceinfo.address1 />
				<CFSET BILLADDRESS2 = '' />
				<CFSET BILLCITY = session.invoiceinfo.city />
				<CFSET BILLSTATE = session.invoiceinfo.state />
				<CFSET BILLCOUNTRY = session.invoiceinfo.country />
				<CFSET BILLZIP = session.invoiceinfo.zip />
				<CFSET BILLPHONE = session.invoiceinfo.phone />
				<CFSET OTHERPHONE = session.invoiceinfo.otherphone />
				<CFSET CELLPHONE = session.invoiceinfo.cellphone />
				<CFSET CONSULTANT = session.invoiceinfo.consultant />
				<CFSET COMPANY = session.invoiceinfo.company />
				<CFSET DRIVERSLICENSE = session.invoiceinfo.driverslicense />
				<CFSET TOBESHIPPED = session.invoiceinfo.tobeshipped />
				<CFSET EMAIL = session.invoiceinfo.email />
				<CFSET SHIPPING = 0 />
				<CFSET PAYMENT_METHOD = session.invoiceinfo.payment_method />
				<CFSET CARDNUMBER = session.invoiceinfo.CardNumber />
				<CFSET CARDEXPIRY = session.invoiceinfo.cardexpm&'/'&session.invoiceinfo.cardexpy />
				<CFSET COMMENTS = session.invoiceinfo.special_instructions />
				<CFSET ORIGIN = session.invoiceinfo.origin />
				<CFSET XSS = '' />
				<CFSET TBC = 0 />
				<CFSET BUSINESSPHONE = session.invoiceinfo.businessphone />
				<CFSET WEBSITE = session.invoiceinfo.website />
				<CFSET ESTIMATE = session.invoiceinfo.estimate />
				<cfif structKeyExists(session.invoiceinfo,'incomplete')>
					<CFSET INCOMPLETE = 1 />
				<cfelse>
					<CFSET INCOMPLETE = 0 />
				</cfif>

				<!--- <cfif session.tobeshipped.tax eq ''>
					<CFSET TOBESHIPPED	= 0 />
				<cfelse>
					<CFSET TOBESHIPPED	= session.invoiceInfo.tobeshipped />
				</cfif> --->

				<CFSET AMOUNTSALE 	= session.invoiceInfo.amountsalevalue />
				<cfif session.invoiceInfo.tax eq ''>
					<CFSET TAX	= 0 />
				<cfelse>
					<CFSET TAX	= session.invoiceInfo.tax />
				</cfif>
				<CFSET TOTAL	 	= session.invoiceInfo.totalSaleValue />
				<cfif session.invoiceInfo.shipping eq ''>
					<CFSET SHIPCOST	= 0 />
				<cfelse>
					<CFSET SHIPCOST	= session.invoiceInfo.shipping />
				</cfif>
				<cfif session.invoiceInfo.amountpaid eq ''>
					<CFSET AMOUNTPAID	= 0 />
				<cfelse>
					<CFSET AMOUNTPAID	= session.invoiceInfo.amountpaid />
				</cfif>

				<CFSET BALANCEDUE	= session.invoiceInfo.balanceDueValue />

				<cfquery name="qOrders" datasource="#application.dsource#">
		           	INSERT INTO orders
						(
							customerid,
							ORDERID,
							FK_LOCATIONS,
							FK_EMPLOYEES,
							SHIPNAME,
							SHIPADDRESS1,
							SHIPADDRESS2,
							SHIPCITY,
							SHIPSTATE,
							SHIPCOUNTRY,
							SHIPZIP,
							SHIPPHONE,
							SHIPMETHOD,
							INSURANCE,
							BILLNAME,
							FNAME,
							LNAME,
							BILLADDRESS1,
							BILLADDRESS2,
							BILLCITY,
							BILLSTATE,
							BILLCOUNTRY,
							BILLZIP,
							BILLPHONE,
							OTHERPHONE,
							CELLPHONE,
							CONSULTANT,
							COMPANY,
							DRIVERSLICENSE,
							TOBESHIPPED,
							EMAIL,
							IPADDRESS,
							REFERRINGPAGE,
							ENTRYPOINT,
							SHIPPING,
							PAYMENT_METHOD,
							CARDNUMBER,
							CARDEXPIRY,
							COMMENTS,
							LINKFROM,
							WARNING,
							PARTNER,
							XSS,
							TBC,
							AMOUNTSALE,
							TAX,
							TOTAL,
							SHIPCOST,
							AMOUNTPAID,
							BALANCEDUE,
							ORIGIN,
							BUSINESSPHONE,
							WEBSITE,
							ESTIMATE,
							INCOMPLETE
							<cfif listFindNoCase(session.userinfo.roles,'international')>
								,LEXY
							</cfif>
							<cfif listFindNoCase(session.userinfo.roles,'b orders')>
								,B_ORDER
							</cfif>
						)
						VALUES
						(
							'#editCustomer.thisCustomerId#',
							'#ORDERID#',
							'#FK_LOCATIONS#',
							'#FK_EMPLOYEES#',
							'#SHIPNAME#',
							'#SHIPADDRESS1#',
							'#SHIPADDRESS2#',
							'#SHIPCITY#',
							'#SHIPSTATE#',
							'#SHIPCOUNTRY#',
							'#SHIPZIP#',
							'#SHIPPHONE#',
							'#SHIPMETHOD#',
							'#INSURANCE#',
							'#BILLNAME#',
							'#FNAME#',
							'#LNAME#',
							'#BILLADDRESS1#',
							'#BILLADDRESS2#',
							'#BILLCITY#',
							'#BILLSTATE#',
							'#BILLCOUNTRY#',
							'#BILLZIP#',
							'#BILLPHONE#',
							'#OTHERPHONE#',
							'#CELLPHONE#',
							'#CONSULTANT#',
							'#COMPANY#',
							'#DRIVERSLICENSE#',
							'#TOBESHIPPED#',
							'#EMAIL#',
							'#IPADDRESS#',
							'#REFERRINGPAGE#',
							'#ENTRYPOINT#',
							'#SHIPPING#',
							'#PAYMENT_METHOD#',
							'#CARDNUMBER#',
							'#CARDEXPIRY#',
							'#COMMENTS#',
							'#LINKFROM#',
							'#WARNING#',
							'#PARTNER#',
							'#xss#',
							#TBC#,
							#AMOUNTSALE#,
							#TAX#,
							#TOTAL#,
							'#SHIPCOST#',
							#AMOUNTPAID#,
							#BALANCEDUE#,
							'#ORIGIN#',
							'#BUSINESSPHONE#',
							'#WEBSITE#',
							#ESTIMATE#,
							#INCOMPLETE#
							<cfif listFindNoCase(session.userinfo.roles,'international')>
								,1
							</cfif>
							<cfif listFindNoCase(session.userinfo.roles,'b orders')>
								,1
							</cfif>
						)
						SELECT @@identity as uid
		        </cfquery>

		        <cfquery name="qInternationalOrders" datasource="#application.dsource#">
		        	SELECT O.orderuid
					FROM   orders AS O
					INNER JOIN Customers AS C ON C.ID = O.customerid
					INNER JOIN locations AS L ON O.fk_locations = L.pk_locations
					INNER JOIN items AS I ON O.OrderID = I.Order_ID
					LEFT OUTER JOIN products AS P ON I.productUID = P.UID
					LEFT OUTER JOIN employees AS E ON O.fk_employees = E.pk_employees
					LEFT OUTER JOIN employees AS A ON C.assignedTo = A.pk_employees
					WHERE lexy = 1
					GROUP BY O.orderuid, C.fname, C.lname, C.Email, O.date, C.email, C.address1, C.city, C.state,C.country,C.zip,C.phone,C.otherphone,C.cellphone,C.businessphone,C.website,C.fax,C.driverslicense,L.name, E.emp_lname, E.emp_fname, A.emp_lname, A.emp_fname,O.orderuid,O.customerid,O.consultant,O.date,O.saleCode,O.percentMarkdown,O.shipCost,O.insurance,O.discount,O.CardNumber,O.CardExpiry,O.shipMethod,O.tax,O.amountSale,O.Total,O.amountPaid,O.balanceDue,O.framingAmount,O.company,O.tracking_number,O.businessphone,O.estimate,O.incomplete
				</cfquery>

				<cfquery name="qBOrders" datasource="#application.dsource#">
		        	SELECT O.orderuid
					FROM   orders AS O
					INNER JOIN Customers AS C ON C.ID = O.customerid
					INNER JOIN locations AS L ON O.fk_locations = L.pk_locations
					INNER JOIN items AS I ON O.OrderID = I.Order_ID
					LEFT OUTER JOIN products AS P ON I.productUID = P.UID
					LEFT OUTER JOIN employees AS E ON O.fk_employees = E.pk_employees
					LEFT OUTER JOIN employees AS A ON C.assignedTo = A.pk_employees
					WHERE B_ORDER = 1
					GROUP BY O.orderuid, C.fname, C.lname, C.Email, O.date, C.email, C.address1, C.city, C.state,C.country,C.zip,C.phone,C.otherphone,C.cellphone,C.businessphone,C.website,C.fax,C.driverslicense,L.name, E.emp_lname, E.emp_fname, A.emp_lname, A.emp_fname,O.orderuid,O.customerid,O.consultant,O.date,O.saleCode,O.percentMarkdown,O.shipCost,O.insurance,O.discount,O.CardNumber,O.CardExpiry,O.shipMethod,O.tax,O.amountSale,O.Total,O.amountPaid,O.balanceDue,O.framingAmount,O.company,O.tracking_number,O.businessphone,O.estimate,O.incomplete
				</cfquery>

		        <cfset returnStruct.thisOrderId = qOrders.uid />

		        <cfif listFindNoCase(session.userinfo.roles,'international')>
			<!--		<cfset returnStruct.thisDisplayOrderId = "C" & (qInternationalOrders.recordcount + 1) />
				<cfelseif listFindNoCase(session.userinfo.roles,'b orders')>>
					<cfset returnStruct.thisDisplayOrderId = "B" & (qBOrders.recordcount + 1) />
				<cfelse>
					<cfset returnStruct.thisDisplayOrderId = "A" & qOrders.uid />
				</cfif>
-->

			<cfelse>

				<cfset returnStruct.success = false />

			</cfif>

			<cfcatch type="any"><cfset returnStruct.error = cfcatch.detail /><cfset returnStruct.success = false /></cfcatch>
		</cftry>


		<cfif returnStruct.success EQ true>
			<!--- ENTER ITEMS --->

			<cfloop from="1" to="#arrayLen(session.orderArray)#" index="idx">
				<cfset thisQuantity = evaluate('session.invoiceinfo.QUANTITY_'&idx) />
				<cfset thisPrice = evaluate('session.invoiceinfo.PRICE_'&idx) />
				<cfset product_code = '0001-'&session.orderArray[idx][5] />
				<cfquery name="qItems" datasource="#application.dsource#">
					INSERT into items
					(
						OrderUID,
						ORDER_ID,
						product_code,
						modelno,
						productUID,
						quantity,
						framing,
						unit_price
						<cfif session.orderArray[idx][1] EQ 0>
							,title
							,artist
							,shortDesc
						</cfif>
					)
					VALUES
					(
						<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#returnStruct.thisOrderId#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#orderid#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#product_code#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.orderArray[idx][5]#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.orderArray[idx][1]#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#thisQuantity#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.orderArray[idx][8]#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#thisPrice#">
						<cfif session.orderArray[idx][1] EQ 0>
							,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.orderArray[idx][2]#">
							,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.orderArray[idx][3]#">
							,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.orderArray[idx][4]#">
						</cfif>
					)
				</cfquery>

			</cfloop>

		</cfif>


		<cfreturn returnStruct />

	</cffunction>


	<cffunction name="getOrders" access="remote">

      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Company" required="no" type="string" default="">
		<cfargument name="AmountSale" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
		<cfargument name="Employee" required="no" type="string" default="">
		<cfargument name="Title" required="no" type="string" default="">
		<cfargument name="Artist" required="no" type="string" default="">
		<cfargument name="Balancedue" required="no" type="string" default="">
		<cfargument name="Origin" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">
        <cfargument name="state" required="no" type="string" default="0">
        <cfargument name="lexy" required="no" type="string" default="0">

		<cfset var qOrders='' />

	   	<cfquery name="qOrders" datasource="#application.dsource#">
			SELECT 'A' + CAST (row_number() OVER(ORDER BY O.orderuid) as varchar) as a_orders,'B' + CAST (row_number() OVER(ORDER BY O.orderuid) as varchar) as b_orders, O.orderuid,'C' + CAST (row_number() OVER(ORDER BY O.orderuid) as varchar) as c_orders, C.fname as customer_fname, C.lname as customer_lname, CONVERT(CHAR(9),O.date,6) as orderDate,C.email as customer_email,C.address1, C.city, C.state,C.country, C.zip, C.phone as customer_phone, C.otherphone as customer_otherphone, C.cellphone as customer_cellphone,C.businessphone as customer_businessphone,C.website as customer_website,C.fax as customer_fax,C.driverslicense as customer_driverslicense,L.name as location_name, E.emp_lname + ', ' + E.emp_fname as emp_name,A.emp_lname + ', ' + A.emp_fname as assignedto_name,O.orderuid,O.customerid,O.consultant as order_consultant,O.date,O.saleCode,O.percentMarkdown,O.shipCost,O.insurance,O.discount,O.CardNumber,O.CardExpiry,O.shipMethod,O.tax,O.amountSale,O.Total,O.amountPaid,O.balanceDue,O.framingAmount,O.company as order_company,O.tracking_number,O.estimate,O.incomplete
			FROM   orders AS O
			INNER JOIN Customers AS C ON C.ID = O.customerid
			INNER JOIN locations AS L ON O.fk_locations = L.pk_locations
			INNER JOIN items AS I ON O.OrderID = I.Order_ID
			LEFT OUTER JOIN products AS P ON I.productUID = P.UID
			LEFT OUTER JOIN employees AS E ON O.fk_employees = E.pk_employees
			LEFT OUTER JOIN employees AS A ON C.assignedTo = A.pk_employees
			WHERE 0=0
			<cfif arguments.Lname neq ''>
	      		AND C.lname like '#arguments.Lname#%'
	      	</cfif>
	      	<cfif arguments.Company neq ''>
	      		AND O.company like '#arguments.Company#%'
	      	</cfif>
	      	<cfif arguments.AmountSale neq ''>
	      		AND O.amountSale = '#arguments.AmountSale#'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND C.email like '#arguments.Email#%'
	      	</cfif>
			<cfif arguments.Employee neq ''>
	      		AND O.fk_employees = '#arguments.Employee#'
	      	</cfif>
			<cfif arguments.Title neq ''>
	      		AND P.name like '%#arguments.Title#%'
	      	</cfif>
			<cfif arguments.Artist neq ''>
	      		AND (P.manufacturer like '%#arguments.Artist#%' OR I.artist like '%#arguments.Artist#%')
	      	</cfif>
			<cfif isDefined('arguments.Balancedue') AND arguments.Balancedue EQ 1>
				AND balancedue > 0
			</cfif>
			<cfif arguments.Origin neq ''>
				AND origin = '#arguments.Origin#'
			</cfif>
			<cfif arguments.fromDate neq ''>
				AND cast(O.date as datetime) >= '#dateFormat(arguments.fromDate)#'
			</cfif>
			<cfif arguments.toDate neq ''>
				AND cast(O.date as datetime) <= '#dateFormat(arguments.toDate)#'
			</cfif>
            <cfif arguments.state neq 0>
				AND UPPER(C.state) = '#ucase(arguments.state)#'
			</cfif>
			<cfif arguments.lexy neq 0>
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
			<!---<cfif session.userinfo.password EQ 'admin12345'>
	      		AND (o.lexy <> 1 OR o.lexy is null)
	      		AND (cast(O.date as datetime) >= '#dateFormat('01/01/2014')#' AND
	      			cast(O.date as datetime) <= '#dateFormat('12/31/2014')#'
	      			)
	      	</cfif>--->
			GROUP BY O.orderuid, C.fname, C.lname, C.Email, O.date, C.email, C.address1, C.city, C.state,C.country,C.zip,C.phone,C.otherphone,C.cellphone,C.businessphone,C.website,C.fax,C.driverslicense,L.name, E.emp_lname, E.emp_fname, A.emp_lname, A.emp_fname,O.orderuid,O.customerid,O.consultant,O.date,O.saleCode,O.percentMarkdown,O.shipCost,O.insurance,O.discount,O.CardNumber,O.CardExpiry,O.shipMethod,O.tax,O.amountSale,O.Total,O.amountPaid,O.balanceDue,O.framingAmount,O.company,O.tracking_number,O.businessphone,O.estimate,O.incomplete
	      	<cfif gridsortcolumn neq ''>
				<cfif gridsortcolumn EQ 'orderDate'>
					ORDER BY cast(O.date as datetime) #gridsortdirection#
				<cfelse>
					ORDER BY #gridsortcolumn# #gridsortdirection#
				</cfif>

			<cfelse>
				ORDER BY cast(O.date as datetime) desc
	      	</cfif>
	   	</cfquery>

   		<cfreturn queryconvertforgrid(qOrders,page,pagesize)/>

   	</cffunction>

	<!--- <cffunction name="getOrderReport" access="remote" returntype="query">

		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
		<cfargument name="Employee" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">

		<cfset var qOrders='' />

	   	<cfquery name="qOrders" datasource="#application.dsource#">
	      	SELECT *
	      	FROM orders O
			INNER JOIN customers C on C.ID = O.customerID
			LEFT OUTER JOIN employees E ON O.fk_employees = E.pk_employees
			WHERE 0=0
			<cfif arguments.Employee neq ''>
	      		AND O.fk_employees = '#arguments.Employee#'
	      	</cfif>
			<cfif arguments.Lname neq ''>
	      		AND C.lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND C.email like '#arguments.Email#%'
	      	</cfif>
			<cfif arguments.fromDate neq ''>
				AND cast(O.date as datetime) >= '#dateFormat(arguments.fromDate)#'
			</cfif>
			<cfif arguments.toDate neq ''>
				AND cast(O.date as datetime) <= '#dateFormat(arguments.toDate)#'
			</cfif>
	   	</cfquery>

   		<cfreturn qOrders />

   	</cffunction> --->

	<cffunction name="getOrder" access="remote" returntype="struct">

      	<cfargument name="orderuid" type="string" default="">

		<cfset var returnStruct = structNew() />
		<cfset var qItems ='' />
		<cfset var itemTable ='' />

		<cfquery name="qOrderItems" datasource="#application.dsource#">
	      	SELECT  P.name as productTitle,P.manufacturer as productArtist,I.unit_price as price,I.id as itemId,I.framing as itemFraming,C.email as customer_email,CAST(C.zip as CHAR(100)) as customer_zip,*
			FROM orders O
			INNER JOIN items I ON O.OrderID = I.Order_ID
			INNER JOIN customers C on C.ID = O.customerID
			LEFT OUTER JOIN products P ON I.ProductUID = P.UID
			LEFT OUTER JOIN employees E ON O.fk_employees = E.pk_employees
			LEFT OUTER JOIN employees A ON C.assignedTo = A.pk_employees
			WHERE O.orderuid = '#arguments.orderuid#'
			AND (I.Product_ID IS NULL OR (I.Product_ID IS NOT NULL AND I.Product_ID <> 'tax'))
	   	</cfquery>

		<cfscript>
			getCancelcodeOptions = application.objectFactory.getInstance('orders').getCancelcodeOptions();
		</cfscript>

		<cfsavecontent variable="itemTable">
		<table bgcolor="FFFFFF">
			<tr bgcolor="000000">
				<td width="150" style="color: #FFFFFF;">Title</td>
				<td width="100" style="color: #FFFFFF;">Artist</td>
				<td width="75" style="color: #FFFFFF;">Price</td>
				<td width="75" style="color: #FFFFFF;">&nbsp;</td>
				<!---<td width="25" style="color: #FFFFFF;">Quantity</td>--->
				<td width="75" style="color: #FFFFFF;">Status</td>
				<td width="50" style="color: #FFFFFF;">&nbsp;</td>
				<td width="25" style="color: #FFFFFF;">&nbsp;</td>
				<!--- <td width="75" style="color: #FFFFFF;">Commission</td> --->
			</tr>
			<cfoutput query="qOrderItems">
			<input type="Hidden" name="isCanceled_#itemId#" id="#itemId#" value="0">
			<!--- if item is in products table --->
			<cfset thisCommission = commission />
			<cfset thisCancelcode = cancelcode />
			<cfif len(productTitle)>
				<cfset thisTitle = productTitle />
			<cfelse>
				<cfset thisTitle = title />
			</cfif>
			<cfif len(productArtist)>
				<cfset thisArtist = productArtist />
			<cfelse>
				<cfset thisArtist = artist />
			</cfif>
			<tr>
				<td>#thisTitle#</td>
				<td>#thisArtist#</td>
				<td align="right">#dollarFormat(price)#</td>
				<td align="center"><cfif itemFraming eq 1>FRAMING</cfif></td>
				<!---<td align="center">#quantity#</td>--->
				<td>
					<select name="cancelcodeOptionsId_#itemId#" onchange="updateSubtotal(this.value,'#thisCancelcode#','#price#','#itemId#')">
						<cfloop query="getCancelcodeOptions">
							<option value="#cancelcode_name#" <cfif cancelcode_name EQ thisCancelcode>selected</cfif>>#cancelcode_name#</option>
						</cfloop>
					</select>
				</td>
				<td>
					<input type="button" value="EDIT" onclick="openItemEditWindow('#itemId#')" />
				</td>
				<td>
					<input type="button" value="DEL" onclick="deleteOrderItem('#itemId#','#arguments.orderuid#')" />
				</td>
				<!--- <td>
					<cfif listfind(session.userinfo.roles,'sa')>
						<cfset commission_list = "A - .01,B - .05,C - .10" />
						<select name="commission_#itemId#">
							<cfloop list="#commission_list#" index="idx">
								<option value="#idx#" <cfif idx EQ thisCommission>selected</cfif>>#idx#</option>
							</cfloop>
						</select>
					<cfelse>
						#thisCommission#
					</cfif>
				</td> --->
			</tr>
			</cfoutput>
		</table>
		<cfoutput>
		<table bgcolor="##FFFFFF">
			<tr>
				<td>
					<input type="button" value="ADD NEW ITEM" onclick="openItemAddWindow('#arguments.orderuid#')" />
				</td>
			</tr>
		</table>
		</cfoutput>
		</cfsavecontent>

		<cfset returnStruct['itemTable'] = itemTable />

		<cfloop list="#qOrderItems.ColumnList#" index="idx">
			<cfset returnStruct[idx] = "" />
		</cfloop>

		<cfset orderItemsList = "AMOUNTSALE,TAX,INSURANCE,SHIPCOST,TOTAL,DISCOUNT,AMOUNTPAID,BALANCEDUE,TOBESHIPPED,INCOMPLETE,CUSTOMER_EMAIL,COMMENTS,PAYMENT_METHOD,SHIPMETHOD,ORIGIN,LEXY" />
		<cfloop list="#orderItemsList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qOrderItems."&idx) />
		</cfloop>


		<cfset returnStruct['customer_zip'] = " "&qOrderItems.customer_zip />

		<cfreturn returnStruct />

   	</cffunction>

	<cffunction name="editProductOrder" access="remote" output="false" returntype="boolean">
	    <cfargument name="form" type="struct">

	    <cfset var success = true />

	    	<cftry>

				<cfquery name="editCustomer" datasource="#application.dsource#">
	                UPDATE customers SET
	                fname 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.fname#">,
	                lname 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.lname#">,
					address1 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.address1#">,
					city 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.city#">,
					state 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.state#">,
					country 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.country#">,
					zip 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.zip#">,
					email 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.customer_email#">,
					phone 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.customer_phone#">,
					otherphone		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.customer_otherphone#">,
					cellphone 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.customer_cellphone#">,
					businessphone 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.customer_businessphone#">,
					website 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.customer_website#">,
					driverslicense 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.customer_driverslicense#">,
					fax 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.customer_fax#">
	                WHERE id 	= #form.customerid#
	            </cfquery>

				<cfquery name="editProductOrder" datasource="#application.dsource#">
	                UPDATE orders SET
					consultant 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.consultant#">,
					company 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.company#">,
					<cfif isDefined('form.framing')>
						framing = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="1">,
					<cfelse>
						framing = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="0">,
					</cfif>
					<cfif isDefined('form.estimate') AND form.estimate EQ 1>
						estimate = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="1">,
					<cfelse>
						estimate = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="0">,
					</cfif>
					<cfif isDefined('form.lexy')>
						lexy = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="1">,
					<cfelse>
						lexy = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="0">,
					</cfif>
	                CardNumber 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.CardNumber#">,
					CardExpiry 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.CardExpiry#">,
					amountSale 	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#parseDollarFormat(form.amountSaleDisplay)#">,
					tax 		= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#parseDollarFormat(form.taxDisplay)#">,
					shipcost 	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#parseDollarFormat(form.shipCostDisplay)#">,
					shipMethod 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.shipMethod#">,
					insurance 	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#parseDollarFormat(form.insuranceDisplay)#">,
					total 		= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#form.totalValue#">,
					discount 	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#parseDollarFormat(form.discountDisplay)#">,
					amountpaid 	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#parseDollarFormat(form.amountPaidDisplay)#">,
					balancedue 	= <cfqueryparam cfsqltype="CF_SQL_MONEY" value="#iif(LEN(form.balanceDueValue),DE('#form.balanceDueValue#'),DE('0'))#">,
					tracking_number = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.tracking_number#">,
					comments 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.comments#">,
					origin 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.origin#">
					<cfif isDefined('form.complete') AND form.complete EQ 1>
						,incomplete = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="0">
					</cfif>
                    ,date 		= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.date#">
	                WHERE orderuid = #form.orderuid#
	            </cfquery>

				<cfloop collection="#form#" item="idx">
					<cfif left(idx,20) EQ 'cancelcodeOptionsId_'>
					<cfset itemId = mid(idx,21,100) />
					<cfset cancelcode = evaluate('form.'&idx) />
						<cfquery name="editProductOrder" datasource="#application.dsource#">
			                UPDATE items SET
			                cancelcode = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cancelcode#">
			                WHERE id = #itemId#
			            </cfquery>
					</cfif>
				</cfloop>
				<!---<cfloop collection="#form#" item="idx">
					<cfif left(idx,11) EQ 'commission_'>
					<cfset itemId = mid(idx,12,100) />
					<cfset commission = evaluate('form.'&idx) />
						<cfquery name="editProductOrder" datasource="#application.dsource#">
			                UPDATE items SET
							commission = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#commission#">
			                WHERE id = #itemId#
			            </cfquery>
					</cfif>
				</cfloop>--->
			<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>

		<cfreturn success>

	</cffunction>


	<cffunction name="deleteOrder" access="remote">
		<cfargument name="orderuid" type="string" default="">

		<cfset var success = true />

		<cftry>

			<cfquery name="editProductOrder" datasource="#application.dsource#">
		        DELETE from items
		        WHERE orderuid = #arguments.orderuid#
	        </cfquery>


			<cfquery name="deleteOrder" datasource="#application.dsource#">
	           	DELETE from orders
	            WHERE orderuid = #arguments.orderuid#
	        </cfquery>

			<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>

		<cfreturn success />

	</cffunction>

	<cffunction name="getItem" access="remote" returntype="struct">

      	<cfargument name="itemId" type="string" default="">

		<cfset var returnStruct = structNew() />
		<cfset var qItem ='' />

		<cfquery name="qItem" datasource="#application.dsource#">
	      	SELECT *
			FROM items I
			LEFT OUTER JOIN products P ON I.ProductUID = P.UID
			WHERE I.id = '#arguments.itemId#'
	   	</cfquery>

		<cfset itemTitle = '' />
		<cfset itemArtist = '' />
		<cfset itemPrice = 0 />
		<cfset itemQty = 1 />

		<cfif qItem.title NEQ ''>
			<cfset itemTitle = qItem.title />
		<cfelseif qItem.name NEQ ''>
			<cfset itemTitle = qItem.name />
		</cfif>
		<cfif qItem.artist NEQ ''>
			<cfset itemArtist = qItem.artist />
		<cfelseif qItem.manufacturer NEQ ''>
			<cfset itemArtist = qItem.manufacturer />
		</cfif>
		<cfif qItem.unit_price NEQ ''>
			<cfset itemPrice = qItem.unit_price />
		</cfif>

		<cfset returnStruct['ORDERID'] = qItem.orderUID />
		<cfset returnStruct['ITEM_TITLE'] = itemTitle />
		<cfset returnStruct['ITEM_ARTIST'] = itemArtist />
		<cfset returnStruct['ITEM_PRICE'] = itemPrice />


		<cfreturn returnStruct />

   	</cffunction>

	<cffunction name="editItemInfo" access="remote" output="false" returntype="any" returnformat="JSON">

      	<cfargument name="form" type="struct">

		<cfset var success = true />

		<cftry>

			<cfquery name="qItem" datasource="#application.dsource#">
				UPDATE items SET
				title = '#form.item_title#',
				artist = '#form.item_artist#',
				unit_price = '#form.price#'
				WHERE id = '#form.itemId#'
			</cfquery>

			<cfscript>
				updateTotals = updateTotals(arguments.orderId);
			</cfscript>

			<cfcatch type="Any"><cfset success = false /></cfcatch>

		</cftry>

		<cfreturn success />

   	</cffunction>

	<cffunction name="deleteItem" access="remote" output="false" returntype="any" returnformat="JSON">

      	<cfargument name="itemId" type="numeric">
		<cfargument name="orderId" type="numeric">

		<cfset var success = true />

		<cftry>

			<cfquery name="qItem" datasource="#application.dsource#">
				DELETE from items
				WHERE id = '#arguments.itemId#'
			</cfquery>

			<cfscript>
				updateTotals = updateTotals(arguments.orderId);
			</cfscript>


			<cfcatch type="Any"><cfset success = false /></cfcatch>

		</cftry>

		<cfreturn success />

   	</cffunction>

	<cffunction name="insertItemFromId" access="remote" output="false" returntype="string">

      	<cfargument name="modelno" type="string">
		<cfargument name="orderId" type="numeric">

		<cfset var success = true />

		<cftry>

			<cfquery name="qProduct" datasource="#application.dsource#">
				SELECT * from products
				WHERE modelno = '#arguments.modelno#'
			</cfquery>

			<cfquery name="qOrder" datasource="#application.dsource#">
				SELECT * from orders
				WHERE orderuid = '#arguments.orderId#'
			</cfquery>

			<cfquery name="qItem" datasource="#application.dsource#">
				INSERT into items
				(
					OrderUID,
					ORDER_ID,
					product_code,
					modelno,
					productUID,
					quantity,
					framing,
					unit_price
				)
				VALUES
				(
					<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.orderId#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qOrder.OrderID#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qProduct.code#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qProduct.modelno#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qProduct.uid#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="1">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qProduct.gallery_price#">
				)
			</cfquery>

			<cfscript>
				updateTotals = updateTotals(arguments.orderId);
			</cfscript>

			<cfcatch type="Any"><cfset success = false /></cfcatch>

		</cftry>

		<cfreturn success />

   	</cffunction>

	<cffunction name="insertItemFromTitle" access="remote" output="false" returntype="string">

      	<cfargument name="name" type="string">
		<cfargument name="orderId" type="numeric">

		<cfset var success = true />

		<cftry>

			<cfquery name="qProduct" datasource="#application.dsource#">
				SELECT * FROM products
				WHERE active = 1
				<cfif arguments.name neq ''>
		      		AND name like '%#arguments.name#%'
				<cfelse>
					AND 0=1
		      	</cfif>
			</cfquery>

			<cfquery name="qOrder" datasource="#application.dsource#">
				SELECT * from orders
				WHERE orderuid = '#arguments.orderId#'
			</cfquery>

			<cfquery name="qItem" datasource="#application.dsource#">
				INSERT into items
				(
					OrderUID,
					ORDER_ID,
					product_code,
					modelno,
					productUID,
					quantity,
					framing,
					unit_price
				)
				VALUES
				(
					<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.orderId#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qOrder.OrderID#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qProduct.code#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qProduct.modelno#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qProduct.uid#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="1">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qProduct.gallery_price#">
				)
			</cfquery>

			<cfscript>
				updateTotals = updateTotals(arguments.orderId);
			</cfscript>


			<cfcatch type="Any"><cfset success = false /></cfcatch>

		</cftry>

		<cfreturn success />

   	</cffunction>

	<cffunction name="insertItemFromInfo" access="remote" output="false" returntype="any" returnformat="JSON">

      	<cfargument name="form" type="struct">

		<cfset var success = true />

		<cftry>

			<cfquery name="qOrder" datasource="#application.dsource#">
				SELECT * from orders
				WHERE orderuid = '#form.orderId#'
			</cfquery>

			<cfquery name="qItem" datasource="#application.dsource#">
				INSERT into items
				(
					OrderUID,
					ORDER_ID,
					product_code,
					modelno,
					productUID,
					quantity,
					framing,
					unit_price,
					title,
					artist,
					shortDesc
				)
				VALUES
				(
					<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.orderId#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qOrder.OrderID#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0001-0000">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0000">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="1">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.price#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.title#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.artist#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.desc#">
				)
			</cfquery>

			<cfscript>
				updateTotals = updateTotals(arguments.orderId);
			</cfscript>

			<cfcatch type="Any"><cfset success = false /></cfcatch>

		</cftry>

		<cfreturn success />

   	</cffunction>

	<cffunction name="insertFramingInfo" access="remote" output="false" returntype="any" returnformat="JSON">

      	<cfargument name="form" type="struct">

		<cfset var success = true />

		<cftry>

			<cfquery name="qOrder" datasource="#application.dsource#">
				SELECT * from orders
				WHERE orderuid = '#form.orderId#'
			</cfquery>

			<cfquery name="qItem" datasource="#application.dsource#">
			INSERT into items
				(
					OrderUID,
					ORDER_ID,
					product_code,
					modelno,
					productUID,
					quantity,
					framing,
					unit_price,
					title,
					artist,
					shortDesc
				)
				VALUES
				(
					<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.orderId#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qOrder.OrderID#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0001-0000">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0000">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="0">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="1">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="1">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.price#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.title#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.artist#">,
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.desc#">
				)
			</cfquery>

			<cfscript>
				updateTotals = updateTotals(arguments.orderId);
			</cfscript>

			<cfcatch type="Any"><cfset success = false /></cfcatch>

		</cftry>

		<cfreturn success />

   	</cffunction>

	<cffunction name="updateTotals" access="remote" output="false" returntype="string">

		<cfargument name="orderId" type="numeric">

		<cfset var success = true />

		<cftry>

			<cfquery name="qOrder" datasource="#application.dsource#">
				SELECT * from orders
				WHERE orderuid = '#arguments.orderid#'
			</cfquery>

			<cfquery name="itemTotal" datasource="#application.dsource#">
				SELECT sum(cast(unit_price as float)) as item_sum from items
				WHERE orderuid = '#arguments.orderid#'
			</cfquery>

			<cfif qOrder.discount == "">
				<cfset qOrder.discount = 0>
			</cfif>

			<cfset total = itemTotal.item_sum + qOrder.tax + qOrder.shipcost />
			<cfset balancedue = total - qOrder.discount + qOrder.amountpaid />

			<cfquery name="updateOrder" datasource="#application.dsource#">
				UPDATE orders SET
				amountSale = '#itemTotal.item_sum#',
				total = '#total#',
				balancedue = '#balancedue#'
				WHERE orderuid = '#arguments.orderid#'
			</cfquery>

			<cfcatch type="Any"><cfset success = false /></cfcatch>

		</cftry>

		<cfreturn success />

   	</cffunction>

	<cffunction name="setSession" access="remote">
		<cfargument name="form" type="struct">

		<cfset var success = true />

		<cftry>

		<cfloop collection="#form#" item="idx">
			<cfset "session.invoiceInfo.#idx#" = evaluate('form.'&idx) />
		</cfloop>

		<cfif session.invoiceInfo.tobeshipped eq '' OR session.invoiceInfo.tobeshipped EQ 0>
			<cfset session.invoiceInfo.tobeshipped	= 0 />
		<cfelse>
			<cfset session.invoiceInfo.tobeshipped	= 1 />
		</cfif>

		<cfif session.invoiceInfo.estimate eq '' OR session.invoiceInfo.estimate EQ 0>
			<cfset session.invoiceInfo.estimate	= 0 />
		<cfelse>
			<cfset session.invoiceInfo.estimate	= 1 />
		</cfif>

		<cfif session.invoiceInfo.incomplete eq '' OR session.invoiceInfo.incomplete EQ 0>
			<cfset session.invoiceInfo.incomplete	= 0 />
		<cfelse>
			<cfset session.invoiceInfo.incomplete	= 1 />
		</cfif>

		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>

		<cfreturn success />

	</cffunction>

	<cffunction name="setAmountInSession" access="remote">
		<cfargument name="amount" type="string">
		<cfargument name="amountType" type="string">

		<cfset var success = true />

		<cftry>

			<cfset "session.invoiceInfo.#arguments.amountType#" = arguments.amount />

		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>


		<cfreturn success />

	</cffunction>

	<cffunction name="getCancelcodeOptions" access="remote">

		<cfset var qCancelcodeOptions = '' />

		<cfquery name="qCancelcodeOptions" datasource="#application.dsource#">
           	SELECT * from cancelcodeOptions
        </cfquery>

		<cfreturn qCancelcodeOptions />

	</cffunction>

	<cffunction name="parseDollarFormat" access="remote">

		<cfargument name="amount" type="string">

		<cfset var decimalAmount = replace(amount,'$','') />
		<cfset decimalAmount = replace(decimalAmount,',','') />

		<cfreturn decimalAmount />

	</cffunction>

    <cffunction name="getStates" access="remote" returntype="query">

    	<cfset var qStates = '' />

		<cfquery name="qStates" datasource="#application.dsource#">
            SELECT * from states
        </cfquery>

		<cfreturn qStates />

	</cffunction>

    <cffunction name="getCountries" access="remote" returntype="query">

    	<cfset var qCountries = '' />

		<cfquery name="qCountries" datasource="#application.dsource#">
            SELECT * from countries
        </cfquery>

		<cfreturn qCountries />

	</cffunction>

	<cffunction name="addDeleteLexy" access="remote">
		<cfargument name="orderuid" required="yes" type="string" default="">
		<cfargument name="checkboxval" required="yes" type="string" default="">

		<cfquery name="editCustomer" datasource="#application.dsource#">
	        UPDATE orders SET
	        lexy = '#arguments.checkboxval#'
	        WHERE orderuid 	= #arguments.orderuid#
	    </cfquery>

	</cffunction>


</cfcomponent>
