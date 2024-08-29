<cfif not parameterexists(xss)>	<cflocation url="error.cfm"> </cfif>

<cfparam name="ORDERUSERID" default="0">
<cfparam name="shipcost" default="0">
<cfparam name="showship" default="0">
<cfparam name="tax" default="0">
<cfparam name="AuthType" default="Auth">
<cfparam name="Authcode" default="">
<cfparam name="avscode" default="">
<cfparam name="Approved" default="1">

<!--- Get contents of cart --->
<cfquery name="GetCartInfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT  * FROM cart WHERE trackerid = '#xss#'
</cfquery>
<cfquery name="GetuserInfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT  * FROM tracker WHERE sessionid = '#xss#'
</cfquery>

<!--- Insert info into customers table if new customer remove this section if not supported --->
<cfquery name="find_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT id as cusid, email, phone, lname, name from customers where (email = '#trim(email)#')
</cfquery>

<cfif not find_cust.recordcount>

	<cfquery name="insert_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		INSERT into customers
		(
			NAME,
			LNAME,
			FNAME,
			ADDRESS1,
			ADDRESS2,
			CITY,
			STATE,
			COUNTRY,
			ZIP,
			PHONE,
			CELLPHONE,
			BUSINESSPHONE,
			OTHERPHONE,
			EMAIL,
			SADDRESS1,
			SADDRESS2,
			SCITY,
			SSTATE,
			WEBSITE
		)
		VALUES
		(
			'#BILLNAME#', 
			'#BILLNAME#', '#BILLNAMEF#',
			'#BILLADDRESS1#',
			'#BILLADDRESS2#',
			'#BILLCITY#',
			'#BILLSTATE#',
			'#BILLCOUNTRY#',
			'#BILLZIP#',
			'#BILLPHONE#',
			'#CELLPHONE#',
			'#BUSINESSPHONE#',
			'#OTHERPHONE#',
			'#EMAIL#',
			'#SHIPADDRESS1#',
			'#SHIPADDRESS2#', 
			'#SHIPCITY#',
			'#SHIPSTATE#',
			'#WEBSITE#'
		)
	</cfquery>
	
	<cfset customerId = insert_cust.uid />
									
<cfelse>

	<cfquery name="update_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		UPDATE customers SET 
			EMAIL = '#EMAIL#'
			<cfif form.BILLPHONE NEQ "">
				,PHONE = '#BILLPHONE#'
			</cfif>
			<cfif form.CELLPHONE NEQ "">
				,CELLPHONE = '#CELLPHONE#'
			</cfif>
			<cfif form.BUSINESSPHONE NEQ "">
				,BUSINESSPHONE = '#BUSINESSPHONE#'
			</cfif>
			<cfif form.OTHERPHONE NEQ "">
				,OTHERPHONE = '#OTHERPHONE#'
			</cfif>
		WHERE id = #find_cust.cusid#
	</cfquery>

	<cfset customerId = find_cust.cusid />
		

</cfif>

<CFSET ORDERUSERID = customerId >
<!--- end of customer insert --->

<cftransaction>

<!--- Set orderid for cc processing --->
<cfset orderid='#lsdateformat(now(), 'yymmdd')##lstimeformat(now(), 'hhmmss')#' />
<cfset orderid= trim(orderid) />
<!--- Do credit card processing --->

<cfset ItemQuery="">

<cfset cardname=#trim(cardtype)#>
<cfset cardnum1=#trim(left(cardnum, 4))#>
<cfset cardnum2 = #mid(cardnum, 5, 4)#>
<cfset cardnum3=#trim(mid(cardnum, 9, 4))#>
<cfset cardnum4=#trim(mid(cardnum, 13, 4))#>
<cfset cardexpm=#trim(cardexpm)#>
<cfset cardexpy=#trim(cardexpy)#>
<cfset nameoncard=#trim(billnamef)#&" "& #trim(billname)#>
<cfset cardstreet=#trim(BillAddress1)#>
<cfset cardcity=#trim(billcity)#>
<cfset cardstate=#trim(billcountry)#>
<cfset cardzip=#trim(billzip)#>
<cfset cardcountry=#trim(billcountry)#>

<cfif shipnamef gt 1>
<CFSET SHIPNAME=#trim(SHIPNAMEF)#&" "&#trim(SHIPNAME)#>
<Cfelse>
<CFSET SHIPNAME = #trim(BILLNAMEF)#&" "&#trim(BILLNAME)#>
</cfif>
<CFIF SHIPADDRESS1 GT 1>
<CFSET SHIPADDRESS1=#trim(SHIPADDRESS1)#>
<CFELSE>
<CFSET SHIPADDRESS1=#trim(BILLADDRESS1)#>
</CFIF>
<CFIF SHIPADDRESS2 GT 1>
<CFSET SHIPADDRESS2=#trim(SHIPADDRESS2)#>
<CFELSE>
<CFSET SHIPADDRESS2=#trim(BILLADDRESS2)#>
</CFIF>
<CFIF SHIPCITY GT 1>
<CFSET SHIPCITY=#trim(SHIPCITY)#>
<CFELSE>
<CFSET SHIPCITY=#trim(BILLCITY)#>
</CFIF>
<CFIF SHIPSTATE GT 1>
<CFSET SHIPSTATE=#trim(SHIPSTATE)#>
<CFELSE>
<CFSET SHIPSTATE=#trim(BILLSTATE)#>
</CFIF>
<CFIF SHIPCOUNTRY GT 1>
<CFSET SHIPCOUNTRY=#trim(SHIPCOUNTRY)#>
<CFELSE>
<CFSET SHIPCOUNTRY=#trim(BILLCOUNTRY)#>
</CFIF>
<CFIF SHIPZIP GT 1>
<CFSET SHIPZIP=#trim(SHIPZIP)#>
<CFELSE>
<CFSET SHIPZIP=#trim(BILLZIP)#>
</CFIF>
<CFIF SHIPPHONE GT 1>
<CFSET SHIPPHONE=#trim(SHIPPHONE)#>
<CFELSE>
<CFSET SHIPPHONE=#trim(BILLPHONE)#>
</CFIF>
<CFSET SHIPMETHOD=#trim(SHIPMETHOD)#>
<CFSET INSURANCE=#trim(INSURANCE)#>
<CFSET SHIPPING = ''>
<CFSET SHIPCODE = ''>
<CFSET BILLNAME=#trim(BILLNAMEF)#&" "&#trim(BILLNAME)#>
<CFSET BILLADDRESS1=#trim(BILLADDRESS1)#>
<CFSET BILLADDRESS2=#trim(BILLADDRESS2)#>
<CFSET BILLCITY=#trim(BILLCITY)#>
<CFSET BILLSTATE=#trim(BILLSTATE)#>
<CFSET BILLCOUNTRY=#trim(BILLCOUNTRY)#>
<CFSET BILLZIP=#trim(BILLZIP)#>
<CFSET BILLPHONE=#trim(BILLPHONE)#>
<CFSET CELLPHONE=#trim(CELLPHONE)#>
<CFSET BUSINESSPHONE=#trim(BUSINESSPHONE)#>
<CFSET OTHERPHONE=#trim(OTHERPHONE)#>
<CFSET EMAIL=#trim(EMAIL)#>
<CFSET WEBSITE=#trim(WEBSITE)#>
<CFSET CARDTYPE=#trim(CARDTYPE)#>
<CFSET CARDNUMBER=#trim(CARDNUM)#>
<CFSET CARDEXPIRY=#trim(CARDEXPM)#&"/"&#trim(CARDEXPY)#>


<!--- Set values for orders table --->
<Cfif isDefined('find_cust.cusid')>
<cfset customerid = #find_cust.cusid#>
<cfelse>
<cfset customerid = "">
</cfif>
<cfset FK_LOCATIONS = '#form.FK_LOCATIONS#'>
<CFSET DATE=#createodbcdate(now())#>
<cfset comments = '#form.comments#'>
<CFSET IPADDRESS=#trim(getuserinfo.originIP)#>
<CFSET REFERRINGPAGE=#trim(getuserinfo.referrer)#>
<CFSET ENTRYPOINT=#trim(getuserinfo.entrypage)#>
<CFSET LINKFROM=#trim(getuserinfo.referrer)#>
<CFSET WARNING="">
<CFSET PARTNER="#partner#">
<CFSET ORIGIN="#ORIGIN#">

<!--- Insert info into orders table --->
<cflock name="insert" timeout="10">
<cfquery name="insert_orders" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	INSERT into orders
	(
		customerid,
		ORDERID,
		FK_LOCATIONS,
		DATE,
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
		BILLADDRESS1,
		BILLADDRESS2,
		BILLCITY,
		BILLSTATE,
		BILLCOUNTRY,
		BILLZIP,
		BILLPHONE,
		CELLPHONE,
		BUSINESSPHONE,
		OTHERPHONE,
		EMAIL,
		WEBSITE,
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
		ORIGIN
	)
	VALUES
	(
		#customerid#,
		'#ORDERID#',
		#FK_LOCATIONS#,
		#DATE#,
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
		'#BILLADDRESS1#',
		'#BILLADDRESS2#',
		'#BILLCITY#',
		'#BILLSTATE#',
		'#BILLCOUNTRY#',
		'#BILLZIP#',
		'#BILLPHONE#',
		'#CELLPHONE#',
		'#BUSINESSPHONE#',
		'#OTHERPHONE#',
		'#EMAIL#',
		'#WEBSITE#',
		'#IPADDRESS#',
		'#REFERRINGPAGE#',
		'#ENTRYPOINT#',
		'#SHIPPING#',
		'#CARDTYPE#',
		'#CARDNUMBER#',
		'#CARDEXPIRY#',
		'#COMMENTS#',
		'#LINKFROM#',
		'#WARNING#',
		'#PARTNER#',
		'#xss#',
		#batchproc#,
		'#ORIGIN#'
	)
</cfquery>
</cflock>

<cfset line_id = 1>
<cfset subtotal = 0>
<cfset ext = 0>
<cfset shipcost = 0>

<!--- Loop through cart to place items in items and options tables --->
<CFLOOP QUERY="GetCartInfo">
<cfquery name="extproductinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	select * from products
	where uid = #pid#
</cfquery>


<!--- Set values for items table --->
<CFSET ORDERDATE=#lsdateformat(createodbcdate(now()), 'mm/dd/yyyy')#>
<CFSET COST= #extproductinfo.truecost#>
<CFSET CANCELCODE="">
<CFSET CUSTOMERID = #find_cust.cusid#>
<CFSET ORDER_ID= #orderid#>
<CFSET PRODUCT_ID=#extproductinfo.code#>
<CFSET PRODUCT_CODE="#extproductinfo.code#">
<CFSET QUANTITY=#GetCartInfo.QTY#>
<CFSET UNIT_PRICE=#GetCartInfo.CHARGE#>
<CFSET PO="">
<CFSET VENDORCODE="#extproductinfo.vendor#">
<CFSET EXPSHIP="">
<CFSET VENDORACCEPT="">
<CFSET DODONE="1">
<!--- set trackreq to 1 if all products sold should get tracking number from shipping --->
<CFSET TRACKREQ="1">
<CFSET TRACKINGNUMBER="">
<CFSET VCAN="">
<CFSET CHECKNO="">
<CFSET FLAG="0">
<CFSET PARTNER="#partner#">
<CFSET LINETOTAL=(#GetCartInfo.QTY# * #GetCartInfo.charge#)>
<CFSET ITEMEXT="">
<CFSET PROCCHOICE="0">
<CFSET MODELNO=extproductinfo.modelno>
<CFSET PRODUCTUID=extproductinfo.uid>
<CFSET TITLE=extproductinfo.name>
<CFSET ARTIST=extproductinfo.manufacturer>
<!--- Put cart items in items table --->
<cflock name="insert" timeout="15">
<cfquery name="insert_items" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	INSERT into items
	(
		ORDERDATE,
		COST,
		CANCELCODE,
		ORDER_ID,
		LINE_ID,
		PRODUCT_ID,
		PRODUCT_CODE,
		QUANTITY,
		UNIT_PRICE,
		PO,
		VENDORCODE,
		EXPSHIP,
		VENDORACCEPT,
		DODONE,
		TRACKREQ,
		TRACKINGNUMBER,
		VCAN,
		CHECKNO,
		FLAG,
		PARTNER,
		LINETOTAL,
		ITEMEXT,
		PROCCHOICE,
		MODELNO,
		PRODUCTUID,
		TITLE,
		ARTIST
	)
	VALUES
	(
		'#ORDERDATE#',
		#COST#,
		'#CANCELCODE#',
		'#ORDER_ID#',
		'#LINE_ID#',
		'#PRODUCT_ID#',
		'#PRODUCT_CODE#',
		'#QUANTITY#',
		'#UNIT_PRICE#',
		'#PO#',
		'#VENDORCODE#',
		'#EXPSHIP#',
		'#VENDORACCEPT#',
		'#DODONE#',
		'#TRACKREQ#',
		'#TRACKINGNUMBER#',
		'#VCAN#',
		'#CHECKNO#',
		'#FLAG#',
		'#PARTNER#',
		#LINETOTAL#,
		'#ITEMEXT#',
		'#PROCCHOICE#',
		'#MODELNO#',
		'#PRODUCTUID#',
		'#TITLE#',
		'#ARTIST#'
	)
</cfquery>
</cflock>

<cfset ext = #charge# * #qty#>
<cfset subtotal = #subtotal# + #ext#>
<cfset line_id = line_id + 1>
</CFLOOP>

<!--- Calculate and Enter Taxes --->
<cfif #form.billstate# is #taxst#>

<cfset tax = (taxamount*0.01)*subtotal />

<cflock name="insert" timeout="15">

<cfquery name="insert_items" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	INSERT into items
	(
		ORDERDATE,
		COST,
		CANCELCODE,
		ORDER_ID,
		LINE_ID,
		Product_id,
		PRODUCT_CODE,
		QUANTITY,
		UNIT_PRICE,
		VENDORCODE,
		EXPSHIP,
		VENDORACCEPT,
		DODONE,
		TRACKREQ,
		TRACKINGNUMBER,
		VCAN,
		CHECKNO,
		FLAG,
		PARTNER,
		LINETOTAL,
		ITEMEXT,
		PROCCHOICE
	)
	VALUES
	(
		'#ORDERDATE#',
		#tax#,
		'#CANCELCODE#',
		'#ORDER_ID#',
		'#LINE_ID#',
		'Tax',
		'Tax',
		'1',
		#tax#,
		'Tax',
		'#EXPSHIP#',
		'1',
		'1',
		'0',
		'',
		'#VCAN#',
		'#CHECKNO#',
		'#FLAG#',
		'#PARTNER#',
		#Tax#,
		'#ITEMEXT#',
		'#PROCCHOICE#'
	)
</cfquery>

</cflock>

<Cfelse>

<cfset tax = 0>

<cflock name="insert" timeout="15">

<cfquery name="insert_items" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
INSERT into items
(ORDERDATE,COST,CANCELCODE,ORDER_ID,LINE_ID,product_id,PRODUCT_CODE,QUANTITY,UNIT_PRICE,VENDORCODE,EXPSHIP,VENDORACCEPT,DODONE,TRACKREQ,TRACKINGNUMBER,VCAN,CHECKNO,FLAG,PARTNER,LINETOTAL,ITEMEXT,PROCCHOICE)
VALUES
('#ORDERDATE#',0,'#CANCELCODE#','#ORDER_ID#','#LINE_ID#','Tax','Tax','1',#tax#,'Tax','#EXPSHIP#','1','1','0','','#VCAN#','#CHECKNO#','#FLAG#','#PARTNER#',0,'#ITEMEXT#','#PROCCHOICE#')
</cfquery>

</cflock>

</cfif>

<Cfset total = tax + insurance + subtotal>

<!--- place information in tracker table for discrete reference --->

<!--- Delete items from cart --->
<cfquery name="GetCartInfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
DELETE FROM cart WHERE trackerid = '#xss#'
</cfquery>
<!--- <cfinclude template="#processtype.processcode#.proc"> --->

<cfif approved eq 1>
	<CFSET AUTHCODE="#trim(AUTHCODE)#">
	<CFSET AVSCODE="#trim(AVSCODE)#">
	
	<cftransaction action="COMMIT">
	<cfquery name="GetCartInfo" datasource="#dsource#" username="#uname#" password="#pword#">
	update tracker
		set orderid = '#order_id#',
			total = #total#
		where sessionid = '#xss#'
	</cfquery>
	<cfquery name="Info" datasource="#dsource#" username="#uname#" password="#pword#">
	update orders
		set authcode = '#authcode#',
			avscode = '#avscode#',
			total = #total#,
			amountSale = #total#
		where orderid = '#order_id#'
	</cfquery>
<cfelse> <!--- Credit card failed --->
	<cftransaction action="ROLLBACK"><!--- Delete items from cart? --->
	<!--- <cfquery name="GetCartInfo" datasource="#dsource#" username="#uname#" password="#pword#">
		DELETE FROM cart WHERE trackerid = '#xss#'
	</cfquery> --->
</cfif>
</cftransaction>
<cfif approved eq 1>

<!--- Send out confirmation email --->
<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="#form.email#" from="onli16@onlinegalleryart.com" subject="Order - Confirmation" type="HTML">
<br><br>
Thank you very much for your order.
<br><br>
If you have any questions regarding your order,
please reference it by using the order ID listed below.
<br><br>
Internet Order Number:  #orderID#
<br><br>
Total:  #dollarformat(total)#
<br><br>
#companyname#
<br><br>
</cfmail>

<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="#emailsupport#" cc="#emailsupportcc#" from="onli16@onlinegalleryart.com" subject="GallArt.com <> Buying & Selling Fine Art <> New Order Placed" type="HTML"> 
<br><br>
An order was placed on #DateFormat(createodbcdate(now()),"mmm dd, yyyy")#.
<br><br>
Shipping Name: #SHIPNAME#<br>
 Address: <br>
 #SHIPADDRESS1# #SHIPADDRESS2#<br>
 #SHIPCITY#, #SHIPSTATE# #SHIPZIP#<br>
#SHIPCOUNTRY#<br>
Phone: #SHIPPHONE#<br>
Email: #EMAIL#<br>
Order - #orderID#<BR>
Total - #dollarformat(total)#<br><BR>
<a href="http://#sitename#/admin">Click Here to review Order</a><br>
Click the Log In button in the upper right corner of your screen, enter your password, then click Orders from the top menu.
</cfmail>
<!--- End of confirmation email --->
<cflocation url="thankyou.cfm?val=y&xss=#xss#">
<cfelse>
<cflocation url="thankyou.cfm?val=n&xss=#xss#&errormsg=#ErrorMessage#">
</cfif>

