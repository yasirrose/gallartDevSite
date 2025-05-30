<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT path FROM products
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
					<cfinclude template="navbar_user.cfm">
				</div>
			</div>
			<div class="inner-section">
				<div class="container-fluid">
					<div class="main-content pb-4">
						<div class="content-section">
								<div class="bottom-content-sec">
									<div class="banner-section">
										<div class="art-work-content">
											<div class="bottom-content">
												<div class="user-registrations quotes-page contact-page">
													<div class="top-heading">
														<cfif isDefined('process') and process EQ 'add'>
															<span style="color: #dd3a7d; padding-top: 25px; font-size: 13px; font-weight: bold;"><br>THANK YOU FOR ADDING YOUR LISTING TO OUR SITE!</span>
														</cfif>
														<h3>SELL YOUR ART ON GALLART.COM!</h3>
													</div>
													<p>Use this form to search for your listings by TITLE, ARTIST, MEDIUM, PRICE, OR DESCRIPTION:</p>
													<cfoutput>
														<FORM action="user_listing_results.cfm?xss=#xss#" method="post">
															<div class="input-form">
																<div class="input-field">
																	<label><b>Title:</b></label>
																	<input type="Text" name="name">
																</div>
																<div class="input-field">
																	<label><b>Artist:</b></label>
																	<input type="Text" name="manufacturer">
																</div>
																<div class="input-field">
																	<label><b>Medium:</b></label>
																	<SELECT name="path">
																			<option value="">All
																			<cfloop query="cats">
																				<option value="#path#">#ucase(path)#
																			
																		</cfloop>
																	</select>
																</div>
																<div class="input-field">
																	<label><b>Gallery Price:</b></label>
																	<input type="Text" name="gallery_price">
																</div>
																<div class="input-field">
																	<label><b>Keyword In Description:</b></label>
																	<input type="Text" name="caption">
																</div>
																<div class="input-button flex-input-btn">
																	<input type="submit" value="Search" name="search" class="SeeMore">
																	<input value="Reset" type="reset" class="SeeMore"/>
																	<input type="Button" class="SeeMore" onClick="javascript: window.location.href='user_listing_detail.cfm?xss=#xss#'" value="Enter New Lisitng" />
																</div>
															</div>
														</FORM>		
													</cfoutput>
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
			<div class="footer-section">
                <cfinclude template="footer_user.cfm">
            </div>
		</div>
	</div>

<cfinclude template="frmxss.cfm">

</body>
</html>