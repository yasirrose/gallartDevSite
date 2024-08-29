<script>

	//   <!-- Start Sidebar Toddle -->

	document.addEventListener("DOMContentLoaded", function() {
    // Select the elements
    var modal = document.querySelector(".web-sidebar-modal");
    var trigger = document.querySelector(".sidebar-Icon");
    var closeButton = document.querySelector(".close-button");

    // Check if all elements are found
    if (modal && trigger && closeButton) {
        // Define toggleModal function
        function toggleModal() {
            modal.classList.toggle("show-sidebar-modal");
			document.body.classList.toggle("body-overflow");
        }

        // Define windowOnClick function
        function windowOnClick(event) {
            if (event.target === modal) {
                toggleModal();
            }
        }

        // Attach event listeners
        trigger.addEventListener("click", toggleModal);
        closeButton.addEventListener("click", toggleModal);
        window.addEventListener("click", windowOnClick);
    } else {
        console.error("One or more elements not found!");
    }
	});

//   <!-- End Sidebar Toddle -->
</script>

<cfoutput>
	<!--- <script language="JavaScript" src="./js/utils.js"></script> --->
	<div id="left">
		<div class="productSearch-filed web-search">
			<form action="products.cfm?xss=#xss#" method="post">
			<input type="text" name="keywords" placeholder="Product Search">                  
			<button type="button" class="search-btn"><i class="fas fa-search"></i></button>
			</form>
		</div>
		<div class="advance-search">
			<a href="searchpage.cfm?xss=#xss#">ADVANCED SEARCH </a>
			<button class="close-button">
				<i class='fas fa-times'></i>
			</button>
		</div>
		<div class="mobile-overlay">	
			<div class="box">
				<a href="quotes.cfm?xss=#xss#"></a>
			</div>
			<div class="box">
				<span>How To Buy From Gallery Art</span>
				<ul>
				<li><i class="fas fa-check"></i><a href="searchpage.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">Search Our Listings</a></li>
				<li><i class="fas fa-check"></i><a href="buyer_info.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">Review Buyer Info</a></li>
				<li><i class="fas fa-check"></i><a href="##">Click Thumbnail Image</a></li>
				<li><i class="fas fa-check"></i><a href="##">Buy Online, or</a></li>
				<li><i class="fas fa-check"></i><a href="contact.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">Contact Gallery Art</a></li>
				</ul>
			</div>
			<div class="box">
				<span>How To Sell On Gallery Art</span>
				<ul>
				<li><i class="fas fa-check"></i><a href="user_registration.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">Register</a></li>
				<li><i class="fas fa-check"></i><a href="seller_info.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">Review Seller Info</a></li>
				<li><i class="fas fa-check"></i><a href="user_listing_search.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">List Your Art</a></li>
				</ul>
				<span class="small">It is free to list with Gallery Art. You only pay a 20% commission on items that are sold.</span>
			</div>
			<div class="box">
				<span>Looking For A Particular Piece?</span><br><br>
				<span class="span-text">If you can't find what you're looking for on our site, you can post a request on our <a href="requests.cfm?xss=#xss#">ART WANTED</a> page.  In order to make requests, you must be a registered member of Gallery Art.  Click <a href="requests_registration.cfm?xss=#xss#">HERE</a> to register.  For more information, please click <a href="requests_info.cfm?xss=#xss#">HERE</a>.</span>			
			</div>
		</div>
		
<!--- 		<div class="featured">  
			<cfinclude template="featured.cfm">
		</div>--->
	</div>
</cfoutput>


<!---<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" height="100%">
	<tr>
		<td valign="top" style="padding-top: 20px;">
			<table border="0" cellspacing="0" cellpadding="0" background="images/product_search.jpg" style="background-repeat: no-repeat; background-position: top;" width="173" height="121">
				<form action="products.cfm?xss=#xss#" method="post">
				<tr>
					<td style="padding-left: 20px; padding-top: 65px;">
						<input type="text" name="keywords" style="font-size: 14px; width: 132px;">
					</td>
				</tr>
				<tr>
					<td style="padding-left: 92px; padding-bottom: 7px;">
						<input type="image" src="images/find_but.jpg" alt="Search by Keyword or Artist" style="border: 1px solid ##ffffff;">
					</td>
				</tr>
				</form>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" style="padding-top: 20px;">
			<a href="searchpage.cfm?xss=#xss#">ADVANCED SEARCH >></a>
		</td>
	</tr>
	<tr>
		<td valign="top" style="padding: 20px 0 0 12px;">
			<table cellspacing="0" cellpadding="5" border="0" width="150" style="border: 3px solid ##000000;">
				<tr>
					<td>
						<a href="quotes.cfm?xss=#xss#">GET A FREE QUOTE FROM GALLERY ART</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top" style="padding: 20px 0 0 12px;">
			<table cellspacing="0" cellpadding="5" border="0" width="150" style="border: 3px solid ##000000;">
				<tr>
					<td>
						<strong>How To Buy <br>From Gallery Art</strong>
					</td>
				</tr>
				<tr>
					<td style="font-size: 14px;">
						<li><a href="searchpage.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">Search Our Listings</a></li>
					</td>
				</tr>
				<tr>
					<td style="font-size: 14px;">
						<li><a href="buyer_info.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">Review Buyer Info</a></li>
					</td>
				</tr>
				<tr>
					<td style="font-size: 14px;">
						<li>Click Thumbnail Image</li>
					</td>
				</tr>
				<tr>
					<td style="font-size: 14px;">
						<li>Buy Online, or</li>
					</td>
				</tr>
				<tr>
					<td style="font-size: 14px;">
						<li><a href="contact.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">Contact Gallery Art</a></li>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top" style="padding: 20px 0 0 12px;">
			<table cellspacing="0" cellpadding="5" border="0" width="150" style="border: 3px solid ##000000;">
				<tr>
					<td>
						<strong>How To Sell <br>On Gallery Art</strong>
					</td>
				</tr>
				<tr>
					<td>
						<li><a href="user_registration.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">Register</a></li>
					</td>
				</tr>
				<tr>
					<td>
						<li><a href="seller_info.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">Review Seller Info</a></li>
					</td>
				</tr>
				<tr>
					<td>
						<li><a href="user_listing_search.cfm?xss=#xss#" style="font-size: 14px; font-weight: normal;">List Your Art</a></li>
					</td>
				</tr>
				<tr>
					<td style="font-size: 7pt;">
						It is free to list with Gallery Art. You only pay a 20% commission on items that are sold.
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top" style="padding: 20px 0 0 12px;">
			<table cellspacing="0" cellpadding="5" border="0" width="150" style="border: 3px solid ##000000;">
				<tr>
					<td>
						<strong>Looking For A Particular Piece?</strong>
					</td>
				</tr>
				<tr>
					<td>
						If you can't find what you're looking for on our site, you can post a request on our <a href="requests.cfm?xss=#xss#">ART WANTED</a> page.  In order to make requests, you must be a registered member of Gallery Art.  Click <a href="requests_registration.cfm?xss=#xss#">HERE</a> to register.  For more information, please click <a href="requests_info.cfm?xss=#xss#">HERE</a>.
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr height="100%">
		<td height="100%" valign="top">
			<table border="0" cellspacing="0" cellpadding="0" background="images/featured.jpg" style="background-repeat: no-repeat; background-position: top;" width="173" height="100%">
				<tr>
					<td valign="top">
						<cfinclude template="featured.cfm">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>
--->