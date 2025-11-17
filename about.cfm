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
			<link rel="stylesheet" type="text/css" href="/stylesheet_.css">
			<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
			<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
			<!--- <script type="text/javascript" src="/js/jquery-1.2.6.min.js"></script> --->
			<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
			<script language="JavaScript" src="/js/utils.js"></script>
		</cfoutput>
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
												<li class="breadcrumb-item"><a href="home" style="color:black;" >Home</a></li>
												<li class="breadcrumb-item active" aria-current="page">About</li>
												</ol>
											</div>

											<div class="bottom-content">
												<div class="user-registrations">
													<div class="row">
														<div class="col-md-7">
															<div class="policy-content">
																<div class="top-heading text-left">
																	<cfoutput>
																		<h3>About Us</h3>
																		<p>Gallery Art is an 8,000 Sq. Ft. internationally recognized go-to gallery, conveniently located in Aventura, halfway between the Miami and Fort Lauderdale airports. Whether you are buying or selling fine art, Gallery Art’s professional art consultants offer specialized and personal one-on-one attention to everyone who visits the gallery, connects through GallArt.com, social media or by telephone. Currently, Gallery Art is showcasing works by Andy Warhol, Banksy, Pablo Picasso, Robert Indiana, Peter Max, Keith Haring, Roy Lichtenstein, Tom Wesselmann, Salvador Dali and other world renowned artists. Gallery Art services include private collection purchases, art sales, custom framing, installations, in-home art showings, worldwide shipping, art certifications and appraisals.<br><br>
																			
																		Along with his staff, Ken Hendel, owner and curator of Gallery Art, prides himself on his commitment to helping first time art enthusiasts as well as seasoned collectors understand current art market trends and market values. Gallery Art has been servicing the community and art world for over 30 years and a visit promises to be more than any art collector could ever expect. </p>
																	</cfoutput>
																</div>
															</div>
														</div>
														<div class="col-md-5">
															<div class="img-sec">
																<div class="virtual-tour">
																	<form action="360_tour.cfm" style="margin-bottom: 2px;">
																		<input type="submit" class="submit-form-btn" value="Click To Take A 360 Virtual Tour" />
																	</form>
																	<div class="virtual-right-img">
																		<a href="360_tour.cfm"><img src="/images/gallart_front.jpg" alt="" border="0"></a>
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