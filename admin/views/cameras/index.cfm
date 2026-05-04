<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td valign="top">
        	
			<cfform method="post" action="index.cfm?event=cameras.edit">
			<table border="0" cellspacing="0" cellpadding="2" align="center" width="400" cellpadding="5">
                <tr>
					<td style="font-size: 12px; width: 10%">
						<strong>Camera Name</strong>
					</td>
					<td style="font-size: 12px; width: 10%" align="center">
						<strong>Number</strong>
					</td>
					<td style="font-size: 12px; width: 18%">
						<strong>Location</strong>
					</td>
				</tr>
				<cfoutput query="getCameras">
				<tr class="#this_row()#">
					<td>
						#ucase(camera_name)#
					</td>
					<td align="center">
						#camera_number#
					</td>
					<td>
						<cfinput type="Text" name="location_#pk_camera#" value="#location#" size="70">
					</td>
				</tr>
				</cfoutput>
				<tr>
					<td colspan="3" align="center">
						<input type="submit" value="EDIT">
					</td>
				</tr>
				</cfform>
			</table>
		</td>
	</tr>
</table>