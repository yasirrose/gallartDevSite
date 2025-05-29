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
<script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script>
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
						<!--- <div class="sidebar web-sidebar-modal">	
							<cfinclude template="left_.cfm">
						</div> --->
						<div class="content-section">
							<div class="bottom-content-sec">
								<div class="banner-section">
									<div class="art-work-content">

										<div aria-label="breadcrumb">
											<ol class="breadcrumb">
											  <li class="breadcrumb-item"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;" >Home</a></li>
											  <li class="breadcrumb-item active" aria-current="page">Terms of Use</li>
											</ol>
										</div>

										<div class="bottom-content">
											<div class="policy-content">
												<div class="top-heading text-left">
													<cfoutput>
														<p>
															Welcome to <b><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>">Gallery Art</a></b>. Our services and products are provided subject to the following terms and conditions. By using the website, you agree to be bound by these terms and conditions. Please read them carefully, as they contain important provisions relating to your use of the site.
														</p>

														<h3>I. Privacy</h3>
														<p>Please review our <b><a href="pns.cfm?xss=<cfoutput>#xss#</cfoutput>" >Privacy Policy</a></b> to understand our privacy practices.</p>

														<h3>II. Terms of Use</h3>
														<p>
															License and Website Access <br><br>

															We grant you a limited, revocable license to access and make personal use of the website as our customer. However, you are not permitted to:
														</p>

															<ul>
																<li>
																	reproduce, duplicate, copy, sell or otherwise exploit the website or any product image, product listing, product description, price, page layout, page design, trade dress, trademark, logo or other content ("Website Content") for any commercial purpose, except as expressly provided;
																</li>
																<li>
																	use a robot, spider or data mining or extraction tool or process to monitor, extract or copy Website Content (except in the operation or use of internet "search engines," hit counters or similar technology);
																</li>
																<li>
																	use any meta tags, search terms, key terms, or the like that contain the website’s name or trademarks used on the website;
																</li>
																<li>
																	engage in any activity that interferes with the website or another user’s ability to use the website;
																</li>
																<li>
																	modify, create derivative works from, reverse engineer, decompile or disassemble any technology used to provide the website and the services offered on the website; or
																</li>
																<li>
																	assist or encourage any third party in engaging in any activity prohibited by these Terms of Use.
																</li>
															</ul>

															<p>
																Any use of the website or Website Content that is not expressly authorized herein is prohibited and immediately terminates the license granted herein.
															</p>

														<h4>Electronic Communications</h4>

														<p>
															You consent to receive communications from us by e-mail. You agree that all agreements, notices, disclosures and other communications that we provide to you by e-mail satisfy any legal requirement that such communications be in writing.
															<br><br>
															If you opt in to receive SMS (text messages) from <b><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>">Gallery Art</a></b> (as/when available), or use a mobile application, the following additional terms and conditions ("Mobile Terms") also apply to you. Your access to the Sites via your mobile device or use of a mobile application confirms your agreement to these Mobile Terms, as well as the rest of the Terms and Conditions.
															<br><br>
															By opting in, you agree to receive promotional SMS text messages on your mobile device. Your consent is not required as a condition of purchasing any goods or services from RoGallery. By agreeing to receive SMS messages from RoGallery, you certify that you are over 18 years of age and (a) you are the mobile account holder or (b) you have the account holder’s permission to enroll the designated mobile phone number and can incur any mobile message or data charges. You agree that you are solely responsible for all message and data charges that apply to use of your mobile device to access the Sites or use of a mobile application. All such charges are billed by and payable to your mobile service provider. Please contact your participating mobile service provider for pricing plans, participation status and details. You understand that wireless through Wi-Fi or a participating mobile service provider may not be available in all areas at all times and may be affected by product, software, coverage or other service changes made by your mobile service provider or otherwise. Additional terms and conditions may apply to your use of a mobile application, based on the type of mobile device on which you install and use the mobile application. You can opt out of receiving SMS messages at any time.

														</p>

														<h4>Your Account</h4>

														<p>
															If you use the website, you are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer, and you agree to accept responsibility for all activities that occur under your account or password. We reserve the right to refuse service, terminate accounts, remove or edit content, or cancel orders at our sole discretion.
														</p>

														<h4>Copyright</h4>

														<p>
															All Website Content is our property or the property of our content suppliers and is protected by international copyright laws. The purchase of any product does not provide the purchaser with any copyright interest or other intellectual property right in the product. All Website Content that is not our property is used with permission. The arrangement and compilation of all Website Content is our exclusive property and is protected by international copyright laws. All software used on the website is our property or the property of our software suppliers and is protected by international copyright laws.
														</p>

														<h4>Trademarks</h4>

														<p>
															Certain graphics, logos, page headers, button icons, scripts, and service names are trademarks, service marks, or trade dress of our company or our affiliated companies. Our trademarks and trade dress may not be used for any commercial or other purposes without our prior written consent. All other trademarks and service marks not owned by <b><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>">Gallery Art</a></b> or our affiliated companies that appear on the website are the property of their respective owners and may or may not be used without their prior written consent.
														</p>

														<h4>Copyright & Trademark Compliance; Complaints</h4>

														<p>
															We honor the intellectual property rights of others. If you believe that your work has been copied or used on the website in a way that constitutes copyright or trademark infringement, please notify us by following the procedure set forth in the immediately following paragraph. Except in limited instances under authorized agreements, we do not reproduce or manufacture the products offered on our site, but rather we purchase or license products from third party suppliers that represent to us that they have sufficient rights to allow us to display and sell the products on the website. Upon receipt of any bona fide claim of infringement, or upon becoming aware of any actual or alleged infringement by any other means, we will remove such actual or alleged infringing product(s) from the website and/or cease sales of the product(s) pending our investigation.
														</p>

														<h4>Reviews, Comments, Communications and Other Content</h4>

														<p>
															Visitors may post or submit reviews, comments, suggestions, communications and other information via our website, by email or through one of our website operation partners, or social media channels. You agree not to submit, transmit, or otherwise make available in any manner any content (i) that is unlawful, harmful, obscene, hateful, threatening, abusive, defamatory, harassing, libelous, invasive of another's privacy, or is otherwise objectionable, (ii) that infringes the intellectual property rights of any party or (iii) which contains a chain letter or constitutes any form of commercial solicitation, political campaign, mass mailing, "spam" or software virus. You may not use a false e-mail address or otherwise provide information that would be misleading as to the origin of such content. Although we do not regularly review content you submit, we reserve the right to edit or remove any content that we find objectionable for any reason. You represent and warrant that you possess all necessary rights to use the content that you submit and that use of such content does not violate generally accepted standards of decency. You agree to defend, indemnify, and hold us harmless from and against any and all claims arising out of or relating to any content that you submit. By submitting content, you automatically grant to us, or warrant that the owner of such content has expressly granted to us, a royalty-free, perpetual, irrevocable, worldwide, unlimited, nonexclusive right and license to use, reproduce, create derivative works from, modify, publish, edit, translate, distribute, perform and display your user name or the content in any media, form, format, manner or forum now known or hereafter developed without compensation to you. We take no responsibility and assume no liability for any content posted by visitors to our website.
														</p>

														<h4>Third Party Links and/or Services</h4>

														<p>
															
															The website may contain links to or services offered by third parties that are not under the control of <b><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>">Gallery Art</a></b> (“Third Party Services”). Any such Third Party Services are provided for your convenience only and you access them at your own risk. Any concerns regarding such Third Party Service should be directed to the particular outside service.

														</p>

														<h4>Limitation of Liability</h4>

														<p>
															
															We do not accept responsibility that the website, its servers, or e-mail sent from the website are free of viruses or other harmful components. We will not be liable for any damages of any kind arising from the use of the website, including, but not limited to direct, indirect, incidental, punitive or consequential damages. Certain laws do not allow limitations as contained in this clause. If these laws apply, some or all of the above limitations may not apply to you and you might have additional rights.

														</p>

														<h3>III. Terms of Sale</h3>

														<p>
															
															These Terms of Sale apply to all offers made by <b><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>">Gallery Art</a></b>, all purchases and orders placed by you and all agreements concluded between us in relation to the products and services offered on this website.

														</p>

														<h4>Return Rights</h4>

														<p>
															
															We are committed to quality products and your satisfaction is 100% guaranteed.
															<br><br>
															If for any reason you are not completely satisfied with your purchase, you may return it within 14 days of receipt. For a complete refund, notify us of the return, send tracking information and please ship back to us in all original packing materials. Shipping charges will not be refunded.
															<br><br>
															If your order should arrive in less than satisfactory condition, we will need to file a claim with the shipping company. Simply take a digital photo of the item and one of the shipping container it arrived in, attach them to an email and send to <b><a href="contact.cfm?xss=#xss#"> info@gallart.com</a></b>  . Please include in the body of the email: your order number, the artist and title, a brief description of the reason for the return, and let us know whether you are seeking a replacement or a refund. Your request will be processed within 48 hours and you will receive an email letting you know your replacement is under production or your refund is being processed.
															<br><br>
															To return your item(s) please pack them in the original tube or box and include the completed Be sure to specify the reason for the return and what action you would like us to take: replacement or refund. We strongly encourage you to return your item via a trackable method.

														</p>

														<h4>Pricing</h4>

														<p>
															
															Notwithstanding the product prices shown on the website, we cannot confirm the price of an item until you order. Despite our best efforts, a small number of the items shown on the website may be mispriced as a result of price changes that are implemented at or about the time of your visit to the website. However, we do NOT charge your credit card until after your order has entered the shipping process. If an item’s correct price is higher than our stated price, your sole recourse is cancellation of your order.

														</p>

														<h4>Edition Numbers</h4>

														<p>
															
															Similar to pricing above, the edition numbers shown on signed and numbered graphics (prints) on the website are sometimes examples and not the exact edition number you will receive when sold. If you are hoping for a specific number, please let us know immediately after placing the order so we can do our best to meet your request. Typically there is no difference in value between one number and another in a printed edition.

														</p>

														<h4>Acceptance of Order</h4>

														<p>
															
															We reserve the right to refuse or cancel any order. In such an event your sole recourse shall be the return of amounts paid by you related to such order (if any).

														</p>

														<h4>Sales Tax</h4>

														<p>
															
															Items picked up at the gallery and shipped in the state of Florida are always subject to sales tax, with new sales tax nexus laws in place sales tax may be applied to your order if we have reached the nexus threshold in your state.

														</p>

														<h4>Product Descriptions</h4>
														<p>
															
															We attempt to describe our products offered as accurately as possible. However, we do not warrant that product descriptions or other content of the website are 100% accurate, complete, reliable, current or error-free. If a product offered by us and purchased by you is not as described, your sole remedy is to return it in unused condition for a conforming replacement, refund or credit.


														</p>

														<h4>Disclaimer</h4>
														<p>
															
														We are not liable for any financial damage (including but not limited to the cost of any replacement purchase) that may occur because of non-timely arrival or any lack of availability or conformity of the product.
														</p>

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
	</div>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer_.cfm">
		</td>
	</tr>
<cfinclude template="frmxss.cfm">

<style>
	ul{
		line-height: 20px;
	}
	h4{
		color: #EC008C;
	}
</style>

</body>
</html>