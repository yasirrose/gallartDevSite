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
<cfset ipp = 12 />
<Cfset rows = 4 />

<!--- Search Individual Items --->

<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT gallery_price as pvalue, *
	FROM products 
	WHERE active = 1 And (path <> '') 
	AND (path IS NOT NULL)
	<cfif isDefined('keywords') and len(keywords)>
		<cfset keyArray = listtoarray(keywords,' ') />
		AND (
			(<cfloop from="1" to="#arraylen(keyArray)#" index="idx">
				name like '%#keyArray[idx]#%' <cfif idx lt arraylen(keyArray)>AND</cfif>
			</cfloop>)
			OR
			(<cfloop from="1" to="#arraylen(keyArray)#" index="idx">
				caption like '%#keyArray[idx]#%' <cfif idx lt arraylen(keyArray)>AND</cfif>
			</cfloop>)
			OR
			(<cfloop from="1" to="#arraylen(keyArray)#" index="idx">
				modelno like '%#keyArray[idx]#%' <cfif idx lt arraylen(keyArray)>AND</cfif>
			</cfloop>)
			OR
			(<cfloop from="1" to="#arraylen(keyArray)#" index="idx">
				manufacturer like '%#keyArray[idx]#%' <cfif idx lt arraylen(keyArray)>AND</cfif>
			</cfloop>)
		)
	<cfelseif isDefined('fam')>
		AND family = '#fam#'
	<cfelseif isDefined('man')>
		AND manufacturer like '%#man#%'
	<cfelseif isDefined('artist')>
		AND manufacturer = '#artist#'
	<cfelseif isDefined('manufact')>
		AND manufacturer like '%#manufact#%'
	<cfelseif isDefined('cat')>
		AND path like '%#cat#%'
	<cfelseif isDefined('new')>
		AND 0=0
	<cfelseif isDefined('form.adv_title') and len(form.adv_title)>
		AND name like '%#form.adv_title#%'
	<cfelseif isDefined('form.adv_artist') and len(form.adv_artist)>
		AND manufacturer like '#form.adv_artist#%'
	<cfelseif isDefined('form.adv_desc_keyword') and len(form.adv_desc_keyword)>
		AND caption like '%#form.adv_desc_keyword#%'
	<cfelseif isDefined('form.adv_year') and len(form.adv_year)>
		AND cast(year as varchar) = '#form.adv_year#'
	<cfelseif isDefined('form.adv_price_range') and len(form.adv_price_range)>
		<cfif form.adv_price_range eq 1>
			AND (cast(gallery_price as float) >= 0 and cast(gallery_price as float) <= 1000)
		<cfelseif form.adv_price_range eq 2>
			AND (cast(gallery_price as float) >= 1000 and cast(gallery_price as float) <= 5000)
		<cfelseif form.adv_price_range eq 3>
			AND (cast(gallery_price as float) >= 5000 and cast(gallery_price as float) <= 10000)
		<cfelseif form.adv_price_range eq 4>
			AND (cast(gallery_price as float) >= 10000 and cast(gallery_price as float) <= 100000)
		<cfelseif form.adv_price_range eq 5>
			AND cast(gallery_price as float) > 100000
		</cfif>
	<cfelseif isDefined('form.adv_medium') and len(form.adv_medium)>
		AND path like '%#form.adv_medium#'
	</cfif>
	<!--- AND fk_users is null --->
	
	ORDER by pvalue DESC
</cfquery>

<cfquery name="makeoffer_buttons" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT show FROM makeoffer_buttons
	WHERE pk_makeoffer_buttons = 1
</cfquery>

<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="100%" height="125" valign="top">
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
		<td valign="top" width="727" height="100%">
		<!--- content starts --->
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
<!--- RESULT LIST STARTS --->	
				<tr>
					<td width="100%">
					<!--- this section shows the list of products --->
					
					<form name="frm" action="products2.cfm" method="post">
						<cfoutput>
						<cfif parameterexists(xss)>
							<input type="hidden" name="xss" value="#xss#">
						</cfif>
						<cfif parameterexists(keywords)>
							<input type="hidden" name="keywords" value="#keywords#">
						</cfif>
						<cfif parameterexists(fam)>
							<input type="hidden" name="fam" value="#fam#">
						</cfif>
						<cfif parameterexists(man)>
							<input type="hidden" name="man" value="#man#">
						</cfif>
						<cfif parameterexists(manufact)>
							<input type="hidden" name="manufact" value="#manufact#">
						</cfif>
						<cfif parameterexists(cat)>
							<input type="hidden" name="cat" value="#cat#">
						</cfif>
						<cfif parameterexists(artist)>
							<input type="hidden" name="artist" value="#artist#">
						</cfif>
						</cfoutput>
					</form>

					<cfif #productinfo.recordcount# gt 0>
						<cfif parameterexists(pagego)>
							<cfset starton = #pagego#>
						<cfelse>
							<cfset starton=1>
						</cfif>
						<cfif starton is 1>
							<cfset startrow = 1>
						<cfelse>
							<cfset startrow = ((#starton# - 1) * ipp) + 1>
						</cfif>
							
					
				<table cellpadding="15" cellspacing="1" border="0" width="100%">
					<!--- Show product list --->
					<cfset pc = 0>
							<tr valign="top">
							<cfoutput query="productinfo" startrow="#startrow#" maxrows="#ipp#">
							
							<cfif productinfo.closeout EQ 1 AND use_highestimate EQ 0>
								<cfset saleprice = special_price />
							<cfelseif productinfo.closeout EQ 1 AND use_highestimate EQ 1>
								<cfset saleprice = high_estimate />
							<cfelse>
								<cfset saleprice = 0 />
							</cfif>
							<cfif listlen(manufacturer) gt 1>
								<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
								<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
                                <cfset artist_name_alt = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
							<cfelse>
								<cfset artist_name = manufacturer />
								<cfset artist_name_url = manufacturer />
                                <cfset artist_name_alt = manufacturer />
							</cfif>
					<cfset pc = pc + 1>
					<td valign="top" align="center">
						<table cellpadding="2" cellspacing="0" width="150">
							<tr>
								<td align="center">
									<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
									<cfif fileexists("#expandpath('.')#\img\#uid#.jpg")>
										<img src="http://#server_name#/img/thumbnails/#uid#.jpg" alt="#artist_name_alt# - #name#" title="#artist_name_alt# - #name#" border="0" align="center">
									<cfelse>
										<div align="center" style="padding: 20px;">NO IMAGE AVAILABLE</div>
									</cfif>	
									</A>
								</td>
							</tr>
							<tr>
								<td align="center">
									<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#')">#name#</a>
								</td>
							</tr>
							<tr>
								<td align="center">
									BY: <A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">#ucase(artist_name)#</a>
								</td>
							</tr>
							<tr>
								<td align="center">
									<cfif retail_price gt 0 and retail_price gt gallery_price>
									Retail Price: <A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">#dollarformat(retail_price)#</a><br>
									</cfif>
									<cfif gallery_price EQ 0 OR gallery_price EQ ''>
									<span style="font-size: 12px; font-weight: bold;">Price On Request</span><br>
									305.932.6166<br>
									<cfelse>
										<cfif gallery_price neq ''>
											Gallery Price: <A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">#dollarformat(gallery_price)#</a>
										</cfif>
									</cfif>
									<cfif saleprice GT 0>
										<cfif application.showSalePrice EQ 1><br>
										<span style="color: ##ff0000">Sale Price: <A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">#dollarformat(saleprice)#</a></span></cfif>
									</cfif>
								</td>
							</tr>
							<tr>
								<td align="center">
									Art ID:&nbsp;<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">#modelno#</a>
								</td>
							</tr>
							<tr>
								<td align="center">
									<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')" class="dbl_arrows">MORE INFO</a>
								</td>
							</tr>
							<tr>
								<td align="center">
									<cfif len(fk_users)><span style="font-size: 12px; font-weight: bold; color: ##ff0000;">PRIVATE LISTING</span><br><br></cfif>
									<cfif makeoffer_buttons.show EQ 1>
										<a href="make_offer.cfm?pid=#uid#&xss=#xss#"><img src="images/make_offer.gif" border="0"></a>
									</cfif>
								</td>
							</tr>
						</table>
					</td>
					<cfif pc eq rows>
					</tr>
					<Tr>
					<cfset pc = 0>
						
						<!--- cfoutput must go AFTER closing cfif: dreamweaver bug --->
						
					</cfif>
					</cfoutput>
					</tr>
					<cfset Totalpages = ceiling(#productinfo.recordcount#/ipp)>
					<form name="pagination_form">
						 <cfoutput>
							<Tr bgcolor="ffffff">
								<td align="right" valign="top" colspan="#rows#"><font face="Arial, Helvetica, sans-serif" size="1">Page #starton# of #Totalpages#</font>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<select name="pagego" onChange="javascript:gonext('products2.cfm?pagego=')" style="font-size: 9pt;">
								<CFLOOP INDEX="pagecount" FROM="1" TO="#Totalpages#" STEP="1">
								<cfif parameterexists(pagego) and pagego eq pagecount>
								<option value="#pagecount#" selected>#pagecount#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<cfelse>
								<option value="#pagecount#">#pagecount#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								
								<!--- cfloop must go AFTER closing cfif: dreamweaver bug --->
								</cfif>
								</CFLOOP>
								</select>
									</td>
							</tr>
						</cfoutput> 
					</form>
					</table>
								</td>
							</tr>
							<tr>
								<td align="center">
					<cfset nextplace = starton + 1>
					<cfset preplace = starton - 1>
					<table cellspacing="0" cellpadding="6" border="0" align="center" width="100%"  bgcolor="#eeeeee" height="10">
							<tr>			
							<td align="left" width="25%">
							<cfif parameterexists(pagego) and pagego gt 1>
							<font face="Arial, Helvetica, sans-serif" size="1"><A HREF="javascript:gonext2('products2.cfm?pagego=<cfoutput>#preplace#</cfoutput>')">
							<< Previous Page</a></font>
							</cfif>
							</td>
							<td align="Center" width="50%"><font face="Arial, Helvetica, sans-serif" size="1"></font>
							</td>
							<td align="right" width="25%">
							<cfif starton neq Totalpages>
								<font face="Arial, Helvetica, sans-serif" size="1"><A HREF="javascript:gonext2('products2.cfm?pagego=<cfoutput>#nextplace#</cfoutput>')">
						Next Page >>
							</a></font>
							</cfif>
							</td>
						</tr>
					</table>
					
					<cfelse>
						<center><Br><Br><Br>
						<cfif parameterexists(keywords) and (productinfo.recordcount lt 1)>
						<font face="verdana, arial,helvetica" size="3" color="66066"><b>Our records show no listing of <cfoutput>#keywords#</cfoutput>/s in our catalog.<br>Please try another search criteria.</b></font>
						</center>
						</cfif>
						<cfif parameterexists(man) and (productinfo.recordcount lt 1)>
						<font face="verdana, arial,helvetica" size="3" color="66066"><b>Our records show no listing of artists whose names begin with <cfoutput>"#man#"</cfoutput> in our catalog.<br>Please try another search criteria.</b></font>
						</center>
						</cfif>
					
					</cfif></td>
						</tr>
					<!--- RESULT LIST ENDS --->												
						</table>
		<!--- content ends --->
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