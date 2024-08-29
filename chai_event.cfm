<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT path FROM products
	group by path
	order by path
</CFQUERY>

<cfquery name="getPages" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * from pages
	WHERE pk_pages = 3
</cfquery>

<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
<script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>

<link href="stylesheet.css" rel="stylesheet" type="text/css">
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

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="100%" height="125" valign="top" bgcolor="#000000">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="100%" valign="top" height="37" bgcolor="#000000">
			<cfinclude template="navbar.cfm">
		</td>
	</tr>
	<tr height="100%">
		<td valign="top" width="173" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr height="100%">
					<td valign="top" height="100%">	
						<cfinclude template="left.cfm">
					</td>
				</tr>
			</table>
		</td>
		<td valign="top" width="727" height="100%" style="padding-right: 10px;">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td align="center" style="padding-top: 10px;">
						<table width="100%" cellspacing="0" cellpadding="0">
    <tbody>
        <tr>
            <td valign="top" align="left"><span id="lblVIB"> <style type="text/css"> div, p, a, li, td { -webkit-text-size-adjust:none; } @media only screen and (max-device-width: 480px) { /* mobile-specific CSS styles go here */ img[class="hide"] { display:none !important; visibility:hidden !important; } img[class="emailicon"] { height:40px !important; width:240px !important; padding-bottom:10px !important; } img[class="webicon"] { height:40px !important; width:201px !important; padding-bottom:10px !important; } img[class="phoneicon"] { height:40px !important; width:169px !important; padding-bottom:10px !important; } } </style> <style type="text/css"> div, p, a, li, td { -webkit-text-size-adjust:none; } </style>
            <table width="600" border="0" align="center" cellspacing="0" cellpadding="5">
                <tbody>
                    <tr>
                        <td height="50" align="center" style="font-family:Arial, Helvetica, sans-serif; font-size:10px;">
                        <div align="center">&nbsp;</div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table width="650" height="30" border="0" align="center" cellspacing="0" cellpadding="0" id="Table_2">
                <tbody>
                    <tr>
                        <td height="40" align="center"><a href="tel:3059326166" title="Icon Bar - Telephone Number"> <img width="127" height="30" border="0" class="phoneicon" alt="" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/icon-bar_01.jpg" style="display:block;" /> </a></td>
                        <td height="40" align="center"><img width="98" height="30" border="0" class="hide" alt="" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/icon-bar_02.jpg" style="display:block;" /></td>
                        <td height="40" align="center"><a href="http://www.gallart.com" target="_blank" title="Icon Bar - GallArt.com"> <img width="151" height="30" border="0" class="webicon" alt="GallArt.com" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/icon-bar_03.jpg" style="display:block;" /> </a></td>
                        <td height="40" align="center"><img width="95" height="30" border="0" class="hide" alt="" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/icon-bar_04.jpg" style="display:block;" /></td>
                        <td height="40" align="center"><a target="_blank" title="Icon Bar - Ken Email" href="mailto:Sales@GallArt.com"> <img width="179" height="30" border="0" class="emailicon" alt="Email: Sales@GallArt.com" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/icon-bar_05.jpg" style="display:block;" /> </a></td>
                    </tr>
                </tbody>
            </table>
            <table width="650" border="0" bgcolor="#000000" align="center" cellspacing="0" cellpadding="1">
                <tbody>
                    <tr>
                        <td>
                        <table width="700" border="0" align="center" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td bgcolor="#FFFFFF" colspan="6">
                                    <table width="700" height="139" border="0" align="center" cellspacing="0" cellpadding="0" id="Table_">
                                        <tbody>
                                            <tr>
                                                <td colspan="6"><a target="_blank" href="http://www.gallart.com"> <img width="547" height="109" border="0" alt="Gallery Art " src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/newhead_01.jpg" style="display:block" /> </a></td>
                                                <td colspan="2"><a href="mailto:websitegallart@gallart.com"> <img width="153" height="109" border="0" alt="EMAIL US" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/newhead_02.jpg" style="display:block" /> </a></td>
                                            </tr>
                                            <tr>
                                                <td><a href="http://www.gallart.com"> <img width="59" height="30" border="0" alt="HOME" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/newhead_03.jpg" style="display:block" /> </a></td>
                                                <td><a href="http://gallart.com/user_registration.cfm"> <img width="107" height="30" border="0" alt="SELL YOUR ART" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/newhead_04.jpg" style="display:block" /> </a></td>
                                                <td><a href="http://gallart.com/alerts.cfm"> <img width="63" height="30" border="0" alt="ALERTS" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/newhead_05.jpg" style="display:block" /> </a></td>
                                                <td><a href="http://gallart.com/new_listings.cfm"> <img width="154" height="30" border="0" alt="RECENT ACQUISITIONS" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/newhead_06.jpg" style="display:block" /> </a></td>
                                                <td><a href="http://gallart.com/classifieds.cfm"> <img width="96" height="30" border="0" alt="CLASSIFIEDS" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/newhead_07.jpg" style="display:block" /> </a></td>
                                                <td><a href="http://gallart.com/featured_events.cfm"> <img width="68" height="30" border="0" alt="EVENTS" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/newhead_08.jpg" style="display:block" /> </a></td>
                                                <td><a href="http://gallart.com/sales.cfm"> <img width="53" height="30" border="0" alt="SALES" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/newhead_09.jpg" style="display:block" /> </a></td>
                                                <td><a href="http://gallart.com/guests.cfm"> <img width="100" height="30" border="0" alt="GUEST BOOK" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/newhead_10.jpg" style="display:block" /> </a></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <!-- new site -->
                                    <table id="Table_01" height="1049" width="700" border="0" cellpadding="0" cellspacing="0">
                                        <tbody>
                                            <tr>
                                                <td colspan="4"><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_01.jpg" alt="Gallery Art and Chai Lifeline Present" height="64" width="700" border="0"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" rowspan="4"><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_02.jpg" alt="" height="496" width="408" border="0"></td>
                                                <td><a id="LID239030" href="http://www.beargivers.org/"><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_03.jpg" alt="A $50 Donation per couple is recommended" height="74" width="292" border="0"></a></td>
                                            </tr>
                                            <tr>
                                                <td><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_04.jpg" alt="Through the Eyes of Our Children" height="157" width="292" border="0"></td>
                                            </tr>
                                            <tr>
                                                <td><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_05.jpg" alt="A Celebration of Expression!
                                                Featuring Artwork by Chai Lifeline Southeast Children and their Siblings Impacted by Serious Illness." height="140" width="292" border="0"></td>
                                            </tr>
                                            <tr>
                                                <td><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_06.jpg" alt="Saturday Evening
                                                November 22, 2014
                                                8:00pm" height="125" width="292" border="0"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="4"><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_07.jpg" alt="at Gallery Art
                                                20633 Biscayne Blvd.
                                                Aventure, FL 33180" height="51" width="700" border="0"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3"><a id="LID239031" href="http://gallart.com/"><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_08.jpg" alt="One Night Only Exhibition & Sale
                                                &quot;The Children's Art&quot;
                                                100% of the proceeds from &quot;The Children's Art&quot; Sale will benefit Chai Lifeline Southeast's therapeutic and recreational programs for seriously ill children and their families." height="337" width="408" border="0"></a></td>
                                                <td><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_09.jpg" alt="" height="337" width="292" border="0"></td>
                                            </tr>
                                            <tr>
                                                <td><a id="LID239032" href="http://www.chailifeline.org/"><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_10.jpg" alt="Chai Lifeline" height="30" width="132" border="0"></a></td>
                                                <td><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_11.jpg" alt="" height="30" width="76" border="0"></td>
                                                <td><a id="LID239033" href="http://www.chailifeline.org/"><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_12.jpg" alt="Chai Crafts" height="30" width="200" border="0"></a></td>
                                                <td><a id="LID239034" href="http://www.beargivers.org/"><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_13.jpg" alt="Bear Givers" height="30" width="292" border="0"></a></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3"><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_14.jpg" alt="" height="71" width="408" border="0"></td>
                                                <td><img style="display:block" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/pcard_15.jpg" alt="" height="71" width="292" border="0"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <!-- end new site -->
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="#000000" colspan="6">
                                    <table width="100%" border="0" align="center" cellspacing="0" cellpadding="5">
                                        <tbody>
                                            <tr>
                                                <td bgcolor="#CCCCCC">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse; border:0px; margin:0px; font:9px Tahoma, Geneva, sans-serif;">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center"><a target="_blank" title="Facebook Icon" href="https://www.facebook.com/pages/GallArt/119056118127427"> <img border="0" style="display:block" class="icon" alt="Facebook Icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-facebook-m.png" /> </a></td>
                                                            <td align="center"><a target="_blank" title="Twitter Icon" href="https://twitter.com/GallArt_com"> <img border="0" style="display:block" class="icon" alt="Twitter Icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-twitter-m.png" /> </a></td>
                                                            <td align="center"><a target="_blank" title="GallArt.com Website Icon" href="http://gallart.com/index.cfm"> <img border="0" style="display:block" class="icon" alt="GallArt.com Icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-gallart-m.png" /> </a></td>
                                                            <td align="center"><a target="_blank" title="Email Ken Icon" href="mailto:Ken@GallArt.com"> <img border="0" style="display:block" class="icon" alt="Email Icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-mail-m.png" /> </a></td>
                                                            <td align="center"><a target="_blank" title="Instagram Icon" href="http://instagram.com/gallartdotcom"> <img border="0" style="display:block" class="icon" alt="Instagram Icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-instagram-m.png" /> </a></td>
                                                            <td align="center"><a target="_blank" title="Tumblr Icon" href="http://gallartcom.tumblr.com/"> <img border="0" style="display:block" class="icon" alt="Tumblr Icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-tumblr-m.png" /> </a></td>
                                                            <td align="center"><a target="_blank" title="Pinterest Icon" href="http://www.pinterest.com/gallartcom/"> <img border="0" style="display:block" class="icon" alt="Pinterest Icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-pinterest-m.png" /> </a></td>
                                                            <td align="center"><a target="_blank" title="LinkedIn Icon" href="https://www.linkedin.com/profile/view?id=57648280"> <img border="0" style="display:block" class="icon" alt="LinkedIn Icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-linkedin-m.png" /> </a></td>
                                                            <td align="center"><a target="_blank" title="Google Plus Icon" href="https://plus.google.com/u/0/100061127067895667263/posts"> <img border="0" style="display:block" class="icon" alt="Google Plus Icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-googleplus-m.png" /> </a></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">Facebook</td>
                                                            <td align="center">Twitter</td>
                                                            <td align="center">Website</td>
                                                            <td align="center">Email</td>
                                                            <td align="center">Instagram</td>
                                                            <td align="center">Tumblr</td>
                                                            <td align="center">Pinterest</td>
                                                            <td align="center">LinkedIn</td>
                                                            <td align="center">GooglePlus</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center">&nbsp;</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table border="0" align="center" cellspacing="0" cellpadding="0" style="font:13px Arial, Helvetica, sans-serif; color:#000;">
                                                    <tbody>
                                                        <tr>
                                                            <td style="font-size:0px;">
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="3" style="border:1px solid #666; font:11px Tahoma, Geneva, sans-serif;">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="font-size:0px;"><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                        <td style="font-size:0px;"><a href=""> <img border="0" style="display:block" class="icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-mail-s.png" alt="" /> </a></td>
                                                                        <td>Forward</td>
                                                                        <td><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            </td>
                                                            <td><img width="15" height="15" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/15x15.png" alt="" /></td>
                                                            <td>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="3" style="border:1px solid #666; font:11px Tahoma, Geneva, sans-serif;">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="font-size:0px;"><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                        <td style="font-size:0px;"><a href="http://www.facebook.com/sharer.php?u=http%3a%2f%2fbsfurl.com%2f1pAgR/2fK/2iE&amp;t=GALLART.COM+%3c%3e+END+OF+SUMMER+%3c%3e+CLEARANCE+%3c%3e+SALE+%3c%3e+DALI+%3c%3e+ERTE+%3c%3e+KAUFMAN+%3c%3e+MAX+%3c%3e+NEIMAN+%3c%3e+TARKAY+%3c%3e+AND+MANY+MORE+%3c%3e"> <img border="0" style="display:block" class="icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-facebook-s.png" alt="" /> </a></td>
                                                                        <td>Share</td>
                                                                        <td><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            </td>
                                                            <td><img width="15" height="15" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/15x15.png" alt="" /></td>
                                                            <td>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="3" style="border:1px solid #666; font:11px Tahoma, Geneva, sans-serif;">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="font-size:0px;"><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                        <td style="font-size:0px;"><a href="http://twitter.com/intent/tweet?status=GALLART.COM+%3c%3e+END+OF+SUMMER+%3c%3e+CLEARANCE+%3c%3e+SALE+%3c%3e+DALI+%3c%3e+ERTE+%3c%3e+KAUFMAN+%3c%3e+MAX+%3c%3e+NEIMAN+%3c%3e+TARKAY+%3c%3e+AND+MANY+MORE+%3c%3e%20http%3a%2f%2fbsfurl.com%2f1pAgT/2fK/2iE"> <img border="0" style="display:block" class="icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-twitter-s.png" alt="" /> </a></td>
                                                                        <td>Tweet</td>
                                                                        <td><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            </td>
                                                            <td><img width="15" height="15" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/15x15.png" alt="" /></td>
                                                            <td>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="3" style="border:1px solid #666; font:11px Tahoma, Geneva, sans-serif;">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="font-size:0px;"><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                        <td style="font-size:0px;"><a href="http://www.pinterest.com/gallartcom/"> <img border="0" style="display:block" class="icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-pinterest-s.png" alt="" /> </a></td>
                                                                        <td>Pin&nbsp;It</td>
                                                                        <td><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            </td>
                                                            <td><img width="15" height="15" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/15x15.png" alt="" /></td>
                                                            <td>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="3" style="border:1px solid #666; font:11px Tahoma, Geneva, sans-serif;">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="font-size:0px;"><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                        <td style="font-size:0px;"><a href="http://www.linkedin.com/shareArticle?mini=true&amp;ro=true&amp;url=http%3a%2f%2fbsfurl.com%2f1pAgU/2fK/2iE&amp;armin=armin&amp;title=GALLART.COM+%3c%3e+END+OF+SUMMER+%3c%3e+CLEARANCE+%3c%3e+SALE+%3c%3e+DALI+%3c%3e+ERTE+%3c%3e+KAUFMAN+%3c%3e+MAX+%3c%3e+NEIMAN+%3c%3e+TARKAY+%3c%3e+AND+MANY+MORE+%3c%3e"> <img border="0" style="display:block" class="icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-LinkedIn-s.png" alt="" /> </a></td>
                                                                        <td>Share</td>
                                                                        <td><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            </td>
                                                            <td><img width="15" height="15" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/15x15.png" alt="" /></td>
                                                            <td style="font-size:0px;">
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="3" style="border:1px solid #666; font:11px Tahoma, Geneva, sans-serif;">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="font-size:0px;"><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                        <td style="font-size:0px;"><a href="https://plusone.google.com/_/+1/confirm?hl=en&amp;url=http%3a%2f%2fbsfurl.com%2f1pAgS/2fK/2iE"> <img border="0" style="display:block" class="icon" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/fc-webicon-googleplus-s.png" alt="" /> </a></td>
                                                                        <td>Share</td>
                                                                        <td><img width="5" height="5" src="http://www.gallart.com/EMAIL_TEMPLATES/CHAI_LIFELINE/images/5x5.png" style="display:block;" alt="" /></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="#000000" colspan="6">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="10" style="font-style:normal;font-variant:normal;font-weight:normal;font-size:14px;line-height:normal;font-family:Arial,Helvetica,sans-serif;color:rgb(255,255,255)">
                                        <tbody>
                                            <tr>
                                                <td align="center">Promenade Shops - Next to Nordstrom Rack | 20633 Biscayne Blvd &nbsp;Aventura FL 33180</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            </span></td>
        </tr>
    </tbody>
</table>
					</td>
				
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer.cfm">
		</td>
	</tr>
</table>

<cfinclude template="frmxss.cfm">

</body>
</html>
