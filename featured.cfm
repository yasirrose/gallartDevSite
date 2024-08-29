<cfquery name="getFeatured" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * 
	FROM products
	WHERE active = 1 and frontshow > 0 order by newid() 
</cfquery>

<table cellspacing="0" cellpadding="0" border="0" width="100%" style="padding-top: 75px;">
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<cfoutput query="getFeatured" maxrows="6">
				
				<cfif listlen(manufacturer) gt 1>
					<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
					<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
				<cfelse>
					<cfset artist_name = manufacturer />
					<cfset artist_name_url = manufacturer />
				</cfif>
				<tr>
					<td valign="top" align="Center">
						<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
							<img src="http://#server_name#/img/thumbnails/#uid#.jpg" alt="#ucase(manufacturer)# - #name#" border="0" align="center">
						</A><br>
						<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">#ucase(Name)#</a>
						<h1>#ucase(artist_name)#</h1><br>
					</td>
				</tr>
				</cfoutput>
			</table>
		</td>
	</tr>
</table>


