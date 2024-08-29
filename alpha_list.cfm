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
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-34565365-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<!-- BEGIN ROBLY WIDGET CODE -->
<script type='text/javascript'>
  var _d_site = _d_site || 'ebb8c5f7da7077e127988b3276107648';
  (function(w, d, p, s, s2) {
    w[p] = w[p] || function() { (w[p].q = w[p].q || []).push(arguments) };
    s = d.createElement('script'); s.async = 1; s.src = '//s3.amazonaws.com/roblyimages/accounts/20559/forms/29541/signup_popup.js';
    s2 = d.getElementsByTagName('script')[0]; s2.parentNode.insertBefore(s, s2);
  })(window, document, 'Robly');
</script>
<!-- END ROBLY WIDGET CODE -->

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
		<td valign="top" width="727" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td valign="top">	
						<cfinclude template="search.cfm">
					</td>
				</tr>
				<tr height="100%">
					<td height="100%" valign="top" style="padding-left: 20px;">	
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<cfquery name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
									SELECT distinct manufacturer,artist 
									FROM products P
									LEFT OUTER JOIN highlighted_artists HL on P.manufacturer = HL.artist
									WHERE manufacturer like '#man#%' 
									AND active = 1 
									AND (path <> '') 
									AND (path IS NOT NULL)
									<!--- AND fk_users is null --->
									ORDER BY manufacturer 
								</cfquery>
								<!--- <cfif man EQ "M">
									<cfset temp = QueryAddRow(data)>
									<cfset temp = QuerySetCell(data, "manufacturer", "MAX, PETER")> 
								</cfif> --->
								<cfquery dbtype="query" name="alpha_info">
									select *
									from data
									ORDER BY manufacturer
								</cfquery>
							<tr>
								<td style="color: #db3a7d;">
								<cfif alpha_info.recordcount>
									<strong>Artists whose name begins with <cfoutput>#man#</cfoutput></strong>&nbsp;(Click artist's name to view art):<br>
									
									<table border=0 cellpadding=3 cellspacing=3 width="100%">
										<tr>
											<td valign="top">
												<table border=0 cellpadding=0 cellspacing=2>
													<cfoutput query="alpha_info">
														<!--- <cfquery name="thumb" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
															SELECT top 1 uid from products
															WHERE manufacturer = '#manufacturer#'
															order by datestamp desc
														</cfquery> --->
													<tr>
														<td>
														<a href="products.cfm?man=#manufacturer#<cfif parameterexists(xss)>&xss=#xss#</cfif>">
															<cfif len(artist) OR manufacturer EQ 'MAX, PETER'>
																<span style="color: ##ff0000; font-size: 12px;">
																	#ucase(manufacturer)#
																	<cfif manufacturer EQ 'MAX, PETER'> (ALL)</cfif>
																</span>
															<cfelse>
																#ucase(manufacturer)#
															</cfif>
														</a>
														</td>
														<!---<td>
															<img src="http://3.235.23.60/img/thumbnails/#thumb.uid#.jpg" border="0" width="75">
														</td>--->
													</tr>
													</cfoutput>
												</table>
											</td>
										</tr>
									</table>
								<cfelse>
									<strong>There are no artists in our database whose name begins with <cfoutput>#man#</cfoutput>.  <br>Please try another search.</strong>
								</cfif>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
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
