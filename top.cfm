<link href="stylesheet_print.css?x=<cfoutput>#RandRange(0,1000)#</cfoutput>" rel="stylesheet" type="text/css" media="print" />
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
	<div class="title"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>"><img src="images/top_01.jpg" width="634" height="123" alt="Gallery Art - Buying & Selling Fine Art & Collections"></a></div>
    <div class="mailto">
    	<img src="images/top_02.jpg" width="166" height="53" alt="">
    	<a href="mailto:sales@gallart.com"><img src="images/top_03.jpg" width="166" height="70" alt="20633 Biscayne Blvd, Aventura, FL 33180, 305.932.6166" border="0"></a>
    </div>
    <div class="top_icons" style="float:left; width: 210px;">
		<a href="https://www.facebook.com/pages/GallArt/119056118127427?ref=hl" target="_blank">
			<img src="https://gallart.com/images/social_icons/facebook-sm.png" border="0" alt="facebook" /></a>
		<a href="https://instagram.com/gallartcom/" target="_blank">
			<img src="https://gallart.com/images/social_icons/instagram-sm.png" border="0" alt="instagram" /></a>
		<a href="https://twitter.com/GallArtcom" target="_blank">
			<img src="https://gallart.com/images/social_icons/twitter-sm.png" border="0" alt="twitter" /></a>
		<a href="https://www.tumblr.com/blog/gallartcom" target="_blank">
			<!--- <img src="https://gallart.com/images/social_icons/tumblr-sm.png" border="0" alt="tumblr" /></a>
		<a href="https://www.pinterest.com/gallartcom/" target="_blank"> --->
			<img src="https://gallart.com/images/social_icons/pinterest-sm.png" border="0" alt="pinterest" /></a>
		<a href="https://www.linkedin.com/company/fine-art-gallery" target="_blank">
			<img src="https://gallart.com/images/social_icons/linkedin.png?x=y" border="0" alt="linkedin" /></a>
		<!--- <a href="https://plus.google.com/109102775092016158483/posts" target="_blank">
			<img src="https://gallart.com/images/social_icons/Gplus.png" border="0" alt="googleplus" /></a> --->
			<a href="https://www.tiktok.com/@GallArtcom" target="_blank">
				<img src="https://gallart.com/images/social_icons/tik-tok.png" border="0" alt="tiktok" style="
				height: 50px;">
				<!--- https://www.tiktok.com/@yourusername --->
			</a>
			<a href="https://www.youtube.com/channel/yourchannelid" target="_blank">
				<img src="https://gallart.com/images/social_icons/youtube.png" border="0" alt="youtube" style="
					height: 50px;">
				<!--- https://www.youtube.com/channel/yourchannelid --->
			</a>
    </div>
</div>
<!---<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="##000000">
	<tr>
		<td rowspan="2">
			<!--- <img src="images/top_01.jpg" width="634" height="123" alt=""> --->
			<img src="images/gallart_animation.gif" width="634" height="123" alt="">
		</td>
		<td align="right"><img src="images/top_02.jpg" width="166" height="53" alt=""></td>
	</tr>
	<tr>
		<td align="right"><a href="mailto:websitegallart@gallart.com"><img src="images/top_03.jpg" width="166" height="70" alt="" border="0"></a></td>
	</tr>
</table>
</cfoutput>--->

