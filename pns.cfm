<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
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
											<div class="policy-content">
													<cfoutput>
														<h4>PRIVACY AND SECURITY</h4>
														<p><b>Return Policy:</b> If you are not happy with your purchase, or the item is defective in any way, simply return the item to the address on the invoice within 14 days.  We will gladly exchange or refund the cost of the invoice and instructions as to what you would like us to do.  The item(s) must be in new condition, with all tags attached, and in the original packaging in which it was shipped.<br><br>
														
															Please do note that sale items are not refundable.<br><br>
															
															Please note:  in most cases we do not credit the original shipping charges.<br><br>
															
															
															<b>Privacy Statement:</b>  #companyname# tracks client information to make your online shopping experience the very best on the Internet. We respect your privacy, and we assure you that we will maintain and use this information responsibly.<br><br>  
															
															<b>General Browsing:</b> #companyname# gathers navigational information about where you go on our Web site. This information allows us to see which areas of #companyname# are most visited. This helps us improve the quality of visitors� online shopping experiences by recognizing and delivering more of the features, services and products our visitors prefer. Additional non-personally identifiable information (i.e. domain type, browser version, service provider and IP address) may be collected which will provide information regarding your use of our Web site (such as the time of your last visit to a page on our site).<br><br>  
															
															<b>Disclosure of Personal Information:</b> #companyname# does not sell, rent or trade your e-mail address to third parties. We may, however, use third parties to help us provide services to you, such as fulfilling orders, processing payments, monitoring site activity, conducting surveys, and administering e-mails, drawings or contests. If personally identifiable information (i.e. name, address, e-mail address, telephone number) is provided to any of these third parties, we will require that such information be maintained by them in strictest confidence.<br><br> 
															
															<b>Questions/Changes in Policy:</b> If you have questions or concerns with respect to our Privacy Policy, please feel free to contact us. If elements of our Privacy Policy change, we will post the policy changes in our Privacy Policy on this Web site. If you are concerned about how your personal information is used, please visit our site often for this and other important announcements about #companyname#.<br><br>  
															
															<b>Security Statement</b> #companyname# believes in providing a safe and secure shopping experience for all of our clients. We provide stringent and effective security measures on our Web site.<br><br> 
															
															It is our policy to never send private information, such as your credit card number, via e-mail. In fact, this is a practice we recommend you adopt in all of your Internet activities.<br><br> 
															
															We designed #companyname# to accept orders only from Web browsers that permit communication through Secure Socket Layer (SSL) technology; for example, 3.0 versions or higher of Netscape Navigator and versions 3.02 or higher of Internet Explorer. This means you'll be unable to inadvertently place an order through an unsecured connection.<br><br> </p>
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
			<cfinclude template="footer_.cfm">
		</td>
	</tr>
<cfinclude template="frmxss.cfm">

</body>
</html>