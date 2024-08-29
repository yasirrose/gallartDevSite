<style>
	table {
		font-family: arial;
	}
	.navContainer {
		margin-top: 10px;
	}
	.navContainer ul {
		list-style: none;
		padding: 0;
  		margin: 0;
	}
	.navContainer ul li {
		float: left;
	}
	.navElement {
		background: url('images/nav_bkg.png') repeat-x;
		padding: 13px 20px 10px;
		color: #FFF!important;
		text-decoration: none;
		text-transform: uppercase;
		font-family: arial;
		font-size: 9pt!important;
		font-weight: normal!important;
		border-left: 1px solid #FFF;
		border-right: 0!important;
	}
	.navElement:hover {
		font-size: 9pt!important;
		font-weight: normal!important;
		color: #CCC!important;
	}
	.navElement:visited {
		font-size: 9pt!important;
		font-weight: normal!important;
	}
</style>

<cfoutput>
<div class="navContainer">
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
</div>
<!--- <table border="0" cellpadding="0" cellspacing="0" width="900" height="37" bgcolor="##000000;">
	<tr>
		<td align="center" valign="top">	
			<a href="index.cfm?xss=#xss#" class="nav"><img src="images/home_nav.gif" border="0" /></a>
		</td>
		<td>
			<hr style="height: 30px; width: 1px;" color="ffffff">
		</td>
		<td align="center" valign="top">
			<a href="user_registration.cfm?xss=#xss#" class="nav"><img src="images/sellyourart_nav.gif" border="0" /></a>
		</td>
		<td>
			<hr style="height: 30px; width: 1px;" color="ffffff">
		</td>
		<td align="center" valign="top">
			<a href="alerts.cfm?xss=#xss#" class="nav"><img src="images/alerts_nav.gif" border="0" /></a>
		</td>
		<td>
			<hr style="height: 30px; width: 1px;" color="ffffff">
		</td>
		<td align="center" valign="top">
			<a href="new_listings.cfm?xss=#xss#" class="nav"><img src="images/recent_acquisitions_nav.gif" border="0" /></a>
		</td>
		<td>
			<hr style="height: 30px; width: 1px;" color="ffffff">
		</td>
		<td align="center" valign="top">
			<a href="classifieds.cfm?xss=#xss#" class="nav"><img src="images/classifieds_nav.gif" border="0" /></a>
		</td>
		<td>
			<hr style="height: 30px; width: 1px;" color="ffffff">
		</td>
		<td align="center" valign="top">
			<a href="featured_events.cfm?xss=#xss#" class="nav"><img src="images/events_nav.gif" border="0" /></a>
		</td>
		<td>
			<hr style="height: 30px; width: 1px;" color="ffffff">
		</td>
		<td align="center" valign="top">
			<a href="sales.cfm?xss=#xss#" class="nav"><img src="images/sales_nav.gif" border="0" /></a>
		</td>
		<td>
			<hr style="height: 30px; width: 1px;" color="ffffff">
		</td>
		<td align="center" valign="top">
			<a href="guests.cfm?xss=#xss#" class="nav"><img src="images/guestbook_nav.gif" border="0" /></a>	
		</td>
		<td>
			<hr style="height: 30px; width: 1px;" color="ffffff">
		</td>
		<td align="center" valign="top">
			<a href="http://blog.gallart.com/" class="nav" target="_blank"><img src="images/blog_nav.gif" border="0" /></a>	
		</td>
	</tr>
</table> --->

<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td>
			<cfinclude template="userlogin_frame.cfm">
		</td>
	</tr>
</table>
</cfoutput>
