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

<div class="search-form-group">
	<!--- <cfoutput>
		<form name="db_search" method="post" action="database.cfm?xss=#xss#">
	</cfoutput>
		<div class="top-content">
			<label>Database View</label>
			<a href="#TB_inline?height=200&width=300&inlineId=databaseview_help&modal=true">
				<span>What's this <span class="question-span">?</span></span>
			</a>
		</div>
		<div class="select-option">
			<select name="manufact" onchange="db_search.submit();" style="font-family: arial; font-size: 7pt;">
				<option value="" selected>PLEASE SELECT ARTIST
					<cfoutput query="artistinfo">
						<cfif manufacturer EQ 'MAX, PETER'>
							<option value="#manufacturer#">MAX, PETER (ALL)
						<cfelseif not isnumeric(manufacturer) and len(manufacturer) gt 1>
							<option value="#manufacturer#" <cfif parameterexists(manufact) and manufact eq '#manufacturer#'>Selected</cfif>>#ucase(manufacturer)#
						</cfif>
					</cfoutput>
			</select>
		</div>
	</form> --->
	
</div>
<!--- <cfoutput>
<form name="db_search" method="post" action="database.cfm?xss=#xss#">
</cfoutput>
<div class="row input-form">
	<div class="col-lg-3 col-md-4 col-sm-6 col-12 mt-2 mb-2">
		<div class="select-option input-field">
			<select name="manufact" onchange="db_search.submit();" style="margin: 0;appearance: none;">
				<option value="" selected>PLEASE SELECT ARTIST
					<cfoutput query="artistinfo">
						<cfif manufacturer EQ 'MAX, PETER'>
							<option value="#manufacturer#">MAX, PETER (ALL)
						<cfelseif not isnumeric(manufacturer) and len(manufacturer) gt 1>
							<option value="#manufacturer#" <cfif parameterexists(manufact) and manufact eq '#manufacturer#'>Selected</cfif>>#ucase(manufacturer)#
						</cfif>
					</cfoutput>
			</select>
		</div>
	</div>
	<div class="col-lg-3 col-md-4 col-sm-6 col-12 mt-2 mb-2 d-flex align-items-center">
		<a href="#TB_inline?height=200&width=300&inlineId=databaseview_help&modal=true" class="thickbox" style="color: ##dd3a7d; text-decoration: underline;"><img src="images/question.jpg" border="0"></a>
	</div>
</div>
</form> --->
