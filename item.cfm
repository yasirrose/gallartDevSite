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
	<script language="JavaScript" src="./js/jquery-1.2.6.min.js"></script>
	<script language="JavaScript" src="./js/slimbox2.js"></script>
	<link href="./css/slimbox2.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</cfoutput>

<link href="stylesheet_.css" rel="stylesheet" type="text/css">
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

<!--- Add Edit or Delete this Item from the Cart --->
<cfif parameterexists(process)>
	<cfif process is "Add" and qty gt 0>
		<cfset opt_name="">
		<cfset opt_value="">
		<cfquery name="addtocart" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		Insert into cart (qty, pid, trackerid,charge,options,optionvalues)values(#qty#, '#pid#', '#xss#', #charge#,'#opt_name#','#opt_value#')
		</cfquery>
		
		<cflocation url="checkout_new.cfm?xss=#xss#" addtoken="No">
	</cfif>
</cfif>
<!--- End of Add Items to Cart --->
<!--- Gather Product Information for product(s) --->
<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
SELECT *
FROM products where uid  = '#pid#' 
<cfif NOT isDefined('url.sellerlisting')>
	AND active = 1
</cfif> 
And (path <> '') AND (path IS NOT NULL)
</cfquery>

<cfquery name="bio_info" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT * from bios
	WHERE artist = '#productinfo.manufacturer#'
</cfquery>

<cfquery name="makeoffer_buttons" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT show FROM makeoffer_buttons
	WHERE pk_makeoffer_buttons = 1
</cfquery>

<cfparam name="saleprice" default="#productinfo.special_price#">
<cfif productinfo.use_highestimate EQ 1>
	<cfset saleprice = productinfo.high_estimate />
</cfif>
	



<!--- Search Individual Items --->

<!--- <cfquery name="prodnav" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT substring(path, 1, PATINDEX('%:%', path)-1) as ccat, uid FROM products 
	WHERE active = 1 And (path <> '') 
	AND (path IS NOT NULL)
	<cfif isDefined('keywords')>
		AND (name like '%#keywords#%' or caption like '%#keywords#%' or modelno like '#keywords#%')
	<cfelseif isDefined('fam')>
		AND family = '#fam#'
	<cfelseif isDefined('man')>
		AND manufacturer like '#man#%'
	<cfelseif isDefined('manufact')>
		AND manufacturer like '#manufact#%'
	<cfelseif isDefined('cat')>
		AND path like '%#cat#%'
	</cfif>
	ORDER by ccat, gallery_price
</cfquery>

<cfset prodlist = "">
<cfloop query="prodnav">
<cfset prodlist = #ListAppend(prodlist, uid)#>
</cfloop> --->
<div class="main-container">
	<div id="Table_01">
		<div class="header-section">
			<div class="top-header">
				<cfinclude template="top_.cfm">
			</div>
			<div class="navbar-section">
				<cfinclude template="navbar_.cfm">
			</div>
		</div>
		<div class="inner-section">
			<div class="container-fluid">
				<div class="main-content">
					<div class="content-section product-page">
						<div class="bottom-content-sec">
							<div class="banner-section">
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr height="100%">
		<td valign="top" height="100%" width="80%">
			<!--- content starts --->
			
			<table border="0" cellpadding="0" cellspacing="0" width="100%" style="padding-top: 10px;">
				
				<tr>
					<td height="100%" align="center" valign="top">
					
					<!--- Product info --->
					<cfoutput query="productinfo">
					<table cellpadding="3" cellspacing="3" border="0">
					
						<tr>
							<td valign="top" colspan="3" align="center">
							<cfif fileexists("http://#server_name#/img/thumbnails/#uid#.jpg")>
                            	<cfset artist_name_alt = "#trim(listlast(productinfo.manufacturer))# #trim(listfirst(productinfo.manufacturer))#" />
								<a href="./img/#uid#.jpg" rel="lightbox" title="#artist_name_alt# - #trim(productinfo.name)#"><img src="./img/#uid#.jpg?x=randrange(1,99)" alt="#artist_name_alt# - #trim(productinfo.name)#" title="#artist_name_alt# - #trim(productinfo.name)#" border="2" width="300"></a><br>
								Click to view large image size.
							<cfelse>
								<div align="center" style="padding: 20px;">NO IMAGE AVAILABLE</div>
							</cfif>
                            <cfif productinfo.ADDITIONAL_IMAGES NEQ "">
                            	<div class="additionalImageContainer">
                                <cfset addImgIdx = 1 />
                                <div class="addImgRow">
                            	<cfloop list="#productinfo.additional_images#" index="idx">
                                	<cfif fileexists("http://#server_name#/img/thumbnails/#uid#.jpg")>
									<a href="http://#server_name#/img/#idx#" rel="lightbox" class="additionalImage"><img src="http://#server_name#/img/#idx#" width="100" /></a>  
                                    <cfif addImgIdx mod 3 EQ 0></div><div class="addImgRow"></cfif>
                                    <cfif listLen(productinfo.additional_images) EQ addImgIdx></div></cfif>
                                    <cfset addImgIdx = addImgIdx + 1 />          
                                   	</cfif>              
                                </cfloop>
                               </div>
							  <script>
                                  var addImgWidth = $(".additionalImageContainer a").width() + 10;
                                  var addImgContainerWidth = $(".additionalImageContainer").width();
                                  var padding = 0;
                                  $(".addImgRow").each(function(){
                                      addImgCount = $(this).find("a").length;
                                      padding = (addImgContainerWidth - (addImgWidth * addImgCount)) / 2;
                                      $(this).css({"padding-left":padding, "padding-right":padding});
                                  });
                              </script>
                            </cfif>
								<table cellpadding="3" cellspacing="0" border="0" width="100%" style="padding: 5px 20px;">
									<tr>
										<td colspan=2><br></td>
									</tr>
									<tr>
										<td width="50%"><cfif productinfo.manufacturer gt 0><font size="1" face="arial, helvetica"><h1>Artist: #ucase(manufacturer)#</h1></cfif></td>
										<td width="50%"><cfif productinfo.name gt 0><font size="1" face="arial, helvetica"><h1>Title: #productinfo.name#</h1></cfif></td>
									</tr>
									
									<tr>
										<td><cfif productinfo.retail_price gt 0><font size="1" face="arial, helvetica">Retail Price: #DollarFormat(productinfo.retail_price)#</cfif></td>
										<td>
											<font size="1" face="arial, helvetica">

											<cfif productinfo.closeout eq 1 and saleprice gt 0 and application.showSalePrice EQ 1>
												<!--- remove for make offer 4/30/15 --->
												<!--- <span style="color: ##ff0000;">Sale Price: #DollarFormat(saleprice)#</span> --->
											<cfelseif productinfo.gallery_price gt 0>																														Gallery Price: #DollarFormat(productinfo.gallery_price)#
											</cfif>
											</font>
										</td>
									</tr>
									
									<tr>
										<td><cfif productinfo.size gt 0><font size="1" face="arial, helvetica">Size: #productinfo.size# INCHES</cfif></td>
										<td><cfif productinfo.year gt 0><font size="1" face="arial, helvetica">Year: #productinfo.year#</cfif></td>
									</tr>
									
									<cfset medium = replace(RemoveChars(path,len(path), 1),":","/","all")>
									<tr>
										<td><cfif medium gt 0><font size="1" face="arial, helvetica">Medium: #medium#</cfif></td>
										<td><cfif edition gt 0><font size="1" face="arial, helvetica">Edition: #edition#</cfif></td>
									</tr>
									
									<tr>
										<td colspan=2><cfif caption gt 0><font size="1" face="arial, helvetica">Description: #trim(caption)#</cfif></td>
									</tr>
									
										<td colspan=2>
										<cfoutput>
											<div style="text-align:center;"><font face="arial, helvetica" size="2"><b>Art ID:</b>&nbsp;#productinfo.modelno#</font></div>
											<table cellpadding="1" cellspacing="1" border="0" valign="top" width="100%" style="padding-top: 10px;">
												<cfform action="item.cfm?pid=#pid#&xss=#xss#" method="POST">
																
												<input type="hidden" name="process" value="Add">
												<cfif productinfo.closeout eq 1 and saleprice gt 0 and application.showSalePrice EQ 1>
													<input type="hidden" name="charge" value="#saleprice#">
												<cfelse>
													<input type="hidden" name="charge" value="#productinfo.gallery_price#">
												</cfif>
												<cfif productinfo.gallery_price eq 0 and (productinfo.closeout neq 1 and productinfo.special_price gt 0)>
												<tr>
													<td colspan="2" bgcolor="#centercolor#" align="center">
													<font face="arial, helvetica" size="1"><b>Price On Request</b></font></td>
												</tr>
												<cfelseif productinfo.closeout eq 1 and saleprice gt 0 and application.showSalePrice EQ 1>
												<tr>
													<td colspan="2" align="center">
													<font face="arial, helvetica" size="2" color="red"><b>Sale Price:</b></font>&nbsp;&nbsp;
													<font face="arial, helvetica"  size="2" color="red">#dollarformat(saleprice)#</font>
													</td>
												</tr>
												<cfelse>
												<tr>
													<td colspan="2" align="center">
													<font face="arial, helvetica" size="2"><b>Gallery Price:</b>&nbsp;&nbsp;
															<cfif productinfo.gallery_price NEQ 0 AND len(productinfo.gallery_price)>
																#dollarformat(productinfo.gallery_price)#
															<cfelse>
																#dollarformat(0)#
															</cfif>
														</font>
													</td>
												</tr>
												</cfif>
												<cfif len(productinfo.fk_users)>
												<tr>
													<td colspan="2" align="center">
														<span style="font-size: 12px; font-weight: bold; color: ##ff0000;">PRIVATE LISTING</span><br><br>
													</td
												></tr>
												</cfif>
												<cfif productinfo.gallery_price neq 0 or (productinfo.closeout eq 1 and productinfo.special_price gt 0)>
							
												<input type="HIDDEN" name="qty" value="1">
												<tr>
													<td colspan="2" align="center">
													<!--- <input type="submit" value="ADD TO YOUR CART" style="font-size: 8pt;"> --->
													<input type="image" src="images/click_to_purchase.gif" style="border: none;">
													<br>
													</td>
												</tr>
												</cfif>
												</cfform>
						
												<tr>
													<td colspan="2">
														<div align="center">
															<!--- <cfif makeoffer_buttons.show EQ 1>
																<a href="make_offer.cfm?pid=#pid#&xss=#xss#"><img src="images/make_offer.gif" border="0"></a>
															</cfif> --->
															<a href="epricing.cfm?pid=#uid#&xss=#xss#"><img src="images/epricing.gif" border="0"></a>
														</div><br>
														<table cellpadding="1" cellspacing="1" border="0" align="Center" width="95%" style="border: 1px solid ##bbbbbb;">
															<cfif productinfo.closeout eq 1 and productinfo.special_price gt 0 and application.showSalePrice EQ 1>
																<Tr>
																	<td align="center"><font face="verdana, arial, helvetica" size="1"><b>Retail Price</b></font>
																	</td>
																	<td align="center"><font face="verdana, arial, helvetica" size="1"><b>Gallery Price</b></font>
																	<td align="center"><font face="verdana, arial, helvetica" size="1"><b>Sale Price</b></font>
																	</td>
																	<td align="center"><font face="verdana, arial, helvetica" size="1"><b>Your Savings</b></font>
																	</td>
																</tr>
																<Tr>
																	<td align="center"><font face="verdana, arial, helvetica" size="2">#dollarformat(productinfo.retail_price)#</font>
																	</td>
																	<td align="center"><font face="verdana, arial, helvetica" size="2">#dollarformat(productinfo.gallery_price)#</font>
																	</td>
																	<td align="center"><font face="verdana, arial, helvetica" size="2">#dollarformat(saleprice)#</font>
																	</td>
																<cfset savings = #productinfo.retail_price# - #saleprice#>
																	<td align="center"><font face="verdana, arial, helvetica" size="2" color="red"><b>#dollarformat(savings)#</b></font>
																	</td>
																</tr>
															
															<cfelse>
																<cfif (productinfo.retail_price gt 0) and (productinfo.gallery_price gt 0) and (productinfo.retail_price gt productinfo.gallery_price)>
																<Tr>
																	<td align="center"><font face="verdana, arial, helvetica" size="1"><b>Retail Price</b></font>
																	</td>
																	<td align="center"><font face="verdana, arial, helvetica" size="1"><b>Gallery Price</b></font>
																	</td>
																	<td align="center"><font face="verdana, arial, helvetica" size="1"><b>Your Savings</b></font>
																	</td>
																</tr>
																<Tr>
																	<td align="center"><font face="verdana, arial, helvetica" size="2">#dollarformat(productinfo.retail_price)#</font>
																	</td>
																	<td align="center"><font face="verdana, arial, helvetica" size="2">#dollarformat(productinfo.gallery_price)#</font>
																	</td>
																<cfset savings = #productinfo.retail_price# - #productinfo.gallery_price#>
																	<td align="center"><font face="verdana, arial, helvetica" size="2" color="red"><b>#dollarformat(savings)#</b></font>
																	</td>
																</tr>
																</cfif>
															
															</cfif>
															
															<cfif parameterexists(process)>
															<Tr>
																<td colspan="3" align="center"><p><font face="Arial, helvetica" size="1" color="#displaycolor#">#qty# #productinfo.name#(s) have been added to your list. <br><div align="center">Thank you!</div></font>
																</td>
															</tr>
															</cfif>
														</table>
													</td>
												</tr>
											</table>
										</cfoutput>
										</td>
									
									
								</table>
							</td>
						</tr>
						</cfoutput>
				
					</td>
				</tr>
				
			</table>
					
		</td>
		<td width="40%" valign="top">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td height="100%" valign="top" align="center">
					<cfoutput>
						<cfif isDefined('bio_info') and bio_info.recordcount>
								<input type="button" value="VIEW ARTIST BIO" onClick="location.href='artist_bio.cfm?bioId=#bio_info.pk_bios#'" class="bioButton">
						</cfif>
						<cfif isDefined('url.artist')>
							<iframe src="slideshow/index.cfm?artist=#url.artist#&pid=#url.pid#" frameborder="0" width="380" height="300" style="overflow:hidden;"></iframe>
						</cfif>
						
					</cfoutput>
					<!--- Matching and Similar --->
					<cfoutput>
					<cfif parameterexists(process)>
					<cfset tdcolspan=0>
					<cfif #productinfo.match1# neq "">
					<cfquery name="match1" maxrows="1" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					Select uid,modelno, name, imageurl from products Where (modelno = '#productinfo.match1#') and active = 1
					</cfquery>
					<cfset tdcolspan = #tdcolspan#+1>
					</cfif>
					<cfif #productinfo.match2# neq "">
					<cfquery name="match2" maxrows="1" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					Select uid,modelno, name, imageurl from products Where (modelno = '#productinfo.match2#') and active = 1
					</cfquery>
					<cfset tdcolspan = #tdcolspan#+1>
					</cfif>
					<cfif #productinfo.match3# neq "">
					<cfquery name="match3" maxrows="1" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					Select uid, modelno, name, imageurl from products Where (modelno = '#productinfo.match3#') and active = 1
					</cfquery>
					<cfset tdcolspan = #tdcolspan#+1>
					</cfif>
					<cfif #productinfo.match4# neq "">
					<cfquery name="match4" maxrows="1" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					Select uid, modelno, name, imageurl from products Where (modelno = '#productinfo.match4#') and active = 1
					</cfquery>
					<cfset tdcolspan = #tdcolspan#+1>
					</cfif>
					<table cellpadding="2" cellspacing="2" border="0" width="120" align="center">
					<cfif #tdcolspan# gt 0>
						<cfif match1.recordcount gt 0>
							<tr>
								<td align="Center"><b>You will also like these:<cfif #tdcolspan# gt 1>s</cfif></b></td>
							</tr>
							<tr>
								<td valign="top" align="Center">
								<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(match1.uid))#')">
									<img src="http://#server_name#/img/thumbnails/#match1.uid#.jpg" alt="#trim(match1.modelno)#" border="1"></a>
								</td>
							</tr>
						</cfif>
						<cfif #tdcolspan# gt 1>
							<cfif match2.recordcount gt 0>
								<Tr>
									<td valign="top" align="center">
									<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(match2.uid))#')">
									<img src="http://#server_name#/img/thumbnails/#match2.uid#.jpg" alt="#trim(match2.modelno)#" border="1"></a>
									</td>
								</tr>
							</cfif>
						</cfif>
						<cfif #tdcolspan# gt 2>
							<cfif match3.recordcount gt 0>
								<Tr>
									<td valign="top" align="center">
									<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(match3.uid))#')">
									<img src="http://#server_name#/img/thumbnails/#match3.uid#.jpg" alt="#trim(match3.modelno)#" border="1"></a>
									</td>
								</tr>
							</cfif>
						</cfif>
						<cfif #tdcolspan# gt 3>
							<cfif match4.recordcount gt 0>
								<Tr>
									<td valign="top" align="center">
									<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(match4.uid))#')">	
									<img src="http://#server_name#/img/thumbnails/#match4.uid#.jpg" alt="#trim(match1.modelno)#" border="1"></a>
									</td>
								</tr>
							</cfif>
						</cfif>
					</cfif>
					</table>
					<cfelse>
						<cfquery name="similar" maxrows="3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
						SELECT * 
						FROM products
						WHERE active = 1 and manufacturer <> '#productinfo.manufacturer #' and path like '#productinfo.path#%'
						</cfquery>
						<cfif #similar.recordcount# gt 0>
						<table cellspacing="2" cellpadding="2" border="0" align="center">
							<Tr>
								<td colspan="#similar.recordcount#" align="center">
									<font face="arial,helvetica" size="2"><b>You Might Also Like:</b></font>
								</td>
							</tr>
							<cfloop query="similar">
							<cfset thisFile = "#expandpath('.')#\img\#similar.uid#.jpg" />
							<cfif listlen(manufacturer) gt 1>
								<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
								<cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
                                <cfset artist_name_alt = "#trim(listlast(manufacturer))# #trim(listfirst(manufacturer))#" />
							<cfelse>
								<cfset artist_name = manufacturer />
								<cfset artist_name_url = manufacturer />
                                <cfset artist_name_alt = manufacturer />
							</cfif>
							<tr>
								<td valign="top" align="center">
								<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#urlencodedformat(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'","")))#')">
								
								<cfif fileExists(thisFile)>
									<img src="http://#server_name#/img/thumbnails/#similar.uid#.jpg" alt="#artist_name_alt# - #trim(name)#" title="#artist_name_alt# - #trim(name)#" border="1">
								<cfelse>
									#ucase(similar.manufacturer)# - #similar.name#
								</cfif>
								<Br>
									<font size="1" face="verdana, arial">#name#</a>
								</td>
					
							</tr>
							</cfloop>
						</table>
						</cfif>
					</cfif>
					</cfoutput>
					<!--- End of Side fill for product Entry --->
					<br><br>
					<cfinclude template="sendtofriend.cfm"><br>
					</td>
				</tr>	
			</table>
			
			
			<!--- content ends --->
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer_.cfm">
		</td>
	</tr>
</table>

<cfinclude template="frmxss.cfm">

</body>
</html>
