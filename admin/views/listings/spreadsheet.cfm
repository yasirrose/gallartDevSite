



<!--- <cfform name="spreadsheetForm">

	<cfloop collection="#form#" item="idx">
		<cfif left(idx,'6') EQ 'SEARCH'>
			#idx#: <cfinput name="idx" type="text" value="#evaluate('form.'&idx)#"><br>
		</cfif>


	</cfloop> --->


<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/listings.js.cfm" language="JavaScript"></script>'>

<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td><input type="Button" value="Back To Search" onclick="javascript:self.history.go(-1);" /></td>
	</tr>
	<tr>
		<td valign="top" width="350">
			<cfform name="gridForm">
				<cfinput type="Hidden" name="searchModelno" value="#form.searchModelno#" />
				<cfinput type="Hidden" name="searchTitle" value="#form.searchTitle#" />
				<cfinput type="Hidden" name="searchArtist" value="#form.searchArtist#" />
				<cfinput type="Hidden" name="searchMedium" value="#form.searchMedium#" />
				<cfinput type="Hidden" name="searchYear" value="#form.searchYear#" />
				<cfinput type="Hidden" name="searchHeight" value="#form.searchHeight#">
				<cfinput type="Hidden" name="searchWidth" value="#form.searchWidth#">
				<cfinput type="Hidden" name="searchDescription" value="#form.searchDescription#" />
				<cfinput type="Hidden" name="searchFromPrice" value="#form.searchFromPrice#" />
				<cfinput type="Hidden" name="searchToPrice" value="#form.searchToPrice#" />
				<cfinput type="Hidden" name="searchFromDate" value="#form.searchFromDate#" />
				<cfinput type="Hidden" name="searchToDate" value="#form.searchToDate#" />
				<cfinput type="Hidden" name="searchFromLastedit" value="#form.searchFromLastedit#" />
				<cfinput type="Hidden" name="searchToLastedit" value="#form.searchToLastedit#" />
				<cfinput type="Hidden" name="searchSellerId" size="10" value="#form.searchSellerId#" />

				<cfinput type="Hidden" name="searchActive" value="#form.searchActive#" />
				<input type="Checkbox" name="searchOnSale" <cfif form.searchOnSale EQ 'on'>checked</cfif> style="display: none;">
				<input type="Hidden" name="searchOnSale">
				<input type="Checkbox" name="searchTrump" <cfif form.searchTrump EQ 'on'>checked</cfif> style="display: none;">
				<input type="Hidden" name="searchTrump">
				<input type="Checkbox" name="searchAuction" <cfif form.searchAuction EQ 'on'>checked</cfif> style="display: none;">
				<input type="Hidden" name="searchAuction">
				<input type="Checkbox" name="searchSlideshow" <cfif form.searchSlideshow EQ 'on'>checked</cfif> style="display: none;">
				<input type="Hidden" name="searchSlideshow">

				<cfgrid format="html" name="data" pagesize="250" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.art.getListings({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchSellerId},{searchModelno},{searchTitle},{searchArtist},{searchMedium},{searchYear},{searchHeight},{searchWidth},{searchDescription},{searchFromPrice},{searchToPrice},{searchFromDate},{searchToDate},{searchFromLastedit},{searchToLastedit},{searchOnSale},{searchTrump},{searchAuction},{searchSlideshow},{searchActive})">
					<cfgridcolumn name="modelno" header="Art ID" width="150" href="index.cfm?event=listings">
				    <cfgridcolumn name="name" header="Title" width="150">
					<cfgridcolumn name="manufacturer" header="Artist" width="150">
					<cfgridcolumn name="path" header="Medium" width="150">
					<cfgridcolumn name="retail_price" header="Retail Price" width="100">
					<cfgridcolumn name="gallery_price" header="Gallery Price" width="100">
					<cfgridcolumn name="Status" header="Status" width="75">
					<cfgridcolumn name="lasteditDate" header="Last Edited" width="100">
				</cfgrid>

			</cfform>
		</td>
	</tr>
</table>


