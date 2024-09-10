<cfset showOnPage = 8 />
<cfset records = getListingsByIdList.recordcount />
<cfset x = ceiling(records/showOnPage) />
	
<cfif records mod showOnPage EQ 0>
	<cfset pages = x />
<cfelse>
	<cfset pages = x />
</cfif>

	
<cfheader name="Content-Disposition" value="inline; filename=document.pdf"> 
<cfcontent type="application/x-pdf"> 

<cfdocument format="pdf" marginbottom="0" marginleft="0" marginright="0" margintop="0" localUrl="true">
<style>
	table {
		font-family:Verdana, Geneva, sans-serif;
		font-size: 11px;
	}
	
	.containerTd {
		padding: 8px 40px;	
	}
	
	td {
		padding: 0;
		margin: 0;
	}
	
	p {
		margin: 0;
		padding: 0;
		line-height: 14px;
	}
	
	.pricetagBucket {
		width: 300px;
		/*border: 1px solid #000000;*/
		text-align: center;
	}
	
	.imgContainer {
		margin-bottom: 5px;
		width: 300px;
	}
	
	.imgContainer div {
		float: left;
		width: 33%;
	}
	
	.imgContainer .gallartLogo {
		text-align: left;
	}
	
	.imgContainer .listingImage {
		text-align: center;
	}
	
	.resize{height:50px;width:auto;}
	.resize{height:auto;width:50px;}
	
	.last {margin-bottom: 1px; color: #FF0000;}
	
</style>

<cfset startLoop = 1 />
<cfset startRow = 1 />
<cfloop from="#startLoop#" to="#pages#" index="idx">
<table>
	<tr>
		<cfset num = 0 />
		 <cfoutput query="getListingsByIdList" startrow="#startRow#" maxrows="#showOnPage#">
		<td class="containerTd">
			<table class="pricetagBucket">
				<tr>
					<td>
						<div style="display: table; height: 225px; ##position: relative; overflow: hidden;">
							<div style=" ##position: absolute; ##top: 50%;display: table-cell; vertical-align: middle;">
								<div style="##position: relative; ##top: -50%">
									<div class="imgContainer">
										<div class="gallartLogo"><img src="../images/gallart.gif" /></div>
										<div class="listingImage"><img src="../img/thumbnails/#uid#.jpg" class="resize" height="50"  /></div>
										<div>&nbsp;</div>
									</div>
									<div style="clear: left;"></div>
									<p><strong>Title:</strong> #name#</p>
									<p><strong>Artist:</strong> #manufacturer#</p>
									<cfif isDefined('form.show_retail')><p><strong>Retail Price:</strong> #dollarFormat(retail_price)#</p></cfif>
									<cfif isDefined('form.show_gallery')><p><strong>Gallery Price:</strong> #dollarFormat(gallery_price)#</p></cfif>
									<cfif isDefined('form.show_sale')><p class="last"><strong>Sale Price:</strong> <cfif form.price_to_use EQ 'sale'>#dollarFormat(special_price)#<cfelseif form.price_to_use eq 'high estimate'>#dollarFormat(high_estimate)#</cfif></p></cfif>
								</div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</td>
		<cfset num = num + 1 />
		<cfif num mod 2 EQ 0></tr><tr></cfif>
	</cfoutput>
		
		</tr>
</table>
<cfif idx LT pages>
	<cfdocumentitem type="pagebreak" />
</cfif>
<cfset startRow = startRow + showOnPage />
</cfloop>

</cfdocument>