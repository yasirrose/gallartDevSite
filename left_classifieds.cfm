<cfquery name="allClassifieds" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT *
	FROM products 
	WHERE active = 1
	AND fk_users is NOT null
</cfquery>

<cfquery name="getArtists" dbtype="query">
	SELECT DISTINCT manufacturer from allClassifieds
	ORDER BY manufacturer
</cfquery>

<!--- <cfquery name="getArtists" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT DISTINCT manufacturer from products
	WHERE active = 1
	AND fk_users is not null
	ORDER by manufacturer 
</cfquery> --->

<cfquery name="getMedium" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	Select path from products
	WHERE fk_users is not null
	group by path
	order by path
</cfquery>

<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" height="100%">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0" width="173" height="121">
				<form action="classifieds.cfm?xss=#xss#" method="post">
				<tr>
					<td style="padding-left: 20px; padding-top: 25px;">
						<strong>Search Classifieds</strong>
					</td>
				</tr>
				<tr>
					<td style="padding-left: 20px; padding-top: 10px;">
						<input type="text" name="keywords" style="font-size: 8pt; width: 132px;">
					</td>
				</tr>
				<tr>
					<td style="padding-left: 92px; padding-bottom: 7px;">
						<input type="image" src="images/find_but.jpg" alt="Search for Products" style="border: 1px solid ##ffffff;">
					</td>
				</tr>
				</form>
			</table>
		</td>
	</tr>
	<tr height="100%">
		<td valign="top" style="padding: 20px 0 0 12px;">
			<table cellspacing="0" cellpadding="5" border="0" width="150" style="border: 3px solid ##000000;">
				<tr>
					<td>
						<strong>We have <span class="pinkText">CLASSIFIED</span><br />items listed by these artists:</strong><br><br>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<table cellspacing="0" cellpadding="3" border="0" width="100%">
							<cfloop query="getArtists">
							<tr>
								<td>
									<a href="classifieds.cfm?artist=#manufacturer#">#manufacturer#</a>
								</td>
							</tr>
							</cfloop>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>
-