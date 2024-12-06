<div class="bottom-row-fields">
    <div>
       <button class="inquire-Button" type="button" data-bs-toggle="collapse" data-bs-target="##collapseExample" aria-expanded="false" aria-controls="collapseExample">
       <b>Inquire About this piece</b>
       </button>
    </div>
    <div class="collapse" id="collapseExample">
       <div class="card card-body" style="border: 1px solid black;">
          <cfif FORM.submitted>
             <!--- Check for a bot. --->
             <cfif phoneError>
                <cfoutput>
                   <!--- <cfdump var="testing 1" abort="true"> --->
                   <script language="JavaScript">
                      document.errorFrm.fname.value = '#form.fname#'
                      document.errorFrm.lname.value = '#form.lname#'
                      document.errorFrm.email.value = '#form.email#'
                      document.errorFrm.phone.value = '#form.phone#'
                      document.errorFrm.otherphone.value = '#form.otherphone#'
                      document.errorFrm.comments.value = '#form.comments#'
                      document.errorFrm.errorMsg.value = '#errorMsg#'
                      document.errorFrm.errorPhone.value = '1'
                      document.errorFrm.submit();
                   </script>
                </cfoutput>
                <cfelseif blnIsBot>
                <cfoutput>
                   <!--- <cfdump var="testing 2" abort="true"> --->
                   <script language="JavaScript">
                      document.errorFrm.fname.value = '#form.fname#'
                      document.errorFrm.lname.value = '#form.lname#'
                      document.errorFrm.email.value = '#form.email#'
                      document.errorFrm.phone.value = '#form.phone#'
                      document.errorFrm.otherphone.value = '#form.otherphone#'
                      document.errorFrm.comments.value = '#form.comments#'
                      document.errorFrm.errorMsg.value = '#errorMsg#'
                      document.errorFrm.captchaError.value = '1'
                      document.errorFrm.submit();
                   </script>
                </cfoutput>
                <cfelse>
                <cftry>
                  
                   

                   <cfquery name="addgLead" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                      insert into leads (fname,lname, notes, email, phone, otherphone, maillist)
                      values('#form.fname#','#form.lname#', '#form.comments#', '#form.email#', '#form.phone#', '#form.otherphone#', '#form.list#')
                   </cfquery>
                   <cfcatch type="Any">
                      Sorry - we have encountered a processing error.  Please try again.
                      <cfabort>
                   </cfcatch>
                </cftry>
                <cfmail 
                   server="#servername#" 
                   username="gallart@onlinegalleryart.com"
                   password="re3objeC!P" 
                   to="#emailsupport#" 
                   cc="#emailsupportcc#" 
                   from="#form.email#" 
                   subject="GallArt.com <> Buying & Selling Fine Art <> Contact Form" type="HTML">
                   <font style="font-size: 10pt; font-family: Arial;">
                   Client Information:
                   <br><br>
                   Name: #form.fname# #form.lname#<br>
                   Email Address: #form.email#<br>
                   Phone: #form.phone#<br>
                   Phone Outside the US: #form.otherphone#<br>
                   Comments: #form.comments#<br>
                   <br><br>
                   </font>
                </cfmail>
                <p>
                   <b>
                      Thank you 
                      <cfoutput>#form.fname# #form.lname#</cfoutput>
                      . <br><br> Your Email has been sent to the respective personnel. <br><br>   We hope that your visit has been a pleasant experience so far.
                   </b>
                </p>
             </cfif>
             <cfelse>
             <cfoutput>
                <CFFORM ACTION="#fullURL#" METHOD="POST" name="guestFrm" onsubmit="return validateForm()">
                   <input type="hidden" name="submitted" value="1" />
                   <input	type="hidden" name="captcha_check"	value="#FORM.captcha_check#" />
                   <div class="top-heading">
                      <h3>CONTACT US</h3>
                   </div>
                   <cfif FORM.captchaError>
                      <p style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</p>
                   </cfif>
                   <cfif FORM.errorPhone EQ 1>
                      <p style="color: ##ff0000; font-weight: bold;">
                         #form.errorMsg#
                      </p>
                   </cfif>
                   <p>Please contact us using the form below:<span style="color: ##ff0000;">* Required</span></p>
                   <br><br>
                   <div class="input-form">
                      <div class="input-field">
                         <label><FONT color="000000"><b>FIRST NAME &nbsp;<span style="color:##ff0000;">*</span></b></FONT></label>
                         <cfinput type="text" id="fname" name="fname" value="#form.fname#" >
                         <span class="error-message" id="fnameError"></span>
                      </div>
                      <div class="input-field">
                         <label><FONT color="000000"><b>LAST NAME &nbsp;<span style="color:##ff0000;">*</span></b></FONT></label>
                         <cfinput type="text" name="lname" value="#form.lname#" id="lname">
                         <span class="error-message" id="lnameError"></span>
                      </div>
                      <div class="input-field">
                         <label><FONT color="000000"><b>E-MAIL ADDRESS &nbsp;<span style="color:##ff0000;">*</span></b></FONT></label>
                         <cfinput type="text" name="email" value="#form.email#" id="email">
                         <span class="error-message" id="emailError"></span>
                      </div>
                      <div class="input-field">
                         <label><FONT color="000000"><b>PHONE (xxx) xxx-xxxx</b></FONT></label>
                         <cfinput type="text" name="phone" value="#form.phone#" required="No" MESSAGE="Please fill in your email address." mask="(999) 999-9999">
                      </div>
                      <div class="input-field">
                         <label><FONT color="000000"><b>PHONE OUTSIDE THE US</b></FONT></label>
                         <cfinput type="text" name="otherphone" value="#form.otherphone#" required="No" >
                      </div>
                      <div class="input-field">
                         <label><FONT color="000000"><b>COMMENTS</b></FONT></label>
                         <TEXTAREA NAME="comments" ROWS=10 COLS=35>#form.comments#</TEXTAREA>
                      </div>
                      <div class="input-field">
                         <cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="low"	fonts="verdana,arial,times new roman,courier" fontsize="28"/>
                         <label><FONT color="000000"><b>Please enter the characters in the image above: <span style="color:##ff0000;">*</span></b></FONT></label>
                         <cfinput type="text" name="captcha" id="captcha">
                         <span class="error-message" id="captchaError"></span>
                      </div>
                      <div class="input-button">
                         <button type="submit" class="SeeMore">Send</button>
                         <button type="reset" class="SeeMore">Reset</button>
                      </div>
                   </div>
                </CFFORM>
             </cfoutput>
          </cfif>
       </div>
    </div>
 </div>


 <div class="bio-field">
    <div>
       <button class="artist-Button" type="button" data-bs-toggle="collapse" data-bs-target="##collapseExample2" aria-expanded="false" aria-controls="collapseExample">
       <b>Artist Biography</b>
       </button>
    </div>
    <div class="collapse" id="collapseExample2">
       <div class="card card-body" style="border: 1px solid black;">
          <div class="bio-content" style="text-align: left;">
             <!-- Output the content from the database -->
             <cfif bio_info.recordCount neq 0 >
                #getBio.bio#
                <cfelse>
                <p>
                   There is no Artist Biography
                </p>
             </cfif>
          </div>
       </div>
    </div>
 </div>