<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<cfset searchString = ''>

<cfsavecontent variable="queryString">
	
<cfoutput>
	0=0
	<cfif IsDefined('form.modelno') and len(trim(form.modelno))>
		and modelno like '%#form.modelno#%'
	</cfif>
	<cfif IsDefined('form.name') and len(trim(form.name))>
		and name like '%#form.name#%'
	</cfif>
	<cfif IsDefined('form.manufacturer') and len(trim(form.manufacturer))>
		and manufacturer like '%#form.manufacturer#%'
	</cfif>
	<cfif IsDefined('form.path') and len(trim(form.path))>
		and path = '#form.path#'
	</cfif>
	<cfif IsDefined('form.sale_price') and len(form.sale_price) and form.sale_price neq 0>
		and sale_price = '#trim(numberformat(replace(form.sale_price,',','','all'),99999999999.99))#'
	</cfif>
	<cfif IsDefined('form.sale_price') and form.sale_price eq 0>
		and sale_price = '0'
	</cfif>
	<cfif IsDefined('form.caption') and len(trim(form.caption))>
		and caption like '%#form.caption#%'
	</cfif>
	<cfif IsDefined('form.caption') and len(trim(form.caption))>
		and caption like '%#form.caption#%'
	</cfif>
	<cfif IsDefined('form.fk_users') and len(trim(form.fk_users))>
		<cfif form.fk_users eq 0>
		 	and fk_users is not null
		<cfelseif form.fk_users gt 0>
			and fk_users = #form.fk_users#
		</cfif>
	</cfif>
</cfoutput>

</cfsavecontent>




<cfquery name="searchresult" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT *
    FROM products
    WHERE #PreserveSingleQuotes(queryString)#
	AND active = 1
</CFQUERY>

<cfquery name="artists" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT distinct manufacturer FROM products
	order by manufacturer
</CFQUERY>
<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT path FROM products
	group by path
	order by path
</CFQUERY>


<html>
<head>
	<title>Filtered Product List</title>
	<script LANGUAGE="javascript">
<!--
function goxss(url){
	document.frmxss.action = url;
	document.frmxss.submit();
}
function popUpWin(urlPage){
	var features =	'scrollbars=yes, toolbar=yes, status=yes, menubar=yes,' +
					'resizable=yes, location=yes, directories=yes,' +
					'left=100, top=100, width=640, height=480';

	myWin =	window.open(urlPage,'WinName',features);
}
-->
</script>
<link href="../stylesheetadmin.css" rel="stylesheet" type="text/css">
	
</head>

<body bgcolor="ffffff" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">

<table border="0" cellpadding="0" cellspacing="0" width="800">
<!--- TOP INCLUDE STARTS --->
	<tr>
		<td align="center" colspan="2" bgcolor="#333333" height="25" style="font-weight: bold; font-size: 10pt; color: #ffffff;">
			NUMBER OF RECORDS FOUND: <cfoutput>#SearchResult.recordcount#</cfoutput>
		</td>
	</tr>
<!--- TOP INCLUDE ENDS, CONTENT AREA STARTS --->
	<tr>
<!--- side include ends, content starts --->			
		<td colspan="2" valign="top">
<!--- CONTENT STARTS --->		
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="500">
				<tr>
					<td align="center" height="10">
						<form>
							<input type="button" value="Back to Search" onclick="javascript:self.history.go(-1);">
						</form>
					</td>
				</tr>
				<tr>
					<td width="100%" align="center" valign="top" colspan="2">
						<cfif searchresult.recordcount>
						<cfform method="post" action="salelink_proc.cfm">
						<input type="Hidden" name="queryString" value="<cfoutput>#queryString#</cfoutput>">
						<table border=0 cellpadding=2 cellspacing=0 width="98%" align="center">
							<tr>
								<td nowrap>
									<strong>Sale Code:</strong>
								</td>
								<td>
									<cfinput type="text" name="saleCode" size="10" required="Yes" message="You must enter a Sale Code">
								</td>
								<td nowrap>
									<strong>Percentage of Gallery Price:</strong>
								</td>
								<td>
									<cfinput type="text" name="percentMarkdown" size="2" validate="integer" required="Yes" message="You must enter an integer as the Percent Markdown.">%
								</td>
								<td colspan="4" align="right">
									<input type="Submit" value="Create Sale Link" name="new">
								</td>
							</tr>
							<tr class="row0">
							    <td>
									Model#
								</td>
								<td>
									Artist
								</td>
								<td>
									Medium
								</td>
							    <td>
									Name of Piece
								</td>
								<td>
									Retail Price
								</td>
							    <td>
									Gallery Price
								</td>
								 <td>
									Sale Price
								</td>
							    <td>
									Use Sale Price
								</td>
							</tr>
							<cfoutput query="SearchResult">
							<cfset this_manufacturer = manufacturer />
							<cfset this_path = path />
							<tr class="#this_row()#">
								<td>
									#modelno#
								</td>
							 	<td>
									#manufacturer#									
								</td>
								<td>
									#path#
								</td>
								<td>
									#name#
								</td>
								<td nowrap>
									$#price#		 	
								</td>
								<td nowrap>
									$#sale_price#
								</td>
								<td nowrap>
									$#closeout_price#
								</td>
								<td>
									<input type="Checkbox" name="salelink_#uid#" value="1">
								</td>
							</tr>
							</cfoutput>
							</cfform>
						</table>			
						<cfelse>
						No Results Found
						</cfif>	
						<br><br><br><br><br>										
					</td>
				</tr>	
		</table>
<!--- CONTENT ENDS --->				
		</td>
	</tr>
</table>

</body>
</html>



