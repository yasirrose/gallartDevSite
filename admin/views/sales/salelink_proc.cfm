<cfif isDefined('form.new')>

	<cfquery name="qSales" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	    INSERT into sales
		(
			saleCode,
			queryString,
			percentMarkdown
		)
		values
		(
			'#form.SaleCode#',
			'#form.queryString#',
			'#form.percentMarkdown#'
		)
	</cfquery>

	<cfloop collection="#form#" item="idx">
		<cfif left(idx,9) eq 'SALELINK_'>
			<cfset this_keyval = right(idx,len(idx)-9)>
			<cfquery name="searchresult" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			    INSERT into saleCode_ProductId
				(
					SaleCode,
					ProductId
				)
				values
				(
					'#form.SaleCode#',
					#this_keyval#
				)
			</cfquery>
		</cfif>
	</cfloop>



<cfelseif isDefined('form.update')>


	<cfquery name="qSales" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	    UPDATE sales set
			percentMarkdown = '#form.percentMarkdown#'
		WHERE pk_sales = #form.pk_sales#
	</cfquery>
	
	<cfquery name="qSalesCode" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	    DELETE from saleCode_ProductId
		WHERE SaleCode = '#form.SaleCode#'
	</cfquery>

	<cfloop collection="#form#" item="idx">
		<cfif left(idx,9) eq 'SALELINK_'>
			<cfset this_keyval = right(idx,len(idx)-9)>
			<cfquery name="searchresult" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			    INSERT into saleCode_ProductId
				(
					SaleCode,
					ProductId
				)
				values
				(
					'#form.SaleCode#',
					#this_keyval#
				)
			</cfquery>
		</cfif>
	</cfloop>
	
	
<cfelseif isDefined('form.delete')>


	<cfquery name="qSales" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	    DELETE from sales
		WHERE pk_sales = #form.pk_sales#
	</cfquery>
	
	<cfquery name="qSalesCode" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	    DELETE from saleCode_ProductId
		WHERE SaleCode = '#form.SaleCode#'
	</cfquery>


</cfif>

<cflocation addtoken="No" url="salelink_search.cfm">