<table border="0" cellpadding="0" cellspacing="0" width="100%" height="500">
	<tr>
		<td colspan="2">
			<form>
				<input type="button" value="Back to Manage Sale Prices" onclick="location.href='index.cfm?event=sales.saleSearch'">
			</form>
		</td>
	</tr>
	<form method="post" action="index.cfm?event=sales.setAllSalePricesProc">
	<tr>
		<td width="100%" valign="top" colspan="2">
			<table>
				<tr>
					<td>
						<strong>SET SALE PRICES FOR ALL LISTINGS</strong><br />
						<ul>
							<li>
								Enter percentage to be used as discount: <input type="text" name="salePercent" id="salePercent" size="2">%
							</li>
                            <li>
								Enter which price will be used for the discount: Retail Price<input type="radio" name="priceToReduce" value="retail" />&nbsp;&nbsp;Gallery Price<input type="radio" name="priceToReduce" value="gallery" checked="checked" />
							</li>
                            <li>
								Or, use high estimate for sales price: <input type="checkbox" name="highEstimate" id="highEstimate" value="1" size="2">
							</li>
                            <li style="margin-top: 20px;">
								Or, check here to REMOVE all sale prices: <input type="checkbox" name="removeSale" id="removeSale" value="1" size="2">
							</li>
                            <li style="margin-top: 20px;">
								Click this button to set sale prices for entire database: <input type="submit" value="SET SALE PRICES" />
								
							</li>
						</ul>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	</form>
</table>