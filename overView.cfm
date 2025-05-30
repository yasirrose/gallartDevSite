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
<script language="JavaScript" src="/js/utils.js"></script>
</cfoutput>

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


	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

<style>
	.user-registrations {
		max-width: 800px;
		margin: 0 auto;
	}
	.row0 {
		font-size: 15px;
	}
	.table-responsive table td {
		padding: 5px;
	}
	.registration-page .content-section .banner-section .art-work-content table input {
       margin-bottom: 0px;
	}
	.registration-page .content-section .banner-section .art-work-content {
		min-height: 554px;
	}
	.see-more-sec {
		display: flex;
		align-items: center;
		justify-content: flex-end;
		margin: 40px 0px 0px;
		padding: 10px;
		gap: 15px;
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
.SeeMore {
	max-width: unset;
}
.billing-section .billing-listing ul li:not(:last-child) {
    border-bottom: 1px solid #c7c8c9;
}
.billing-section .billing-listing ul li {
	padding-bottom: 10px;
}
.billing-section .billing-listing ul li b i {
	font-weight: normal;
}
.table-cart-detail {
	background: #F2F2F2;
    padding: 30px;
    border-radius: 15px;	
}
.table-cart-detail {
	background: #F2F2F2;
    padding: 30px;
    border-radius: 15px;	
}
.table-cart-detail tbody, .table-cart-detail td, .table-cart-detail tfoot, .table-cart-detail th, .table-cart-detail thead, .table-cart-detail tr {
	border-color: #c7c8c94f; 
    border-width: 1px;	
	padding: 10px;
}
table tr td, table tr td * {
	font-size: 13px !important;
}
.billing-section .billing-listing ul li * {
    width: 50%; 
    min-width: 50%;
}
table tr td img{
	max-width: 100px;
}
@media (max-width: 991px) {
	.billing-section .billing-listing ul li * {
		min-width: 50%;
	}	
}
.registration-page .content-section .banner-section .art-work-content table input {
    margin-bottom: 0px;
    margin: 0;
}
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

	<cfset userID = session.sellerinfo.pk_users>

	

    
    <!--- <cfset productIDs = []> --->

    <!--- <cfif StructKeyExists(cookie, "AddWishListlistItem") >
        <cfset wishlistItems = deserializeJSON(cookie.AddWishListlistItem)>
			<cfloop array="#wishlistItems#" index="item">
				<cfif item.pk_user EQ userID>
					<cfset arrayAppend(productIDs, item.pid)>
				</cfif>
       		</cfloop>
    </cfif> --->

	<cfquery name="wishlistData" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		SELECT w.pk_id, p.*
		FROM Wishlist w
		INNER JOIN products p ON w.product_id = p.uid
		WHERE w.user_id = <cfqueryparam value="#userID#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfquery name="getSellerRecord" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
			SELECT * FROM products where fk_users = #userID#
	</cfquery>

	<cfquery name="get_items" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		  SELECT 
        items.product_code AS pid, 
        items.quantity AS qty, 
        orders.email AS email, 
		orders.total as total_price,
        * 
		FROM items
		LEFT JOIN products ON products.code = items.product_code
		LEFT JOIN orders ON orders.orderUID = items.orderUID
		WHERE  orders.email = '#session.sellerinfo.email#'
				order by ID DESC
	</cfquery>
    
	<!--- <cfdump var="#get_items#" abort="true"> --->
   

    <div class="main-container registration-page">
        <div id="Table_01">
			<div class="header-section">
				<div class="top-header">
					<cfinclude template="top_.cfm">
				</div>
				<div class="navbar-section">
					<cfinclude template="navbar_user.cfm">
				</div>
			</div>

			<div class="inner-section">
                <div class="container-fluid">
                    <div class="main-content pb-4">
                        <div class="content-section">
                            <div class="bottom-content-sec">
                                <div class="banner-section">
                                    <div class="art-work-content">
                                        <div class="bottom-content">


											<div class="top-heading">
												<h3>Account Overview</h3>
											</div>



											<div class="table-cart-detail">
												<h5><strong>Review Your Wish List Record:</strong></h5>
												<cfif wishlistData.recordcount GT 0>
													<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
														<tr>
															<td width="30%" height="20"><b>Title</b></td>
															<td width="30%" align="center"><b>Artist</b></td>
															<td width="10%" align="center"><b>Thumbnail</b></td>
															<td width="15%" align="center"><b>Price</b></td>
															<td width="15%" align="center"><b>Action</b></td>
														</tr>
														<cfoutput query="wishlistData">
															<cfif listlen(manufacturer) gt 1>
																<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
																<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
															<cfelse>
																<cfset artist_name = manufacturer />
																<cfset artist_name_url = manufacturer />
															</cfif>

															<tr>
																<td valign="center">
																	<a HREF="javascript:goxss('/item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
																		#REReplace(name, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")#
																	</a>
																	
																</td>
																<td align="center" valign="middle">
																	# REReplace(artist_name, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")#
																</td>
																<td align="center" valign="middle">
																	<cfif fileexists("http://23.20.226.157/img/thumbnails/#wishlistData.uid#.jpg")> 
																		<IMG SRC="./img/#uid#.jpg?x=randrange(1,99)"   width="100" BORDER="0" ALT="#wishlistData.uid#" align="Center" style="max-height: 100px;">
																		<cfelse>
																			<!--- <img src="https://dummyimage.com/150x100/050005/ededf2.png&text=No+Image+Available+"> --->
																			<img src="http://23.20.226.157/img/thumbnails/noImage.jfif.jpeg">
																	</cfif>
																</td>
																<td align="center" valign="middle">
																	<cfif special_price gt 0>
																		<span style="color: ##ff0000;">
																			#DollarFormat(special_price)# Sale
																		 </span>
																		<cfelseif gallery_price GT 0>
																			#dollarformat(gallery_price)#
																	<cfelse>
																		<span>
																			<b style="color:red;">Price On request</b>
																		</span>

																	</cfif>
																	
																	
																</td>
																<td align="center" valign="middle">
																	<form action="overView.cfm?xss=#xss#" method="post">
																		<input type="hidden" name="wishlist_pk_id" id="wishlist_pk_id" value="#wishlistData.PK_ID#">
																		<input type="hidden" name="product_id" id="product_id" value="#wishlistData.uid#">
																		<input type="submit" class="Seemore" value="Delete" onclick="deleteWishlist(event, this)">
																	</form>
																</td>
															</tr>
														</cfoutput>
														
													</table>
												<cfelse>
													<table cellspacing="0" cellpadding="0" border="0" width="100%">
														<tr>
															<td align="center" style="padding: 25px; font-weight: bold;">
																Sorry -- no results found.  Please try again.
															</td>
														</tr>
													</table>
												</cfif>
											</div>


											<div class="table-cart-detail mt-5">
												<h5><strong>Sell Your Art On GALLART.COM!:</strong></h5>
												
													<button  type="button" class="btn btn-primary mb-2 btn-sm" style="background: #ec008c; float:right; border: 2px solid #ec008c" onClick="javascript:goxss('user_listing_detail.cfm?xss=<cfoutput>#xss#</cfoutput>')">Add New Listings</button>
													

												<cfif getSellerRecord.recordCount GT 0>
													<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
														<tr>
															<td width="30%" height="20"><b>Title</b></td>
															<td width="30%" align="center"><b>Artist</b></td>
															<td width="10%" align="center"><b>Thumbnail</b></td>
															<td width="15%" align="center"><b>Price</b></td>
															<td width="15%" align="center"><b>Action</b></td>
														</tr>

														<cfoutput query="getSellerRecord">
															<cfif listlen(manufacturer) gt 1>
																<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
																<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
															<cfelse>
																<cfset artist_name = manufacturer />
																<cfset artist_name_url = manufacturer />
															</cfif>

															<tr>
																<td valign="center">
																	#REReplace(name, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")#
																</td>
																<td align="center" valign="middle">
																	# REReplace(artist_name, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")#
																</td>
																<td align="center" valign="middle">
																	<cfif fileexists("http://23.20.226.157/img/thumbnails/#getSellerRecord.uid#.jpg")> 
																		<IMG SRC="./img/#uid#.jpg?x=randrange(1,99)"   width="100" BORDER="0" ALT="#getSellerRecord.uid#" align="Center">
																		<cfelse>
																			<!--- <img src="https://dummyimage.com/150x100/050005/ededf2.png&text=No+Image+Available+"> --->
																			<img src="http://23.20.226.157/img/thumbnails/noImage.jfif.jpeg">
																	</cfif>
																</td>
																<td align="center" valign="middle">#dollarformat(gallery_price)#</td>
																<td align="center" valign="middle">
																	<input type="submit" class="Seemore" value="Update" onClick="javascript:goxss('user_listing_detail.cfm?ID=#URLEncodedFormat(getSellerRecord.UID)#')">
																</td>
															</tr> 
														</cfoutput>
														
													</table>
												<cfelse>
													<table cellspacing="0" cellpadding="0" border="0" width="100%">
														<tr>
															<td align="center" style="padding: 25px; font-weight: bold;">
																Sorry -- no results found.  Please try again.
															</td>
														</tr>
													</table>

												</cfif>

												
											</div>



											<div class="table-cart-detail mt-5">
												<h5><strong>Review Purchase Orders:</strong></h5>

												<cfif get_items.recordCount GT 0 >
													<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
														<tr>
															<td width="30%" height="20"><b>Title</b></td>
															<td width="10%" align="center"><b>Model No.</b></td>
															<td width="10%" align="center"><b>ID</b></td>
															<td width="25%" ><b>Artist</b></td>
															<td width="15%" align="center"><b>Total Price</b></td>
															<td width="15%" align="center"><b>Email</b></td>
															
														</tr>

														<cfoutput query="get_items">
															<cfif listlen(artist) gt 1>
																<cfset artist_name = "#listlast(artist)# #listfirst(artist)#" />
																<cfset artist_name_url = "#listlast(artist)#_#listfirst(artist)#" />
															<cfelse>
																<cfset artist_name = artist />
																<cfset artist_name_url = artist />
															</cfif>

															<tr>
																<td valign="center">
																	#REReplace(get_items.title, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")#  
																</td>
																<td align="center" valign="middle">#get_items.modelno#</td>
																<td align="center" valign="middle">#get_items.ID#</td>
																<td  >
																	# REReplace(artist_name, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")# 
																</td>
																<td align="center" valign="middle">#dollarformat(get_items.total_price)#</td>
																<td align="center" valign="middle">#get_items.email#</td>
															</tr> 
														</cfoutput>

													</table> 
												<cfelse>
													<table cellspacing="0" cellpadding="0" border="0" width="100%">
														<tr>
															<td align="center" style="padding: 25px; font-weight: bold;">
																Sorry -- no results found.  Please try again.
															</td>
														</tr>
													</table>
												</cfif>

												
											</div>

											
											
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="footer-section">
                <cfinclude template="footer_user.cfm">
            </div>
		</div>
	</div>


	<script>
		function deleteWishlist(event, button){

			event.preventDefault(); // Prevent form submission

			var wishlist_pk_id = $(button).closest("form").find("#wishlist_pk_id").val();

			console.log(wishlist_pk_id);

            if(confirm("Are you sure you want to delete this item?")){

				$.ajax({
					url: "inquiry.cfm", // ColdFusion file handling the request
					type: "POST",
					data: { wishlist_pk_id: wishlist_pk_id },
					dataType: "json",
					success: function (response) {
						if (response.status === "success") {
							toastr.success(response.message);
							// Remove the row from the table
							$(button).closest("tr").fadeOut(300, function () {
								$(this).remove();
							});
						} else {
							toastr.warning(response.message);
						}
					},
					error: function () {
						toastr.error("Error deleting item from wishlist.");
					}
				});

			}
		}
	</script>

<cfinclude template="frmxss.cfm">

</body>
</html>