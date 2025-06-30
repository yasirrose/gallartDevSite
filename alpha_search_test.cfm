<div class="search-form-group">
	<form name="dropdown">
		<div class="top-content">
			<label><b>Search by artist alphabetically</b></label>
		</div>
		<cfoutput>
			<div class="alpha-row">
				<cfloop from="65" to="90" index="idx">
					<div>
						<a href="alpha_list.cfm?man=#chr(idx)#&xss=#xss#" class="alpha">#chr(idx)#</a>
					</div>
				</cfloop>
			</div>
		</cfoutput>
	</form>
	
</div>

<!--- <table cellpadding="0" cellspacing="0" border="0" width="95%" align="center" style="padding-right: 10px;"> 
	<tr>
		<td align="Center">
			<cfoutput>
				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr>
						<td width="2%">&nbsp;</td>
						<cfloop from="65" to="90" index="idx">
							<td width="3.8%">
							<a href="alpha_list.cfm?man=#chr(idx)#&xss=#xss#" class="alpha">#chr(idx)#</a>
							</td>
						</cfloop>
					</tr>
				</table>
			</cfoutput>
		</td>
	</tr>
</table> --->
