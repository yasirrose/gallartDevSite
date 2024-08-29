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
<Cfset rows = 3 />

<!--- Search Individual Items --->

<cfquery name="initialSearch" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT substring(path, 1, PATINDEX('%:%', path)-1) as ccat, gallery_price as pvalue, *
	FROM products 
	WHERE active = 1 And (path <> '') 
	AND (path IS NOT NULL)
	<!--- AND fk_users is null --->
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
		AND path like '%#form.adv_year#'
	</cfif>
	<!--- AND fk_users is null --->
	
	ORDER by pvalue DESC, ccat
</cfquery>

<cfquery name="productinfo" dbtype="query">
	SELECT * from initialSearch
	WHERE fk_users is null
</cfquery>

<cfquery name="searchClassifieds" dbtype="query">
	SELECT uid from initialSearch
	WHERE fk_users is NOT null
</cfquery>

<table id="Table_01" width="800" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="800" height="125" valign="top">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="800" valign="top" height="37">
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
		<td valign="top" width="627" height="100%">
		<!--- content starts --->
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td align="right">
						 <Table width="100%" bgcolor="#eeeeee">
						<Tr>
						<Td align="center" width="50%"><cfinclude template="shortmeter.cfm"></td>
						<td align="right" width="50%"><cfinclude template="displaynav.cfm"></td>
						</tr>
						</table>	
					</td>
				</tr>
				<cfif NOT productinfo.recordcount AND searchClassifieds.recordcount>
				<tr>
					<td style="font-size: 14px;padding: 10px;">
						We don't have any of the listings that you requested in our Gallery, however, we do have some classified listings that meet your search criteria.  Please click SEARCH CLASSIFIEDS below to search our classified listings.
					</td>
				</tr>
				<tr>
					<td style="font-size: 14px;padding: 10px;" align="center">
						<cfoutput>
						<form name="classifiedSearch" action="classifieds.cfm" method="post">
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
							<input type="hidden" name="artist" value="#manufact#">
							</cfif>
							<cfif parameterexists(cat)>
							<input type="hidden" name="cat" value="#cat#">
							</cfif>
							<input type="Submit" value="SEARCH CLASSIFIEDS" class="pinkSubmit">
						</form>
						</cfoutput>
					</td>
				</tr>
				<cfelseif NOT productinfo.recordcount AND NOT searchClassifieds.recordcount>
				<tr>
					<td style="font-size: 14px;padding: 10px;">
						Sorry, we don't have any listings that meet your search criteria.  Please search again.
					</td>
				</tr>
				<cfelse>
					<cfif searchClassifieds.recordcount>
						<tr>
							<td style="font-size: 14px;padding: 10px;">
								We also have some listings in our classifieds that meet your search criteria.  Please click SEARCH CLASSIFIEDS below to search our classified listings.
							</td>
						</tr>
						<tr>
							<td style="font-size: 14px;padding: 10px;" align="center">
								<cfoutput>
								<form name="classifiedSearch" action="classifieds.cfm" method="post">
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
									<input type="hidden" name="artist" value="#manufact#">
									</cfif>
									<cfif parameterexists(cat)>
									<input type="hidden" name="cat" value="#cat#">
									</cfif>
									<input type="Submit" value="SEARCH CLASSIFIEDS" class="pinkSubmit">
								</form>
								</cfoutput>
							</td>
						</tr>
					</cfif>
<!--- RESULT LIST STARTS --->	
				<tr>
					<td width="100%">
					<!--- this section shows the list of products --->
					<cfoutput>
					<form name="frm" action="products.cfm" method="post">
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
					</cfoutput>
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
							
							<cfif listlen(manufacturer) gt 1>
								<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
								<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
							<cfelse>
								<cfset artist_name = manufacturer />
								<cfset artist_name_url = manufacturer />
							</cfif>
					<Cfset pc = pc + 1>
								<Td valign="top" align="Center">
								
								<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">

<img src="http://#server_name#/img/thumbnails/#uid#.jpg" alt="#ucase(manufacturer)# - #name#" border="0" align="center"></A><br>
								<font face="verdana,arial, helvetica" size="1" color="black"><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#')"><font face="verdana,arial, helvetica" size="1" color="black">#name#</a><h1>BY: #ucase(artist_name)#</h1><font color="660066" size="1">
					<cfif retail_price gt 0 and retail_price gt gallery_price>
					Retail Price: #dollarformat(retail_price)#</cfif></font><Br>
					<font face="verdana,arial, helvetica" size="1" color="ff6600">
					<cfif gallery_price EQ 0 OR gallery_price EQ ''>
					<span style="font-size: 12px; font-weight: bold;">Price On Request</span><br>
					305.932.6166<br>
					<cfelse>
						<cfif gallery_price neq ''>
							Gallery Price: <b>#dollarformat(gallery_price)#</b><br>
						</cfif>
					</cfif>
					</font>
					<br>
					<a href="make_offer.cfm?pid=#uid#&xss=#xss#"><input type="Buttton" value="MAKE AN OFFER!" style="font-size: 9px; cursor: pointer;" class="pinkSubmit"></a>

					</td>
					<cfif pc eq rows>
					</tr>
					<Tr>
					<cfset pc = 0>
					</cfif>
						</cfoutput>
					</tr>
					<cfset Totalpages = ceiling(#productinfo.recordcount#/ipp)>
					 <cfoutput>
						<Tr bgcolor="ffffff">
							<td align="right" valign="top" colspan="#rows#"><font face="Arial, Helvetica, sans-serif" size="1">Page #starton# of #Totalpages#</font>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<select name="pagego" onChange="javascript:gonext('products.cfm?pagego=')" style="font-size: 9pt;">
					<CFLOOP INDEX="pagecount" FROM="1" TO="#Totalpages#" STEP="1">
					<cfif parameterexists(pagego) and pagego eq pagecount>
					<option value="#pagecount#" selected>#pagecount#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<cfelse>
					<option value="#pagecount#">#pagecount#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</cfif>
					</CFLOOP>
					</select>
								</td>
							</tr>
						</cfoutput> 
							
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
							<font face="Arial, Helvetica, sans-serif" size="1"><A HREF="javascript:gonext2('products.cfm?pagego=<cfoutput>#preplace#</cfoutput>')">
							<< Previous Page</a></font>
							</cfif>
							</td>
							<td align="Center" width="50%"><font face="Arial, Helvetica, sans-serif" size="1"></font>
							</td>
							<td align="right" width="25%">
							<cfif starton neq Totalpages>
								<font face="Arial, Helvetica, sans-serif" size="1"><A HREF="javascript:gonext2('products.cfm?pagego=<cfoutput>#nextplace#</cfoutput>')">
						Next Page >>
							</a></font>
							</cfif>
							</td>
						</tr>
					</table>
					</form>
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
					</cfif>
					</td>
				</tr>
				</cfif>
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