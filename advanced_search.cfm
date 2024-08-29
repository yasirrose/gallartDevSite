<cfquery name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" cachedwithin="#createTimespan(0,1,0,0)#">
	SELECT distinct manufacturer from products
	where active = 1
	<!--- AND fk_users is null --->
	order by manufacturer
</cfquery>
<!--- <cfset temp = QueryAddRow(data)>
<cfset Temp = QuerySetCell(data, "manufacturer", "MAX, PETER")>  --->
<cfquery dbtype="query" name="artistinfo">
	select *
	from data
	ORDER BY manufacturer
</cfquery>
<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" cachedwithin="#createTimespan(0,1,0,0)#">
Select path from products
WHERE active = 1
<!--- AND fk_users is null --->
group by path
order by path
</cfquery>

<cfoutput>
<table cellspacing="0" cellpadding="3" border="0" width="100%">
<form action="products.cfm?xss=#xss#" method="post">
	<tr>
		<td>
			Title
		</td>
		<td>
			<input type="Text" name="adv_title" style="font-family: verdana; font-size: 7pt;">
		</td>
		<td>
			Artist
		</td>
		<td>
			<select name="adv_artist" style="font-family: verdana; font-size: 7pt;">
				<option value="" selected>ALL
					<cfloop query="artistinfo">
						<cfif manufacturer EQ 'MAX, PETER'>
							<option value="#manufacturer#">MAX, PETER (ALL)
						<cfelseif not isnumeric(manufacturer) and len(manufacturer) gt 1>
							<option value="#manufacturer#" <cfif parameterexists(manufact) and manufact eq '#manufacturer#'>Selected</cfif>>#ucase(manufacturer)#
						</cfif>
					</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			Keyword in Description
		</td>
		<td>
			<input type="text" name="adv_desc_keyword" style="font-family: verdana; font-size: 7pt;">
		</td>
		<td>
			Year
		</td>
		<td>
			<input type="text" name="adv_year" style="font-family: verdana; font-size: 7pt;">
		</td>
		
	</tr>
	<tr>
		
		<td>
			Price Range
		</td>
		<td colspan="3">
			<select name="adv_price_range" style="font-family: verdana; font-size: 7pt;">
				<option value="">ALL
				<option value="1">$0 - $1,000
				<option value="2">$1,000 - $5,000
				<option value="3">$5,000 - $10,000
				<option value="4">$10,000 - $100,000
				<option value="5">over $100,000
			</select>
		</td>
	</tr>
	<tr>
		<td>
			Medium
		</td>
		<td colspan="3">
			<select name="adv_medium" style="font-family: verdana; font-size: 7pt;">
				<option value="">ALL
				<cfloop query="cats">
					<option value="#path#">#ucase(path)#
				</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="right">
			<input type="image" src="images/search.gif" style="border: none;"><br>
			<input style="background:url(images/reset.gif) no-repeat; width: 87px; height: 30px; border: none;" type="reset" value="" />
		</td>
	</tr>
</table>
</form>
</cfoutput>
