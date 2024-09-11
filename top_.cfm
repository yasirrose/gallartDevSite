<link href="stylesheet_print.css?x=<cfoutput>#RandRange(0,1000)#</cfoutput>" rel="stylesheet" type="text/css" media="print" />
<!--- <cfoutput>

	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</cfoutput> --->
<script language="JavaScript">
function helpWin(url) {
	w = 350;  // width
	h = 75;  // height
	var features =	'scrollbars=no, toolbar=no, status=no, menubar=no ' +
					',resizable=no, location=no, directories=no ' +
					',left=' + ((screen.width-w)/2) +
					',top='  + ((screen.height-h)/2) +
					',width=' + w + ',height=' + h;

	myWin =	window.open(url,'WinName',features);
}
</script>
<div id="top">
	<div class="top-conteiner">
		<div class="site-logo"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>"><img src="images/top_01.jpg" alt="Gallery Art - Buying & Selling Fine Art & Collections"></a></div>
		<div class="mailto">
			<div class="mailto-text">
				<p>20633 Biscayne Blvd Aventura, FL 33180</p>
				<p><strong>305-932-6166</strong></p>
			</div>
			<a class="btn" href="mailto:sales@gallart.com">Email Us! CLICK!</a>
		</div>
		<div class="top_icons">
			<a href="https://www.facebook.com/pages/GallArt/119056118127427?ref=hl" target="_blank"><img src="https://gallart.com/images/social_icons/facebook-sm.png" border="0" alt="facebook" /></a>
			<a href="https://instagram.com/gallartcom/" target="_blank"><img src="https://gallart.com/images/social_icons/instagram-sm.png" border="0" alt="instagram" /></a>
			<a href="https://twitter.com/GallArtcom" target="_blank"><img src="https://gallart.com/images/social_icons/twitter-sm.png" border="0" alt="twitter" /></a>
			<!--- <a href="https://www.tumblr.com/blog/gallartcom" target="_blank"><img src="https://gallart.com/images/social_icons/tumblr-sm.png" border="0" alt="tumblr" /></a> --->
			<a href="https://www.pinterest.com/gallartcom/" target="_blank"><img src="https://gallart.com/images/social_icons/pinterest-sm.png" border="0" alt="pinterest" /></a>
			<a href="https://www.linkedin.com/company/fine-art-gallery" target="_blank"><img src="https://gallart.com/images/social_icons/linkedin.png?x=y" border="0" alt="linkedin" /></a>
			<!--- <a href="https://plus.google.com/109102775092016158483/posts" target="_blank"><img src="https://gallart.com/images/social_icons/Gplus.png" border="0" alt="googleplus" /></a> --->
			<a href="https://www.tiktok.com/@gallart.com?_t=8pV8Ytrax5j&_r=1" target="_blank">
				<img src="https://gallart.com/images/social_icons/tik-tok.png" border="0" alt="tiktok" />
				<!--- https://www.tiktok.com/@yourusername --->
			</a>
			<a href="https://youtu.be/IcsQJXlEMrA?si=Y06pms8b5_vgz3Pq" target="_blank">
				<img src="https://gallart.com/images/social_icons/youtube.png" border="0" alt="youtube" />
				<!--- https://www.youtube.com/channel/yourchannelid --->
			</a>
			
		</div>
	</div>
</div>

