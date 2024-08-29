<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
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
	<cfquery name="qCameras" datasource="#application.dsource#">
		SELECT * from camera
		WHERE camera_name = 'center'
	</cfquery>
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
		<td valign="top" height="1100" colspan="2">
			<table style="margin-bottom: -30px;">
				<tr>
					<td style="font-size: 11pt; padding-top: 10px; padding-left: 36px;">
						<strong>Click <span style="color: #ff0000">Control Key</span> below <img src="images/camera/controlkey.png" border="0">  located in the top left corner of the Live Cam Screen to have PAN & ZOOM capabilities.</strong><br />
						Click on the <strong>ARROWS</strong> <img src="images/camera/controlkeyarrows.png" border="0"> to direct the camera.  Click on the <strong>PLUS/MINUS</strong> <img src="images/camera/controlkeyplusminus.png" border="0"> to zoom camera in/out.<br /><br/>

					</td>
				</tr>
			</table>
			<iframe src="cameras/center_camera.html" width="900" height="900" marginwidth="10" marginheight="10" frameborder="0"></iframe>
			<div style="width: 654px; padding-left: 36px; color: #000000; font-size: 9pt; position: absolute; top: 790px; z-index: -1;">
				*If you do not see the control key <img src="images/camera/controlkey.png" border="0"> above users will need to click on the drop down arrow <img src="images/camera/camera_downarrow.png" border="0">, scroll down to <strong>How to control PTZ</strong> and select <strong>PTZ control bar</strong> for control key to appear in top left corner.  
				<br/><br/>
				To see 1 of the 7 Live Cam Pre-Set Views listed below click on <img src="images/camera/p_icon.png" border="0">, <br />scroll & select the number that correlates to the Pre-Set View Key you want to see.<br /><br/>
				<img src="images/camera/camera_conrols.png" border="0">
				<br/><br />
				<span style="color: #fc56fc;">CENTER LIVE CAM PRE-SET VIEW KEY</span>
				<table width="350" border="1" cellpadding="3" cellspacing="0" style="color: #333333; border-color: #999999">

					<cfoutput query="qCameras">
						<tr>
							<td style="width: 10%" align="center">#camera_number#</td>
							<td style="padding-left:10px;">#location#</td>
						</tr>
					</cfoutput>
				</table>
				<br /><br />
			</div>
		</td>
	</tr>
	<!--- <tr height="100%">
		<td valign="top" height="100%">
			<iframe src="http://65.23.17.116:8211/index.html" width="800" height="900" marginwidth="0" marginheight="0" frameborder="0"></iframe>
		</td>
	</tr> --->
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer.cfm">
		</td>
	</tr>
</table>

<cfinclude template="frmxss.cfm">

</body>
</html>