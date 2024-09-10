
<cfquery name="qSaleCode" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT * from sales
</CFQUERY>

	<SCRIPT LANGUAGE="JavaScript">
function CheckEntries(){
	if(document.searchFrm.pk_sales.value == "")

	{
		alert("Pleae select a Sales Code");
		return false;
	}
}
</SCRIPT>

<div style="text-align: center"><input type="Button" value="Back To Sales Menu" onclick="location.href='index.cfm?event=sales'"></div>
<table border="0" cellpadding="10" cellspacing="0" width="90%">
	<tr>
		<td valign="top"><br>
		<cfoutput>
			<FORM action="index.cfm?event=sales.salesiteCodeResults" method="post" name="searchFrm"  onsubmit="return CheckEntries()">
			
			<table border="0" cellpadding="10" cellspacing="0" width="250">
				<tr>
					<td colspan="2">
						<input type="Button" value="Create New Sale Link" onclick="location.href='index.cfm?event=sales.salelinkCreateSearch'">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<h3>SEARCH EXISTING SALE CODES:</h3>
					</td>
				</tr>
				<tr>
					<td width="40%" style="font-size: 9pt; padding-right: 10px;"><b>Sale Code:</b></td>
					<td width="60%">
						<select name="pk_sales">
							<option value="">Please Select</option>
							<cfloop query="getSales">
								<option value="#pk_sales#">#saleCode#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<Tr>
					<Td colspan="2" align="Center">
					<INPUT type="submit" value="Search">&nbsp;&nbsp;<input type="reset" value="Reset Values">
					</td>
				</tr>
			</table>
			</FORM>								
		</cfoutput>
		</td>	
	</tr>
</table>	
