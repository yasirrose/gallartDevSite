<table cellpadding="0" cellspacing="0" border="0" width="95%" align="center" style="padding-right: 10px;">
	<tr>
		<td align="Center">
			<cfoutput>
				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr>
						<td width="2%">&nbsp;</td>
						<cfloop from="65" to="90" index="idx">
							<td width="3.8%">
							<a href="alpha_list.cfm?man=#chr(idx)#" class="alpha">#chr(idx)#</a>
							</td>
						</cfloop>
					</tr>
				</table>
			</cfoutput>
		</td>
	</tr>
	<cfif isDefined('man')>
		<cfoutput>
			<cfquery name="alpha_info" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
				SELECT distinct manufacturer 
				FROM products 
				WHERE manufacturer like '#man#%' 
				AND active = 1 
				AND (path <> '') 
				AND (path IS NOT NULL)
				ORDER BY manufacturer 
			</cfquery>
		<tr>
			<td style="color: ##FF3399;">Artists whose name begins with #man#:<br>
				<cfloop query="alpha_info">
					<a href="products.cfm?man=#manufacturer#">#ucase(manufacturer)#</a><br>
				</cfloop>
				(Click artist's name to view art)
			</td>
		</tr>
		</cfoutput>
	</cfif>
</table>
