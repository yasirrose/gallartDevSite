<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
<script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>

<link href="stylesheet.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<cfquery name="searchresult" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT *
    FROM products
    WHERE (products.manufacturer like '#form.manufact#'
    <cfif form.manufact EQ 'MAX, PETER'>
    	OR products.manufacturer like 'MAX, PETER%')
   	<cfelse>
   		)
    </cfif>

	AND active = 1
	order by gallery_price desc
</CFQUERY>
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="100%" height="125" valign="top" bgcolor="#000000">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="100%" valign="top" height="37" bgcolor="#000000">
			<cfinclude template="navbar.cfm">
		</td>
	</tr>
	<tr height="100%">
		<td valign="top" width="173" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr height="100%">
					<td valign="top" height="100%">	
						<cfinclude template="left.cfm">
					</td>
				</tr>
			</table>
		</td>
		<td valign="top" width="727" height="100%" style="padding-top: 10px; padding-right: 10px;">
			<cfif SearchResult.recordcount>
			<cfoutput><strong>#SearchResult.recordcount# pieces found.</strong></cfoutput>
						<!--- CONTENT STARTS --->		
			<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<TR class="row0">
				<TD>Artist</TD>
				<TD>Medium</TD>
			    <TD>Size</TD>
			    <TD>Name of Piece</TD>
			    <TD COLSPAN="2" align="center">Gallery Price</TD>
			</TR>
			<CFOUTPUT query="SearchResult">
			<TR class="#this_row()#">
			 	<TD style="font-family: arial; font-size: 8pt;"><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#')">#manufacturer#</a></TD>
				<TD style="font-family: arial; font-size: 8pt;"><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#')">#replace(path,':','')#</a></TD>
				<TD style="font-family: arial; font-size: 8pt;"><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#')">#overview#</a></TD>
				<TD style="font-family: arial; font-size: 8pt;"><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#')">#name#</a></TD>
				<TD style="font-family: arial; font-size: 8pt;" align="right"><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#')">#dollarformat(gallery_price)#</a>&nbsp;&nbsp;&nbsp;</TD>
				<TD>&nbsp;</td>
			</TR>
			</CFOUTPUT>
			</TABLE>	
			<cfelse>
				Sorry, no results found.  Please try another search.
			</cfif>
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer.cfm">
		</td>
	</tr>
</table>

<cfinclude template="frmxss.cfm">

</body>
</html>