  <cfquery name="getOrder" datasource="#application.dsource#" debug>
 	SELECT 
	 O.lexy,O.orderuid,C.fname as customer_fname,C.lname as customer_lname,C.phone as customer_phone,C.businessphone as customer_businessphone,C.cellphone as customer_cellphone,C.fax as customer_fax,C.address1,C.city,C.state,C.country,C.zip,C.email as customer_email,C.website as customer_website,C.website as driverslicense,O.consultant as order_consultant,O.date,O.company as order_company,O.Payment_Method,O.origin,O.CardNumber,O.CardExpiry,O.authcode,O.comments,O.tobeshipped,O.amountsale,O.tax,O.shipCost,O.shipMethod,O.insurance,O.total,O.discount,O.amountpaid,O.balanceDue
 	FROM orders O
 	INNER JOIN customers C on C.ID = O.customerID
 	WHERE orderuid='#url.orderuid#'
 </cfquery>
 
 
 <cfquery name="getItems" datasource="#application.dsource#">
    SELECT  P.name as productTitle,P.manufacturer as productArtist,
    ( CASE WHEN I.unit_price <> '' THEN I.unit_price
    ELSE '0' END ) AS price, 
    I.id as itemId,I.framing as itemFraming,C.email as customer_email,CAST(C.zip as CHAR(100)) as customer_zip,*
    FROM orders O 
    INNER JOIN items I ON O.OrderID = I.Order_ID 
    INNER JOIN customers C on C.ID = O.customerID
    LEFT OUTER JOIN products P ON I.ProductUID = P.UID
    LEFT OUTER JOIN employees E ON O.fk_employees = E.pk_employees
    LEFT OUTER JOIN employees A ON C.assignedTo = A.pk_employees
    WHERE O.orderuid = '#url.orderuid#'
    AND (I.Product_ID IS NULL OR (I.Product_ID IS NOT NULL AND I.Product_ID <> 'tax'))
</cfquery>
     
<!--- <cfinclude template="product_invoice_template.cfm">    --->

<cfheader name="Content-Disposition" value="inline; filename=document.pdf"> 
<cfcontent type="application/x-pdf"> 

<cfdocument format="pdf" marginbottom="0" marginleft="0" marginright="0" margintop="0" localUrl="true">
	<cfinclude template="product_invoice_template.cfm">
</cfdocument>
