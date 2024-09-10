<cfquery name="getOrder" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
 	SELECT 
	 O.orderuid,C.fname as customer_fname,C.lname as customer_lname,C.phone as customer_phone,C.businessphone as customer_businessphone,C.cellphone as customer_cellphone,C.fax as customer_fax,C.address1,C.city,C.state,C.country,C.zip,C.email as customer_email,C.website as customer_website,C.website as driverslicense,O.consultant as order_consultant,O.date,O.company as order_company,O.Payment_Method,O.origin,O.CardNumber,O.CardExpiry,O.authcode,O.comments,O.tobeshipped,O.amountsale,O.tax,O.shipCost,O.shipMethod,O.insurance,O.total,O.discount,O.amountpaid,O.balanceDue
 	FROM orders O
 	INNER JOIN customers C on C.ID = O.customerID
 	WHERE orderuid='#url.orderuid#'
 </cfquery>
 

<cfquery name="getItems" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT  P.name as productTitle,P.manufacturer as productArtist,
    ( CASE WHEN I.unit_price <> '' THEN I.unit_price
    ELSE 0 END ) AS price,
    I.id as itemId,I.framing as itemFraming,*
	FROM orders O 
	INNER JOIN items I ON O.OrderID = I.Order_ID 
	LEFT OUTER JOIN products P ON I.Product_code = P.code
	WHERE O.orderuid = '#url.orderuid#'
	AND (I.Product_ID IS NULL OR (I.Product_ID IS NOT NULL AND I.Product_ID <> 'tax'))
 </cfquery>
 
<cfdocument format="pdf" filename="#application.ppath#\admin\uploads\products\#url.orderuid#.pdf" overwrite="yes"> 
	<cfinclude template="product_invoice_template.cfm">
</cfdocument>

<cfsavecontent variable="emailBody">
	<cfoutput>
	Dear #getOrder.customer_fname# #getOrder.customer_lname#,<br><br>
	Attached is your invoice for your Gallart Order ###getOrder.orderuid#. <br>
	Thank you for doing business with us!
	<br><br>
	Gallery Art<br>
	20633 Biscayne Blvd<br>
	Aventura, FL 33180<br>
	305.932.6166<br>
	<a href="http://www.gallart.com">www.gallart.com</a>
	</cfoutput>
</cfsavecontent>

<cfset form.sender = "info@gallart.com" />
<cfset form.recipient = getOrder.customer_email />
<cfset form.subject = "Your Gallart Invoice" />
<cfset form.body = emailBody />
<cfset form.attachment = "#application.ppath#\admin\uploads\products\#url.orderuid#.pdf" />

<cfscript>
	emailInvoice = application.objectFactoryAdmin.getInstance('mailer').sendMail( argumentcollection = form );
</cfscript>
<cfoutput>
<link REL="STYLESHEET" TYPE="text/css" HREF="http://#server_name#/admin/css/main.css">
<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td>
			<h3>INVOICE SENT</h3>
		</td>
	</tr>
	<tr>
		<td>
			Invoice ###url.orderuid# has been sent to #getOrder.customer_fname# #getOrder.customer_lname#.
		</td>
	</tr>
</table>
</cfoutput>
