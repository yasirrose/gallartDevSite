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
			<a href="index.cfm?xss=#xss#" class="navElement">Home</a>
		</li>
		<li>
			<a href="user_registration.cfm?xss=#xss#" class="navElement">Sell Your Art</a>
		</li>
		<li>
			<a href="alerts.cfm?xss=#xss#" class="navElement">Alerts</a>
		</li>
		<li>
			<a href="new_listings.cfm?xss=#xss#" class="navElement">Recent Acquisitions</a>
		</li>
		<li>
			<a href="classifieds.cfm?xss=#xss#" class="navElement">Classifieds</a>
		</li>
		<li>
			<a href="featured_events.cfm?xss=#xss#" class="navElement">Events</a>
		</li>
		<li>
			<a href="sales.cfm?xss=#xss#" class="navElement">Sales</a>
		</li>
		<li>
			<a href="guests.cfm?xss=#xss#" class="navElement">Guest Book</a>
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
				<a href="index.cfm?xss=#xss#" class="nav-link">Home</a>
			</li>
			<li class="nav-item">
				<a href="user_registration.cfm?xss=#xss#" class="nav-link">Sell Your Art</a>
			</li>
			<li class="nav-item">
				<a href="alerts.cfm?xss=#xss#" class="nav-link">Alerts</a>
			</li>
			<li class="nav-item">
				<a href="new_listings.cfm?xss=#xss#" class="nav-link">Recent Acquisitions</a>
			</li>
			<li class="nav-item">
				<a href="classifieds.cfm?xss=#xss#" class="nav-link">Classifieds</a>
			</li>
			<li class="nav-item">
				<a href="featured_events.cfm?xss=#xss#" class="nav-link">Events</a>
			</li>
			<li class="nav-item">
				<a href="sales.cfm?xss=#xss#" class="nav-link">Sales</a>
			</li>
			<li class="nav-item">
				<a href="guests.cfm?xss=#xss#" class="nav-link">Guest Book</a>
			</li>
			<li class="nav-item">
				<a href="http://blog.gallart.com/" class="nav-link">Blog</a>
			</li>
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
