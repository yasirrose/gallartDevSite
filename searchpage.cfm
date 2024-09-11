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
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
<script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>

<link href="stylesheet_.css" rel="stylesheet" type="text/css">
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
	<div class="main-container registration-page">
		<div id="Table_01">
			<div class="header-section">
				<div class="top-header">
					<cfinclude template="top_.cfm">
				</div>
				<div class="navbar-section">
					<cfinclude template="navbar_.cfm">
				</div>
			</div>
			<div class="inner-section">
				<div class="container-fluid">
					<div class="main-content">
						<div class="mobile-sidebar-logo">
							<div class="sidebar-Icon">
								<i class="fas fa-bars"></i>
							</div>
						</div>
						<div class="sidebar web-sidebar-modal">	
							<cfinclude template="left_.cfm">
						</div>
						<div class="content-section">
							<div class="bottom-content-sec">
								<div class="banner-section">
									<div class="art-work-content">
										<div class="bottom-content">
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
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer_.cfm">
		</td>
	</tr>

<cfinclude template="frmxss.cfm">

</body>
</html>