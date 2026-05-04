<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
<script language="JavaScript" src="/js/utils.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</cfoutput>

<cfquery name="getPages" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * from pages
	WHERE pk_pages = 7
</cfquery>

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
<!--- 						<div class="mobile-sidebar-logo"> 
							<div class="sidebar-Icon">
								<i class="fas fa-bars"></i>
							</div>
						</div>
						<div class="sidebar web-sidebar-modal">	
							<cfinclude template="left_.cfm">
						</div> --->
						<div class="content-section">
							<div class="bottom-content-sec">
								<div class="banner-section">
									<div class="art-work-content">

                              <div aria-label="breadcrumb">
                                 <ol class="breadcrumb">
                                   <li class="breadcrumb-item"><a href="/" style="color:black;" >Home</a></li>
                                   <li class="breadcrumb-item"><a href="/about-us" style="color:black;" >About</a></li>
                                   <li class="breadcrumb-item active" aria-current="page">Gallery Visit</li>
                                 </ol>
                              </div>

										<div class="bottom-content">
											<div class="user-registrations tour-page">
												<iframe src="https://www.google.com/maps/embed?pb=!1m0!3m2!1sen!2sus!4v1492464868769!6m8!1m7!1sF%3A-fMO_7LcEUrw%2FWPTJD1CX5II%2FAAAAAAAB0bo%2F1-_a1kMQCb4HzxhRZoXPPby9vPFETgo2ACLIB!2m2!1d25.96665145257!2d-80.144123006933!3f1.6610468872347925!4f-2.000650917306473!5f0.4000000000000002"  frameborder="0" style="border:0;" allowfullscreen></iframe>
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

</body>
</html>