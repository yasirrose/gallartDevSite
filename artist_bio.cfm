<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="getBio" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT * from bios
	WHERE 0=0 <cfif isDefined('url.bioid') > and pk_bios = #url.bioId# </cfif>
</cfquery>


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

	</head>
	<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<cfoutput>
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
												<div class="bottom-content">
													<div class="top-heading m-0">
														<div class="bio-content" style="text-align: left;">
															#getBio.bio#														
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
			</div>
			<tr>
				<td colspan="2" valign="baseline">
					<cfinclude template="footer_.cfm">
				</td>
			</tr>
		</cfoutput>
		<cfinclude template="frmxss.cfm">

		<style>
			.bio-content img {
				float: left;
				margin-right: 20px;
				height: auto;
				max-width: 250px;
			}

			/* ✅ FORCE LEFT ALIGN for text only */
			.bio-content p,
			.bio-content div,
			.bio-content span {
				text-align: left !important;
			}

			/* ✅ IMAGE-ONLY BIOS */
			.bio-content.only-image img {
				float: none;
				margin-right: 0;
				max-width: 100% !important;
				display: block;
			}
		</style>


		<script>
			document.addEventListener("DOMContentLoaded", function () {
				var bio = document.querySelector(".bio-content");
				if (!bio) return;

				// remove whitespace + nbsp
				var text = bio.textContent.replace(/\u00A0/g, '').trim();
				var images = bio.querySelectorAll("img");

				// ✅ only image present
				if (images.length === 1 && text.length === 0) {
					bio.classList.add("only-image");
				}
			});

			function toggleBio() {
				
				var preview = document.getElementById('bio-preview');
				var button = document.getElementById('toggle-btn');
			
				// Toggle between showing truncated and full content
				if (preview.classList.contains('expanded')) {
					// If currently showing full content, collapse it
					preview.classList.remove('expanded');
					button.innerText = 'Show More'; // Change the button text
				} else {
					// If currently showing truncated content, expand it
					preview.classList.add('expanded');
					button.innerText = 'Show Less';  // Change the button text
				}
			}
		</script>

	</body>
</html>