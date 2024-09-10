<cfscript>
	if( form.keyExists( 'fieldnames' ) ) {
		mailer = new admin.models.mailer();

		mailer.sendMail( argumentcollection=form );

		writeOutput( '
			<script>
				window.opener.location.reload();
				window.close();
			</script>
		' );
	}
</cfscript>

<cfoutput>
	<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="##ffffff">
		<cfform method="post" action="" name="emailLeadForm">
			<input type="hidden" name="sender" id="sender" value="#session.userinfo.email#">
			<input type="hidden" name="senderFname" id="senderFname" value="#session.userinfo.fname#">
			<input type="hidden" name="senderLname" id="senderLname" value="#session.userinfo.lname#">
			<input type="hidden" name="currEmpId" id="currEmpId" value="#session.userinfo.pk_employees#">
			<input type="hidden" name="recipient" id="recipient" value="">
			<input type="hidden" name="salutation" id="salutation" value="">
			<input type="hidden" name="closer" id="closer" value="">

			<tr>
				<td style="font-family: Arial; font-size: 12px; width: 75px;">
					Subject:&nbsp;&nbsp;
				</td>
				<td>
					<input type="Text" name="subject" value="Gallart - Response To Your Inquiry" size="50">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<cftextarea name="body" id="body" height="300" width="600" richtext="yes" toolbar="Basic">Enter email content . . .</cftextarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="font-family: Arial; font-size: 12px;">
					Sincerely,<br><br>
					#session.userinfo.fname# #session.userinfo.lname#<br>
					Gallery Art<br>
					20633 Biscayne Blvd<br>
					Aventura FL 33180<br>
					305 932 6166 gallery<br>
					305 937 2125 fax<br>

				</td>
			</tr>
			<tr>
				<td align="center" colspan="2" style="font-family: Arial; font-size: 11px;">
					<input type="Submit" value="SEND EMAIL" />
				</td>
			</tr>
		</cfform>
	</table>
</cfoutput>
