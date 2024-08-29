<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT path FROM products
	group by path
	order by path
</CFQUERY>
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
		<td colspan="2" width="700" valign="top" height="37" align="center">
			<cfinclude template="navbar_user.cfm">
		</td>
	</tr>
	<tr height="100%">
		<td valign="top" width="700" height="100%">
			<table cellspacing="0" cellpadding="0" border="0" width="700">
				<tr>
					<td align="center" style="padding-top: 10px;">
						<cfif isDefined('process') and process EQ 'add'>
							<span style="color: #dd3a7d; padding-top: 25px; font-size: 13px; font-weight: bold;"><br>THANK YOU FOR ADDING YOUR LISTING TO OUR SITE!</span>
						</cfif>
						<h4 style="font-style: italic;">SELL YOUR ART ON GALLART.COM!</h4>
					</td>
				</tr>
				<tr>
					<td align="center">
						<cfoutput>
						<FORM action="user_listing_results.cfm?xss=#xss#" method="post">
						<table cellspacing="0" cellpadding="5" border="0">
							<tr>
								<td colspan="2">
									Use this form to search for your listings by TITLE, ARTIST, MEDIUM, PRICE, OR DESCRIPTION:
								</td>
							</tr>
							<tr class="#this_row()#">
								<td style="padding-right: 10px;"><b>Title</b>:</b></td>
								<td>
									<input type="Text" name="name" style="width: 155px;">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td style="padding-right: 10px;"><b>Artist:</b></td>
								<td>
									<input type="Text" name="manufacturer" style="width: 155px;">
								</td>
							</tr>
					
							<tr class="#this_row()#">
								<td style="padding-right: 10px;"><b>Medium:</b>
								<td>
								<SELECT name="path" style="font-size: 8pt;">
									<option value="">All
									<cfloop query="cats">
										<option value="#path#">#ucase(path)#
									
								</cfloop></select>
								
								</td>
							</tr>
							<tr class="#this_row()#">
								<td style="padding-right: 10px;"><b>Gallery Price:</b></td>
								<td>
									<input type="Text" name="gallery_price" style="width: 155px;">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td style="padding-right: 10px;"><b>Keyword In Description:</b></td>
								<td>
									<input type="Text" name="caption" style="width: 155px;">
								</td>
							</tr>
							<tr>
								<td colspan="2" align="Center">
								<input type="image" src="images/search.gif" name="search" style="border: none;"><br>
								<input style="background:url(images/reset.gif) no-repeat; width: 87px; height: 30px; border: none; cursor: pointer;" type="reset" value="" /><br><br>
								<input type="Button" style="background:url(images/enter_new_listing_button.gif) no-repeat; width: 150px; height: 30px; border: none; cursor: pointer;" onClick="javascript: window.location.href='user_listing_detail.cfm?xss=#xss#'" value="" />
							
								</td>
							</tr>
						
						</TABLE>
						</FORM>		
						</cfoutput>
					</td>
				
				</tr>
			</table>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer_user.cfm">
		</td>
	</tr>
</table>

<cfinclude template="frmxss.cfm">

</body>
</html>