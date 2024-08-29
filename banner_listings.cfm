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
<cfparam name="url.listing" default="" />
<cfparam name="art_Type" default="" />
<cfswitch expression="#url.listing#"> 
	<cfcase value="popart"> 
		<cfset art_Type= 'Pop Art'>
	</cfcase> 
	<cfcase value="ArtDeco"> 
		<cfset art_Type= 'Art Deco'>
	</cfcase> 
	<cfcase value="Cubism"> 
		<cfset art_Type= 'Cubism'>
	</cfcase> 
	<cfcase value="urbanart"> 
		<cfset art_Type= 'Urban Art'>
	</cfcase> 
	<cfcase value="abstract"> 
		<cfset art_Type= 'Abstract'>
	</cfcase> 
	<cfcase value="Contemporary"> 
		<cfset art_Type= 'Contemporary Art'>
	</cfcase> 
	<cfcase value="Realism"> 
		<cfset art_Type= 'Realism'>
	</cfcase> 
	<cfcase value="Surrealism"> 
		<cfset art_Type= 'Surrealism'>
	</cfcase> 
	<cfcase value="Figurative"> 
		<cfset art_Type= 'Figurative'>
	</cfcase> 
</cfswitch>
<!--- getting artist list  --->
<cfquery name="Artist_by_art_type" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT DISTINCT manufacturer FROM products
	WHERE ',' + artType + ',' LIKE '%,#art_Type#,%'
</cfquery>
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
		<td valign="top" width="727" height="100%" style="padding: 20px 0;">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td valign="top">
						<div style="font-weight: bold; font-size: 16px; padding: 10px 0;">Browse By Category:</div>
					<cfoutput>	
						<table id="Table_01" width="1000" height="205" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<a href="./banner_listings.cfm?listing=popart<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/pop_art.jpg" width="152" height="205" alt="" border="0"></a></td>
								<td>
									<img src="/images/banner_listings/banner_listings_02.jpg" width="22" height="205" alt=""></td>
								<td>
									<a href="./banner_listings.cfm?listing=ArtDeco<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/traditional.jpg" width="150" height="205" alt=""></a></td>
								<td>
									<img src="/images/banner_listings/banner_listings_04.jpg" width="22" height="205" alt=""></td>
								<td>
									<a href="./banner_listings.cfm?listing=Contemporary<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/modern_masters.jpg" width="151" height="205" alt=""></a></td>
								<td>
									<img src="/images/banner_listings/banner_listings_06.jpg" width="21" height="205" alt=""></td>
								<td>
									<a href="./banner_listings.cfm?listing=urbanart<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/urban_art.jpg" width="144" height="205" alt=""></a></td>
								<td>
									<img src="/images/banner_listings/banner_listings_08.jpg" width="21" height="205" alt=""></td>
								<td>
									<a href="./banner_listings.cfm?listing=abstract<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/abstract.jpg" width="151" height="205" alt=""></a></td>
								<td>
									<img src="/images/banner_listings/banner_listings_08.jpg" width="22" height="205" alt=""></td>
								<td>
									<a href="./banner_listings.cfm?listing=Cubism<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/urban_art.jpg" width="144" height="205" alt=""></a></td>
								<td>
									<img src="/images/banner_listings/banner_listings_08.jpg" width="22" height="205" alt=""></td>
								<td>
									<a href="./banner_listings.cfm?listing=Surrealism<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/latin_american.jpg" width="154" height="205" alt=""></a></td>
							</tr>
							<tr>
								<td>
									<a href="./banner_listings.cfm?listing=Realism<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/urban_art.jpg" width="144" height="205" alt=""></a></td>
								<td>
									<a href="./banner_listings.cfm?listing=Figurative<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/urban_art.jpg" width="144" height="205" alt=""></a></td>
								
							</tr>
						</table>
					</cfoutput>
					</td>
				</tr>
				<tr height="100%">
					<td height="100%" valign="top" style="padding: 20px 0;">	
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td style="color: #db3a7d;">
									<h2 style="text-transform: uppercase;">
									<cfoutput>
										#art_Type#
									</cfoutput>
									</h2>
									<cfif url.listing NEQ "">
										<div style="font-weight: bold; font-size: 14px;">Click artist's name to view art:</div>
										<cfset artists = expandPath("/banner_listings/#url.listing#.txt")>
										<table border=0 cellpadding=3 cellspacing=3 width="100%">
											<cfif Artist_by_art_type.recordCount gt 0>
												<cfoutput query="Artist_by_art_type">
													<tr>
														<td valign="top">
															<cfif manufacturer EQ "RAE" OR manufacturer EQ "SEEN">
																<a style="font-size: 14px;" href="products.cfm?man=#manufacturer#<cfif parameterexists(xss)>&xss=#xss#</cfif>">#ucase(manufacturer)#</a>
															<cfelse>
																<a style="font-size: 14px;" href="products.cfm?keywords=#manufacturer#<cfif parameterexists(xss)>&xss=#xss#</cfif>">#ucase(manufacturer)#</a>
															</cfif>
														</td>
													</tr>
												</cfoutput>
											<cfelse>
												<p>No Artist found for the specified art category.</p>
											</cfif>
										</table>
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





