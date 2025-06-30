<cfparam name="send_msg" default="">

<cfif isDefined('form.sendtofriend')>
	
<cfmail server="#servername#" username="onli16@onlinegalleryart.com" password="re3objec" to="#form.email_to#" from="onli16@onlinegalleryart.com" 
   subject="Gallery Art - Interesting Piece" type="HTML">
   <font style="font-size: 10pt; font-family: Arial;">
      Look at what I found on www.gallart.com:
      <br><br>
      <a href="#form.link#" target="_blank">#form.link#</a>
      <cfif len(form.message)>
         <br><br>
         #form.message#
      </cfif>
      <br><br>
      This message from: #form.email_from#
      <br><br>
   </font>
</cfmail>

<cfset send_msg="Your email has been sent." />

</cfif>

<cfoutput>
   <div class="input-form text-left">

      <cfif isDefined('send_msg') and len(send_msg)>
      <div align="center"><strong>#send_msg#</strong></div>
      <cfelse>
      <cfform method="post" action="#script_name#?#query_string#">
         <input type="Hidden" name="link" value="http://#server_name##script_name#?#query_string#">
         <div class="top-heading">
            <strong>SEND THIS PAGE TO A FRIEND</strong>
         </div>
         <div class="input-field">
            <label>Friend's Email:</label>
            <cfinput type="Text" name="email_to" required="Yes" message="Please enter your friend's email.">
         </div>
         <div class="input-field">
            <label>Your Email:</label>
            <cfinput type="Text" name="email_from" required="Yes" message="Please enter your email.">
         </div>
         <div class="input-field">
            <label>Message:</label>
            <input type="Text" name="message">
         </div>
         <div class="input-button">
            <button type="submit" class="SeeMore">Send</button>
         </div>
      </cfform>
      </cfif>
   </div>

</cfoutput>