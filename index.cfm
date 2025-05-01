<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">
<link rel="shortcut icon" href="favicon.ico" >
<cfoutput>
	<cfif findNoCase("index.cfm", CGI.SCRIPT_NAME)>
		<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
		<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
	</cfif>
	<link href="./css/photogallery.css" rel="stylesheet" type="text/css">
	<script language="JavaScript" src="./js/utils.js"></script>
	<script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script>
	<script type="text/javascript" src="./js/jquery.bgpos.js"></script>
	<script type="text/javascript" src="./js/jquery.cross-slide.js"></script>
    <script language="JavaScript" src="./js/slimbox2.js"></script>
	<link href="./css/slimbox2.css" rel="stylesheet" type="text/css">
</cfoutput>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<cfquery name="qSlideshow" datasource="#application.dsource#">
    SELECT UID FROM products P
	WHERE slideshow = 1
</cfquery>
<style>
	.main-container {
		max-width: 1920px;
		margin: 0 auto;
	}
	.virtual-tour {
		max-width: 176px;
		text-align: left;
		margin: 0 auto;
	}
	.gallery-live {
		width: 1000px;
		display: flex;
		justify-content: center;
	}
	.product-items {
		width: 1000px;
	}
	.see-more-sec {
		display: flex;
		align-items: center;
		justify-content: flex-end;
		margin: 40px 0px 0px;
		padding: 10px;
	}
	a.SeeMore {
    /* background: #ec008c; */
	background-color: transparent;
    width: 100%;
    max-width: 130px;
    height: 40px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 0;
    color: #000 !important;
    font-size: 14px;
    /* border: 2px solid #ec008c; */
	border: 2px solid #000;
    font-weight: 700;
    letter-spacing: 1px;
	transition: all 0.5s ease;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	text-transform: uppercase;
	gap: 8px;
	
}
a.SeeMore:hover {
    background: transparent;
    color: #fff !important;
    transition: all 0.5s ease;
	background-color: #0000004f;
}
</style>
<script>
 $(function() {
 	if ( $('#slideshow').length ){
		$('#slideshow').crossSlide({
		  sleep: 2,
		  fade: 1
		}, [
		<cfoutput query="qSlideshow">
		  { src: './img/thumbnails/#uid#.jpg' }<cfif currentrow LT qSlideshow.recordcount>,</cfif>
		</cfoutput>
		]);
	}
});
</script>


<link href="stylesheet_.css?x=<cfoutput>#RandRange(0,100)#</cfoutput>" rel="stylesheet" type="text/css">
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-34565365-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'https://www') + '.google-analytics.com/ga.js';
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
	<div class="main-container">
		
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
						<div class="content-section">
							<div class="banner-section">
								<div class="banner-content">
									<div class="content-sec">
										<cfinclude template="search.cfm">
										<div class="like-content mobile-like-content ">
											<iframe src="https://www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2Fpages%2FGallArt%2F119056118127427&amp;layout=standard&amp;show_faces=false&amp;width=450&amp;action=like&amp;colorscheme=light&amp;height=35" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:400px; height:35px;" allowTransparency="true"></iframe>
										</div>
									</div>
<!--- 									<div style="padding: 20px 0 0 0;"> 
										<div id="slideshow"></div>
										</div> --->
								</div>
								
								<div class="bottom-content-sec">
									<!-- <div class="like-content desktop-like-content ">
										<iframe src="https://www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2Fpages%2FGallArt%2F119056118127427&amp;layout=standard&amp;show_faces=false&amp;width=450&amp;action=like&amp;colorscheme=light&amp;height=35" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:400px; height:35px;" allowTransparency="true"></iframe>
									</div> -->
									<div class="art-work-content">
										<div class="featured-work-content banner-sec">
											<div class="top-heading ">
												<!--- <h3>Banner Images</h3> --->
											</div>
											<div class="bottom-content">
												<div class="product-items">
													<cfinclude template="banners.cfm">
												</div>
											</div>
										</div>
										<div class="featured-work-content" style="background-color:#F2F2F2; border-radius:10px;">
											<div class="top-heading home-page-heading">
												<h3>FEATURED ARTISTS</h3>
											</div>
											<div class="bottom-content">
												<div class="product-items">
													<cfinclude template="center_featured.cfm">
												</div>
											</div>
										</div>


										<cfquery name="initialQuery" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
											SELECT top 8 *
											FROM products 
											WHERE active = 1
											<cfif isDefined('keywords')>
												AND (name like '%#keywords#%' or caption like '%#keywords#%' or modelno like '#keywords#%' or manufacturer like '%#keywords#%')
											</cfif>
											<cfif isDefined('artist') and len(artist)>
												AND manufacturer = '#artist#'
											</cfif>
											<cfif isDefined('path') and len(path)>
												AND path = '#path#'
											</cfif>
											AND fk_users is null
											ORDER BY active_date desc
										</cfquery>


										<!--- <cfif isDefined('cgi.REMOTE_ADDR') and cgi.REMOTE_ADDR eq '127.0.0.1'>
											<cfdump var="#initialQuery#">
										</cfif> --->
										<div class="Recent Aquestoins" style="background-color:#F2F2F2; border-radius:10px;">
										<div class="top-heading home-page-heading">
											<h3>RECENT ACQUISITIONS</h3>
										</div>
										<div class="bottom-content">
											<div class="gallery-lists">


												<cfoutput query="initialQuery" >
													<div class="list-item">
													<cfif listlen(manufacturer) gt 1>
														<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
														<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
													<cfelse>
														<cfset artist_name = manufacturer />
														<cfset artist_name_url = manufacturer />
													</cfif>
													
												<!--- <Cfset pc = pc + 1> --->
												<Td valign="top" align="Center">
												<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(HTMLEditFormat(manufacturer),"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
													<!--- <cfset uidd = '20338'> --->
												<!--- <IMG SRC="http://23.20.226.157/img/#uidd#.jpg?x=randrange(1,99)"  width="100" BORDER="0" ALT="#trim(modelno)#" align="Center"> 
												
												 SRC="./img/thumbnails/#uid#.jpg?x=randrange(1,99)"
												--->
												<cfif fileexists("http://23.20.226.157/img/thumbnails/#uid#.jpg") >
													<IMG SRC="./img/#uid#.jpg?x=randrange(1,99)"   width="100" BORDER="0" ALT="#trim(modelno)#" align="Center">
												<cfelse>
													<img src="https://as2.ftcdn.net/v2/jpg/07/95/29/45/1000_F_795294547_gaBzWLhkAYBSz1ZUIZssHhvzGzstNmHK.jpg">
												</cfif>
												</A>
												<Br>
												<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(HTMLEditFormat(manufacturer),"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">

													<cfset romanNumerals = "I,II,III,IV,V,VI,VII,VIII,IX,X,XI,XII,XIII,XIV,XV,XVI,XVII,XVIII,XIX,XX">


														<cfset words = ListToArray(name, " ")>
														<cfset updatedName = "">

														<cfloop index="word" array="#words#">
															<cfset cleanWord = REReplace(word, "[^a-zA-Z]", "", "ALL")>

															<cfif cleanWord EQ "FS">
																<!--- Preserve "FS" in uppercase --->
																<cfset updatedName = updatedName & " " & UCase(word)>
															<cfelse>
																<!--- Keep the original case of other words --->
																<cfset updatedName = updatedName & " " & word>
															</cfif>
														</cfloop>

														<!--- Trim to remove leading space --->
														<cfset updatedName = Trim(updatedName)>

														

													<b>#updatedName#</b>

												
												</a>
												<br>
												<span class="bytext">
													<!--- <cfset capitalize_artistName = REReplace(artist_name, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")> --->
														By: #artist_name#<Br>
												</span>

												<!--- By: #ucase(artist_name)#<Br> </span> --->
												<!--- <font color="660066" >
													<cfif retail_price gt 0 and retail_price gt gallery_price>
														Retail Price: #dollarformat(retail_price)#
													</cfif>
												</font>
												<Br>
												<span class="pinkText">
													<cfif gallery_price eq 0>
														<b>Price On Request</b>
													<cfelse>
														Gallery Price: <b>#dollarformat(gallery_price)#</b>
													</cfif>
												</span>
												<br>
												Art ID:&nbsp;#modelno#<br><br>
												<cfif len(fk_users)>
													<span style="font-size: 12px; font-weight: bold; color: ##ff0000;">
														PRIVATE LISTING
													</span>
													<br><br>
												</cfif> --->

												<div>
													<cfif retail_price gt 0 and retail_price gt gallery_price>

														<cfif gallery_price gt 0 and  gallery_price gt special_price>
								
															<cfif closeout eq 1 and special_price gt 0 >
																<del>#DollarFormat(gallery_price)#</del>
																&nbsp; 
																 <b>
																	<span style="color: ##ff0000;">
																		#DollarFormat(special_price)# 
																	</span>
																</b>
															 <cfelse>
																<del>#DollarFormat(retail_price)#</del>
																&nbsp; 
																
																<b> #DollarFormat(gallery_price)# </b>
															</cfif>
	
														 <cfelse>
															<!--- <span style="color: red;">
																	Price On Request
															</span> --->
															<cfif closeout eq 1 and special_price gt 0 and special_price LT retail_price>
																<del>#DollarFormat(retail_price)# </del>
																&nbsp; 
																	<b>
																		<span style="color: ##ff0000;">
																		#DollarFormat(special_price)# 
																		</span>
																	</b>
											
																	<cfelse>
																		<b> #DollarFormat(retail_price)# </b>
															</cfif>
								
														</cfif>
													 <cfelse>
														
														<cfif gallery_price EQ 0 OR gallery_price EQ ''>
															
															<span style="color: red;">
																Price On Request
															</span>
														 <cfelse>
															<cfif retail_price neq 0 and gallery_price GT retail_price>
																<b>#DollarFormat(retail_price)#</b>
															 <cfelse>
																<cfif closeout eq 1 and special_price gt 0 and special_price LT gallery_price>
																	<del>#DollarFormat(gallery_price)# </del>
																	&nbsp; 
																		<b>
																			<span style="color: ##ff0000;">
																			#DollarFormat(special_price)# 
																			</span>
																		</b>
												
																		<cfelse>
																			<b>#DollarFormat(gallery_price)#</b>
																</cfif>
															</cfif>
														</cfif>
								
													</cfif>
												</div>

												Art ID:&nbsp;#modelno#<br><br>
											
											</td>
										
										      </div>
											</cfoutput>

											
											</div>
											<cfoutput>
												<div class="see-more-sec">
													<a href="new_listings.cfm?xss=#xss#" class="SeeMore">
														<span>See More</span>
														<i class="fa fa-arrow-right" aria-hidden="true"></i>
													</a>
												</div>
											</cfoutput>
										</div>
									</div>
		
										
									</div>
									<div class="art-work-content" style="background-color:#F2F2F2; border-radius:10px;">



										<!--- <cfquery name="initialQuery" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
											SELECT top 8 *
											FROM products 
											WHERE active = 1
											<cfif isDefined('keywords')>
												AND (name like '%#keywords#%' or caption like '%#keywords#%' or modelno like '#keywords#%' or manufacturer like '%#keywords#%')
											</cfif>
											<cfif isDefined('artist') and len(artist)>
												AND manufacturer = '#artist#'
											</cfif>
											<cfif isDefined('path') and len(path)>
												AND path = '#path#'
											</cfif>
											AND fk_users is null
											ORDER BY active_date desc
										</cfquery> --->


										<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
											SELECT top 8 *
											FROM products 
											WHERE (path <> '') 
											AND active = 1
											AND (path IS NOT NULL)
											<cfif isDefined('keywords')>
												AND (name like '%#keywords#%' or caption like '%#keywords#%' or modelno like '#keywords#%' or manufacturer like '%#keywords#%')
											</cfif>
											<cfif isDefined('artist') and len(artist)>
												AND manufacturer = '#artist#'
											</cfif>
											<cfif isDefined('path') and len(path)>
												and path = '#path#'
											</cfif>
											AND closeout = 1
											AND fk_users is null
											<cfif isDefined('priceOrder') and len(priceOrder)>
												ORDER by special_price #priceOrder#
											<cfelse>
												ORDER by active_date desc
											</cfif>
											
										</cfquery>


										<!--- <cfif isDefined('cgi.REMOTE_ADDR') and cgi.REMOTE_ADDR eq '127.0.0.1'>
											<cfdump var="#initialQuery#">
										</cfif> --->
										<div class="top-heading home-page-heading">
											<h3>ARTWORKS ON SALE</h3>
										</div>
										<div class="bottom-content">
											<div class="gallery-lists">


												<cfoutput query="productinfo">
													<div class="list-item">
													<cfif listlen(manufacturer) gt 1>
														<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
														<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
													<cfelse>
														<cfset artist_name = manufacturer />
														<cfset artist_name_url = manufacturer />
													</cfif>
													<!--- <Cfset pc = pc + 1> --->
													<Td valign="top" align="Center">
													<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(HTMLEditFormat(manufacturer),"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(name))#')">
														<!--- http://#server_name#/img/thumbnails/#uid#.jpg --->
														<cfif fileexists("http://23.20.226.157/img/thumbnails/#uid#.jpg") >
															<IMG SRC="./img/#uid#.jpg?x=randrange(1,99)"   width="100" BORDER="0" ALT="#trim(modelno)#" align="Center">
														<cfelse>
															<img src="https://as2.ftcdn.net/v2/jpg/07/95/29/45/1000_F_795294547_gaBzWLhkAYBSz1ZUIZssHhvzGzstNmHK.jpg">
														</cfif>
													</A>
													<Br>
													<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(HTMLEditFormat(manufacturer),"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(name))#')">

														<cfset romanNumerals = "I,II,III,IV,V,VI,VII,VIII,IX,X,XI,XII,XIII,XIV,XV,XVI,XVII,XVIII,XIX,XX">


														<cfset words = ListToArray(name, " ")>
														<cfset updatedName = "">

														<cfloop index="word" array="#words#">
															<cfset cleanWord = REReplace(word, "[^a-zA-Z]", "", "ALL")>

															<cfif cleanWord EQ "FS">
																<!--- Preserve "FS" in uppercase --->
																<cfset updatedName = updatedName & " " & UCase(word)>
															<cfelse>
																<!--- Keep the original case of other words --->
																<cfset updatedName = updatedName & " " & word>
															</cfif>
														</cfloop>

														<cfset updatedName = Trim(updatedName)>

													<b>#updatedName#</b>

													
													</a>
													<br>
													<div>
														<!--- <cfset capitalize_artistName = REReplace(artist_name, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")> --->
														By: #artist_name#<Br>
													</div>
													<!--- By: #artist_name#<Br> --->

													<!--- <font color="660066" >
													<cfif len(retail_price)>
													Retail Price: #dollarformat(retail_price)#
													</cfif></font><Br>
													<cfif len(gallery_price)>
													Gallery Price: #dollarformat(gallery_price)#
													</cfif></font><Br>
													<cfif len(special_price) and application.showSalePrice EQ 1>
													<span style="color: ##ff0000">Sale Price: #dollarFormat(special_price)#</span>
													</cfif></font><Br>
													<span class="pinkText">
													<cfif special_price eq 0>
													<b>Price On Request</b>
													<cfelse>
												
													</cfif>

													</span> --->

													<div>
														<cfif retail_price gt 0 and retail_price gt gallery_price>

															<cfif gallery_price gt 0 and  gallery_price gt special_price>
									
																<cfif closeout eq 1 and special_price gt 0 >
																	<del>#DollarFormat(gallery_price)#</del>
																	&nbsp; 
																	 <b>
																		<span style="color: ##ff0000;">
																			#DollarFormat(special_price)# 
																		</span>
																	</b>
																 <cfelse>
																	<del>#DollarFormat(retail_price)#</del>
																	&nbsp; 
																	
																	<b> #DollarFormat(gallery_price)# </b>
																</cfif>
		
															 <cfelse>
																<!--- <span style="color: red;">
																		Price On Request
																</span> --->
																<cfif closeout eq 1 and special_price gt 0 and special_price LT retail_price>
																	<del>#DollarFormat(retail_price)# </del>
																	&nbsp; 
																		<b>
																			<span style="color: ##ff0000;">
																			#DollarFormat(special_price)# 
																			</span>
																		</b>
												
																		<cfelse>
																			<b> #DollarFormat(retail_price)# </b>
																</cfif>
									
															</cfif>
														 <cfelse>
															
															<cfif gallery_price EQ 0 OR gallery_price EQ ''>
																
																<span style="color: red;">
																	Price On Request
																</span>
															 <cfelse>
																<cfif retail_price neq 0 and retail_price GT gallery_price >
																	<b>#DollarFormat(retail_price)#</b>
																 <cfelse>
																	<cfif closeout eq 1 and special_price gt 0 and special_price LT gallery_price>
																		<del>#DollarFormat(gallery_price)# </del>
																		&nbsp; 
																			<b>
																				<span style="color: ##ff0000;">
																				#DollarFormat(special_price)# 
																				</span>
																			</b>
													
																			<cfelse>
																				<b>#DollarFormat(gallery_price)#</b>
																	</cfif>
																</cfif>
															</cfif>
									
														</cfif>
													</div>

													
												Art ID:&nbsp;#modelno#<br><br>
												<cfif len(fk_users)><span style="font-size: 12px; font-weight: bold; color: ##ff0000;">PRIVATE LISTING</span><br><br>
												</cfif>
												
												</td>
												</tr>
												<Tr>

											
												</div>
												</cfoutput>
											</div>

											
											<cfoutput>
												<div class="see-more-sec">
													<a href="sales.cfm?xss=#xss#" class="SeeMore">
														<span>See More</span>
														<i class="fa fa-arrow-right" aria-hidden="true"></i>
													</a>
												</div>
											</cfoutput>
										</div>
		
										
									</div>
								
									<!--- <div class="featured-work-content featured-artwork-content ">
										<div class="top-heading home-page-heading">
											<h3>Featured Artworks</h3>
										</div>
										<div class="bottom-content">
											<div class="product-items">
												<cfinclude template="featured_.cfm">
											</div>
										</div>
									</div> --->
									
							</div>
						</div>
						
					</div>
				</divcl>
			</div>

			<button type="button" style="display:none;" onclick="gotoTopFunction()" class="btn"  id="myBtn" title="Go to top">
				<i class="fas fa-chevron-up"></i>
			 </button>

			<tr height="100%">
				<td valign="top" width="727" height="100%">
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" valign="baseline">
					<cfinclude template="footer_.cfm">
				</td>
			</tr>
		</div>
	</div>

	<cfif NOT structKeyExists(session, "email") OR session.email EQ "" >
		<div class="modal onload-modal fade" id="onload" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-head">
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body pt-0">
						<div class="inner-content">
							<div class="top-image">
								<img src="images/G-Logowhite.png" alt="logo" />
							</div>
							<h2>Stay in touch</h2>
							<p>Be the first to know about Gallery Art's upcoming events, recent acquisitions and sales.</p>
							<div class="email-form">
								<form id="signupForm" method="POST">
									<div class="form-floating">
										<input type="email" name="email" required class="form-control" id="email" placeholder="email">
										<label for="floatingInput">Email</label>
									  </div>
									<div class="privacy-content">
									  <p>
										By signing up, you agree to Gallart’s
										<a href="pns.cfm?xss=<cfoutput>#xss#</cfoutput>">Privacy Policy</a> 
										and 
										<a href="shippingpolicy.cfm?xss=<cfoutput>#xss#</cfoutput>">Terms of Use</a>
									</p>
									</div>
									<div class="form-btn">
										<button  type="submit" class="btn btn-primary">Sign Up</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</cfif>
	


	<cfif isDefined('form.email') and form.email neq ''>
		<cfset email = trim(FORM.email)>
		<cfset ipAddress = cgi.remote_addr>
		<cfset createdAt = now()>
		
		<cfquery name="qGetNewsLetterUser" datasource="#application.dsource#">
			Select * FROM newsLetterUsers where email = '#form.email#'
		</cfquery>
		
		<cfif qGetNewsLetterUser.recordCount EQ 0 >
				<cfquery name="addNewsLetterUsers" datasource="#application.dsource#">
					INSERT INTO newsLetterUsers (
							email, 
							created_at, 
							ipAddress
							)
					VALUES (
							<cfqueryparam value="#email#" cfsqltype="cf_sql_varchar">, 
							<cfqueryparam value="#createdAt#" cfsqltype="cf_sql_timestamp">, 
							<cfqueryparam value="#ipAddress#" cfsqltype="cf_sql_varchar">
							)
				</cfquery>
			 	<cfset session.email = email>
					<cfoutput>
						<script>
							
							window.location.href = 'index.cfm?xss=<cfoutput>#xss#</cfoutput>';
						</script>
					</cfoutput>
			<cfelse>
				<cfset session.email = email>
				<cfoutput>
					<script>
						alert('You are already subscribed.');
						window.location.href = 'index.cfm?xss=<cfoutput>#xss#</cfoutput>';
					</script>
				</cfoutput>
		</cfif>
		
	
		<!--- <cfelse>
			<cfoutput>
				<p style="color: red;">Error: Please fill out all required fields before submitting the form.</p>
			</cfoutput> --->
		
	</cfif>
	

<cfinclude template="frmxss.cfm">

</body>
</html>

<style>
	#myBtn {
  display: none;
  position: fixed;
  bottom: 30px;
  right: 30px;
  z-index: 100;
  width: 50px; /* Small square size */
  height: 50px;
  background-color: white;
  color: black;
  border: none;
  border-radius: 10px; /* Rounded corners for style */
  cursor: pointer;
  font-size: 28px; /* Icon size */
  display: flex;
  justify-content: center;
  align-items: center;
  border: 1px solid black;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    // Check if the modal has already been shown using localStorage
    window.onload = () => {
        // If modal is not shown yet, show it
        if (!localStorage.getItem("modalShown")) {
            $('#onload').modal('show');
            localStorage.setItem("modalShown", "true"); // Store that modal has been shown
        }

        // Close the modal when clicking anywhere on the page
        $(document).click(function (e) {
            if (!$(e.target).closest('#onload').length) {
                // If click is outside the modal, hide it and set the localStorage flag
                $('#onload').modal('hide');
            }
        });
    }
</script>
<!--- <script>
	document.getElementById('signupBtn').addEventListener('click', function (event) {
	  // Prevent the default anchor navigation
	  event.preventDefault();
  
	  // Get the email input field
	  const emailInput = document.getElementById('floatingInput');
	  const emailValue = emailInput.value.trim();
  
	  // Email validation regex
	  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  
	  // Validate the email
	  if (emailValue === '') {
		alert('Please fill in your email address.');
	  } else if (!emailRegex.test(emailValue)) {
		alert('Please enter a valid email address.');
	  } else {
		// Navigate to the URL if the email is valid
		window.location.href = 'mailing_list.cfm?xss=<cfoutput>#xss#</cfoutput>';
	  }
	});
  </script> --->
<script>
	 window.onscroll = function() {scrollFunction()};

function scrollFunction() {
   if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
	  document.getElementById("myBtn").style.display = "block";
   } else {
	  document.getElementById("myBtn").style.display = "none";
   }
}

function gotoTopFunction() {
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
            e.preventDefault();
        }

</script>


