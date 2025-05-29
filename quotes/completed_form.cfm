<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfset FNAME = "John" />
<cfset LNAME = "Doe" />
<cfset EMAIL = "john@doe.com" />
<cfset PHONE = "654-987-3214" />
<cfset CELL = "874-659-5824" />
<cfset ARTIST = "Peter Max" />
<cfset TITLE = "Flower Lady" />
<cfset MEDIUM = "ACRYLIC ON CANVAS" />
<cfset GRAPHICS = "GRAPHIC/PRINT INFO" />
<cfset EDITION = "10" />
<cfset SIGNATURE = "Hand Signed" />
<cfset SIZE = "36 X 48 INCHES" />
<cfset SCULPTURE = "NO" />
<cfset YEAR = "1992" />
<cfset DESCRIPTION = "HAND SIGNED IN ACRYLIC ON CANVAS. CERTIFICATE OF AUTHENTICITY INCLUDED. ADDITIONAL IMAGES ARE AVAILABLE UPON REQUEST. PLEASE DO NOT HESITATE TO ASK FURTHER QUESTIONS." />
<html>
<head>
	<cfoutput>
	<title>#companyname# - #titletext#</title>
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script>
	</cfoutput>
	<meta name='viewport' content='width=device-width, initial-scale=1'>
	<cfinclude template="../meta.cfm">
	
	<link href="../stylesheet_.css" rel="stylesheet" type="text/css">
	<style>
		td {font-size: 11px; font-weight: bold;}
	</style>
	
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<cfoutput>
	<div class="main-container registration-page">
		<div id="Table_01">
			<div class="header-section text-center py-4 px-4">
				<img src="/images/top_01.jpg" style="width: 100%; max-width: 634px; height: auto;" alt="image">
			</div>
			<div class="inner-section">
				<div class="container">
					<div class="main-content">
						<div class="content-section">
							<div class="bottom-content-sec">
								<div class="banner-section">
									<div class="art-work-content">
										<div class="bottom-content">
											<div class="user-registrations quotes-page">
												<div class="top-heading">
													<h3>Free Quote Form</h3>
												</div>
												<cfform method="post" action="quote_proc.cfm">
												<div class="input-form">
													<div class="input-field">
														<label>First Name:</label>
														<cfinput type="Text" name="fname" value="#fname#" required="Yes" message="Please enter your first name." size="40" />&nbsp;<span style="color:##ff0000;">* Required Field</span>
													</div>
													<div class="input-field">
														<label>Last Name:</label>
														<cfinput type="Text" name="lname" value="#lname#" size="40" required="Yes" message="Please enter your last name." />&nbsp;<span style="color:##ff0000;">* Required Field</span>
													</div>
													<div class="input-field">
														<label>Email Address:</label>
														<cfinput type="Text" name="email" value="#email#" size="40" required="Yes" message="Please enter your email address." />&nbsp;<span style="color:##ff0000;">* Required Field</span>
													</div>
													<div class="input-field">
														<label>Phone Number:</label>
														<cfinput type="Text" name="phone" value="#phone#" size="40" required="Yes" message="Please enter your phone number." />&nbsp;<span style="color:##ff0000;">* Required Field</span>
													</div>
													<div class="input-field">
														<label>Cell Number:</label>
														<cfinput type="Text" name="cell" value="#cell#" size="40" required="Yes" message="Please enter your cell number." />
													</div>
													<div class="input-field">
														<label>Artist:</label>
														<cfinput type="Text" name="artist" value="#artist#" size="40" required="Yes" message="Please enter the artist." />&nbsp;<span style="color:##ff0000;">* Required Field</span>
													</div>
													<div class="input-field">
														<label>Title:</label>
														<cfinput type="Text" name="title" value="#title#" size="40" required="Yes" message="Please enter the title." />&nbsp;<span style="color:##ff0000;">* Required Field</span>
													</div>
													<div class="input-field">
														<label>Medium:</label>
														<cfinput type="Text" name="medium" value="#medium#" size="40" required="Yes" message="Please enter the medium." />&nbsp;<span style="color:##ff0000;">* Required Field</span>
													</div>
													<div class="input-field">
														<label>Graphics/Prints:</label>
														<cfinput type="Text" name="graphics" value="#graphics#" size="40" required="No" message="Please enter Graphics/Prints." />&nbsp;<input type="Text" name="edition" value="#edition#" size="5" />&nbsp;Edition ##
													</div>
													<div class="input-field">
														<label>Signature:</label>
														<div class="checkbox">
															<div class="checkbox-field">
																<input type="radio" name="signature" value="Hand Signed" checked>
																<label>hand signed</label>
															</div>
															<div class="checkbox-field">
																<input type="radio" name="signature" value="Plate Signed">
																<label>plate signed</label>
															</div>
														</div>
													</div>
													<div class="input-field">
														<label>Unframed Size:</label>
														<cfinput type="Text" name="size" value="#size#" size="40" required="No" message="Please enter the unframed size." />&nbsp;&nbsp;Height x Width
													</div>
													<div class="input-field">
														<label>Sculpture:</label>
														<cfinput type="Text" name="sculpture" value="#sculpture#" size="40" required="No" message="Please enter the Sculpture size." />&nbsp;&nbsp;Height x Width x Depth
													</div>
													<div class="input-field">
														<label>Year:</label>
														<cfinput type="Text" name="year" value="#year#" size="40" required="No" message="Please enter the year." />
													</div>
													<div class="input-field">
														<label>Brief Description:</label>
														<textarea name="description" rows="3" cols="35">#description#</textarea>
													</div>
													<div class="choose-field">
														<label>Upload Picture:</label>
														<cfinput type="File" name="pictureUpload" required="No" message="You must upload a picture.">
													</div>
												</div>
												</cfform>
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


</cfoutput>

</body>
</html>
