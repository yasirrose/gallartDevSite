<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT path FROM products
	group by path
	order by path
</CFQUERY>

<cfparam name="success" default="false">
<cfparam name="msg" default="">

<cfif isDefined('proc_pw')>

	<cfquery name="findUser" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT * from users
		where email = '#form.email#'
	</cfquery>
	
	<cfif findUser.recordcount>
		<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="#findUser.email#" from="onli16@onlinegalleryart.com" subject="Gallery Art Password Retrieval" type="HTML">
			<font style="font-size: 10pt; font-family: Arial;">
			Your Gallery Art Password is:
			<br><br>
			#findUser.password#
			<br><br>
			Please keep in a safe place.
			<br><br>
			Thank you from Gallery Art.
			</font>
		</cfmail>	

		<cfset success = "true" />		
		<cfset msg = "Your password has been emailed to you." />
		
	<cfelse>
	
		<cfset msg = "That email address is not in our system.  Please try again." />
	
	</cfif>

</cfif>

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
	<script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script>
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
			<div class="inner-section forget-password-screen">
				<div class="container-fluid">
					<div class="main-content">
						<div class="content-section">
							<div class="bottom-content-sec">
								<div class="banner-section">
									<div class="art-work-content">

										<div aria-label="breadcrumb">
											<ol class="breadcrumb">
											  <li class="breadcrumb-item"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;" >Home</a></li>
											  <li class="breadcrumb-item"><a href="user_registration.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;" >Sell Your Art</a></li>
											  <li class="breadcrumb-item active" aria-current="page">Forget Password</li>
											</ol>
										</div>

										<div class="bottom-content">
											<div class="user-registrations forgot-password">
												<div class="top-heading text-center">
													<h3>FORGOT PASSWORD</h3>
												</div>
												<cfoutput>
													<cfif success eq "false">
													
														<cfif len(msg)><strong>#msg#</strong></cfif>
														
														<form method="post" action="#script_name#">
															<div class="user-content text-center">
																<p>Enter your email address below, and we will email your password to you:</p>
																<div class="input-form">
																	<div class="input-field">
																		<input type="Text" name="email" size="40">
																	</div>
																	<div class="input-button">
																		<input type="Submit" value="Send My Password" class="SeeMore" name="proc_pw">
																	</div>
																</div>
															</div>
														</form>
														
													<cfelse>
													
														<cfif len(msg)><strong>#msg#</strong></cfif>
													
													</cfif>
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
	</div>
<tr>
	<td colspan="2" valign="baseline">
		<cfinclude template="footer_user.cfm">
	</td>
</tr>
<cfinclude template="frmxss.cfm">

</body>
</html>