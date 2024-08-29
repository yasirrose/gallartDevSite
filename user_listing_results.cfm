<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<cfparam name="session.sellerinfo.list_searchString" default="fk_users = #session.sellerinfo.pk_users#">

<cfif isDefined('search')>

	<cfsavecontent variable="session.sellerinfo.list_searchString">
	
	<cfoutput>
		fk_users = #session.sellerinfo.pk_users#
		<cfif IsDefined('form.modelno') and len(trim(form.modelno))>
			and modelno like '%#form.modelno#%'
		</cfif>
		<cfif IsDefined('form.name') and len(trim(form.name))>
			and name like '%#form.name#%'
		</cfif>
		<cfif IsDefined('form.manufacturer') and len(trim(form.manufacturer))>
			and manufacturer like '%#form.manufacturer#%'
		</cfif>
		<cfif IsDefined('form.path') and len(trim(form.path))>
			and path = '#form.path#'
		</cfif>
		<cfif IsDefined('form.gallery_price') and len(trim(form.gallery_price))>
			and gallery_price = #gallery_price#
		</cfif>
		<cfif IsDefined('form.caption') and len(trim(form.caption))>
			and caption like '%#form.caption#%'
		</cfif>
	
	</cfoutput>
	
	</cfsavecontent>

</cfif>

<cfquery name="getProducts" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT *
    FROM products
    WHERE #PreserveSingleQuotes(session.sellerinfo.list_searchString)#
	order by uid
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
		<td valign="top" width="700" height="100%" style="padding: 10px;">
			<table cellspacing="0" cellpadding="0" border="0" width="700">
				<tr>
					<td align="center" style="padding-top: 10px;">
						<cfif isDefined('process')>
							<span style="color: #dd3a7d; padding-top: 25px; font-size: 13px; font-weight: bold;"><br>
								<cfif process EQ 'update'>
									YOU HAVE SUCCESSFULLY UPDATED YOUR LISTING.
								<cfelseif process EQ 'delete'>
									YOU HAVE SUCCESSFULLY DELETED YOUR LISTING.
								</cfif>
							</span>
						</cfif>
						<h4 style="font-style: italic;">SELL YOUR ART ON GALLART.COM!</h4>
					</td>
				</tr>
				<tr>
					<td align="center" style="padding-top: 10px;">
						<input type="Button" style="background:url(images/new_search.gif) no-repeat; width: 150px; height: 30px; border: none; cursor: pointer;" onClick="javascript:goxss('user_listing_search.cfm?xss=<cfoutput>#xss#</cfoutput>')" value="" />
					</td>
				</tr>
				<tr>
					<td align="center" style="padding-top: 10px;">
					<cfif getProducts.recordcount>
						<table border="0" cellpadding="2" cellspacing="0" width="700">
							<tr class="row0">
								<td></td>
								<td>Artist</td>
								<td>Medium</td>
							    <td>Title</td>
							    <td COLSPAN="2" align="center">Gallery Price</td>
							      <td>Status</td>
								      <td>Last Edited</td>
							</tr>
							<CFOUTPUT query="getProducts">
							<tr class="#this_row()#">
								<td width="25">
									<input type="Button" style="background:url(images/view_button.gif) no-repeat; width: 86px; height: 30px; border: none; cursor: pointer;" onClick="javascript:goxss('user_listing_detail.cfm?ID=#URLEncodedFormat(UID)#')" value="" />
								</td>
							 	<td><font face="arial, helvetica" size="1">#manufacturer#</font></td>
								<td><font face="arial, helvetica" size="1">#path#</font></td>
								<td><font face="arial, helvetica" size="1">#name#</font></td>
								<td align="right"><font face="arial, helvetica" size="1">#dollarformat(gallery_price)#&nbsp;&nbsp;&nbsp;</font></td>
								<td>&nbsp;</td>
								<td><font face="arial, helvetica" size="1"><cfif Active is 1>Active<cfelse>Inactive</cfif></font></td>
								<td align="center"><font face="arial, helvetica" size="1">#dateformat(datestamp)#</font></td>
							</tr>
							</CFOUTPUT>
						</table>	
					<cfelse>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td align="center" style="padding: 25px; font-weight: bold;">
									Sorry -- no results found.  Please try again.
								</td>
							</tr>
						</table>
					</cfif>
					</td>
				</tr>
			</table>
		</td>
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