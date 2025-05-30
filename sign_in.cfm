<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<!--- get autoemail content --->
<cfquery name="getPages" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
   SELECT * from pages
   WHERE pk_pages = 6
</cfquery>
<html>
   <head>
      <cfoutput>
         <title>#companyname# - #titletext#</title>
      </cfoutput>
      <cfinclude template="meta.cfm">
      <cfoutput>
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
         <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
         <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
         <!--- <script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script> --->
         <script language="JavaScript" src="/js/utils.js"></script>
      </cfoutput>
      <meta name='viewport' content='width=device-width, initial-scale=1'>
      <link href="/stylesheet_.css" rel="stylesheet" type="text/css">
      <style>
         .custom-radio .form-check-input:checked {
         background-color: #0d6efd;
         border-color: #0d6efd;
         }
         .custom-radio .form-check-input {
         height: 1.5rem;
         width: 1.5rem;
         border-radius: 50%;
         }
      </style>
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
      <cfif IsDefined( "form.login" )>
      <cfquery name="ValidUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
         SELECT * from users
         where email = '#form.email_login#'
         and password = '#form.password#'
      </cfquery>
      <cfif ValidUser.recordcount>
         <cfset session.sellerinfo.pk_users = ValidUser.pk_users>
         <cfset session.sellerinfo.fname = ValidUser.fname>
         <cfset session.sellerinfo.lname = ValidUser.lname>
         <cfset session.sellerinfo.email = ValidUser.email>
         <cfset session.sellerinfo.login = 1 />
         <cfif isDefined('xss')>
         <cfset url_string = "user_listing_detail.cfm?xss="&xss />
         <cfelse>
         <cfset url_string = "user_listing_detail.cfm" />
      </cfif>
      <cflocation addtoken="No" url="#url_string#">
      <cfelse>
      <cfset seller_login_error = 1 />
      </cfif>
      </cfif>
      <!-- End processing -->
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
            <div class="inner-section">
               <div class="container-fluid">
                  <div class="main-content">
                     <div class="mobile-sidebar-logo">
                        <div class="sidebar-Icon">
                           <i class="fas fa-bars"></i>
                        </div>
                     </div>
                     <!--- <div class="sidebar web-sidebar-modal">	
                        <cfinclude template="left_.cfm">
                        </div> --->
                     <div class="content-section">
                        <div class="bottom-content-sec">
                           <div class="banner-section">
                              <div class="art-work-content">
                                 <!---<div aria-label="breadcrumb"> 
                                    <ol class="breadcrumb">
                                      <li class="breadcrumb-item"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;" >Home</a></li>
                                      <li class="breadcrumb-item active" aria-current="page">Sign In</li>
                                    </ol>
                                    </div>--->
                                 <div class="bottom-content">
                                    <div class="user-registrations">
                                       <div class="row justify-content-center">
                                          <div class="col-lg-6">
                                             <div class="form-sectiom">
                                                <div class="main-heading">
                                                   <h3>Your Gallart Account</h3>
                                                </div>
                                                <div class="bottom-content">
                                                   <cfif isDefined('seller_login_error')>
                                                   <div align="center" style="color: red; font-weight: bold;">
                                                      THAT EMAIL AND/OR PASSWORD<br>IS NOT IN OUR SYSTEM.<br>
                                                      PLEASE TRY AGAIN:
                                                   </div>
                                                   <cfelse>
                                                   <p>If you have already signed up as a seller, please log in here:</p>
                                                   </cfif>
                                                   <cfoutput>
                                                      <cfform name="loginFrm" method="POST" action="#script_name#?xss=#xss#" onsubmit="return validateSignForm()">
                                                         <input type="Hidden" name="login">
                                                         <div class="input-form signin-form">
                                                            <div class="input-field">
                                                               <label><strong>Email:</strong></label>
                                                               <cfinput type="text"  name="email_login" id="email_login" size="20">
                                                               <span class="error-message" id="email_loginError"></span>
                                                            </div>
                                                            <div class="input-field">
                                                               <label><strong>Password:</strong></label>
                                                               <cfinput type="password"  name="password" id="password" size="20">
                                                               <span class="error-message" id="passwordError"></span>
                                                            </div>
                                                            <div class="forget-pass">
                                                               <a href="forgot_password.cfm?xss=#xss#">Forget your password?</a>
                                                            </div>
                                                            <div class="input-button">
                                                               <button type="submit" class="SeeMore">Sign In</button>
                                                            </div>
                                                            <div class="join-us">
                                                               <span>Not a member?</span> <a href="user_registration.cfm?xss=#xss#">Join us</a>
                                                            </div>
                                                         </div>
                                                      </cfform>
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
                  </div>
               </div>
            </div>
         </div>
         <tr>
            <td colspan="2" valign="baseline">
               <cfinclude template="footer_.cfm">
            </td>
         </tr>
      </div>
      </div>
      <cfinclude template="frmxss.cfm">
      <script>
         function validateSignForm(){
         	let isValid = true;
         	const email_login = document.getElementById('email_login').value.trim();
         	const password = document.getElementById('password').value.trim();
         
         	if (!email_login) {
                   document.getElementById('email_loginError').textContent = 'Please enter your email address';
                   isValid = false;
                	}
         
          if (!password) {
                   document.getElementById('passwordError').textContent = 'Please enter your password';
                   isValid = false;
                	}
         
         	 return isValid;
         
         }
      </script>
      <style>
         .error-message {
         color: #ff0000;
         font-size: 0.9em;
         margin-top: 5px;
         display: block;
         }
      </style>
   </body>
</html>