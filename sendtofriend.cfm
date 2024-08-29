<cfparam name="send_msg" default="">

<cfif isDefined('form.sendtofriend')>

	<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="#form.email_to#" from="onli16@onlinegalleryart.com" subject="Gallery Art - Interesting Piece" type="HTML">
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
	
	<cfset send_msg = "Your email has been sent." />

</cfif>

<cfoutput>
<table cellspacing="0" cellpadding="5" border="0" width="250" style="border: 1px solid ##000000;">
	<cfif isDefined('send_msg') and len(send_msg)>
		<tr>
			<td>
				<div align="center"><strong>#send_msg#</strong></div>
			</td>
		</tr>
	<cfelse>
	<cfform method="post" action="#script_name#?#query_string#">
	<input type="Hidden" name="link" value="http://#server_name##script_name#?#query_string#">
	<tr>
		<td colspan="2" align="center">
			<strong>SEND THIS PAGE TO A FRIEND</strong>
		</td>
	</tr>
	<tr>
		<td style="font-size: 7pt;">
			Friend's Email:
		</td>
		<td>
			<cfinput type="Text" name="email_to" style="font-size: 7pt;" required="Yes" message="Please enter your friend's email.">
		</td>
	</tr>
	<tr>
		<td style="font-size: 7pt;">
			Your Email:
		</td>
		<td>
			<cfinput type="Text" name="email_from" style="font-size: 7pt;" required="Yes" message="Please enter your email.">
		</td>
	</tr>
	<tr>
		<td style="font-size: 7pt;">
			Message:
		</td>
		<td>
			<input type="Text" name="message" style="font-size: 7pt;">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="image" src="images/send.gif" style="border: none;">
		</td>
	</tr>
	</cfform>
	</cfif>
</table>

</cfoutput>
