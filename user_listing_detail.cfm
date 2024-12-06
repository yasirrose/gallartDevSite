<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<!--- set default shipping --->
<cfquery name="shipping" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT top 1 * FROM shipping
</CFQUERY>

<cfset ship_weight = shipping.shipweight />
<cfset shipinfo = shipping.shipdesc />
<cfset fileSizeLimit = 200000 />
<cfset fileSizeLimitKb = '200KB' />

<!--- Inserting, Updating or Deleting the Product Information --->
<cfif isDefined('process')>


	<cfif process is "ADD">
    
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
            
            <cfif category is not "">
            <cfif right(category,1) neq ":">
            <cfset category = category&":">
            <cfelse>
            <cfset category = category>
            </cfif>
            </cfif>
            
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
                    size
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
                    '#ucase(form.manufacturer)#', 
                    '#form.active#',
                    '#expressair#', 
                    '#shipinfo#', 
                    '#availablity#', 
                    '#caption#',
                    '#year#',
                    '#size#'
                )
                SELECT @@identity as uid 
            </cfquery>
            
                <cfset thisId = insertListing.uid />
            
            </cflock>
            
            <cfif isDefined('form.fileup') and form.fileup NEQ "">
                        
                <cffile action="upload" nameconflict="overwrite" filefield="fileup" destination="#uploaddir#/#thisId#.jpg" result="fileupload">
        
                <cfif fileupload.fileWasSaved>
                    
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
                        action="WRITE"
                        source="#oImageSmall#"
                        destination="#application.uploaddir#/thumbnails/#thisId#.jpg"
                        overwrite="true"
                    />
                
                </cfif>
                            
            </cfif>
            
            <cftry>
        
        	<cfmail server="#application.mailserver#" username="#application.mailserver_un#" password="#application.mailserver_pw#" to="#emailsupport#" cc="#emailsupportcc#" from="#emailsupport#" subject="GallArt.com <> Buying & Selling Fine Art <> New Member Registration <> Seller" type="HTML">
                <font style="font-size: 10pt; font-family: Arial;">
                <strong>#session.sellerinfo.fname# #session.sellerinfo.lname#</strong> entered a new product on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
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
            
            <cfcatch type="Any">ERROR!!<cfabort></cfcatch>
            
            </cftry>
            
            <cflocation url="user_listing_search.cfm?xss=#xss#&process=add" addtoken="No">
            
     	<cfelse>
        	<cflocation url="user_listing_detail.cfm?xss=#xss#&error=filetoolarge" addtoken="No">
		</cfif>
		
	
	<cfelseif process is "UPDATE">
    
    	<cfif cgi.content_length LTE fileSizeLimit>
	
		<cfif isDefined('form.fileup') and form.fileup NEQ "">
                    
            <cffile action="upload" nameconflict="overwrite" filefield="fileup" destination="#uploaddir#/#form.uid#.jpg" result="fileupload">
    
            <cfif fileupload.fileWasSaved>
                
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
            
            </cfif>
                        
        </cfif>
	
		<!--- parse out unwanted chars --->
        <cfset form.retail_price 	= rereplace(form.retail_price, "[^0-9|.]", "", "all")> 
        <cfset form.gallery_price 	= rereplace(form.gallery_price, "[^0-9|.]", "", "all")> 
            
        <cfif form.quantity lt 1>
        <cfset tquantity = 0>
        <Cfelse>
        <cfset tquantity = form.quantity>
        </cfif>
        
        <cfif category is not "">
        <cfif right(category,1) neq ":">
        <cfset category = category&":">
        <cfelse>
        <cfset category = category>
        </cfif>
        </cfif>
        
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
                    manufacturer = '#ucase(form.manufacturer)#', 
                    active = #form.active#,
                    expressair = '#expressair#',
                    shipinfo = '#shipinfo#',
                    availablity = '#availablity#',
                    caption = '#caption#',
                    year = '#year#',
                    size = '#size#'
                WHERE uid = #form.uid#
            </cfquery>
            
            <cftry>
            
            <cfmail server="#application.mailserver#" username="#application.mailserver_un#" password="#application.mailserver_pw#" to="#emailsupport#" cc="#emailsupportcc#" from="#emailsupport#" subject="Gallery Art Member Listing Update" type="HTML">
                <font style="font-size: 10pt; font-family: Arial;">
                <strong>#session.sellerinfo.fname# #session.sellerinfo.lname#</strong> updated a product on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
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
            
            <cfcatch type="Any">ERROR!!<cfabort></cfcatch>
            
            </cftry>
            
            <cflocation url="user_listing_results.cfm?xss=#xss#&process=update" addtoken="No">
            
      	<cfelse>
        	<cflocation url="user_listing_detail.cfm?xss=#xss#&id=#form.uid#&error=filetoolarge" addtoken="No">
		</cfif>
		
		
	
	<cfelseif process is "DELETE">
	
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
		
		<cflocation url="user_listing_results.cfm?xss=#xss#&process=delete" addtoken="No">
	
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
    SELECT path FROM products
	group by path
	order by path
</CFQUERY>

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
	<script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>

<link href="stylesheet_.css" rel="stylesheet" type="text/css">
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

function validEntries(frm) {
	if(frm.vendor.value == '') {
		alert('please select Vendor'); return false;
	}
	if(frm.name.value == ''){
	alert('You must enter a Title.');
	frm.name.focus();
	return false;
	}
	if(frm.retail_price.value == '' || frm.retail_price.value == '$0.00' || frm.retail_price.value == 0){
	alert('You must enter a Retail Price greater than zero.');
	frm.retail_price.focus();
	return false;
	}
	if(frm.gallery_price.value == '' || frm.gallery_price.value == '$0.00' || frm.gallery_price.value == 0){
	alert('You must enter a Gallery Price greater than zero.');
	frm.gallery_price.focus();
	return false;
	}
	if(frm.manufacturer.value == ''){
	alert('You must select an Artist.');
	frm.manufacturer.focus();
	return false;
	}
	if(frm.category.value == ''){
	alert('You must select a Medium.');
	frm.category.focus();
	return false;
	}
	if(!isValidSize(frm.size.value)){
	alert('You must enter a valid SIZE: only numbers and the letter x');
	frm.size.focus();
	return false;
	}
	return true;
	
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
                                                        <span style="color: #dd3a7d; padding-top: 25px; font-size: 13px; font-weight: bold;">Sorry, but the file that you are attempting to load is too large.  Please reduce your file size to <cfoutput>#fileSizeLimitKb#</cfoutput>.</span>
                                                    </cfif>
                                                    <cfif sellerArt.recordcount GT 5>
                                                        <span style="color: #dd3a7d; padding-top: 25px; font-size: 13px; font-weight: bold;">Sorry, but you are only allowed 5 free uploads.  Please contact <a href="mailto:info@gallart.com" style="color: #ff0000; font-size: 13px; text-decoration:underline;">Gallart.com</a> in order to submit additional listings at $35 apiece.</span>
                                                    </cfif>
                                                    <h3>SELL YOUR ART ON GALLART.COM!</h3>
                                                </div>
                                                <p>Use this simple form to list your art.  Remember:</p>
                                                <ul>
                                                    <li>Don't use any personal information in your description, or watermarks in the images.</li>
                                                    <li>GALLART.COM will charge a 20% fee when you sell your art</li>
                                                    <li>You are only allowed 5 free uploads.  Please contact <a href="mailto:info@gallart.com" style="text-decoration:underline;">Gallart.com</a> in order to submit additional listings at $35 apiece.</li>
                                                </ul>
                                                <p>You may enter as many pieces of art as you like!</p>
                                                <p>GALLART.COM will review your listings.  If they are approved, they will be shown on the site.</p>

                                                <cfoutput>

                                                    <form name="frm1" action="user_listing_detail.cfm?xss=#xss#" method="post" enctype="multipart/form-data" onSubmit="javascript:return validEntries(document.frm1);">
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
                                                                <label><b>Title:</b></label>
                                                                <input type="text" name="name" value="#replace(detail.Name,'"','&quot;','all')#" size="40">
                                                            </div>

                                                            <div class="input-field">
                                                                <label><b>Select Artist:</b></label>
                                                                <Select name="artistview"  onchange="ArtistView()">
                                                                    <option value="">Select here ...</option>
                                                                    <cfloop query="artists">
                                                                    <cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
                                                                    <option value="#manufacturer#" <cfif manufacturer is #detail.manufacturer#>Selected</cfif>>#ucase(manufacturer)#
                                                                    </cfif>
                                                                    
                                                                    </cfloop>
                                                                </select>
                                                            </div>

                                                            <div class="input-field">
                                                                <label><b><i>Select an artist from dropdown above, OR type in a new artist:</i></b></label>
                                                                <input type="Text" name="manufacturer" value="#ucase(detail.manufacturer)#" size="40">
                                                            </div>

                                                            <div class="input-field">
                                                                <label><b>Year:</b></label>
                                                                <input type="text" name="year" value="#detail.year#" size="25">
                                                            </div>

                                                            <div class="input-field">
                                                                <label><b>Size:</b>(HEIGHT x WIDTH)</label>
                                                                <input type="text" name="size" value="#detail.size#" size="25">&nbsp;<font face="Verdana, Arial,helvetica" size="1"></font>
                                                            </div>

                                                            <div class="input-field">
                                                                <label><b>Select Medium:</b></label>
                                                                <Select name="category">
                                                                    <option value="">Select here ...</option>
                                                                    <cfloop query="cats">
                                                                        <option value="#path#" <cfif #path# is #detail.path#>Selected</cfif>>#ucase(path)#
                                                                    
                                                                    </cfloop>
                                                                </select>
                                                            </div>

                                                            <div class="input-field">
                                                                <label><b>Retail Price:</b></label>
                                                                <input type="text" name="retail_price" value="#dollarformat(detail.retail_price)#" size="25" maxlength="13">
                                                            </div>

                                                            <div class="input-field">
                                                                <label><b>Gallery Price:</b> (selling price)</label>
                                                                <input type="text" name="gallery_price" value="#dollarformat(detail.gallery_price)#" size="25" maxlength="13">
                                                            </div>

                                                            <div class="input-field">
                                                                <label><b>Description:</b></label>
                                                                <textarea name="caption" cols="90" rows="4">#detail.caption#</textarea>
                                                            </div>

                                                            <div class="input-field">
                                                                <label><b>Upload New Product Picture</b> <span style="color: ##ff0000; font-size: 8pt;">(THE FILE MUST BE A .JPG, AND MUST BE LESS THAN #fileSizeLimitKb# IN SIZE)</span></label>
                                                                <input type="file" name="fileup" size="22" style="font-size: xx-small;padding: 0;">
                                                            </div>
                                                            <div class="input-field">
                                                                <cfif fileexists("#expandpath('.')#\img\thumbnails\#detail.uid#.jpg")>
                                                                    <img src="http://#server_name#/img/thumbnails/#detail.uid#.jpg?u=#randrange(1,1000)#">
                                                                </cfif>
                                                            </div>
                                                            <div class="input-button flex-input-btn listing-detail-btns">
                                                                <cfif isDefined('url.id')>
                                                                    <input type="Hidden" name="process" value="UPDATE" class="SeeMore">
                                                                    <input type="button" name="process" class="SeeMore" value="Add Your Listing" onClick="javascript:return confirm('Updating your product will temporarily remove it from the site until Gallery Art can review it -- Are You Sure?');"><br>
                                                                    <input type="reset" value="Reset" class="SeeMore" />
                                                                    <input type="hidden" name="id" value="#url.id#">
                                                                        <Cfif isDefined('returnq')>
                                                                        <input type="hidden" name="returnq" value="#returnq#">
                                                                        </cfif>
                                                                    <input type="hidden" name="uid" value="#detail.uid#"><br><br>
                                                                    
                                                                    <cfelse>
                                                                    <input type="Hidden" name="process" value="ADD">
                                                                    <input type="button" name="process" class="SeeMore" value="Add Your Listing">
                                                                        <Cfif isDefined('returnq')>
                                                                        <input type="hidden" name="returnq" value="#returnq#">
                                                                        </cfif>
                                                                    </cfif>
                                                            </div>
                                                        </div>
                                                    </form>

                                                    <form name="frmDelete" action="user_listing_detail.cfm?xss=#xss#" method="post">
                                                        <div class="input-form">
                                                            <input type="Hidden" name="process" value="DELETE">
                                                            <input type="hidden" name="uid" value="#detail.uid#">

                                                            <div class="input-button flex-input-btn listing-detail-btns">
                                                                <input type="button" name="process" class="SeeMore" value="Delete!" onClick="javascript:return confirm('Delete -- Are You Sure?');">
                                                            </div>
                                                        </div>
                                                    </form>
                                                    
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

</body>
</html>
