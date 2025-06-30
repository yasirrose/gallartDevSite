<cfoutput>
	<footer>
		<div class="footer-container">
			<div class="footer-wrapper">
				<div class="top-footer">
					<div class="row">
						<div class="col-md-2 col-sm-6 col-12 mb-3 footer-items">
							<div class="footer-menu">
								<h3>Main Menu</h3>
								<!--- <cfdump var="#cookiesAccepted#"> --->
								<ul>
									<li> <a href="/">Home</a> </li>
									<!--- <li> <a href="user_registration">Sell Your Art</a> </li>
									<li> <a href="requests">Requests</a> </li>
									<li> <a href="quotes">Quotes</a> </li>
									<li> <a href="mailing_list">Mailing List</a> </li>
									<li> <a href="buyer_info">Buyer Info</a> </li>
									<li> <a href="seller_info">Seller Info</a> </li>
									<li> <a href="searchpage">Search</a> </li>
									<li> <a href="alerts">Alert</a> </li>
									<li> <a href="http://blog.gallart.com/">Blog</a> </li> --->
									<!-- <li> <a href="contact">Contact Us</a> </li> -->
									<li> <a href="/search">Search</a> </li>
									<li> <a href="/recent-acquisitions">Recent Acquisitions</a> </li>
									<li> <a href="/sale-items">Sales</a> </li>
									<li> <a href="/classifieds">Classifieds</a> </li>
									<li> <a href="/events">Events</a> </li>
									<li> <a href="/sell-your-art">Sell Your Art</a> </li>
									<li> <a href="/promotion">Promotion</a> </li>

									
								</ul>
							</div>
						</div>
						<div class="col-md-2 col-sm-6 col-12 mb-3 footer-items">
							<div class="footer-menu">
								<h3>Customer Service</h3>
								<ul>
									<li> <a href="/login">Account</a> </li>
									<li> <a href="/view-cart">View Cart</a> </li>
									<li> <a href="/shipping-policy">Shipping Policy</a> </li>
									<li> <a href="/privacy">Privacy</a> </li>
									<li> <a href="/terms">Terms of Use</a> </li>
								</ul>
							</div>
						</div>
						<div class="col-md-2 col-sm-6 col-12 mb-3 footer-items">
							<div class="footer-menu">
								<h3>Contact Us</h3>
								<div class="address">
									<!-- <p>Fine Art, Buy/Sell, 8,000 Sq, Ft. Showroom. Works by Warhol, Lichtenstein, Wesselmann, Indiana, Picasso, Chagall, Haring, Max, Britto, Neiman & more 20633 Biscayne Blvd, Aventura, FL</p>
									<ul>
										<li><a href="tel:33180 305.932.6166">33180 305.932.6166</a></li>
										<li><a href="mailto:info@gallart.com">info@gallart.com</a></li>
									</ul> -->

									<p>Gallery Art <br>20633 Biscayne Blvd Suite C2<br> Aventura, FL 33180 </p>
									<ul>
										<li><a href="tel:305.932.6166">305.932.6166</a></li>
										<li><a href="305.439.7422">305.439.7422 (Text) </a></li>
										<li><a href="/contact-us">info@gallart.com</a></li>
									</ul>

									

								</div>
							</div>
						</div>
						<div class="col-md-3 col-sm-6 col-12 mb-3 footer-items">
							<div class="footer-menu">								
								<div class="map-image">
									<a href="https://maps.app.goo.gl/MZniVSbiddj1X1vWA" target="_blank">
										<img src="/images/Gallery-Art-Map-V2.jpg" alt="image">
									</a>
								</div>
							</div>
						</div>
						<div class="col-md-3 col-sm-6 col-12 mb-3 footer-items">
							<div class="footer-menu mb-3">
								<h3>Subscribe to our Newsletter</h3>
								<div class="address">
									<p class="mb-3">Subscribe to receive our newsletter and notifications about new arrivals.</p>
									<div class="footer__newsletter">
										<form method="POST" onsubmit="return validateFormForNewsletter()">
											<input type="email" id="footerEmail" size="15" maxsize="15" name="footerEmail"  placeholder="Enter Your Email">
											<span class="error-message" id="footerEmailError"></span>
											<button type="submit" class="footer__newsletter-btn" name="commit" aria-label="Subscribe">
												<i class="fa fa-envelope"></i>
												<span class="footer__newsletter-btn-label">
													Subscribe
												</span>
											</button>
										</form>
									</div>
								</div>
							</div>			
							<div class="footer-menu">
								
								<h3>Stay Connected</h3>
								<div class="social-media">
									<ul>
										<li>
											<a href="https://www.facebook.com/pages/GallArt/119056118127427?ref=hl" target="_blank">
												 <img src="https://gallart.com/images/social_icons/facebook-sm.png" border="0" alt="facebook" /> 
												<!-- - <p style="font-size:25px; color:##959595;">
													<i class="fab fa-facebook-square"></i>
												</p> - -->
											</a>
										</li>
										<li>
											<a href="https://instagram.com/gallartcom/" target="_blank">
												 <img src="https://gallart.com/images/social_icons/instagram-sm.png" border="0" alt="instagram" /> 
												<!--- <p style="font-size:25px; color:##959595;">
													<i class="fab fa-instagram-square"></i>
												</p> --->
											</a>
										</li>
										<li>
											<a href="https://twitter.com/GallArtcom" target="_blank">
												 <img src="https://gallart.com/images/social_icons/twitter-sm.png" border="0" alt="twitter" /> 
												<!--- <p style="font-size:25px; color:##959595;">
													<i class="fab fa-twitter-square"></i>
												</p> --->
											</a>
										</li>
										<li>
											<a href="https://www.pinterest.com/gallartcom/" target="_blank">
												 <img src="https://gallart.com/images/social_icons/pinterest-sm.png" border="0" alt="pinterest" /> 
												<!--- <p style="font-size:25px; color:##959595;">
													<i class="fab fa-pinterest-square"></i>
												</p> --->
											</a>
										</li>
										<li>
											<a href="https://www.linkedin.com/company/fine-art-gallery" target="_blank">
												 <img src="https://gallart.com/images/social_icons/linkedin.png?x=y" border="0" alt="linkedin" /> 
												<!--- <p style="font-size:25px; color:##959595;">
													<i class="fab fa-linkedin"></i>
												</p> --->

											</a>
										</li>
										<li>
											<a href="https://www.tiktok.com/@gallart.com?_t=8pV8Ytrax5j&_r=1" target="_blank">
												 <img src="https://gallart.com/images/social_icons/tik-tok.png" border="0" alt="tiktok" /> 
												<!--- <p style="font-size:25px; color:##959595;">
													<i class="fab fa-tiktok"></i>
												</p> --->
											</a>
										</li>
										<li>
											<a href="https://youtu.be/IcsQJXlEMrA?si=Y06pms8b5_vgz3Pq" target="_blank">
												 <img src="https://gallart.com/images/social_icons/youtube.png" border="0" alt="youtube" /> 
												<!--- <p style="font-size:25px; color:##959595;">
													<i class="fab fa-youtube-square"></i>
												</p> --->
											</a>
										</li>		
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="bottom-footer">
					<p>copyright #year(createodbcdate(now()))# www.gallart.com</p>
				</div>
			</div>
		</div>

		<cfif structKeyExists(cookie, "cookiesAccepted")>
			<cfset cookiesAccepted = cookie.cookiesAccepted>
		<cfelse>
			<cfset cookiesAccepted = "not_set">
		</cfif>

		<script>
			function validateFormForNewsletter() {
				let isValid = true;
			
				// Clear previous error messages
				document.querySelectorAll('.error-message').forEach(error => error.textContent = '');

				const email = document.getElementById('footerEmail').value.trim();

				if (!email) {
					document.getElementById('footerEmailError').textContent = 'Please enter your email address.';
					isValid = false;
				} else if (!/\S+@\S+\.\S+/.test(email)) {
					document.getElementById('footerEmailError').textContent = 'Please enter a valid email address.';
					isValid = false;
				}

				return isValid;
				
			}
		</script>
		
		
		<cfif NOT StructKeyExists(cookie, "userConsent")>
			<div id="cookies-banner" style="display:block;">
				<div class="cookie-banner-left">
					<p>This website uses cookies to ensure you get the best experience on our website.</p>
				</div>
				<div class="cookie-banner-right">
					<button class="button button--secondary button--auto-width button--center" id="decline-btn">Decline</button>
					<button class="button button--primary button--auto-width button--center" id="accept-btn">Accept</button>
				</div>
			</div>
		</cfif>
		
	</footer>

	<cfif isDefined('form.footerEmail') and form.footerEmail neq ''>
		<cfset email = trim(FORM.footerEmail)>
		<cfset ipAddress = cgi.remote_addr>
		<cfset createdAt = now()>

		
		<cfquery name="qGetNewsLetterUserLogs" datasource="#application.dsource#">
			Select * FROM newsLetterUsers where CAST([created_at] AS DATE) = #createdAt# and ipAddress = '#ipAddress#' and isdeleted is null
		</cfquery>
		
		<!--- <cfdump var="#form#" abort="true"> --->
		<!--- <cfdump var="#qGetNewsLetterUserLogs.recordCount#" abort="true"> --->

		<cfif qGetNewsLetterUserLogs.recordCount LT 2>

			<cfquery name="qGetNewsLetterUser" datasource="#application.dsource#">
				Select * FROM newsLetterUsers where email = '#form.footerEmail#' and isdeleted is null
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
							alert('Your Email is Submitted');
							window.location.href = '/';
						</script>
					</cfoutput>
				<cfelse>
					<cfset session.email = email>
					<cfoutput>
						<script>
							alert('You are already subscribed.');
							window.location.href = '/';
						</script>
					</cfoutput>
			</cfif>
		 <cfelse>
			<cfoutput>
				<script>
					alert('You cannnot add record more than 2 times');
					// window.location.href = '#script_name#';
				</script>
			</cfoutput>
		</cfif>

		
		
	
		<!--- <cfelse>
			<cfoutput>
				<p style="color: red;">Error: Please fill out all required fields before submitting the form.</p>
			</cfoutput> --->
		
	</cfif>

	
	</cfoutput>
	
	

	<script>
        document.addEventListener("DOMContentLoaded", function () {
            // Check if the cookie consent banner should be displayed
            if (!document.cookie.split("; ").find(row => row.startsWith("userConsent="))) {
                document.getElementById("cookies-banner").style.display = "block";
            }

            // Handle Accept button click
            document.getElementById("accept-btn").addEventListener("click", function () {
                document.cookie = "userConsent=accepted; path=/; max-age=" + 60 * 60 * 24 * 365; // 1 year
                document.getElementById("cookies-banner").style.display = "none";
            });

            // Handle Decline button click
            document.getElementById("decline-btn").addEventListener("click", function () {
                document.cookie = "userConsent=declined; path=/; max-age=" + 60 * 60 * 24 * 365; // 1 year
                document.getElementById("cookies-banner").style.display = "none";
            });
        });
    </script>

	<style>
		.error-message {
			color: #ff0000;
			font-size: 0.9em;
			margin-top: 5px;
			display: block;
		}
	</style>
	
	<!--- <cfif structKeyExists(url, "action") AND url.action EQ "setCookie">
		<!-- Set the cookie values based on the URL parameters -->
		<cfset cookie.cookiesAccepted = url.value>
		<cfset cookie.cookiesAccepted.expires = createDateTime(year(now()) + 1, month(now()), day(now()), hour(now()), minute(now()), second(now()))>
		<cfset cookie.cookiesAccepted.path = "/">
	</cfif> --->
	