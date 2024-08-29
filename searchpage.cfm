<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" cachedwithin="#createTimespan(0,1,0,0)#">
    SELECT path FROM products
	WHERE fk_users is null
	group by path
	order by path
</CFQUERY>

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
						<cfinclude template="left_search.cfm">
					</td>
				</tr>
			</table>
		</td>
		<td valign="top" width="727" height="100%">
			<div align="center"><h2>SEARCH GALLERY ART</h2></div>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding-left: 10px; padding-top: 10px;">
						<h4>Simple Search</h4>
						Enter a keyword into the box below, and the system will find art that has that keyword in the title, description, or Artists' name.<br><br>
						<table border="0" cellspacing="0" cellpadding="0">
							<form action="products.cfm?xss=#xss#" method="post">
							<tr>
								<td>
									<input type="text" name="keywords" style="font-size: 7pt; width: 132px; font-family: verdana;">&nbsp;&nbsp;<input type="image" src="images/search.gif" style="border: none;">
								</td>
							</tr>
							</form>
						</table>
					</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px dotted #000000;">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td style="padding-left: 10px; padding-top: 10px;">
						<h4>Advanced Search</h4>
						Use the fields below for a more precise search:<br><br>
						<cfinclude template="advanced_search.cfm">
					</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px dotted #000000;">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td style="padding-left: 10px; padding-top: 10px;">
						<h4>Search our Gallery</h4>
						Use the dropdown below to search for art by Artist.  Simply select an Artist, and the system will take you to a page showing thumbnails of the pieces in our inventory by that Artist.<br><br>
						<cfinclude template="gallery_search.cfm">
					</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px dotted #000000;">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td style="padding-left: 10px; padding-top: 10px;">
						<h4>Search our Database</h4>
						Use the dropdown below to search by Artist.  When you select an Artist, you will be taken to a listing page of all of the art in our inventory by that Artist.  Click on any text to view details.<br><br>
						<cfinclude template="database_search.cfm">
					</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px dotted #000000;">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td style="padding: 10px 0px 20px 10px;">
						<h4>Alphabetical Search</h4>
						Click on a letter of the alphabet below to view art by Artists whose last name begins with that letter.  Then, click on the Artist's name to view art by that Artist.<br><br>
						<cfinclude template="alpha_search.cfm">
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