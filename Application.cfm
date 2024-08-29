<cfapplication 
    name="galleryart"
    clientmanagement="Yes"
    sessionmanagement="Yes"
    sessiontimeout="#CreateTimeSpan(0,6,0,0)#"
    applicationtimeout="#CreateTimeSpan(1,0,0,0)#">

<cfset enableRobustException="true">
<cfset application.dsource="gallarttest">
<cfset server_name="gallart.com">

<cfset COMPANYNAME="gallart">
<cfset dsource="gallarttest">
<cfset uname="admin">
<cfset pword="GAllart2022!!"> 
<cfset rootpath = "">
<cfset application.ppath = GetDirectoryFromPath(GetCurrentTemplatePath()) />
<cfset partner = "WEB">
<cfset batchproc = 0>
<cfset filelocation = "#application.ppath#gallart.com\vendors\pos\">
<cfset filemap = "/vendors/pos/">
<!--- if you wish to charge sales tax put in the appopriate state, and the amount of tax to charge.  Put in 6 for 6%, not .06 --->
<cfset taxst ="FL">
<cfset taxamount = "6.5">
<cfset shipopt = 1>
<cfset insurance = "10">

<cfset application.showSalePrice = 1 />

<cfset application.objectFactoryLeads = createObject('component','leads.models.objectFactory_app').init() />
<cfset application.objectFactory = createObject('component','orders.models.objectFactory_app').init() />
<cfset application.objectFactoryAdmin = createObject('component','admin.models.objectFactory_app').init() />
<cfset application.objectFactoryExtranet = createObject('component','extranet.models.objectFactory_app').init() />
<!--- 
1 = ship_weight * shipmult 
2 = Send to UPS for quote 
--->
<!--- Shipping will always be equal to or more than shipmin --->
<cfset shipmin = "25.00">
<!--- maximum for express air, this also shows on the airtable.cfm and is contained in the shippingoptions table as the expressair entry --->


<!--- shipmult is multiplies by the "shipweight" to get the base shipping charge --->
<cfset shipmult = "2">
<!--- set to 0 if you do not wish to insure OR insure amount will be added for each $100 after the first --->
<cfset insure = "0.35">
<!--- standard markup defaults. These will only be used if pricing fields in the products backoffice are left blank --->
<!--- <!--- from true cost, amount to mark up for "wholesale" --->
<cfset costmkup = "1.59">
<!--- from true cost, amount to mark up for "our web price" --->
<cfset webmkup = "2.25">
<!--- from truecost, amount to mark up for retail --->
<cfset retailmkup = "3.25"> --->


<cfset imgpath = "https://#server_name#/images">

<!--- all emails will be sent to this email address. To add more, send to an alias and forward to additional accounts. If an address is put into cc, it will be sent as well --->
<cfset emailsupport = "websitegallart@gallart.com">
<cfset emailsupportcc = "KENGALLART@aol.com">
<!--- This should represent the page which should be used for secure processing.  set to a non secure page while developing, and change when ready --->
<cfset securepage = "https://#server_name#">
<cfset titletext="Buy and Sell - Peter Max, Andy Warhol, Tom Wesselmann">
<!--- When refering to the site, "sitename" is used. When refering to company, "companyname" is used --->
<cfset sitename = "#server_name#">
<cfset companyname="Gallart.com">
<cfset caddress = "20633 Biscayne Blvd">
<cfset csz = "Aventura, FL 33180">
<cfset czip = "33180">
<cfset cphone = "305-932-6166">
<cfset footmess = "Gallery Art Online">
<Cfset addbutton = "/img/add.gif">
<cfset sidecolor ="cccccc">
<cfset centercolor ="ffffff">
<cfset displaycolor ="222222">
<cfset uploaddir = "#application.ppath#img">
<!--- FOR CFC ACCESS --->
<cfset application.uploaddir = "#application.ppath#img">
<cfset we_uploaddir = "#application.ppath#weimg\">
<cfset we_uploadweb = "https://#server_name#/weimg/">
<cfset uploaddirweb = "https://#server_name#/img">
<!--- If you want the email a friend option Put 'Y', else put 'N' --->
<cfset efriend = 'Y'>

<cfset vendoradd = "y">

<cfif not isDefined('xss')>
	<cfset xss = randrange(1,9999) & chr(randrange(65,90)) & randrange(1,9999)>
	<cfquery name="insertTrack" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		INSERT INTO tracker(sessionid, referrer, entrypage, originIP) VALUES('#xss#', '#cgi.http_referer#', '#cgi.path_info#', '#cgi.remote_addr#')
	</cfquery>
</cfif>

<cfif isDefined('url.emailLogId')>
	<cfquery name="insertTrack" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		INSERT INTO email_tracker
		(
			fk_email_log,
			referrer, 
			entrypage, 
			originIP
		) 
		VALUES
		(
			'#url.emailLogId#', 
			'#cgi.http_referer#', 
			'#cgi.path_info#', 
			'#cgi.remote_addr#'
		)
	</cfquery>
</cfif>

<cfquery name="cleanTracker" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	DELETE from tracker
WHERE createdon < '#DateFormat(createodbcdate(DateAdd('w',-1,now())))#'
</cfquery>

<!--- <cfparam name="flashow" default="siteflash"> --->
<!--- for mails sent from main site (contact forms, etc) --->
<cfset servername = "mail2.onlinegalleryart.com" />

<!--- email blast server --->
<cfset application.email_server = "mail2.gallart_.com" />
<cfset application.email_username = "info@onlinegalleryart.us" />
<cfset application.email_password = "22kenhen" />
<cfset application.email_from = "info@onlinegalleryart.us" />

<!--- TEMP: blast from web server --->
<!--- <cfset application.email_server = "mail2.onlinegalleryart.com" />
<cfset application.email_username = "onli16@onlinegalleryart.com" />
<cfset application.email_password = "re3objec" />
<cfset application.email_from = "info@gallart.com" /> --->

<!--- LinkPoint Global Settings --->
<cfset merchuname="">
<cfset merchantpass="">
<cfset KeyFile ="">
<cfset HostAddr = "">
<Cfset PORT = "1139">
<!--- LP Mode --->
<!--- 0: Run transactions in LIVE mode, transaction charges apply --->
<!--- 1: Run transactions in TEST mode, no transaction charges --->
<!--- 2: Return a duplicate transaction result --->
<!--- 3: Return a decline transaction result --->
<CFSET MODE = 1> 
<cfset sitecolor = "777777">
<cfset ImgFile = "http://3.235.23.60/img/djlogo.gif">

<cfset adminuname="kengallart@aol.com">
<cfset adminpass="DsT48c">

<cfset biouname="PrvtSpace@aol.com">
<cfset biopass="bioentry">



<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	delete from tracker
	where createdon < #dateadd('m',-1,createodbcdate(now()))#
</cfquery>


<cfinclude template="functions.cfm">

<!--- SET THESE VARIABLES FOR LEAD SYSTEM - CONFIGBEAN --->

<cfscript>
	application.dsource='gallarttest';
	application.dbuname='admin';
	application.dbpword='GAllart2022!!';
	application.rootpath='';
	application.vmap='';
	application.mailserver='mail2.onlinegalleryart_.com';
</cfscript>

<!--- mailserver for web --->

<!--- re3objec --->


<cfscript>
	application.mailserver='mail2.onlinegalleryart_.com';
	application.mailserver_un='gallart@onlinegalleryart.com';
	application.mailserver_pw='re3objeC!P';
</cfscript>


<cffunction name="onError" access="public" returntype="void">
    <cfargument name="Exception" type="any" required="true">
    <cfargument name="EventName" type="string" required="true">
  
    <!--- Display the error information --->
    <cfdump var="#Arguments.EventName#" label="Error Information">
    <cfdump var="#Arguments.Exception#" label="Error Information">
    <cfabort>
  </cffunction>