<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<!--- set default shipping --->
<cfquery name="shipping" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT top 1 * FROM shipping
</CFQUERY>

<cfset ship_weight = shipping.shipweight />
<cfset shipinfo = shipping.shipdesc />
<cfset fileSizeLimit = 2000000 />
<cfset fileSizeLimitKb = '2MB' />

<!--- Inserting, Updating or Deleting the Product Information --->
<cfif isDefined('process')>

	<cfif structKeyExists(form, "process") AND ListFirst(form.process, ",") EQ "ADD">

        <cfif isDefined("session.sellerinfo.pk_users")>
            <cfquery name="qrytocheck" datasource="#dsource#" username="#uname#" password="#pword#">
               SELECT * FROM products
               where fk_users = #session.sellerinfo.pk_users#
            </cfquery>
         <cfelse>
            <cfquery name="qrytocheck" datasource="#dsource#" username="#uname#" password="#pword#">
               SELECT top 10 * FROM products
            </cfquery>
        </cfif>

        <cfif qrytocheck.recordcount LT 5>        
    
            <cfif cgi.content_length LTE fileSizeLimit>
            
                <cflock name="inserting" timeout="10">
                
                    <!--- parse out unwanted chars --->
                    <cfset form.retail_price 	= rereplace(form.retail_price, "[^0-9|.]", "", "all")> 
                    <cfset form.gallery_price 	= rereplace(form.gallery_price, "[^0-9|.]", "", "all")> 
                
                    <!--- Create Model No --->
                    <cfquery name="modinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                        SELECT top 1 modelno_numeric FROM products
                        order by modelno_numeric desc
                    </cfquery>
                
                    <cfset modelno_numeric_new = modinfo.modelno_numeric + 1 />
                    
                    <cfset modelno = "S" & modelno_numeric_new />
            
                    <cfif form.quantity lt 1>
                        <cfset tquantity = 0>
                    <Cfelse>
                        <cfset tquantity = form.quantity>
                    </cfif>
                
                    <!--- <cfif category is not "">
                        <cfif right(category,1) neq ":">
                            <cfset category = category&":">
                        <cfelse> --->
                            <cfset category = category>
                        <!--- </cfif>
                    </cfif> --->           
                            
                        <cfquery name="insertListing" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                            INSERT INTO products 
                            (
                                fk_users,
                                datestamp, 
                                modelno, 
                                modelno_numeric,
                                code, 
                                name, 
                                retail_price,
                                gallery_price,
                                quantity, 
                                orderable, 
                                path, 
                                options, 
                                ship_weight, 
                                Vendor, 
                                manufacturer, 
                                Active, 
                                expressair, 
                                shipinfo, 
                                availablity, 
                                caption,
                                year,
                                size,
                                LASTEDIT
                            )
                            VALUES
                            (
                                #session.sellerinfo.pk_users#,
                                '#datestamp#', 
                                '#modelno#',
                                #modelno_numeric_new#,
                                '#form.Vendor#-#modelno#',
                                '#form.name#', 
                                #form.retail_price#, 
                                #form.gallery_price#, 
                                #tquantity#, 
                                #orderable#, 
                                '#category#', 
                                '#form.options#', 
                                #ship_weight#,
                                '#form.Vendor#',
                                '#form.manufacturer#', 
                                '#form.active#',
                                '#expressair#', 
                                '#shipinfo#', 
                                '#availablity#', 
                                '#caption#',
                                '#year#',
                                '#size#',
                                <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#createodbcdatetime(now())#">
                            )
                            SELECT @@identity as uid 
                        </cfquery>
                        
                        <cfset thisId = insertListing.uid /> 
                        
                        <cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
                        <cfset date = now()>
                        <cfset moduleName = 'Sell your art form'>
                        <cfset action = 'Insert'>

                        <cfquery name="addLog" datasource="#application.dsource#" >
                            INSERT INTO logs 
                                ( moduleName, ipAddress, date, action)
                                VALUES
                                ( '#moduleName#', '#ipAddress#', #date#, '#action#')
                        </cfquery>
                
                </cflock>
                
                <cfif isDefined('form.fileup') and form.fileup NEQ "">
                            
                    <cffile action="upload" nameconflict="overwrite" filefield="fileup" destination="#uploaddir#" result="fileupload">

                    <cfset fileExt = lcase(fileupload.clientFileExt)>

                    <cfif fileupload.fileWasSaved and fileExt EQ "jpg">
                                                
                        <cffile 
                            action="rename" 
                            source="#fileupload.serverDirectory#/#fileupload.serverFile#" 
                            destination="#fileupload.serverDirectory#/#thisId#.jpg">

                        <!--- Step 5: Process image --->
                        <cfimage 
                            action="read" 
                            source="#application.uploaddir#/#thisId#.jpg" 
                            name="oImage" 
                        />

                        <cfimage
                            action="resize"
                            source="#oImage#"
                            width="100"
                            height=""
                            name="oImageSmall"
                        />

                        <cfimage
                            action="write"
                            source="#oImageSmall#"
                            destination="#application.uploaddir#/thumbnails/#thisId#.jpg"
                            overwrite="true"
                        />
                                                
                     <cfelse>

                        <cfset session.ext = true>
                        <cflocation url="/user_listing_detail/#thisId#" addtoken="No">

                    </cfif>
                                                                
                </cfif>
                
                <cftry>
            
                    <cfmail 
                        server="#application.mailserver#" 
                        username="#application.mailserver_un#" 
                        password="#application.mailserver_pw#" 
                        to="#emailsupport#" 
                        cc="#emailsupportcc#" 
                        from="#emailsupport#" 
                        subject="GallArt.com <> Buying & Selling Fine Art <> New Member Registration <> Seller" 
                        type="HTML"
                        >
                            <font style="font-size: 10pt; font-family: Arial;">
                            <strong>
                                #session.sellerinfo.fname# #session.sellerinfo.lname#
                            </strong> entered a new product on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  
                            <br><br>
                            Title: #form.name#<br>
                            Artist: #form.manufacturer#<br>
                            Year: #form.year#<br>
                            Size: #form.size#<br>
                            Medium: #form.category#<br>
                            Retail Price: #form.retail_price#<br>
                            Gallery Price: #form.gallery_price#<br>
                            Art ID: #modelno#<br><br>
                            Please review this product in Admin, and update the status to "Active" to show on the site.
                            <br><br>
                    </cfmail>
                
                    <cfcatch type="Any">
                        ERROR!!<cfabort>
                    </cfcatch>
                
                </cftry>
                
                <cflocation url="/overView" addtoken="No">
                
             <cfelse>
                <cfset session.filetoolarge = true>
                <cflocation url="/user_listing_detail/" addtoken="No">
            </cfif>
		
         <cfelse>
            <cfset session.limitReached = true>
            <cflocation url="/user_listing_detail/" addtoken="No">
        </cfif>
	
	 <cfelseif structKeyExists(form, "process") AND ListFirst(form.process, ",") EQ "UPDATE">
    
    	<cfif cgi.content_length LTE fileSizeLimit>
	
		    <!--- parse out unwanted chars --->
            <cfset form.retail_price 	= rereplace(form.retail_price, "[^0-9|.]", "", "all")> 
            <cfset form.gallery_price 	= rereplace(form.gallery_price, "[^0-9|.]", "", "all")> 
            
            <cfif form.quantity lt 1>
                <cfset tquantity = 0>
            <Cfelse>
                <cfset tquantity = form.quantity>
            </cfif>
            
            <!--- <cfif category is not "">
                <cfif right(category,1) neq ":">
                    <cfset category = category&":">
                <cfelse> --->
                    <cfset category = category>
                <!--- </cfif>
            </cfif> --->

            <cfquery name="currentaction" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                UPDATE products SET
                    datestamp = '#datestamp#',
                    name = '#form.name#', 
                    orderable = #form.orderable#,
                    quantity = #tquantity#,
                    path = '#category#', 
                    options = '#form.options#', 
                    ship_weight = #ship_weight#, 
                    Vendor = '#form.Vendor#',
                    retail_price = #form.retail_price#,
                    gallery_price = #form.gallery_price#,
                    <cfif isDefined('Form.fileup') and Form.fileup is not "">
                    imageURL = '#uploaddirweb#/#uid#.jpg', 
                    </cfif>
                    manufacturer = '#form.manufacturer#', 
                    active = #form.active#,
                    expressair = '#expressair#',
                    shipinfo = '#shipinfo#',
                    availablity = '#availablity#',
                    caption = '#caption#',
                    year = '#year#',
                    size = '#size#',
                    LASTEDIT = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#createodbcdatetime(now())#">
                WHERE uid = #form.uid#
            </cfquery>

            <cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
            <cfset date = now()>
            <cfset moduleName = 'Sell your art form'>
            <cfset action = 'Update'>

            <cfquery name="addLog" datasource="#application.dsource#" >
                INSERT INTO logs 
                    ( moduleName, ipAddress, date, action)
                    VALUES
                    ( '#moduleName#', '#ipAddress#', #date#, '#action#')
            </cfquery>

            <cfif isDefined('form.fileup') and form.fileup NEQ "">
            
                <cffile action="upload" nameconflict="overwrite" filefield="fileup" destination="#uploaddir#" result="fileupload">

                <cfset fileExt = lcase(fileupload.clientFileExt)>

                <cfif fileupload.fileWasSaved and fileExt EQ 'jpg'>

                    <cffile 
                        action="rename" 
                        source="#fileupload.serverDirectory#/#fileupload.serverFile#" 
                        destination="#fileupload.serverDirectory#/#form.uid#.jpg"
                    >
                
                    <cfimage 
                        action="read" 
                        source="#application.uploaddir#/#form.uid#.jpg" 
                        name="oImage" 
                    />
            
                    <cfimage
                        action="resize"
                        source="#oImage#"
                        width="100"
                        height=""
                        name="oImageSmall"
                    />
                
                    <cfimage
                        action="WRITE"
                        source="#oImageSmall#"
                        destination="#application.uploaddir#/thumbnails/#form.uid#.jpg"
                        overwrite="true"
                    />
                                
                 <cfelse>
                    <cffile action="delete" file="#fileupload.serverDirectory#/#fileupload.serverFile#">
                    <cfset session.ext = true>
                    <cflocation url="/user_listing_detail/#form.uid#" addtoken="No">
                </cfif>
                                    
            </cfif>
            
            <cftry>
            
                <cfmail 
                    server="#application.mailserver#" 
                    username="#application.mailserver_un#" 
                    password="#application.mailserver_pw#" 
                    to="#emailsupport#" 
                    cc="#emailsupportcc#" 
                    from="#emailsupport#" 
                    subject="Gallery Art Member Listing Update" 
                    type="HTML"
                    >
                        <font style="font-size: 10pt; font-family: Arial;">
                        <strong>
                            #session.sellerinfo.fname# #session.sellerinfo.lname#
                        </strong> updated a product on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  
                        <br><br>
                        Title: #form.name#<br>
                        Artist: #form.manufacturer#<br>
                        Year: #form.year#<br>
                        Size: #form.size#<br>
                        Medium: #form.category#<br>
                        Retail Price: #form.retail_price#<br>
                        Gallery Price: #form.gallery_price#<br>
                        <!--- Art ID: #form.modelno#<br><br> --->
                        Please review this product in Admin, and update the status to "Active" to show on the site.
                        <br><br>
                </cfmail>
            
             <cfcatch type="Any">
                ERROR!!
                <cfabort>
             </cfcatch>
            
            </cftry>
            
            <cflocation url="/overView" addtoken="No">
            
      	 <cfelse>
            <cfset session.filetoolarge = true>
        	<cflocation url="/user_listing_detail/#form.uid#" addtoken="No">
		</cfif>
		
		
	
	 <cfelseif structKeyExists(form, "process") AND ListFirst(form.process, ",") EQ "DELETE" >
	
		<cftry>
			<cffile action="DELETE" file="#uploaddir#/#form.uid#.jpg">
		 <cfcatch type="Any"></cfcatch>
		</cftry>
		
		<cftry>
			<cffile action="DELETE" file="#uploaddir#/thumbnails/#form.uid#.jpg">
		 <cfcatch type="Any"></cfcatch>
		</cftry>
	
		
		<cfquery name="currentaction" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			DELETE products where uid = #form.uid#	
		</cfquery>

        <cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
        <cfset date = now()>
        <cfset moduleName = 'Sell your art form'>
        <cfset action = 'Delete'>

        <cfquery name="addLog" datasource="#application.dsource#" >
            INSERT INTO logs 
                ( moduleName, ipAddress, date, action)
                VALUES
                ( '#moduleName#', '#ipAddress#', #date#, '#action#')
        </cfquery>
		
		<cflocation url="/user_listing_results/delete" addtoken="No">
	
	</cfif>
    

</cfif>

<!--- End processing --->

 <!--- <cfset StructDelete(Session, "sellerinfo")> --->

<cfif isDefined("session.sellerinfo.pk_users")>
    <cfquery name="sellerArt" datasource="#dsource#" username="#uname#" password="#pword#">
        SELECT * FROM products
        where fk_users = #session.sellerinfo.pk_users#
    </cfquery>
 <cfelse>
    <cfquery name="sellerArt" datasource="#dsource#" username="#uname#" password="#pword#">
        SELECT top 10 * FROM products
    </cfquery>
</cfif>
    

<cfquery name="opt" datasource="#dsource#" username="#uname#" password="#pword#">
	SELECT * FROM opt ORDER BY opt,val
</cfquery>

<Cfif parameterexists(id)>
    <cfquery name="detail" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT * FROM products
        WHERE products.UID = #ID#
    </CFQUERY>
    <cfset modelno = detail.modelno>
<Cfelse>
    <cfquery name="detail" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT * FROM products
        WHERE 0=1
    </CFQUERY>
</cfif>

<cfquery name="artists" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT distinct manufacturer FROM products
	order by manufacturer
</CFQUERY>

<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT DISTINCT path FROM products
    group by path
    order by path
</cfquery>

<html>
    <head>
        <cfoutput>
        <title>#companyname# - #titletext#</title>
        </cfoutput>

        <cfinclude template="meta.cfm">

        <cfoutput>
            <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
            <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
            <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
            <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
            <script language="JavaScript" src="/js/utils.js"></script>
        </cfoutput>

        <link href="/stylesheet_.css" rel="stylesheet" type="text/css">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

        <script LANGUAGE="javascript">

            function isValidSize(sText){
                var ValidChars = "0123456789.xX ";
                var isValid=true;
                var Char;
            
                for (i = 0; i < sText.length && isValid == true; i++){ 
                    Char = sText.charAt(i); 
                    if (ValidChars.indexOf(Char) == -1){
                        isValid = false;
                    }
                }
                return isValid;
            }

            function disableSubmitButton(button) {
                if (button) {
                    button.disabled = true;
                    button.value = "Processing..."; // Button text change optional
                }
            }

            function validEntries(frm) {
                if(frm.vendor.value == '') {
                    alert('please select Vendor'); return false;
                }
                isValid = true;
                document.querySelectorAll('.error-message').forEach(error => error.textContent = '');
                if(frm.name.value == ''){
                    toastr.error('You must enter a Title.');
                    isValid = false;
                }

                

                if(frm.gallery_price.value == '' || frm.gallery_price.value == '$0.00' || frm.gallery_price.value == 0){
                    toastr.error('You must enter a Gallery Price greater than zero');
                    isValid = false;
                }
                if(frm.manufacturer.value == ''){
                    toastr.error('You must select an Artist.');
                    isValid = false;
                }
                if(frm.category.value == ''){
                    toastr.error('You must select a Medium.');
                    isValid = false;
                }


                if (frm.size.value.trim() === '') {
                    toastr.error('You must enter a valid SIZE in the format height x width (e.g. 12x24)');
                    isValid = false;
                } else {

                    const sizePattern = /^[0-9]+(\.[0-9]+)*\s*[xX]\s*[0-9]+(\.[0-9]+)*(\s*[xX]\s*[0-9]+(\.[0-9]+)*)?$/;

                    if (!sizePattern.test(frm.size.value.trim())) {
                        toastr.error('Size must be in the format height x width (e.g. 12x24)');
                        isValid = false;
                    }
                }

                if(frm.caption.value == ''){
                    toastr.error('You must enter a artwork description.');
                    isValid = false;
                }
                
            

                if(isValid){
                    const submitButton = frm.querySelector("input[type=submit]");
                    disableSubmitButton(submitButton);
                }

            

                return isValid;
                
            }
            function ArtistView() {
                var artistvalue = document.frm1.artistview.value;
                document.frm1.manufacturer.value = artistvalue; 
                return true;
            }
        </script>

        <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-34565365-1']);
        _gaq.push(['_trackPageview']);

        (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

        </script>

        <!-- BEGIN ROBLY WIDGET CODE -->
        <script type='text/javascript'>
            var _d_site = _d_site || 'ebb8c5f7da7077e127988b3276107648';
            (function(w, d, p, s, s2) {
                w[p] = w[p] || function() { (w[p].q = w[p].q || []).push(arguments) };
                s = d.createElement('script'); s.async = 1; s.src = '//s3.amazonaws.com/roblyimages/accounts/20559/forms/29541/signup_popup.js';
                s2 = d.getElementsByTagName('script')[0]; s2.parentNode.insertBefore(s, s2);
            })(window, document, 'Robly');
        </script>
        <!-- END ROBLY WIDGET CODE -->

    </head>

    <body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

        <div class="main-container registration-page">
            <div id="Table_01">
                <div class="header-section">
                    <div class="top-header">
                        <cfinclude template="top_.cfm">
                    </div>
                    <div class="navbar-section">
                        <cfinclude template="navbar_user.cfm">
                    </div>
                </div>
                <div class="inner-section">
                    <div class="container-fluid">
                        <div class="main-content pb-4">
                            <div class="content-section">
                                <div class="bottom-content-sec">
                                    <div class="banner-section">
                                        <div class="art-work-content">
                                            <div class="bottom-content">
                                                <div class="user-registrations quotes-page contact-page">
                                                    <div class="top-heading">
                                                        <cfif structKeyExists(url,'error')>
                                                            <span style="color: #dd3a7d; padding-top: 25px; font-size: 13px; font-weight: bold;">
                                                                Sorry, but the file that you are attempting to load is too large.  
                                                                Please reduce your file size to <cfoutput>#fileSizeLimitKb#</cfoutput>.
                                                            </span>
                                                        </cfif>
                                                        <cfif sellerArt.recordcount GTE 5>
                                                            <cfif !isDefined('url.id')>
                                                                <span style="color: #dd3a7d; padding-top: 25px; font-size: 13px; font-weight: bold;">
                                                                    Sorry, but you are only allowed 5 free uploads.  Please contact
                                                                    <b>
                                                                        <a href="mailto:info@gallart.com" style="color: #ff0000; font-size: 13px; text-decoration:underline;">
                                                                            Gallart.com
                                                                        </a>
                                                                    </b> in order to submit additional listings at $35 apiece.
                                                                </span>
                                                            </cfif>
                                                        </cfif>
                                                        <h3>SELL YOUR ART ON GALLART.COM!</h3>
                                                    </div>
                                                    <p>Use this simple form to list your art.  Remember:</p>
                                                    <ul>
                                                        <li>Don't use any personal information in your description, or watermarks in the images.</li>
                                                        <li>GALLART.COM will charge a 20% fee when you sell your art</li>
                                                        <li>You are only allowed 5 free uploads.  Please contact <b> <a href="mailto:info@gallart.com" style="text-decoration:underline;">Gallart.com</a> </b> in order to submit additional listings at $35 apiece.</li>
                                                    </ul>
                                                    <!--- <p>You may enter as many pieces of art as you like!</p> --->
                                                    <p>GALLART.COM will review your listings.  If they are approved, they will be shown on the site.</p>
                                        
                                                    <cfoutput>

                                                        <form name="frm1" action="/user_listing_detail" method="post" enctype="multipart/form-data" onSubmit="javascript:return validEntries(document.frm1);">
                                                            <div class="input-form">
                                                                <input type="Hidden" name="fk_users" value="#session.sellerinfo.pk_users#">
                                                                <input type="hidden" name="orderable" value="0">
                                                                <input type="hidden" name="quantity" value="0">
                                                                <input type="hidden" name="availablity" value="3 - 5 Business Days">
                                                                <input type="hidden" name="expressair" value="no">
                                                                <input type="hidden" name="options" value="">
                                                                <input type="hidden" name="active" value="0">
                                                                <input type="hidden" name="datestamp" value="#dateformat(now(), 'mm/dd/yyyy')#">
                                                                <input type="hidden" name="vendor" value="0001">

                                                                <div class="input-field">
                                                                    <label><b>Title:<span style="color: ##ff0000;">*</span></b></label>
                                                                    <input type="text" name="name" value="#replace(detail.Name,'"','&quot;','all')#" maxlength="30" size="40">
                                                                    <span class="error-message" id="titleError"></span>
                                                                </div>

                                                                <div class="input-field">
                                                                    <label><b>Select Artist:<span style="color: ##ff0000;">*</span></b></label>
                                                                    <Select name="artistview"  onchange="ArtistView()" class="select2">
                                                                        <option value="">Select here ...</option>
                                                                        <cfloop query="artists">
                                                                        <cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
                                                                        <option value="#HTMLEditFormat(manufacturer)#" <cfif HTMLEditFormat(manufacturer) is #HTMLEditFormat(detail.manufacturer)#>Selected</cfif>>#HTMLEditFormat(manufacturer)#
                                                                        </cfif>
                                                                        
                                                                        </cfloop>
                                                                    </select>
                                                                    <span class="error-message" id="artistviewError"></span>
                                                                </div>

                                                                <div class="input-field">
                                                                    <label><b><i>Select an artist from dropdown above, OR type in a new artist below (last name, first name):</i></b></label>
                                                                    <input type="Text" name="manufacturer" maxlength="40" value="#HTMLEditFormat(detail.manufacturer)#" size="40">
                                                                </div>

                                                                <div class="input-field">
                                                                    <label><b>Year:</b></label>
                                                                    <input type="text" name="year" value="#detail.year#" maxlength="6" size="25">
                                                                </div>

                                                                <div class="input-field">
                                                                    <label><b>Size (height x width) in inches:<span style="color: ##ff0000;">*</span></b></label>
                                                                    <input type="text" name="size" value="#detail.size#" maxlength="15" size="25">&nbsp;<font face="Verdana, Arial,helvetica" size="1"></font>
                                                                    <span class="error-message" id="SizeError"></span>
                                                                </div>

                                                                <div class="input-field">
                                                                    <label><b>Select Medium from dropdown below:<span style="color: ##ff0000;">*</span></b></label>
                                                                    <Select name="category" class="select2">
                                                                        <option value="">Select here ...</option>
                                                                        <cfloop query="cats">
                                                                            <option value="#path#" <cfif #path# is #detail.path#>Selected</cfif>>#path#
                                                                        
                                                                        </cfloop>
                                                                    </select>
                                                                    <span class="error-message" id="MediumError"></span>
                                                                </div>

                                                                <div class="input-field">
                                                                    <label><b>Retail Price:</b></label>
                                                                    <input type="text" name="retail_price" value="#dollarformat(detail.retail_price)#" size="25" maxlength="10">
                                                                    <span class="error-message" id="RetailPriceError"></span>
                                                                </div>

                                                                <div class="input-field">
                                                                    <label><b>Selling Price (20% fee will be deducted from this price):<span style="color: ##ff0000;">*</span></b></label>
                                                                    <input type="text" name="gallery_price" value="#dollarformat(detail.gallery_price)#" size="25" maxlength="10">
                                                                    <span class="error-message" id="GalleryPriceError"></span>
                                                                </div>

                                                                <div class="input-field">
                                                                    <label><b>Description:<span style="color: ##ff0000;">*</span></b></label>
                                                                    <textarea name="caption" maxlength="500" id="caption" cols="90" rows="4">#detail.caption#</textarea>
                                                                    <div id="charCount" class="mb-3">0 / 500 characters</div>
                                                                </div>
                                                                <div class="input-field">
                                                                <!--- <label><b>Upload New Product Picture</b> <span style="color: ##ff0000; font-size: 8pt;">(THE FILE MUST BE A .JPG, AND MUST BE LESS THAN #fileSizeLimitKb# IN SIZE)</span></label>
                                                                    <input type="file" name="fileup" size="22" style="font-size: xx-small;padding: 0;"> --->
                                                                    
                                                                        <div class="input-field image-upload pb-2">
                                                                            <h3>
                                                                            UPLOAD IMAGE
                                                                            </h3>
                                                                            <ul>
                                                                                <li>- Please attach an image of the artwork </li>
                                                                                <li>- The file must be a .JPG  </li>
                                                                                <li>- Image size maximum <b>2MB</b>. </li>
                                                                            </ul>
                                                                        </div>
                                                                        <!--- <label><b>Upload New Product Picture</b>
                                                                            <span style="color: ##ff0000; font-size: 8pt;">(THE FILE MUST BE A .JPG, AND MUST BE LESS THAN #fileSizeLimitKb# IN SIZE)</span>
                                                                            </label> --->
                                                                        <div class="file-upload-wrapper sm-file-upload-wrapper">
                                                                            <label for="file-upload" class="file-upload-label">
                                                                            <div class="file-upload-icon">
                                                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                                                                    <path d="M12 2C11.45 2 11 2.45 11 3V13H8L12 17L16 13H13V3C13 2.45 12.55 2 12 2ZM5 19H19C19.55 19 20 18.55 20 18V16C20 15.45 19.55 15 19 15H5C4.45 15 4 15.45 4 16V18C4 18.55 4.45 19 5 19Z"></path>
                                                                                </svg>
                                                                            </div>
                                                                            <div class="file-upload-text"><strong>Browse File</strong></div>
                                                                            </label>
                                                                            <div class="file-upload-custom">
                                                                                <input type="file" name="fileup" size="22" style="padding: 0;">
                                                                            </div>
                                                                            
                                                                        </div>


                                                                    </div>
                                                                <div class="input-field">
                                                                    <cfif fileexists("#expandpath('.')#/img/thumbnails/#detail.uid#.jpg")>
                                                                        <img src="http://#server_name#/img/#detail.uid#.jpg?u=#randrange(1,1000)#" style="width: 200px !important;">
                                                                    </cfif>
                                                                </div>
                                                                <div class="input-button flex-input-btn listing-detail-btns">
                                                                    <cfif isDefined('url.id')>
                                                                        <input type="Hidden" name="process" value="UPDATE" class="SeeMore">
                                                                        <input type="submit" name="process" id="btnUpdate" class="SeeMore" value="Update Your Listing" onClick="javascript:return confirm('Updating your product will temporarily remove it from the site until Gallery Art can review it -- Are You Sure?');"><br>
                                                                        <input type="reset" value="Reset" class="SeeMore" />
                                                                        <input type="hidden" name="id" value="#url.id#">
                                                                            <Cfif isDefined('returnq')>
                                                                            <input type="hidden" name="returnq" value="#returnq#">
                                                                            </cfif>
                                                                        <input type="hidden" name="uid" value="#detail.uid#"><br><br>
                                                                        
                                                                        <cfelse>
                                                                        <input type="Hidden"  name="process" value="ADD">
                                                                        <input type="submit" id="btnAdd" name="process" class="SeeMore" value="Add Your Listing">
                                                                            <Cfif isDefined('returnq')>
                                                                            <input type="hidden" name="returnq" value="#returnq#">
                                                                            </cfif>
                                                                        </cfif>
                                                                </div>
                                                            </div>
                                                        </form>

                                                        <cfif structKeyExists(detail, "uid") and len(trim(detail.uid))>
                                                            <form name="frmDelete" action="/user_listing_detail" method="post">
                                                                <div class="input-form">
                                                                    <input type="Hidden" name="process" value="DELETE">
                                                                    <input type="hidden" name="uid" value="#detail.uid#">

                                                                    <div class="input-button flex-input-btn listing-detail-btns">
                                                                        <input type="submit" name="process" id="btnDelete" class="SeeMore" value="Delete!" onclick="return handleDelete(this);">
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </cfif>
                                                    </cfoutput>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer-section">
                    <cfinclude template="footer_user.cfm">
                </div>
            </div>
        </div>

        <cfinclude template="frmxss.cfm">

        <script>
            $(document).ready(function () {
                $('.select2').select2({
                    matcher: function (params, data) {
                        if ($.trim(params.term) === '') {
                            return data;
                        }

                        // Prevent matching placeholder during search
                        if (data.id === '') {
                            return null;
                        }

                        var term = params.term.toLowerCase();
                        var text = data.text.toLowerCase();

                        // Starts with match
                        if (text.startsWith(term)) {
                            return data;
                        }

                        // Contains match (less priority)
                        if (text.indexOf(term) > -1) {
                            var modifiedData = $.extend({}, data, true);
                            modifiedData.text = data.text + ' ';
                            return modifiedData;
                        }

                        return null;
                    },

                    sorter: function (data) {
                        var term = $('.select2-search__field').val().toLowerCase();
                        return data.sort(function (a, b) {
                            var aStarts = a.text.toLowerCase().startsWith(term);
                            var bStarts = b.text.toLowerCase().startsWith(term);

                            if (aStarts && !bStarts) return -1;
                            if (!aStarts && bStarts) return 1;
                            return 0;
                        });
                    }
                });
            });


            function handleDelete(btn) {
                // pehle confirmation lo
                if (!confirm('Delete -- Are You Sure?')) {
                    return false; // cancel
                }

                // abhi form submit hone do, button turant disable mat karo
                // form submit hone ke baad ek chhota delay laga ke button disable kar dete hain
                setTimeout(() => {
                    btn.disabled = true;
                    btn.value = "Deleting…";
                }, 10);

                return true; // allow form submission
            }

        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function() {
                const textarea = document.getElementById("caption");
                const counter = document.getElementById("charCount");
                const maxLength = 500;

                function updateCount() {
                const currentLength = textarea.value.length;
                counter.textContent = `${currentLength} / ${maxLength} characters`;
                }

                // Update counter initially
                updateCount();

                // Update on input
                textarea.addEventListener("input", updateCount);
            });
        </script>

        <script>
            <cfif structKeyExists(session, "limitReached") and session.limitReached>
                toastr.error('Sorry, You are only allowed 5 free uploads.');
                <cfset structDelete(session, "limitReached")>
            </cfif>
            <cfif structKeyExists(session, "filetoolarge") and session.filetoolarge>
                toastr.error('Image size is maximum 2MB');
                <cfset structDelete(session, "filetoolarge")>
            </cfif>
            <cfif structKeyExists(session, "ext") and session.ext>
                toastr.error('Only JGP files add');
                <cfset structDelete(session, "ext")>
            </cfif>
        </script>

        <style>

            body{
                overflow-x: hidden;
            }

            .select2-container--default .select2-selection--single {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 4px;
                height: 38px;
                padding: 5px 10px;
                font-size: 14px;
                font-family: inherit;
                box-sizing: border-box;
            }

            .select2-container--default .select2-selection--single .select2-selection__rendered {
                line-height: 28px;
                color: #333;
            }

            .select2-container--default .select2-selection--single .select2-selection__arrow {
                height: 36px;
                top: 1px;
                right: 10px;
                width: 20px;
            }

            /* Ensure full width */
            .select2-container {
                width: 100% !important;
            }


            .select2-container--default .select2-search--dropdown .select2-search__field {
                border: 1px solid #aaa;
                height: 30px;
                font-size: 14px;
            }

            /* Styleing of Select2 dropdown end */

            .error-message {
                color: #ff0000;
                font-size: 0.9em;
                margin-top: 5px;
                display: block;
            }
            .input-field {
                margin-bottom: 15px;
            }
            .input-field.image-upload ul {
                margin: 0;
                padding: 0;
            }
            ul li {
                padding: 5px 0;
                font-size: 16px;
                line-height: 1.2;
                color: #212529;
                font-weight: 400;
            }
            .input-field.image-upload ul li  {
                list-style: none;
                padding: 5px 0;
                font-size: 16px;
                line-height: 1.2;
                color: #212529;
                font-weight: 400;
            } 
            .file-upload-wrapper {
                width: 100%;
                padding: 20px;
                background: #f2f2f2;
                border: 2px dashed lightgray;
                border-radius: 8px;
                text-align: center;
                cursor: pointer;
                color: #000;
                margin-bottom: 30px;
                margin-top: 15px;
            }

            .file-upload-label {
                display: block;
                cursor: pointer;
            }

            .file-upload-input {
                display: none;
            }

            .file-upload-icon {
                margin-bottom: 10px;
            }

            .file-upload-icon svg {
                width: 40px;
                height: 40px;
                fill: #666;
            }

            .file-upload-text strong {
                font-size: 16px;
                color: #333;
            }

            .file-upload-text p {
                font-size: 14px;
                color: #666;
                margin: 5px 0 0;
            }
            .registration-page .content-section .banner-section .art-work-content .file-upload-custom input {
                height: auto !important;
                margin: 0;
                background: transparent;
            }
            .registration-page .content-section .banner-section .art-work-content .file-upload-custom {
                border-radius: 10px;
                border: 1px solid lightgray;
                padding: 6px 15px;
            }
        </style>

    </body>
</html>
