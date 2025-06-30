<script>

	//   <!-- Start Sidebar Toddle -->

	document.addEventListener("DOMContentLoaded", function() {
    // Select the elements
	var modal = document.querySelector(".navbar-collapse");
    var trigger = document.querySelector(".navbar-toggler");

    // Check if all elements are found
    if (modal && trigger) {
        // Define toggleModal function
        function toggleModal() {
            modal.classList.toggle("show");
        }

        // Define windowOnClick function
        function windowOnClick(event) {
            if (event.target === modal) {
                toggleModal();
            }
        }

        // Attach event listeners
        trigger.addEventListener("click", toggleModal);
        window.addEventListener("click", windowOnClick);
    } else {
        console.error("One or more elements not found!");
    }
	});

//   <!-- End Sidebar Toddle -->
</script>

<cfoutput>
<!--- <div class="navContainer">
	<ul>
		<li>
			<a href="index.cfm" class="navElement">Home</a>
		</li>
		<li>
			<a href="user_registration.cfm" class="navElement">Sell Your Art</a>
		</li>
		<li>
			<a href="alerts.cfm" class="navElement">Alerts</a>
		</li>
		<li>
			<a href="recent-acquisitions" class="navElement">Recent Acquisitions</a>
		</li>
		<li>
			<a href="classifieds.cfm" class="navElement">Classifieds</a>
		</li>
		<li>
			<a href="featured_events.cfm" class="navElement">Events</a>
		</li>
		<li>
			<a href="sales.cfm" class="navElement">Sales</a>
		</li>
		<li>
			<a href="guests.cfm" class="navElement">Guest Book</a>
		</li>
		<li>
			<a href="http://blog.gallart.com/" class="navElement">Blog</a>
		</li>
	<ul>
</div> --->
<nav class="navbar navbar-expand-lg">
	<div class="navContainer">
	  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="##navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"><i class="fa fa-bars"></i></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav me-auto ms-auto">
			<li class="nav-item">
				<a href="/" class="nav-link">Home</a>
			</li>
			<li class="nav-item">
				<a href="/recent-acquisitions" class="nav-link">Recent Acquisitions</a>
			</li>
			<li class="nav-item">
				<a href="/sale-items" class="nav-link">Sales</a>
			</li>
			<li class="nav-item">
				<a href="/classifieds" class="nav-link">Classifieds</a>
			</li>
			<li class="nav-item">
				<a href="/events" class="nav-link">Events</a>
			</li>
			<li class="nav-item">
				<a href="/sell-your-art" class="nav-link" onclick="clearActiveTab()">Sell Your Art</a>
			</li>
			<li class="nav-item">
				<a href="/about-us" class="nav-link">About</a>
			</li>
			<li class="nav-item">
				<a href="/contact-us" class="nav-link">Contact Us</a>
			</li>
			<!--- <li class="nav-item">
				<a href="alerts" class="nav-link">Alerts</a>
			</li> --->
			<!--- <li class="nav-item">
				<a href="guests.cfm" class="nav-link">Guest Book</a>
			</li> --->
			<!--- <li class="nav-item">
				<a href="http://blog.gallart.com/" class="nav-link">Blog</a>
			</li> --->
			<!--- <li class="sub-items" style="position:relative;">
				<a href="" class="nav-link">More</a>
				<ul class="sub-menu standard">
					<li>Hello</li>
					<li>User</li>
				</ul>
			</li> --->
			<!--- <li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="##" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				  More
				</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a href="requests.cfm" class="dropdown-item">Requests.cfm</a>
					<a href="quotes.cfm" class="dropdown-item">Quotes</a>
					<a href="mailing_list.cfm" class="dropdown-item">Mailing List</a>
					<a href="buyer_info.cfm" class="dropdown-item">Buyer Info</a>
					<a href="seller_info.cfm" class="dropdown-item">Seller Info</a>
					<a href="searchpage.cfm" class="dropdown-item">Search</a>
				</div>
			  </li> --->
		</ul>
	  </div>
	</div>
  </nav>

<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td>
			<cfinclude template="userlogin_frame.cfm">
		</td>
	</tr>
</table>

	

</cfoutput>

<style>
	/* Style for dropdown on hover */
.nav-item.dropdown:hover .dropdown-menu {
	display: block;
}

.dropdown-menu {
	min-width: 10rem; /* Adjust as needed */
	box-shadow: 0 0.5rem 1rem rgba(0,0,0,.15);
	border: none;
	padding: 0;
	margin-top: 30px;
}

.dropdown-item {
	padding: 0.5rem 1rem;
	color: #333;
	text-decoration: none;
	transition: background-color 0.3s ease;
	
}

.dropdown-item:hover {
	color: #EC008C;
	/* background-color: black; */
}
 /* ul.sub-menu.standard {
    position: absolute;
    left: -25px;
    top: 64px;
    padding: 15px 80px 25px 30px;
}
ul.sub-menu {
    display: none;
    background-color: #373a3c;
    z-index: 100;
} */

</style>

<script>
    function clearActiveTab() {
        // Clear the 'activeTab' key from localStorage
		console.log('test');
        localStorage.removeItem('activeTab');
    }
</script>

