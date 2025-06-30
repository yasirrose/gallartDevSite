<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
   SELECT path FROM products
   group by path
   order by path
</CFQUERY>
<cfquery name="getPages" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
   SELECT * from pages
   WHERE pk_pages = 4
</cfquery>
<html>
   <head>
      <cfoutput>
         <title>#companyname# - #titletext#</title>
      </cfoutput>
      <cfinclude template="meta.cfm">
      <cfoutput>
         <!--- <script language="JavaScript" src="http://#server_name#/js/utils.js"></script> --->
         <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
         <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
         <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
         <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
         <script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script>
         <script language="JavaScript" src="./js/utils.js"></script>
      </cfoutput>
      <link href="stylesheet_.css" rel="stylesheet" type="text/css">
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
                  <cfinclude template="navbar_.cfm">
               </div>
            </div>
            <div class="main-content">
               <div class="content-section">
                  <div class="bottom-content-sec">
                     <div class="banner-section">
                        <div class="art-work-content">

							<div aria-label="breadcrumb">
								<ol class="breadcrumb">
								  <li class="breadcrumb-item"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;" >Home</a></li>
								  <li class="breadcrumb-item"><a href="alerts.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;" >Email Alerts</a></li>
								  <li class="breadcrumb-item active" aria-current="page">Email Alert Info</li>
								</ol>
							</div>

                           <div class="bottom-content">
                              <div class="user-registrations">
                                 <div class="top-heading">
                                    <h3>INFORMATION FOR EMAIL ALERTS ON GALLERYART.COM</h3>
                                    <cfoutput>
                                       <p>#getPages.page_content#</p>
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
      </div>
      <tr>
         <td colspan="2" valign="baseline">
            <cfinclude template="footer_.cfm">
         </td>
      </tr>
      <cfinclude template="frmxss.cfm">
   </body>
</html>