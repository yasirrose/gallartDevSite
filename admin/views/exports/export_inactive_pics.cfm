<CFQUERY name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	select * from products
	where active = 0
	or active is null
	order by uid
</CFQUERY>

<!--- <cfdump var="#data#" /> --->

<cfcontent type="application/ms-excel" reset="Yes">
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Inventory Listing rows 7401 - 7700 #DateFormat(createodbcdate(now()))#.xls""">

	<table border="1" cellpadding="0" cellspacing="0">
		<!--- <tr class="row0">
			<td>
				Art ID
			</td>
			<td>
				Title
			</td>
			 <td>
				Image Path
			</td>
			<td>
				Image Size
			</td>
		</tr> --->
		<cfoutput query="data" maxrows="300" startrow="7401">
		<cfset imgurl = "http://www.gallart.com/img/" & #uid# & ".jpg" />
		<!--- <cfset imgurl = imageurl /> --->
		<cfif fileExists(imgurl) AND GetFileInfo(imgurl).size GTE 200000>
		<tr>
			<td>
				#modelno#
			</td>
			<td>
				#name#
			</td>
			<td valign="top">
				#imgurl#
			</td>
			<td>
				#GetFileInfo(imgurl).size#
			</td>
		</tr>
		</cfif>
		</cfoutput>
	</table>
	













