<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<cfif isDefined('request_proc')>
<cfquery name="insertRequest" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
   INSERT into requests
   (
   title,
   artist,
   fk_users,
   fk_request_status
   )
   values
   (
   '#form.title#',
   '#form.artist#',
   #session.sellerinfo.pk_users#,
   '1'
   )
</cfquery>
<cfquery name="findUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
   SELECT * from users
   WHERE pk_users = #session.sellerinfo.pk_users#
</cfquery>
<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
   password="re3objec" to="#emailsupport#" cc="#emailsupportcc#"  from="info@gallart.com" subject="Gallery Art  - REQUEST submitted" type="HTML">
   <font style="font-size: 10pt; font-family: Arial;">
   <strong>#session.sellerinfo.fname# #session.sellerinfo.lname#</strong> has submitted a REQUEST on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
   Title: #form.title#<br>
   Artist: #form.artist#<br><br>
   Seller email: #session.sellerinfo.email#<br><br>		
   Please review it in Admin, and approve or delete.
   <br><br>
</cfmail>
<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
   password="re3objec" to="#session.sellerinfo.email#" from="info@gallart.com" subject="Gallery Art  - REQUEST Submission" type="HTML">
   <font style="font-size: 10pt; font-family: Arial;">
   Thank you, #session.sellerinfo.fname# #session.sellerinfo.lname#, for submitting your listing to our REQUEST page at www.gallart.com. <br><br>
   Thanks,<br><br>
   Gallery Art
   <br><br>
</cfmail>
<cflocation url="requests_thanks.cfm?xss=#xss#" addtoken="No">
</cfif>
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
      <cfoutput>
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
               <div class="inner-section forget-password-screen">
                  <div class="container-fluid">
                     <div class="main-content">
                        <div class="content-section">
                           <div class="bottom-content-sec">
                              <div class="banner-section">
                                 <div class="art-work-content">
                                    <div class="bottom-content">
                                       <div aria-label="breadcrumb">
                                          <ol class="breadcrumb">
                                             <li class="breadcrumb-item"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;" >Home</a></li>
                                             <li class="breadcrumb-item active" aria-current="page">Requests Submit</li>
                                          </ol>
                                       </div>
                                       <div class="user-registrations forgot-password request-submit">
                                          <div class="top-heading text-center">
                                             <h3>SUBMIT REQUEST FOR ART</h3>
                                          </div>
                                          <div class="user-content text-center">
                                             <p>You must be a registered member in order to submit a request.  Please login below or click <a href="requests_registration.cfm?xss=#xss#"><strong>HERE</strong> </a> to register:<br><br></p>
                                             <cfif not isDefined('session.sellerinfo.fname')>
                                             <tr>
                                                <td style="padding-top: 10px;">
                                                </td>
                                             </tr>
                                             <tr>
                                                <td style="padding-top: 10px;">
                                                   <cfinclude template="requests_login.cfm">
                                                </td>
                                             </tr>
                                             <cfelse>
                                             <p>Please enter the name of the piece you would like to have listed, and the Artist of the piece.  Both fields are required.  Your listing is subject to approval by Gallery Art.<br><br></p>
                                             <cfform method="POST" action="#script_name#?#query_string#">
                                                <div class="input-form">
                                                   <div class="input-field">
                                                      <label>Title of Piece:</label>
                                                      <cfinput type="Text" name="title" required="Yes" message="You must enter a title.">
                                                   </div>
                                                   <div class="input-field">
                                                      <label>Artist:</label>
                                                      <cfinput type="Text" name="artist" required="Yes" message="You must enter an artist.">
                                                   </div>
                                                   <div class="input-button">
                                                      <input type="Submit" value="Submit" name="request_proc" class="SeeMore">
                                                   </div>
                                                </div>
                                             </cfform>
                                             </cfif>
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
            </div>
         </div>
         <tr>
            <td colspan="2" valign="baseline">
               <cfinclude template="footer_.cfm">
            </td>
         </tr>
      </cfoutput>
      <cfinclude template="frmxss.cfm">
   </body>
</html>