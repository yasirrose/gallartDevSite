
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
<script type="text/javascript" src="/js/jquery-1.2.6.min.js"></script>
<script language="JavaScript" src="/js/utils.js"></script>
</cfoutput>

<link href="/stylesheet_.css" rel="stylesheet" type="text/css">
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
						<!--- <div class="sidebar web-sidebar-modal">	
							<cfinclude template="left_.cfm">
						</div> --->
						<div class="content-section">
							<div class="bottom-content-sec">
								<div class="banner-section">
									<div class="art-work-content">

										<div aria-label="breadcrumb">
											<ol class="breadcrumb">
											  <li class="breadcrumb-item"><a href="/" style="color:black;" >Home</a></li>
											  <li class="breadcrumb-item active" aria-current="page">Home Artists</li>
											</ol>
										</div>

										<div class="bottom-content banner-content p-0 m-0">
											<div class="user-registrations searchpage-sec">
												<div class="content-sec" style="margin: 0 auto 30px;">
													<!--- <cfinclude template="search.cfm"> --->
													<div class="search-form-group">
														<div class="top-content new-top-content">
															<h4><b>Browse <i>Artists</i> by Name</b></h4>
														</div>
														<form name="dropdown">
															
															<cfoutput>
																<div class="alpha-row">
																	<cfloop from="65" to="90" index="idx">
																		<cfset currentLetter = chr(idx)>
																		<div>
																			<a href="/alpha_list/#currentLetter#"
																				class="alpha <cfif currentLetter EQ url.man>active</cfif>">
																				#currentLetter#
																			</a>
																		</div>
																	</cfloop>
																</div>
															</cfoutput>
														</form>
														
													</div>
												</div>
												<div class="searchalpha-listing">
													<cfquery name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
														SELECT distinct manufacturer,artist,producturl, LOWER(P.manufacturer) AS lower_manufacturer  
														FROM products P
														LEFT OUTER JOIN highlighted_artists HL on P.manufacturer = HL.artist
														WHERE manufacturer like '#man#%' 
														AND active = 1 
														AND (path <> '') 
														AND (path IS NOT NULL)
														<!--- AND fk_users is null --->
														ORDER BY lower_manufacturer 
													</cfquery>
													<!--- <cfif man EQ "M">
														<cfset temp = QueryAddRow(data)>
														<cfset temp = QuerySetCell(data, "manufacturer", "MAX, PETER")> 
													</cfif> --->
													<cfquery dbtype="query" name="alpha_info">
														select *
														from data
														ORDER BY lower_manufacturer
													</cfquery>

													<!--- <cfdump var="#alpha_info#" > --->

													<cfif alpha_info.recordcount>
														<!--- <h4><strong>Artists whose name begins with <cfoutput>#man#</cfoutput></strong>&nbsp;(Click artist's name to view art):</h4> --->
														<div class="aloha-list">
															<ul>
																<cfoutput query="alpha_info">
																	<li>
																		<a href="/artists/#URLEncodedFormat(producturl)#">

																			<!--- <cfset capitalize_artistName = REReplace(manufacturer, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")> --->

																			<cfif len(artist) OR manufacturer EQ 'MAX, PETER'>
																				<span style="color: ##ff0000; font-size: 14px;">
																					#manufacturer#
																					<!--- <cfif manufacturer EQ 'MAX, PETER'> (ALL)</cfif> --->
																				</span>
																			<cfelse>
																				#manufacturer#
																			</cfif>
																		</a>
																	</li>
																</cfoutput>
															</ul>
														</div>
													<cfelse>
														<strong>There are no artists in our database whose name begins with <cfoutput>#man#</cfoutput>.  <br>Please try another search.</strong>
													</cfif>
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
		</div>
	</div>
<tr>
	<td colspan="2" valign="baseline">
		<cfinclude template="footer_.cfm">
	</td>
</tr>
<cfinclude template="frmxss.cfm">

<style>
	.main-content .mobile-sidebar-logo .sidebar-Icon{
		display: none;
	}

	.alpha {
  text-decoration: none;
  padding-bottom: 5px;
}

.alpha.active {
  border-bottom: 2px solid black; /* Underline effect */
  color: red; /* Optional: Highlight the active letter in a different color */
}
.new-top-content {
	margin-bottom: 40px;
}
.new-top-content h4 {
	font-size: 34px;
    font-weight: 300;
    font-family: 'Font Awesome 5 Brands';
    margin-bottom: 0;
}
</style>

</body>
</html>
