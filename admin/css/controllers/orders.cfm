<!--- get the Action from the event --->
<cfset Action = listlast(URL.event, '.') />

<cfset ViewPath = "../views/orders" />

<cfif session.loggedin EQ false AND event eq "orders.manageProducts">
	<cflocation url="index.cfm?logout=1" addtoken="No">
</cfif>

<cfswitch expression="#Action#">

	<cfdefaultcase>
		<cfinclude template="../views/layout.top.cfm" />

		<cfset fieldList = "assignedTo,customerId,leadId,phone,otherphone,CellPhone,BusinessPhone,Fax,Consultant,Company,lname,fname,Address1,City,State,Country,Zip,website,Email,Payment_Method,CardNumber,cardexpm,cardexpy,authcode,DriversLicense,tobeshipped,special_instructions,origin,estimate" />
		<cfloop list="#fieldList#" index="idx">
			<cfif structKeyExists(session,'invoiceInfo')>
				<cfset "form.#idx#" = evaluate("session.invoiceInfo."&idx) />
			<cfelse>
				<cfset "form.#idx#" = "" />
			</cfif>
		</cfloop>

		<cfif structKeyExists(session,'invoiceInfo')>
			<cfif structKeyExists(session.invoiceInfo,'Framing')>
				<cfset form.Framing = session.invoiceInfo.Framing />
			<cfelse>
				<cfset form.Framing = "" />
			</cfif>
		<cfelse>
			<cfset form.Framing = "" />
		</cfif>

		<cfscript>
			getCustomers = application.objectFactoryAdmin.getInstance('customers').getAllCustomers();
			getLeads	 = application.objectFactoryAdmin.getInstance('leads').getAllLeads();
			getStates	 = application.objectFactoryAdmin.getInstance('orders').getStates();
		</cfscript>

		<cfinclude template="#ViewPath#/products/product_form.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfdefaultcase>

	<cfcase value="confirmInvoice">
		<cfinclude template="../views/layout.top.cfm" />

		<cfscript>
			setSession = application.objectFactoryAdmin.getInstance('orders').setSession( argumentcollection = form );
		</cfscript>

		<cfinclude template="#ViewPath#/products/confirm_invoice.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfcase>

	<cfcase value="createPdf">
		<cfinclude template="../views/layout.top.cfm" />

		<cfif NOT structKeyExists(session,'invoiceInfo')>
			<cfinclude template="#ViewPath#/products/session_expired.cfm">
			<cfabort>
		</cfif>

		<cfscript>
			setSession = application.objectFactoryAdmin.getInstance('orders').setSession( argumentcollection = form );
		</cfscript>

		<cfscript>
			processNewOrder = application.objectFactoryAdmin.getInstance('orders').processNewOrder();
		</cfscript>

		<cfif session.invoiceinfo.leadId NEQ ''>
			<cfscript>
				deleteLead = application.objectFactoryAdmin.getInstance('leads').deleteLead(session.invoiceinfo.leadId);
			</cfscript>
		</cfif>
		<cfset session.invoiceinfo.invoiceNumber = processNewOrder.thisOrderId />
		<cfset session.invoiceinfo.displayInvoiceNumber = processNewOrder.thisDisplayOrderId />


		<cfset printFields = 1 />

		<cfdocument format="pdf" filename="#expandpath('.')#/uploads/products/#session.invoiceinfo.invoiceNumber#.pdf" overwrite="yes" localurl="true">

			<cfinclude template="#ViewPath#/products/print_invoice_template_localurl.cfm">

  		</cfdocument>

		<!--- <cfif REMOTE_ADDR EQ '74.225.29.65'>

			<cfinclude template="#ViewPath#/products/email_order_template.cfm">


			<cfabort>
		</cfif> --->

		<!--- if admin selects send to customer --->
		<cfif structKeyExists(form,'sendemail')>

			<cfsavecontent variable="emailBody">
				<cfoutput>
				Dear #session.invoiceinfo.fname# #session.invoiceinfo.lname#,<br><br>
				Attached is your invoice for your Gallart Order
				###session.invoiceinfo.displayInvoiceNumber#. <br>
				Thank you for doing business with us!
				<br><br>
				Gallery Art<br>
				20633 Biscayne Blvd<br>
				Aventura, FL 33180<br>
				305.932.6166<br>
				<a href="http://www.gallart.com">GallArt.com</a>
				</cfoutput>
			</cfsavecontent>

			<cfset form.sender = "info@gallart.com" />
			<cfset form.recipient = session.invoiceinfo.email />
			<cfset form.subject = "Your Gallart Order" />
			<cfset form.body = emailBody />
			<cfset form.attachment = "#expandpath('.')#/uploads/products/#session.invoiceinfo.invoiceNumber#.pdf" />

			<cfscript>
				emailInvoice = application.objectFactoryAdmin.getInstance('mailer').sendMail( argumentcollection = form );
			</cfscript>

		</cfif>

		<!--- email goes to Ken and sales person --->

			<cfscript>
				getEmployeeFromPassword = application.objectFactoryAdmin.getInstance('employees').getEmployeeFromPassword( session.invoiceinfo.password );
			</cfscript>

			<cfsavecontent variable="emailBody">
				<cfoutput>
				Attached is the invoice for Gallart Order ###session.invoiceinfo.displayInvoiceNumber#.  Here is the order:<br><br>
				<cfinclude template="#ViewPath#/products/email_order_template.cfm">
				<br><br>
				</cfoutput>
			</cfsavecontent>

			<cfset form.sender = "info@gallart.com" />
			<cfset form.recipient = "#getEmployeeFromPassword.emp_email#,kengallart@aol.com" />
			<cfset form.subject = "Gallart Order" />
			<cfset form.body = emailBody />
			<cfset form.attachment = "#expandpath('.')#/uploads/products/#session.invoiceinfo.invoiceNumber#.pdf" />

			<cfscript>
				emailInvoice = application.objectFactoryAdmin.getInstance('mailer').sendMail( argumentcollection = form );
			</cfscript>

		<cflocation url="index.cfm?event=orders.printInvoice" addtoken="No">

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfcase>

	<cfcase value="printInvoice">
		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/products/print_invoice_frame.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfcase>

	<cfcase value="newOrder">
		<cfinclude template="../views/layout.top.cfm" />

		<cfset fieldList = "assignedTo,customerId,leadId,phone,otherphone,CellPhone,BusinessPhone,Fax,Consultant,Company,lname,fname,Address1,City,State,Country,Zip,website,Email,Payment_Method,CardNumber,cardexpm,cardexpy,authcode,DriversLicense,tobeshipped,special_instructions,origin,estimate" />
		<cfloop list="#fieldList#" index="idx">
			<cfset "form.#idx#" = "" />
		</cfloop>

		<cfset form.Framing = "" />

		<cfif structKeyExists(session,'invoiceInfo')>
			<cfset temp = structDelete(session,'invoiceInfo') />
		</cfif>
		<cfif structKeyExists(session,'orderArray')>
			<cfset temp = structDelete(session,'orderArray') />
		</cfif>

		<cfscript>
			getCustomers = application.objectFactoryAdmin.getInstance('customers').getAllCustomers();
			getLeads	 = application.objectFactoryAdmin.getInstance('leads').getAllLeads();
			getStates	 = application.objectFactoryAdmin.getInstance('orders').getStates();
		</cfscript>


		<!--- from listings module --->
		<cfif isDefined('url.modelNo')>

			<cfscript>
				getArt = application.objectFactoryAdmin.getInstance('art').getArt(url.modelNo);
			</cfscript>

		</cfif>

		<cfinclude template="#ViewPath#/products/product_form.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfcase>

	<cfcase value="artInfo">
		<cfinclude template="#ViewPath#/products/artInfo.cfm">
	</cfcase>

	<cfcase value="framingInfo">
		<cfinclude template="#ViewPath#/products/framingInfo.cfm">
	</cfcase>

	<cfcase value="artInfoManage">
		<cfinclude template="#ViewPath#/manage/artInfo.cfm">
	</cfcase>

	<cfcase value="framingInfoManage">
		<cfinclude template="#ViewPath#/manage/framingInfo.cfm">
	</cfcase>

	<cfcase value="manageProducts">
		<cfinclude template="../views/layout.top.cfm" />

		<cfparam name="url.searchLname" default="" />
		<cfparam name="url.searchCompany" default="" />
		<cfparam name="url.searchAmountSale" default="" />
		<cfparam name="url.searchEmail" default="" />
		<cfparam name="url.searchEmployeeId" default="" />
		<cfparam name="url.searchTitle" default="" />
		<cfparam name="url.searchArtist" default="" />
		<cfparam name="url.searchFromDate" default="" />
		<cfparam name="url.searchToDate" default="" />
        <cfparam name="url.searchStates" default="" />

		<cfparam name="form.searchLname" default="#url.searchLname#" />
		<cfparam name="form.searchCompany" default="#url.searchCompany#" />
		<cfparam name="form.searchAmountSale" default="#url.searchAmountSale#" />
		<cfparam name="form.searchEmail" default="#url.searchEmail#" />
		<cfparam name="form.searchEmployeeId" default="#url.searchEmployeeId#" />
		<cfparam name="form.searchTitle" default="#url.searchTitle#" />
		<cfparam name="form.searchArtist" default="#url.searchArtist#" />
		<cfparam name="form.searchFromDate" default="#url.searchFromDate#" />
		<cfparam name="form.searchToDate" default="#url.searchToDate#" />
        <cfparam name="form.searchStates" default="#url.searchStates#" />

		<cfscript>
			getEmployees = application.objectFactoryAdmin.getInstance('employees').getAllEmployees();
			getCancelcodeOptions = application.objectFactoryAdmin.getInstance('orders').getCancelcodeOptions();
			getStates	 = application.objectFactoryAdmin.getInstance('orders').getStates();
		</cfscript>

		<cfinclude template="#ViewPath#/manage/product_orders.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfcase>

	<cfcase value="editItem">
		<cfinclude template="#ViewPath#/manage/editItem.cfm">
	</cfcase>

	<cfcase value="sendEmailToCustomer">
		<cfinclude template="#ViewPath#/manage/sendEmailToCustomer.cfm">
	</cfcase>

	<cfcase value="productOrdersProcess">
		<cfinclude template="../views/layout.top.cfm" />

		<cfscript>
			editProductOrder = application.objectFactoryAdmin.getInstance('orders').editProductOrder( argumentcollection = form );
		</cfscript>


		<cfset searchString = "" />
		<cfif len(form.searchLnameValue)>
			<cfset searchString = searchString&"&searchLname=#form.searchLnameValue#" />
		</cfif>
		<cfif len(form.searchCompanyValue)>
			<cfset searchString = searchString&"&searchCompany=#form.searchCompanyValue#" />
		</cfif>
		<cfif len(form.searchAmountSaleValue)>
			<cfset searchString = searchString&"&searchAmountSale=#form.searchAmountSaleValue#" />
		</cfif>
		<cfif len(form.searchEmailValue)>
			<cfset searchString = searchString&"&searchEmail=#form.searchEmailValue#" />
		</cfif>

		<cflocation url="index.cfm?event=orders.manageProducts&#searchString#" addtoken="No" />

		<!--- <cfinclude template="#ViewPath#/manage/product_orders_process.cfm"> --->

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfcase>

	<cfcase value="productOrdersDetail">
		<cfinclude template="../views/layout.top.cfm" />

		<cfinclude template="#ViewPath#/manage/product_orders_detail.cfm">

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfcase>

	<!--- <cfcase value="orderReport">

		<cfscript>
			getOrderReport = application.objectFactoryAdmin.getInstance('orders').getOrderReport( argumentcollection = url );
		</cfscript>

		<cfinclude template="#ViewPath#/manage/product_order_report.cfm">

	</cfcase> --->

	<cfcase value="emailPdfAdmin">
		<cfinclude template="../views/layout.top.cfm" />

		<cfset url.uid = "611" />

		<cfdocument format="pdf" filename="#expandpath('.')#/uploads/products/#url.uid#.pdf" overwrite="yes">

			<cfinclude template="#ViewPath#/manage/update_product_invoice.cfm">

  		</cfdocument>

		<!--- <cfsavecontent variable="emailBody">
			<cfoutput>
			Dear #session.invoiceinfo.fname# #session.invoiceinfo.lname#,<br><br>
			Attached is your invoice for your Gallart Order ###session.invoiceinfo.invoiceNumber#. <br>
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
		<cfset form.recipient = session.invoiceinfo.email />
		<cfset form.subject = "Your Gallart Order" />
		<cfset form.body = emailBody />
		<cfset form.attachment = "#expandpath('.')#/uploads/products/#session.invoiceinfo.invoiceNumber#.pdf" />

		<cfscript>
			emailInvoice = application.objectFactoryAdmin.getInstance('mailer').sendMail( argumentcollection = form );
		</cfscript> --->

		<cfinclude template="../views/layout.bottom.cfm" />
	</cfcase>

	<cfcase value="mailTest">
		<cfinclude template="../views/layout.top.cfm" />

			<cfsavecontent variable="emailBody">
				<cfoutput>
				This is an email test
				</cfoutput>
			</cfsavecontent>

			<cfset form.sender = "info@gallart.com" />
			<cfset form.recipient = "steverucker@gmail.com" />
			<cfset form.subject = "Gallart Test Email" />
			<cfset form.body = emailBody />
			<!--- <cfset form.attachment = "#expandpath('.')#/uploads/products/#session.invoiceinfo.invoiceNumber#.pdf" /> --->

			<cfscript>
				emailInvoice = application.objectFactoryAdmin.getInstance('mailer').sendMail( argumentcollection = form );
			</cfscript>

			<cfdump var="#emailInvoice#"><cfabort>

			<cfinclude template="../views/layout.bottom.cfm" />
		</cfcase>
</cfswitch>
