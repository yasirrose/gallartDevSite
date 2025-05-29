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
	SELECT *
	FROM products 
	WHERE  active = 1
	AND fk_users is NOT null
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
	</cfif>
	<!--- <cfif isDefined('keywords')>
		AND (name like '%#keywords#%' or caption like '%#keywords#%' or modelno like '#keywords#%' or manufacturer like '%#keywords#%')
	</cfif> --->
	<cfif isDefined('artist') and len(artist)>
		AND manufacturer = '#artist#'
	</cfif>
	<cfif isDefined('path') and len(path)>
		and path = '#path#'
	</cfif>
	
	<cfif isDefined('priceOrder') and len(priceOrder)>
		ORDER by gallery_price #priceOrder#
	<cfelse>
		ORDER by manufacturer
	</cfif>
	
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
		<td valign="top" width="173" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr height="100%">
					<td valign="top" height="100%">	
						<cfinclude template="left_classifieds.cfm">
					</td>
				</tr>
			</table>
		</td>
		<td valign="top" width="627" height="100%">
		<!--- content starts --->
			<div align="center" style="font-size: 24px; font-weight: bold; padding: 0 0 3px 0;" class="pinkText"><em>CLASSIFIEDS/PRIVATE LISTINGS</em></div>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td valign="top">
						<cfoutput>
						<table width="600" border="0" cellspacing="0" cellpadding="0" background="images/sales_browse_notext.jpg" style="background-repeat: no-repeat; background-position: top;" width="627" height="127">
							<tr>
								<td valign="top" width="100%" height="25">
									
									<table width="100%" border="0">
										<form method="post" action="classifieds.cfm?xss=#xss#" name="srchForm">
										<tr>
											<td width="150" style="font-size: 11pt; font-weight: bold; padding: 5px 0 0 10px;">
												Search By Artist:
											</td>
											<td valign="top" style="padding: 5px 0 0 0;">
												<select name="artist">
													<option value="">Please Select</option>
													<cfloop query="getArtists">
														<option value="#manufacturer#">#manufacturer#</option>
													</cfloop>
												</select>
											</td>
										</tr>
										<tr>
											<td style="font-size: 11pt; font-weight: bold; padding: 5px 0 0 10px;">
												Search By Medium:
											</td>
											<td valign="top" style="padding: 5px 0 0 0;">
												<select name="path">
													<option value="">Please Select</option>
													<cfloop query="getMedium">
														<option value="#path#">#path#</option>
													</cfloop>
												</select>
											</td>
										</tr>
										<tr>
											<td colspan="2" align="center">
												<input type="image" src="images/search.gif" style="border: none;">
												<!--- <input type="Reset" value="RESET" style="background-color:  ##dd3a7d; color: ##ffffff; font-weight: bold;"> --->
											</td>
										</tr>
										</form>
									</table>
									
								</td>
							</tr>
							<tr>
								<td valign="top" height="32" style="padding: 0 0 0 270px;">
									<form method="post" action="classifieds.cfm?xss=#xss#" name="orderForm">
									<cfif parameterexists(keywords)>
									<input type="hidden" name="keywords" value="#keywords#">
									</cfif>
									<cfif parameterexists(artist)>
									<input type="hidden" name="artist" value="#artist#">
									</cfif>
									<cfif parameterexists(path)>
									<input type="hidden" name="path" value="#path#">
									</cfif>
									<table cellspacing="0" cellpadding="0" border="0" width="300">
										<tr>
											<td style="font-size: 11pt; font-weight: bold; padding: 0 0 0 0;">
												Order By Gallery Price:
											</td>
											<td>
												<select name="priceOrder" onChange="document.orderForm.submit();">
													<option value="">Please Select</option>
													<option value="asc" <cfif isDefined('form.priceOrder') and priceOrder eq 'asc'>selected</cfif>>Lowest To Highest</option>
													<option value="desc" <cfif isDefined('form.priceOrder') and priceOrder eq 'desc'>selected</cfif>>Highest To Lowest</option>
												</select>
											</td>
										</tr>
									</table>
									</form>	
								</td>
							</tr>
						</table>
						</cfoutput>
					</td>
				</tr>
<!--- RESULT LIST STARTS --->	
				<tr>
							<td align="center" style="font-size: 12pt; font-weight: bold;" class="pinkText">
								<cfif isDefined('artist') and len(artist)>
									Artist: <cfoutput>#artist#</cfoutput>
								</cfif>
							</td>
						
						</tr>
				<tr>

					<td width="100%">
					
					<!--- this section shows the list of products --->
					<cfoutput>
					<form name="frm" action="classifieds.cfm" method="post">
					<cfif parameterexists(xss)>
					<input type="hidden" name="xss" value="#xss#">
					</cfif>
					<cfif parameterexists(keywords)>
					<input type="hidden" name="keywords" value="#keywords#">
					</cfif>
					<cfif parameterexists(artist)>
					<input type="hidden" name="artist" value="#artist#">
					</cfif>
					<cfif parameterexists(path)>
					<input type="hidden" name="path" value="#path#">
					</cfif>
					<cfif parameterexists(priceOrder)>
					<input type="hidden" name="priceOrder" value="#priceOrder#">
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
					
						<cfif listlen(manufacturer) gt 1>
							<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
							<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
                            <cfset artist_name_alt = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
						<cfelse>
							<cfset artist_name = manufacturer />
							<cfset artist_name_url = manufacturer />
                            <cfset artist_name_alt = manufacturer />
						</cfif>
					
						<Cfset pc = pc + 1>
						<Td valign="top" align="Center">
						<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(trim(replace(manufacturer,"'",'')))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
						<cfif fileexists("https://#server_name#/img/thumbnails/#uid#.jpg")>
							<img src="./img/thumbnails/#uid#.jpg" alt="#artist_name_alt# - #name#" title="#artist_name_alt# - #name#" border="0" align="center">
						<cfelse>
							<div align="center" style="padding: 20px;">NO IMAGE AVAILABLE</div>
						</cfif>	
						</A>
						<br>
						<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artistname=#urlencodedformat(trim(replace(artist_name_url,"'",'')))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
						#name#
						</a>
						<br>
						By: #ucase(manufacturer)#<Br>
						<font color="660066" size="1">
						<cfif retail_price gt 0 and retail_price gt sale_price>
						Retail Price: #dollarformat(retail_price)#
						</cfif></font><Br>
						<span class="pinkText">
						<cfif gallery_price EQ 0 OR gallery_price EQ ''>
						<span style="font-size: 12px; font-weight: bold;">Price On Request</span><br>
						305.932.6166<br>
						<cfelse>
						Gallery Price: <b>#dollarformat(gallery_price)#</b>
						</cfif>
						</span>
						<br>
					Art ID:&nbsp;#modelno#<br><br>
						<table>
						<!--- <cfform action="make_offer.cfm?pid=#uid#&xss=#xss#" method="POST"> --->
							<tr>
								<td colspan="2" align="center">
									<a href="make_offer.cfm?pid=#uid#&xss=#xss#"><img src="images/make_offer.gif" border="0"></a>
								</td>
							</tr>
						<!--- </cfform> --->
						</table>
					</td>
					<cfif pc eq rows>
					</tr>
					<Tr>
					<cfset pc = 0>
					</cfif>
					</cfoutput>
						</tr>
					<cfset Totalpages = ceiling(#productinfo.recordcount#/ipp)>
					<form name="pagination_form">
						<cfoutput>
							<Tr bgcolor="ffffff">
								<td align="right" valign="top" colspan="#rows#"><font face="Arial, Helvetica, sans-serif" size="1">Page #starton# of #Totalpages#</font>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<select name="pagego" onChange="javascript:gonext('classifieds.cfm?pagego=')" style="font-size: 9pt;">
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
							<font face="Arial, Helvetica, sans-serif" size="1"><A HREF="javascript:gonext2('classifieds.cfm?pagego=<cfoutput>#preplace#</cfoutput>')">
							<< Previous Page</a></font>
							</cfif>
							</td>
							<td align="Center" width="50%"><font face="Arial, Helvetica, sans-serif" size="1"></font>
							</td>
							<td align="right" width="25%">
							<cfif starton neq Totalpages>
								<font face="Arial, Helvetica, sans-serif" size="1"><A HREF="javascript:gonext2('classifieds.cfm?pagego=<cfoutput>#nextplace#</cfoutput>')">
						Next Page >>
							</a></font>
							</cfif>
							</td>
						</tr>
					</table>
					
					<cfelse>
						<div align="center">SORRY - NO CLASSIFIEDS ARE LISTED AT THIS TIME USING THOSE SEARCH CRITERIA. <BR />PLEASE SEARCH AGAIN.</div>
					</cfif>
					</td>
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
