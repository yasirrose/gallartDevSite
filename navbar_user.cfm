<cfif isDefined('session.sellerinfo.fname')>

	<cfoutput>
		<nav class="navbar navbar-expand-lg">
			<div class="navContainer">
			  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="##navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"><i class="fa fa-bars"></i></span>
			  </button>
			  <div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto ms-auto">
					<li class="nav-item">
						<p><strong>Welcome Member: #UCASE(session.sellerinfo.fname)# #UCASE(session.sellerinfo.lname)#</strong></p>
					</li>
					<li class="nav-item">
						<a href="JavaScript:void(0)" class="nav-link" onclick="javascript:goxss('index.cfm?xss=#xss#')">Home</a>
					</li>
					<li class="nav-item">
						<a href="JavaScript:void(0)" class="nav-link" onclick="javascript: window.location.href='user_listing_detail.cfm?xss=#xss#'">Enter New Listing</a>
					</li>
					<li class="nav-item">
						<a href="JavaScript:void(0)" class="nav-link" onclick="javascript:goxss('overView.cfm?xss=#xss#')">Account Overview</a>
					</li>
					<li class="nav-item">
						<a href="JavaScript:void(0)" class="nav-link" onclick="window.location.href='logout.cfm<cfif parameterexists(xss)>?xss=#xss#</cfif>'">Log Out</a>
					</li>
				</ul>
			  </div>
			</div>
		</nav>
	</cfoutput>
	
	<cfelse>
	
	<cflocation url="user_login_page.cfm" addtoken="No">
	
	</cfif>
	