<cfapplication name="galleryart"
               clientmanagement="Yes"
               sessionmanagement="Yes"
               sessiontimeout="#CreateTimeSpan(0,0,20,0)#"
               applicationtimeout="#CreateTimeSpan(1,0,0,0)#">
<cfset dsource="onli16-gallart">
<cfset uname="onli16_gallart">
<cfset pword="re3objec"> 
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
<!--- from true cost, amount to mark up for "wholesale" --->
<cfset costmkup = "1.59">
<!--- from true cost, amount to mark up for "our web price" --->
<cfset webmkup = "2.25">
<!--- from truecost, amount to mark up for retail --->
<cfset retailmkup = "3.25">



<!--- all emails will be sent to this email address. To add more, send to an alias and forward to additional accounts. If an address is put into cc, it will be sent as well --->
<cfset emailsupport = "websitegallart@gallart.com">
<cfset emailsupportcc = "KENGALLART@aol.com">
<!--- This should represent the page which should be used for secure processing.  set to a non secure page while developing, and change when ready --->
<cfset securepage = "http://#server_name#">
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
<cfset we_uploaddir = "#application.ppath#weimg\">
<cfset we_uploadweb = "http://#server_name#/weimg/">
<cfset uploaddirweb = "http://#server_name#/img">
<!--- If you want the email a friend option Put 'Y', else put 'N' --->
<cfset efriend = 'Y'>

<cfset vendoradd = "y">

<cfif not parameterexists(xss)>
<cfset xss = randrange(1,9999) & chr(randrange(65,90)) & randrange(1,9999)>
<cfquery name="insertTrack" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		INSERT INTO tracker(sessionid, referrer, entrypage, originIP) VALUES('#xss#', '#cgi.http_referer#', '#cgi.path_info#', '#cgi.remote_addr#')
	</cfquery>
</cfif>
<!--- <cfparam name="flashow" default="siteflash"> --->

<cfset servername = "127.0.0.1" />

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
<cfset ImgFile = "C:\inetpub\wwwroot\gallart.com\img\djlogo.gif">

<cfset adminuname="kengallart@aol.com">
<cfset adminpass="ga113ry">

<!--- <cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	delete from tracker
	where createdon < #dateadd('m',-1,createodbcdate(now()))#
</cfquery> --->


<cfinclude template="functions.cfm">



