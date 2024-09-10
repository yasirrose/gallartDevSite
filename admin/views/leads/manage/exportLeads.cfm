
<cfcontent type="application/ms-excel" reset="Yes">
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Lead Export #DateFormat(createodbcdate(now()))#.xls""">

<cfoutput>


	<table border="1" cellpadding="2" cellspacing="0">
		<tr bgcolor="##000000">
			<td style="color: ##FFFFFF;" valign="top">
				<strong>First Name</strong>
			</td>
			<td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Last Name</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Email</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Cell Phone</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Home Phone</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Business Phone</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Best Time To Call</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Address</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>City</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>State</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Country</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Zip</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Company</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Website</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Artists</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Titles</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Notes</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Origin</strong>
			</td>
		</tr>
        <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Last Name</strong>
			</td>
            <td style="color: ##FFFFFF;" valign="top" width="350">
				<strong>Last Name</strong>
			</td>
		<cfloop query="getLeads">
		<tr>
			<td valign="top">
				#fname#
			</td>
			<td valign="top">
				#lname#
			</td>
			<td valign="top">
				#email#
			</td>
            <td valign="top">
				#cellphone#
			</td>
            <td valign="top">
				#phone#
			</td>
            <td valign="top">
				#businessphone#
			</td>
            <td valign="top">
				#besttime#
			</td>
            <td valign="top">
				#address#
			</td>
            <td valign="top">
				#city#
			</td>
            <td valign="top">
				#state#
			</td>
            <td valign="top">
				#country#
			</td>
            <td valign="top">
				#zip#
			</td>
            <td valign="top">
				#company#
			</td>
            <td valign="top">
				#website#
			</td>
            <td valign="top">
				#artists#
			</td>
            <td valign="top">
				#titles#
			</td>
            <td valign="top">
				#notes#
			</td>
            <td valign="top">
				#origin#
			</td>
		</tr>
		</cfloop>
	</table>
	
</cfoutput>

						