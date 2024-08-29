<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">


<cfset fileSizeLimit = 200000 />
<cfset fileSizeLimitKb = '200KB' />


<cfif isDefined('process')>

    <cfquery name="getPreviousEntries" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT * FROM purchases_consignments
        where email = '#form.email#'
    </CFQUERY>

    <cfif (getPreviousEntries.recordcount + 1) GTE 5>
        <cflocation url="purchases_consignments.cfm?xss=#xss#&reachedMax=true" addtoken="No">
    <cfelse>
    
    	<cfif cgi.content_length LTE fileSizeLimit>
            
            <cfparam name="cffile.serverfile" default="" />

            <cfif len(thisImage)>
                <cffile action="UPLOAD" filefield="thisImage" destination="#expandpath('.')#/purchases_consignments/images" nameconflict="MAKEUNIQUE">
                <cfset Uploaded_File_Name = CFFile.ClientFile>
            </cfif>
            
            
            <cfquery name="insertListing" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                INSERT INTO purchases_consignments 
                (
                    NAME,
                    PHONE,
                    EMAIL,
                    IMAGE_NAME,
                    ARTIST,
                    TITLE,
                    MEDIUM,
                    SIZE,
                    ADDITIONAL_DETAILS
                )
                VALUES
                (
                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.NAME#">,
                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.PHONE#">,
                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.EMAIL#">,
                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cffile.serverFile#">,
                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.ARTIST#">,
                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.TITLE#">,
                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.MEDIUM#">,
                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.SIZE#">,
                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.ADDITIONAL_DETAILS#">
                )
                SELECT @@identity as uid 
            </cfquery>
            

            
            <cftry>
        

            <cfmail server="#application.mailserver#" username="#application.mailserver_un#" password="#application.mailserver_pw#" to="steverucker@gmail.com" from="#form.email#" subject="GallArt.com <> Buying & Selling Fine Art <> Purchases/Consignments Form" type="HTML">
                <font style="font-size: 10pt; font-family: Arial;">
                <strong>#form.name#</strong> entered a new product on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
                Phone: #form.phone#<br>
                Email: #form.email#<br>
                Artist: #form.artist#<br>
                Title: #form.title#<br>
                Medium: #form.medium#<br>
                Size: #form.size#<br>
                Additional Details: #form.additional_details#<br>
                <cfif len(thisImage)>
                    <cfmailparam 
                        file="#expandpath('.')#/purchases_consignments/images/#Uploaded_File_Name#"
                        contentid="purchase_consignment_image" 
                        disposition="inline"
                    />
                </cfif>
                <br><br>
            </cfmail>
            
            <cfcatch type="Any">ERROR!!<cfabort></cfcatch>
            
            </cftry>
            
            <cflocation url="purchases_consignments_test.cfm?xss=#xss#&processed=true&entryCount=#getPreviousEntries.recordcount#" addtoken="No">
            
     	<cfelse>
        	<cflocation url="purchases_consignments_test.cfm?xss=#xss#&error=filetoolarge" addtoken="No">
    	</cfif>

    </cfif>
    

</cfif>

<!-- End processing -->

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
<script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>

<link href="stylesheet.css" rel="stylesheet" type="text/css">

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
<style>
    .purchases-consignments td, .purchases-consignments input, .purchases-consignments select, .purchases-consignments a {
        font-size: 14px;
    }
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td colspan="2" width="100%" height="125" valign="top" bgcolor="#000000">
            <cfinclude template="top.cfm">
        </td>
    </tr>
    <tr>
        <td colspan="2" width="100%" valign="top" height="37" bgcolor="#000000">
            <cfinclude template="navbar.cfm">
        </td>
    </tr>
    <tr height="100%">
        <td valign="top" width="173" height="100%">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr height="100%">
                    <td valign="top" height="100%"> 
                        <cfinclude template="left.cfm">
                    </td>
                </tr>
            </table>
        </td>
        <td valign="top" width="627" height="100%">
            <table cellspacing="0" cellpadding="0" border="0" width="400">
				<tr>
					<td align="center" style="padding-top: 5px;">
						<h4 style="font-style: italic;">PURCHASES/CONSIGNMENT FORM</h4>
					</td>
				</tr>
                <cfif structKeyExists(url,'reachedMax')>
                <tr>
                    <td align="center" style="color: #ff0000; font-size: 13px;">
                        YOU HAVE REACHED THE MAXIMUM NUMBER OF <br />
                        ENTRIES FOR THIS FORM.  
                    </td>
                </tr>
                <cfelse>
                    <cfif structKeyExists(url,'error')>
                    <tr>
                    	<td align="center" style="color: #ff0000; font-size: 13px;">
                        	Sorry, but the file that you are attempting to load is too large.  Please reduce your file size to <cfoutput>#fileSizeLimitKb#</cfoutput>.
                        </td>
                    </tr>
                    <cfelse>

    				<tr>
    					<td style="padding: 10px 0 0 25px;">
                            <cfif structKeyExists(url,'processed')>
                                <span style="color: #ff0000; font-size: 13px;">
                                <cfset remainingEntries = 5 - (entryCount + 1)>
                                YOUR LISTING HAS BEEN ENTERED SUCCESSFULLY.<br />
                                <cfif remainingEntries LT 5 AND remainingEntries GT 0>
                                    YOU MAY ENTER <cfoutput>#remainingEntries#</cfoutput> MORE ITEMS
                                <cfelse>
                                    YOU HAVE REACHED THE MAXIMUM NUMBER OF ENTRIES <br />
                                    FOR THIS FORM
                                </cfif>
                                </span>
                                <br /><br />
                            </cfif>
    						<cfoutput>
    						<cfform name="frm1" action="purchases_consignments_test.cfm?xss=#xss#" method="post" enctype="multipart/form-data">
                            <span style="color: ##ff0000; font-size: 14px;">* Required</span><br/>
    						<table cellspacing="0" cellpadding="5" border="0" width="100%" class="purchases-consignments">
                                <tr>
                                    <td><b>Name:</b>
                                    </td>
                                    <td><cfinput type="text" name="name" size="30" required="Yes" message="Please enter your name.">&nbsp;<span style="color: ##ff0000;">*</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Phone:</b>
                                    </td>
                                    <td><cfinput type="text" name="phone" size="30" required="No"  message="Please enter a phone number." mask="(999) 999-9999">
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Email:</b>
                                    </td>
                                    <td><cfinput type="text" name="email" size="30" required="Yes" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" message="Please enter a proper email." >&nbsp;<span style="color: ##ff0000;">*</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Artist:</b>
                                    </td>
                                    <td><cfinput type="text" name="artist" size="30" required="Yes"  message="Please enter an artist." >&nbsp;<span style="color: ##ff0000;">*</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Title:</b>
                                    </td>
                                    <td><cfinput type="text" name="title" size="30" required="No"  message="Please enter a title." >
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"><b>Medium:</b>
                                        <Select name="medium">
                                            <option value="">Select here ...</option>
                                            <cfloop query="cats">
                                                <option value="#path#">#ucase(path)#
                                            
                                        </cfloop></select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Size:</b>
                                    </td>
                                    <td><cfinput type="text" name="size" size="30" required="No"  message="Please enter a size." >
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"><b>Additional Details:</b></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><textarea name="additional_details" cols="50" rows="4"></textarea></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                    <b>Upload Photo</b> <br /><span style="color: ##ff0000; font-size: 8pt; font-weight: bold;">(THE FILE MUST BE A .JPG, AND MUST BE LESS THAN #fileSizeLimitKb# IN SIZE)</span>*<br><br>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td valign="top" width="50%">
                                                    <input type="file" name="thisImage" size="22">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"><b>*If you can't upload your photo, please email <a href="mailto:sales@gallart.com">sales@gallart.com</a> or text <a href="tel:305-318-0328">305-318-0328</a> for further assistance.  Limit to 5 uploads.  Contact us if you have more than 5 works of art you are looking to consign or sell with us for Art Basel.</b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <input type="Hidden" name="process">
                                        <input type="Image" src="images/send.gif" style="border: none;">                          
                                    </td>
                                </tr>
                            </table>
    						</cfform>						
    						</cfoutput>
    					</td>
    				</tr>
                    </cfif>
                </cfif>
			</table>
        </td>
    </tr>
    <tr>
        <td colspan="2" valign="baseline">
            <cfinclude template="footer.cfm">
        </td>
    </tr>
</table>

<cfinclude template="frmxss.cfm">

</body>
</html>
