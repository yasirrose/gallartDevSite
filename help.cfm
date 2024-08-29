<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Help</title>
</head>

<body style="background-color: #dd3a7d;">
<table cellspacing="0" cellpadding="0" border="0" width="300" bgcolor="dd3a7d">
	<tr>
		<td style="font-size: 9pt; font-family: Arial; color: #ffffff;">
			<cfswitch expression="#url.helpID#">
				<cfcase value="PictureGallery">
					Select an artist from the dropdown to view all artwork by that artist.  You will be taken to a page of thumbnail listings of every work of art by that artist in our system.  Click on the thumbnail for a detailed view.
				</cfcase>
				<cfcase value="DatabaseView">
					Select an artist from the dropdown to see a listing of all the artwork by that artist in our database.  The listing is text only, and can be printed out for your records.
				</cfcase>
				<cfcase value="SearchAlpha">
					Click on a letter to view all of the artists in our system whose last name begins with that letter.
				</cfcase>
			</cfswitch>
		</td>
	</tr>
</table>


</body>
</html>
