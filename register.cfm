<!--- Kill extra output. --->
<cfif NOT structKeyExists(session, 'sellerinfo') >

   <cfsilent>
      <!--- REGISTRATION FORM CAPTCHA --->
      <cfparam name="form.fname" default="">
      <cfparam name="form.lname" default="">
      <cfparam name="form.email" default="">
      <cfparam name="form.cellphone" default="">
      <cfparam name="form.phone" default="">
      <cfparam name="form.phoneType" default="">
      <cfparam name="form.businessphone" default="">
      <cfparam name="form.otherphone" default="">
      <cfparam name="form.website" default="">
      <cfparam name="form.captchaError" default="0">
      <cfparam name="form.errorMsg" default="">
      <cfparam name="form.errorPhone" default="0">
      <cfparam name="FORM.captcha"	type="string"	default=""	/>
      <cfparam name="FORM.captcha_check"	type="string" default="" />
      <cftry>
         <cfparam name="FORM.submitted"	type="numeric"	default="0"	/>
         <cfcatch>
            <cfset FORM.submitted = 0 />
         </cfcatch>
      </cftry>
      <!--- Set a flag to see if this user is a bot or not. --->
      <cfset blnIsBot = true />
      <cfset phoneError = false />
      <!--- Check to see if the form has been submitted. --->
      <cfif FORM.submitted>
         <cfset errorMsg = "" />
         <!--- <cfif len(form.cellphone) AND NOT isValid("regex",form.cellphone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
            <cfset errorMsg = "Please enter your cell phone number in the format (xxx) xxx-xxxx <br/>" />
            </cfif>
            <cfif len(form.phone) AND NOT isValid("regex",form.phone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
            <cfset errorMsg = errorMsg & "Please enter your home phone number in the format (xxx) xxx-xxxx <br/>" />
            </cfif>
            <cfif len(form.businessphone) AND NOT isValid("regex",form.businessphone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
            <cfset errorMsg = errorMsg & "Please enter your business phone number in the format (xxx) xxx-xxxx <br/>" />
            </cfif> --->
         <cfif errorMsg NEQ "">
            <cfset phoneError = true />
            <cfelse>
            <cftry>
               <!--- Decrypt the check value. --->
               <cfset strCaptcha = Decrypt( FORM.captcha_check, "gallart-is-the-best", "CFMX_COMPAT", "HEX"	) />
               <cfif (strCaptcha EQ FORM.captcha)>
                  <cfset blnIsBot = false />
               </cfif>
               <cfcatch>
                  <cfset blnIsBot = true />
               </cfcatch>
            </cftry>
         </cfif>
      </cfif>
      <cfset arrValidChars = ListToArray(
         "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
         "2,3,4,5,6,7,8,9"
      ) />
      <!--- Now, shuffle the array. --->
      <cfset CreateObject( "java", "java.util.Collections"	).Shuffle(	arrValidChars )	/>
      <cfset strCaptcha = (
         arrValidChars[ 1 ] &
         arrValidChars[ 2 ] 
      ) />
      <cfset FORM.captcha_check = Encrypt( strCaptcha,"gallart-is-the-best", "CFMX_COMPAT", "HEX" ) />
   </cfsilent>
   <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
   <cfparam name="xss" default="">
   <cfquery name="getPages" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
      SELECT * from pages
      WHERE pk_pages = 6
   </cfquery>
   <html>
      <head>
         <cfoutput>
            <title>#companyname# - #titletext#</title>
            <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
            <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
            <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
            <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
         </cfoutput>
         <cfinclude template="meta.cfm">
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
         <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
         <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
         <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
      </head>
      <body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
         <div class="main-container registration-page">
            <cfoutput>
               <form method="post" action="#script_name#" name="errorFrm">
                  <input type="Hidden" name="fname">
                  <input type="Hidden" name="lname">
                  <input type="Hidden" name="email">
                  <input type="Hidden" name="cellphone">
                  <input type="Hidden" name="phone">
                  <input type="Hidden" name="businessphone">
                  <input type="Hidden" name="otherphone">
                  <input type="Hidden" name="website">
                  <input type="Hidden" name="errorMsg">
                  <!--- <input type="Hidden" name="captchaError" value="0"> --->
                  <input type="Hidden" name="errorPhone" value="0">
               </form>
            </cfoutput>
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
                                    <div aria-label="breadcrumb">
                                       <ol class="breadcrumb">
                                          <li class="breadcrumb-item"><a href="/" style="color:black;" >Home</a></li>
                                          <li class="breadcrumb-item active" aria-current="page">Registration</li>
                                       </ol>
                                    </div>
                                    <div class="bottom-content">
                                       <div class="user-registrations quotes-page contact-page" style="max-width: 100%;">
                                          <!--- Check for a bot. --->
                                          <cfif FORM.submitted>

                                             <cfset apikey="6LddEiMrAAAAAJdkOFhc6RFcBOQ4Ol15oaRHRwJb">
                                             <cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="post">
                                                <cfhttpparam type="formField" name="secret" value="#apikey#">
                                                <cfhttpparam type="formField" name="response" value="#FORM['g-recaptcha-response']#">
                                                <cfhttpparam type="formField" name="remoteip" value="#CGI.REMOTE_ADDR#">
                                             </cfhttp> 
                                             <cfset captchaResponse = DeserializeJSON(cfhttp.FileContent)>
                                             <!--- <cfdump var="#captchaResponse#" abort="true"> --->
                                             <cfif phoneError>
                                                <cfoutput>
                                                   <!--- <cfdump var="testing 1" abort="true"> --->
                                                   <script language="JavaScript">
                                                      document.errorFrm.fname.value = '#form.fname#'
                                                      document.errorFrm.lname.value = '#form.lname#'
                                                      document.errorFrm.email.value = '#form.email#'
                                                      document.errorFrm.cellphone.value = '#form.cellphone#'
                                                      document.errorFrm.phone.value = '#form.phone#'
                                                      document.errorFrm.phone.value = '#form.phoneType#'
                                                      document.errorFrm.businessphone.value = '#form.businessphone#'
                                                      document.errorFrm.otherphone.value = '#form.otherphone#'
                                                      document.errorFrm.website.value = '#form.website#'
                                                      document.errorFrm.errorMsg.value = '#errorMsg#'
                                                      document.errorFrm.errorPhone.value = '1'
                                                      document.errorFrm.submit();
                                                   </script>
                                                </cfoutput>
                                              <cfelseif captchaResponse.success NEQ 'YES'>
                                                <cfoutput>
                                                   <!--- <cfdump var="testing 2" abort="true"> --->
                                                   <script language="JavaScript">
                                                      document.errorFrm.fname.value = '#form.fname#'
                                                      document.errorFrm.lname.value = '#form.lname#'
                                                      document.errorFrm.email.value = '#form.email#'
                                                      document.errorFrm.cellphone.value = '#form.cellphone#'
                                                      document.errorFrm.phone.value = '#form.phone#'
                                                      document.errorFrm.phone.value = '#form.phoneType#'
                                                      document.errorFrm.businessphone.value = '#form.businessphone#'
                                                      document.errorFrm.otherphone.value = '#form.otherphone#'
                                                      document.errorFrm.website.value = '#form.website#'
                                                      document.errorFrm.errorMsg.value = '#errorMsg#'
                                                      document.errorFrm.captchaError.value = '1'
                                                      document.errorFrm.submit();
                                                   </script>
                                                </cfoutput>
                                              <cfelse>
                                                <cfquery name="CheckDups" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                                                   select pk_users from users where email =  
                                                   <cfqueryparam value="#trim(form.email)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
                                                </cfquery>
                                                <cfif CheckDups.recordcount gt 0>
                                                   <script language="JavaScript">
                                                      alert('The email you selected is taken. If you are already a member please log in.');
                                                      history.go(-1);
                                                   </script>
                                                   <cfabort>
                                                </cfif>
                                                <cfif form.password neq form.password2>
                                                   <script language="JavaScript">
                                                      alert('Password missmatch. Please retype your password.');
                                                      history.go(-1);
                                                   </script>
                                                   <cfabort>
                                                </cfif>
                                                <!--- <cfdump var="testing 3" abort="true"> --->

                                                <cfif len(trim(form.cellphone)) AND form.phoneType EQ "Home Phone">
                                                   <cfset phone = form.cellphone>
                                                <cfelse>
                                                   <cfset phone = "">
                                                </cfif>

                                                <cfif len(trim(form.cellphone)) AND form.phoneType EQ "Cell Phone">
                                                   <cfset cellphone = form.cellphone>
                                                <cfelse>
                                                   <cfset cellphone = "">
                                                </cfif>

                                                <cfif len(trim(form.cellphone)) AND form.phoneType EQ "Business Phone">
                                                   <cfset businessphone = form.cellphone>
                                                <cfelse>
                                                   <cfset businessphone = "">
                                                </cfif>

                                                <cfif len(trim(form.cellphone)) AND form.phoneType EQ "OutsideUS">
                                                   <cfset otherphone = form.cellphone>
                                                <cfelse>
                                                   <cfset otherphone = "">
                                                </cfif>

                                                <cfif form.fname neq '' and form.lname neq '' and form.email neq '' and form.password neq ''  >
                                                   <cflock name="insertuser" timeout="10">
                                                      <!--- <cfdump var="test data" abort="true"> --->
                                                      <cfquery name="insertUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                                                         INSERT into users
                                                            (
                                                               fname,
                                                               lname,
                                                               email,
                                                               password,
                                                               cellphone,
                                                               phone,
                                                               businessphone,
                                                               otherphone,
                                                               datestamp
                                                            )
                                                            values
                                                            (
                                                               <cfqueryparam value="#form.fname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
                                                               ,<cfqueryparam value="#form.lname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
                                                               ,<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
                                                               ,<cfqueryparam value="#form.password#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
                                                               ,<cfqueryparam value="#cellphone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">
                                                               ,<cfqueryparam value="#phone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">
                                                               ,<cfqueryparam value="#businessphone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">
                                                               ,<cfqueryparam value="#otherphone#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">
                                                               ,<cfqueryparam value="#now()#" cfsqltype="CF_SQL_TIMESTAMP" maxlength="100">
                                                            )
                                                      </cfquery>
                                                      <!--- getting the last input UID --->
                                                      <cfquery name="lastUID" datasource="#dsource#" username="#uname#" password="#pword#">
                                                         SELECT @@identity as uid FROM users
                                                      </cfquery>
                                                      <cfset session.sellerinfo.pk_users = lastUID.uid>
                                                      <cfset session.sellerinfo.fname = form.fname>
                                                      <cfset session.sellerinfo.lname = form.lname>
                                                      <cfset session.sellerinfo.email = form.email>
                                                      <cfset session.sellerinfo.login = 1 />

                                                      <!--- Add the logs data --->
                                                      <cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
                                                      <cfset date = now()>
                                                      <cfset moduleName = 'Register'>
                                                      <cfset action = 'Insert'>
                                                      
                                                      <cfquery name="addLog" datasource="#application.dsource#" >
                                                         INSERT INTO logs 
                                                            ( moduleName, ipAddress, date, action)
                                                            VALUES
                                                            ( '#moduleName#', '#ipAddress#', #date#, '#action#')
                                                      </cfquery>

                                                   </cflock>
                                                   <cfmail 
                                                         server="#servername#" 
                                                         username="onli16@onlinegalleryart.com"
                                                         password="re3objec" 
                                                         to="#emailsupport#" 
                                                         cc="#emailsupportcc#" 
                                                         from="#form.email#" 
                                                         subject="GallArt.com <> Buying & Selling Fine Art <> New Member Registration <> Seller" 
                                                         type="HTML"
                                                         >
                                                      <font style="font-size: 10pt; font-family: Arial;">
                                                      <strong>
                                                         #session.sellerinfo.fname# #session.sellerinfo.lname#</strong> 
                                                         registered as a new Member on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
                                                      <br><br>
                                                   </cfmail>
                                                   <cfmail 
                                                         server="#servername#" 
                                                         username="onli16@onlinegalleryart.com"
                                                         password="re3objec" 
                                                         to="#form.email#" 
                                                         from="onli16@onlinegalleryart.com" 
                                                         subject="Gallery Art - Welcome New Member" 
                                                         type="HTML"
                                                         >
                                                      <font style="font-size: 10pt; font-family: Arial;">
                                                      Thank you, #session.sellerinfo.fname# #session.sellerinfo.lname#, for registering as a Member at www.gallart.com. <br><br>
                                                      Your password is:<br>
                                                      #form.password#<br><br>
                                                      Please keep it in a safe place.<br><br>
                                                      You are now ready to list your artwork!<br><br>
                                                      #getPages.page_content#
                                                      <br><br>
                                                   </cfmail>
                                                   <script>
                                                      $(document).ready(function() {
                                                         toastr.options = {
                                                            'closeButton': true,
                                                            'debug': false,
                                                            'newestOnTop': false,
                                                            'progressBar': true,
                                                            'positionClass': 'toast-top-right',
                                                            'preventDuplicates': false,
                                                            'showDuration': '1000',
                                                            'hideDuration': '1000',
                                                            'timeOut': '5000',
                                                            'extendedTimeOut': '1000',
                                                            'showEasing': 'swing',
                                                            'hideEasing': 'linear',
                                                            'showMethod': 'fadeIn',
                                                            'hideMethod': 'fadeOut',
                                                         }
                                                      });
                                                      
                                                      toastr.success('Your Record is added successfully.');
                                                   </script>
                                                   <cflocation url="/overView" addtoken="No">
                                                 <cfelse>
                                                   <cfoutput>
                                                      <p style="color: red;">Error: Your data is not added. Please fill out all required fields before submitting the form.</p>
                                                   </cfoutput>
                                                </cfif>
                                             </cfif>
                                           <cfelse>
                                             <cfoutput>
                                                <div class="user-content form-sectiom">
                                                   <h3>Create an Account</h3>
                                                   <h4> Already have an account? <a href="login" style="color: ##EC008C"> <b> Login </b></a> </h4>
                                                   <br><br>
                                                   <cfif FORM.captchaError>
                                                      <span style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</span><br><br>
                                                   </cfif>
                                                   <cfif FORM.errorPhone EQ 1>
                                                      <span style="color: ##ff0000; font-weight: bold;">
                                                      #form.errorMsg#
                                                      </span><br><br>
                                                   </cfif>
                                                   <!--- onsubmit="return validateSellerForm()" --->
                                                   <div class="form-style">
                                                      <CFFORM ACTION="#script_name#" METHOD="POST"  id="submitSellerForm">
                                                         <input type="hidden" name="submitted" value="1" />
                                                         <input	type="hidden" name="captcha_check"	value="#FORM.captcha_check#" />
                                                         <div class="input-form">
                                                            <div class="row">
                                                               <div class="col-md-6">
                                                                  <div class="input-field">
                                                                     <label><b>First Name:<span style="color: ##ff0000;">*</span></b></label>
                                                                     <cfinput type="text" name="fname" maxlength="15" id="S_fname" value="#form.fname#" size="30" >
                                                                     <span class="error-message" id="S_fnameError"></span>
                                                                  </div>
                                                               </div>
                                                               <div class="col-md-6">
                                                                  <div class="input-field">
                                                                     <label><b>Last Name:<span style="color: ##ff0000;">*</span></b></label>
                                                                     <cfinput type="text" name="lname" maxlength="15" id="S_lname" value="#form.lname#" size="30">
                                                                     <span class="error-message" id="S_lnameError"></span>
                                                                  </div>
                                                               </div>
                                                               <div class="col-md-4">
                                                                  <div class="input-field">
                                                                     <label><b>Email:<span style="color: ##ff0000;">*</span></b></label>
                                                                     <cfinput type="text" name="Email" id="S_Email" value="#form.Email#" size="30" maxlength="20" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$">
                                                                     <span class="error-message" id="S_EmailError"></span>
                                                                  </div>
                                                               </div>

                                                               <div class="col-md-4">
                                                                  <div class="input-field">
                                                                     <label><b>Phone Type:<span style="color: ##ff0000;">*</span></b></label>
                                                                     <select name="phoneType" id="phoneType" >
                                                                        <option value="Cell Phone">Cell Phone</option>
                                                                        <option value="Home Phone">Home Phone</option>
                                                                        <option value="Business Phone">Business Phone</option>
                                                                        <option value="OutsideUS">Outside US Phone</option>
                                                                     </select>
                                                                     <span class="error-message" id="S_phoneTypeError"></span>
                                                                  </div>
                                                               </div>

                                                               <div class="col-md-4">
                                                                  <div class="input-field">
                                                                     <label><b>Phone Number:<span style="color: ##ff0000;">*</span></b></label>
                                                                     <cfinput type="text" name="cellphone" id="S_cellphone" maxlength="20" value="#form.cellphone#"   size="30">
                                                                     <span id="formatSign">(xxx) xxx-xxxx</span>
                                                                     <span class="error-message" id="S_cellphoneError"></span>
                                                                  </div>
                                                               </div>
                                                               <div class="col-md-6">
                                                                  <div class="input-field">
                                                                     <label><b>Create a Password:<span style="color: ##ff0000;">*</span></b></label>
                                                                     <cfinput type="password" name="password" maxlength="15" id="S_password" size="30" >
                                                                     <span class="error-message" id="S_passwordError"></span>
                                                                  </div>
                                                               </div>
                                                               <div class="col-md-6">
                                                                  <div class="input-field">
                                                                     <label><b>Re-enter Password:<span style="color: ##ff0000;">*</span></b></label>
                                                                     <cfinput type="password" name="password2" maxlength="15" id="S_password2" size="30" >
                                                                     <span class="error-message" id="S_password2Error"></span>
                                                                  </div>
                                                               </div>
                                                            </div>
                                                            <div class="input-field pt-3">
                                                               <div class="g-recaptcha" id="gRecaptchaGeneral" data-sitekey="6LddEiMrAAAAAOnJRd03TsT_vYkEbebkW0T3u_ne"></div>
                                                               <span class="error-message" id="S_recaptchaError"></span>
                                                            </div>
                                                            <div class="input-button mt-3 register-btn">
                                                               <input type="Hidden" name="proc_reg">
                                                               <cfif NOT structKeyExists(session, 'sellerinfo') >
                                                               <button type="button" class="SeeMore" id="S_submitbtn" onclick="validateSellerForm()">Create an account</button>
                                                               <cfelse>
                                                               <p>
                                                                  You are already logged in. If you want to add listings, please <b><a href="/user_listing_detail">click here</a></b>.
                                                               </p>
                                                               </cfif>
                                                               <br>
                                                            </div>
                                                            <!--- <p style="text-align: center;">
                                                               If you have already signed up as a seller, please <a href="/login"> <b>Sign In </b></a>
                                                               </p> --->
                                                         </div>
                                                      </cfform>
                                                   </div>
                                                   
                                                </div>
                                             </cfoutput>
                                          </div>
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
         <tr>
            <td colspan="2" valign="baseline">
               <cfinclude template="footer_.cfm">
            </td>
         </tr>
         <cfinclude template="frmxss.cfm">
         <script src="https://www.google.com/recaptcha/api.js" async defer></script>
         <script>
         
            function validateSellerForm(){
               // alert('test');
               document.querySelectorAll('.error-message').forEach(error => error.textContent = '');
               
               let isValid = true;
               
               const S_fname = document.getElementById('S_fname').value.trim();
               const S_lname = document.getElementById('S_lname').value.trim();
               const S_email = document.getElementById('S_Email').value.trim();
               const S_phone = document.getElementById('S_cellphone').value.trim();
               const phoneType = document.querySelector("[name='phoneType']").value;
               const S_password = document.getElementById('S_password').value.trim();
               const S_password2 = document.getElementById('S_password2').value.trim();
               //  const S_captcha = document.getElementById('S_captcha').value.trim();
               
               const phoneRegex = /^\(\d{3}\) \d{3}-\d{4}$/;

               const S_submitBtn = document.getElementById('S_submitbtn');

               S_submitBtn.disabled = true;
               S_submitBtn.textContent = "Processing..."; 

               var recaptcha = grecaptcha.getResponse();
               console.log(recaptcha.length);
               
               if (recaptcha.length == 0) {
                  document.getElementById("S_recaptchaError").innerText = "Please confirm you are not a robot.";
                  isValid = false;
               }
               
               if (!S_fname) {
                  document.getElementById('S_fnameError').textContent = 'Please fill in your first name.';
                  isValid = false;
               }
               
               // Validate LAST NAME
               if (!S_lname) {
                  document.getElementById('S_lnameError').textContent = 'Please fill in your last name.';
                  isValid = false;
               }
               
               // Validate EMAIL
               if (!S_email) {
                  document.getElementById('S_EmailError').textContent = 'Please fill in your email address.';
                  isValid = false;
               } else if (!/\S+@\S+\.\S+/.test(S_email)) {
                  document.getElementById('S_EmailError').textContent = 'Please enter a valid email address.';
                  isValid = false;
               }
               
               
               //  if (!S_phone) {
               //  document.getElementById('S_cellphoneError').textContent = 'Please enter a phone number.';
               //  isValid = false;
               //  } 
               // else if (!phoneRegex.test(S_phone)) {
               // 	document.getElementById('S_cellphoneError').textContent = 'Please enter your phone number in the format (xxx) xxx-xxxx';
               // 	isValid false; // Prevent form submission
               // }
               
               // if (S_phone && !phoneRegex.test(S_phone)) {
               // 	document.getElementById('S_cellphoneError').textContent = 'Please enter a valid phone number in the format (xxx) xxx-xxxx.';
               // 	isValid = false;
               // }
               
               if (!S_password) {
                  document.getElementById('S_passwordError').textContent = 'Please enter your password.';
                  isValid = false;
               }
               
               if (!S_password2) {
                  document.getElementById('S_password2Error').textContent = 'Please re-enter your password.';
                  isValid = false;
               }
               
               if (S_password && S_password2 && S_password !== S_password2) {
                  document.getElementById('S_password2Error').textContent = 'Passwords do not match.';
                  isValid = false;
               }

               if (!phoneType) {
                  document.getElementById('S_phoneTypeError').textContent = 'Please enter phone number';
                  isValid = false;
               }

               if(phoneType){
                  if(phoneType === "Home Phone" || phoneType === "Cell Phone" || phoneType === "Business Phone"){
                     if (S_phone && !phoneRegex.test(S_phone)) {
                        document.getElementById('S_cellphoneError').textContent = 'Please enter phone number in format: (xxx) xxx-xxxx ';
                        document.getElementById('S_cellphone').focus();
                        isValid = false;
                     }
                  }
               }
               
               // Validate CAPTCHA
               //  if (!S_captcha) {
               //  document.getElementById('S_captchaError').textContent = 'Please enter the characters in the image.';
               //  isValid = false;
               //  }
               
               if (isValid) {
               // Submit the form
                  document.getElementById('submitSellerForm').submit();
               } else {
                  // Re-enable button if validation fails
                  S_submitBtn.disabled = false;
                  S_submitBtn.textContent = "Create an account";
               }
               
               return isValid;
            }
   
         </script>

         <script>
               document.addEventListener("DOMContentLoaded", function() {
                  const phoneInput = document.getElementById("S_cellphone");
                  const phoneType = document.getElementById("phoneType");
                  const formatSign = document.getElementById("formatSign");

                  function toggleFormatSign() {
                     if (phoneType.value === "OutsideUS") {
                        formatSign.style.display = "none";
                     } else {
                        formatSign.style.display = "inline";
                     }
                  }

                  // run on load (in case form already has value)
                  toggleFormatSign();

                  // run on change
                  phoneType.addEventListener("change", toggleFormatSign);

                  phoneInput.addEventListener("input", function(e) {
                     // If type is OutsideUS → skip formatting
                     if (phoneType.value === "OutsideUS") {
                        return;
                     }

                     let value = e.target.value.replace(/\D/g, ""); // only digits
                     if (value.length > 10) value = value.substring(0, 10);

                     // Apply formatting as user types
                     if (value.length > 6) {
                        e.target.value = `(${value.substring(0,3)}) ${value.substring(3,6)}-${value.substring(6)}`;
                     } else if (value.length > 3) {
                        e.target.value = `(${value.substring(0,3)}) ${value.substring(3)}`;
                     } else if (value.length > 0) {
                        e.target.value = `(${value}`;
                     } else {
                        e.target.value = "";
                     }
                  });
               });
         </script>

         <style>
            .error-message {
               color: #ff0000;
               font-size: 0.9em;
               margin-top: 5px;
               display: block;
            }
            .input-field {
               margin-bottom: 15px;
            }
            .registration-page .content-section .banner-section .art-work-content input, 
            .registration-page .content-section .banner-section .art-work-content select,
            .registration-page .content-section .banner-section .art-work-content .user-registrations .form-sectiom textarea {
                  background-color: #fff; 
                  border-radius: 10px !important;
                  border: 1px solid lightgray !important;
               }

            .form-sectiom {
               background: #f2f2f2;
               border-radius: 10px;
               padding: 50px;
            }
            @media (max-width: 767px) {
               .form-sectiom { 
                  padding: 40px 20px;
               }
            }
            
         </style>
      </body>
   </html>
<cfelse>
	<cflocation addtoken="No" url="/overView">
</cfif>