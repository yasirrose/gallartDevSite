<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
<script language="JavaScript" src="./js/utils.js"></script>
<script language="JavaScript" src="http://#server_name#/js/jquery-1.2.6.min.js"></script>
<script language="JavaScript" src="http://#server_name#/js/slimbox2.js"></script>
<link href="http://#server_name#/css/slimbox2.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</cfoutput>

<SCRIPT LANGUAGE="JavaScript">
function popUpWin(urlPage){
	var features =	'scrollbars=yes, toolbar=no, status=no, menubar=no,' +
					'resizable=no, location=no, directories=no,' +
					'left=100, top=100, width=793, height=400';

	myWin =	window.open(urlPage,'WinName',features);
}
	
</SCRIPT>

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
<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM products P
	LEFT OUTER JOIN users U on P.fk_users = U.pk_users
	where uid  = '#pid#' 
	and active = 1
</cfquery>
<cfquery name="similar" maxrows="3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * 
	FROM products
	WHERE active = 1 and manufacturer <> '#productinfo.manufacturer #' and path like '#productinfo.path#%'
</cfquery>
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
										<div class="user-registrations make-offer-page">
											<div class="inner-content">
												<cfoutput>
													<cfif isDefined('form.offer')>
													<!--- Insert info into customers table if new customer remove this section if not supported --->
													<cfquery name="find_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
														SELECT * from customers where (email = '#trim(email)#')
													</cfquery>
													
													<cfif not find_cust.recordcount>
													
														<cfquery name="insert_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
															INSERT into customers
															(
																LNAME,
																FNAME,
																PHONE,
																EMAIL
															)
															VALUES
															(
																'#BILLNAME#', 
																'#BILLNAMEF#',
																'#makeoffer_phone#',
																'#EMAIL#'
															)
															SELECT @@identity as uid 
														</cfquery>
														
														<cfset customerId = insert_cust.uid />
														
													<cfelse>
													
														<cfset customerId = find_cust.id />
														
													</cfif>
													
													<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
														INSERT into makeoffer
														(
															fk_customers,
															fk_products,
															offer,
															makeoffer_phone,
															best_time
														)
														VALUES
														(
															#customerId#, 
															#productinfo.uid#,
															#form.Offer#,
															'#form.makeoffer_phone#',
															'#form.best_time#'
														)
													</cfquery>
													<cfmail server="#servername#" username="gallart@onlinegalleryart.com"
														password="re3objeC!P" to="#emailsupport#" cc="#emailsupportcc#"  from="#form.Email#" subject="GallArt.com <> We Buy & Sell Fine Art <> Make An Offer" type="HTML">
														<font style="font-size: 10pt; font-family: Arial;">
														The following user made an offer on the piece below:
														<br><br>
														Name: #form.BILLNAMEF# #form.BILLNAME#<br>
														Email Address: #form.Email#<br>
														Phone: #form.makeoffer_phone#<br>
														Best time to call: #form.best_time#<br>
														Offer: $#form.Offer#<br>
														Artist: #ucase(productinfo.manufacturer)#<br>
														Title: #productinfo.name#<br>
														Art ID: #productinfo.modelno#<br>
														Retail Price: #dollarFormat(productinfo.retail_price)#<br>
														Gallery Price: #dollarFormat(productinfo.gallery_price)#<br>
														<!--- removed for make offer 5/6/15 --->
														<!--- Sale Price: #dollarFormat(productinfo.sale_price)# --->
														<cfif productinfo.fk_users GT 1>
															<br>
															Seller: #productinfo.fname# #productinfo.lname#<br>
															Seller Email: #productinfo.email#<br>
															Seller Phone: #productinfo.phone#
														</cfif>
														<br><br>
														</font>
													</cfmail>
													<span style="color:##dd3a7d; font-size: 16px; font-weight: bold;">THANK YOU FOR MAKING YOUR OFFER!<br>WE WILL BE IN TOUCH WITH YOU SHORTLY<br><br>
														<a href="index.cfm?xss=#xss#" style="color:##dd3a7d; font-size: 16px; font-weight: bold; text-decoration: underline;">CLICK HERE</a> TO MAKE ANOTHER OFFER</span>
													<cfelse>
													<cfif productinfo.recordcount>
													<div class="top-heading text-left">
														<h3>MAKE US AN OFFER - LIMITED TIME!</h3>
													</div>
													<div class="row">
														<div class="col-md-6">
															<cfform action="" method="post" name="frm1">
															<cfset imgFile = expandpath('.') & '\img\' & productinfo.uid &'.jpg' />
															<cfif fileExists(imgFile)>
																<img src="http://#server_name#/img/#productinfo.uid#.jpg" border="2" width="300"><br>
																<a href="http://#server_name#/img/#productinfo.uid#.jpg" rel="lightbox">[CLICK]</a> to view large image size in separate window.
															</cfif>
															<div class="row">
																<div class="col-md-6">
																	<cfif productinfo.manufacturer gt 0><font size="1" face="arial, helvetica"><h1>Artist: #ucase(productinfo.manufacturer)#</h1></font></cfif>
																	<cfif productinfo.retail_price gt 0><font size="1" face="arial, helvetica">Retail Price: #DollarFormat(productinfo.retail_price)#</font></cfif>
																</div>
																<div class="col-md-6">
																	<p class="m-0"><cfif productinfo.name gt 0><font size="1" face="arial, helvetica">Title: #productinfo.name#</font></cfif></p>
																	<p class="m-0"><font size="1" face="arial, helvetica">
																			<cfif productinfo.closeout eq 1 and productinfo.special_price gt 0>
																			<cfelseif productinfo.gallery_price gt 0>Gallery Price: #DollarFormat(productinfo.gallery_price)#
																			</cfif>
																		</font></p>
																</div>
																<div class="col-md-12">
																	<cfif productinfo.overview gt 0><font size="1" face="arial, helvetica">Size: #productinfo.overview#</font></cfif>
																	<cfif productinfo.specs gt 0><font size="1" face="arial, helvetica">Year: #productinfo.specs#</font></cfif>
																</div>
																<cfset medium = replace(RemoveChars(productinfo.path,len(productinfo.path), 1),":","/","all")>
																<div class="col-md-12">
																	<cfif medium gt 0><font size="1" face="arial, helvetica">Medium: #medium#</font></cfif>
																	<cfif productinfo.edition gt 0><font size="1" face="arial, helvetica">Edition: #productinfo.edition#</font></cfif>
																</div>
																<div class="col-md-12 mb-3">
																	<cfif productinfo.caption gt 0><font size="1" face="arial, helvetica">Description: #trim(productinfo.caption)#</font></cfif>
																</div>
																<div class="col-md-12 text-center">
																	<p><span style="color:##dd3a7d; font-size: 16px; font-weight: bold;line-height: 1.2;">MAKE AN OFFER FOR THIS PIECE!<br>SIMPLY SUBMIT THE FORM BELOW:</span></p>
																</div>
																<div class="input-form">
																	<div class="input-field">
																		<label><b>Name</b> <i>(First Last)</i></label>
																		<cfinput type="text" name="billnamef" size="15" required="Yes" message="We require the billing first name to process the order.">&nbsp;<cfinput type="text" name="BillName" size="25" required="Yes" message="We require the billing last name to process the order.">
																	</div>
																	<div class="input-field">
																		<label><b>Phone</b></label>
																		<cfinput type="text" name="makeoffer_phone" size="35" required="Yes" message="We require your Phone number.">
																	</div>
																	<div class="input-field">
																		<label><b>Best time to call:</b></label>
																		<cfinput type="text" name="best_time" size="35" required="Yes" message="Best time to call is required." >
																	</div>
																	<div class="input-field">
																		<label><b>Email</b></label>
																		<cfinput type="text" name="Email" size="35" required="Yes" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" message="Email is required." >
																	</div>
																	<hr>
																	<div class="input-field">
																		<label><b>MAKE AN OFFER:</b>&nbsp;&nbsp;$</label>
																		<cfinput type="text" name="Offer" size="10" required="Yes" message="Please make an offer - enter a dollar amount, no $ or decimal." validate="integer" >
																	</div>
																	<div class="input-button">
																		<input type="submit" value="CLICK TO SUBMIT YOUR OFFER!" name="submit" class="SeeMore">
																	</div>
																</div>
															</div>
															</cfform>
															</cfif>
															</cfif>
															</cfoutput>
														</div>
														<div class="col-md-6">
														<cfoutput>
														<cfif #similar.recordcount# gt 0>
														<div class="inner-content">
															<div class="mb-1">
																<font face="arial,helvetica" size="2"><b>You Might Also Like:</b></font>
															</div>
															<cfloop query="similar">
															<cfset thisFile = "#expandpath('.')#\img\#similar.uid#.jpg" />
														
															<cfif listlen(manufacturer) gt 1>
																<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
																<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
															<cfelse>
																<cfset artist_name = manufacturer />
																<cfset artist_name_url = manufacturer />
															</cfif>
															<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
															<cfif fileExists(thisFile)>
															<img src="http://#server_name#/img/thumbnails/#similar.uid#.jpg" alt="#ucase(similar.manufacturer)# - #similar.name#" border="1">
															<cfelse>
															#ucase(similar.manufacturer)# - #similar.name#
															</cfif>
															<Br>
															<font size="1" face="verdana, arial">#name#</a>
															</cfloop>
															</cfif>
										
															<input type="button" value="Click Here for Other Listings" class="SeeMore" style="margin: 15px 0 0;height: 40px;max-width: 290px;text-align: center;" onClick="location.href='index.cfm?xss=#xss#'">
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