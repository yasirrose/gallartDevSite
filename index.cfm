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
	a.SeeMore {
    background: #ec008c;
    width: 100%;
    max-width: 130px;
    height: 40px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 40px 0 10 auto;
    color: #fff !important;
    font-size: 14px;
    border: 2px solid #ec008c;
    font-weight: 700;
    letter-spacing: 1px;
	transition: all 0.5s ease;
}
a.SeeMore:hover {
    background: transparent;
    color: #ec008c !important;
    transition: all 0.5s ease;
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
						<div class="sidebar web-sidebar-modal">	
							<cfinclude template="left_.cfm">
						</div>
						<div class="content-section">
							<div class="banner-section">
								<div class="banner-content">
									<div class="content-sec">
										<div class="top-heading">
											<h3>Browse Our Inventory</h3>
										</div>
										<cfinclude template="search.cfm">
										<div class="like-content mobile-like-content ">
											<iframe src="https://www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2Fpages%2FGallArt%2F119056118127427&amp;layout=standard&amp;show_faces=false&amp;width=450&amp;action=like&amp;colorscheme=light&amp;height=35" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:400px; height:35px;" allowTransparency="true"></iframe>
										</div>
									</div>
									<div class="img-sec">
										<div class="virtual-tour">
											<form action="360_tour.cfm" style="margin-bottom: 2px;">
												<input type="submit" value="Click To Take A 360 Virtual Tour" />
											</form>
											<div>
												<a href="360_tour.cfm"><img src="/images/gallart_front.jpg" alt="" border="0"></a>
											</div>
											<div class="productSearch-filed mobile-search">
												<form action="products.cfm?xss=#xss#" method="post">
												<input type="text" name="keywords" placeholder="Product Search">                  
												<button type="button" class="search-btn"><i class="fas fa-search"></i></button>
												</form>
											</div>
										</div>
									</div>
<!--- 									<div style="padding: 20px 0 0 0;"> 
										<div id="slideshow"></div>
										</div>--->
								</div>
								<div class="bottom-content-sec">
									<div class="like-content desktop-like-content ">
										<iframe src="https://www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2Fpages%2FGallArt%2F119056118127427&amp;layout=standard&amp;show_faces=false&amp;width=450&amp;action=like&amp;colorscheme=light&amp;height=35" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:400px; height:35px;" allowTransparency="true"></iframe>
									</div>
									<div class="art-work-content">
										<div class="featured-work-content">
											<div class="top-heading">
												<!--- <h3>Banner Images</h3> --->
											</div>
											<div class="bottom-content">
												<div class="product-items">
													<cfinclude template="banners.cfm">
												</div>
											</div>
										</div>
										<div class="featured-work-content">
											<div class="top-heading">
												<h3>Featured Artists</h3>
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
										<div class="top-heading">
											<h3>Recent Acquisitions</h3>
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
												<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
													<!--- <cfset uidd = '20338'> --->
												<!--- <IMG SRC="http://23.20.226.157/img/#uidd#.jpg?x=randrange(1,99)"  width="100" BORDER="0" ALT="#trim(modelno)#" align="Center"> 
												
												 SRC="./img/thumbnails/#uid#.jpg?x=randrange(1,99)"
												--->
												<IMG SRC="./img/#uid#.jpg?x=randrange(1,99)"   width="100" BORDER="0" ALT="#trim(modelno)#" align="Center">
												</A>
												<Br>
												<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
												#name#
												</a>
												<br>
												<span class="bytext">
												By: #ucase(artist_name)#<Br> </span>
												<font color="660066" size="2">
												<cfif retail_price gt 0 and retail_price gt gallery_price>
												Retail Price: #dollarformat(retail_price)#
												</cfif></font><Br>
												<span class="pinkText">
												<cfif gallery_price eq 0>
												<b>Price On Request</b>
												<cfelse>
												Gallery Price: <b>#dollarformat(gallery_price)#</b>
												</cfif>
												</span><br>
												Art ID:&nbsp;#modelno#<br><br>
											<cfif len(fk_users)><span style="font-size: 12px; font-weight: bold; color: ##ff0000;">PRIVATE LISTING</span><br><br></cfif>
											
											</td>
										
										      </div>
											</cfoutput>

											
											</div>
											<cfoutput>
												<a href="new_listings.cfm?xss=#xss#" class="SeeMore">See More</a>
											</cfoutput>
										</div>
		
										
									</div>
									<div class="art-work-content">



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
												ORDER by manufacturer
											</cfif>
											
										</cfquery>


										<!--- <cfif isDefined('cgi.REMOTE_ADDR') and cgi.REMOTE_ADDR eq '127.0.0.1'>
											<cfdump var="#initialQuery#">
										</cfif> --->
										<div class="top-heading">
											<h3>SALE ITEMS</h3>
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
													<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(name))#')">
														<!--- http://#server_name#/img/thumbnails/#uid#.jpg --->
													<IMG SRC="http://#server_name#/img/#uid#.jpg"  width="100" BORDER="0" ALT="#trim(modelno)#" align="Center">
													</A>
													<Br>
													<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(name))#')">
													#name#
													</a>
													<br>
													By: #ucase(manufacturer)#<Br>
													<font color="660066" size="1">
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
													</span>
													<br>
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
												<a href="sales.cfm?xss=#xss#" class="SeeMore">See More</a>
											</cfoutput>
										</div>
		
										
									</div>
								
									<!--- <div class="featured-work-content featured-artwork-content ">
										<div class="top-heading">
											<h3>Featured Artworks</h3>
										</div>
										<div class="bottom-content">
											<div class="product-items">
												<cfinclude template="featured_.cfm">
											</div>
										</div>
									</div> --->
									<div class="gallery-art-sec">
										<div class="<cfinclude template="home_page_content.cfm">
									</div>
									<div class="company-sec">
										<cfinclude template="company.cfm">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<tr height="100%">
				<td valign="top" width="727" height="100%">
					<table border="0" cellpadding="0" cellspacing="0" width="100%"
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
	
<div itemscope itemtype="https://schema.org/ArtGallery" class="desc footer-desc">
    <h6 itemprop="name">Gallery Art - Buying & Selling Fine Art & Collections</h6>
    <span itemprop="url"><a href="https://gallart.com/">Gallart.com</a></span>
    <span itemprop="description">Fine Art, Buy/Sell, 8,000 Sq, Ft. Showroom. Works by Warhol, Lichtenstein, Wesselmann, Indiana, Picasso, Chagall, Haring, Max, Britto, Neiman &amp; more</span>
    <span itemprop="address">20633 Biscayne Blvd, Aventura, FL 33180</span>
    <span itemprop="telephone">305.932.6166</span>
    <span itemprop="email">info@gallart.com</span>
</div>
<cfinclude template="frmxss.cfm">

</body>
</html>
