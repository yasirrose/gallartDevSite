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
<script language="JavaScript" src="http://#server_name#/js/jquery-1.2.6.min.js"></script>
<script language="JavaScript" src="http://#server_name#/js/slimbox2.js"></script>
<link href="http://#server_name#/css/slimbox2.css" rel="stylesheet" type="text/css">
</cfoutput>

<SCRIPT LANGUAGE="JavaScript">
function popUpWin(urlPage){
	var features =	'scrollbars=yes, toolbar=no, status=no, menubar=no,' +
					'resizable=no, location=no, directories=no,' +
					'left=100, top=100, width=793, height=400';

	myWin =	window.open(urlPage,'WinName',features);
}
	
</SCRIPT>

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
<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * FROM products P
	LEFT OUTER JOIN users U on P.fk_users = U.pk_users
	where uid  = '#pid#' 
	and active = 1
</cfquery>
<cfquery name="similar" maxrows="3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * 
	FROM products
	WHERE active = 1 and manufacturer <> '#productinfo.manufacturer #' and path like '#productinfo.path#%'
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
						<cfinclude template="left.cfm">
					</td>
				</tr>
			</table>
		</td>
		<td valign="top">
			<!--- Customer Entry --->
			<table cellpadding="0" cellspacing="0" border="0" width="600">
			<Tr>
				<Td  valign="top">
			<cfoutput>
			
			<cfif isDefined('form.offer')>
			
			<!--- Insert info into customers table if new customer remove this section if not supported --->
			<cfquery name="find_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
				SELECT * from customers where (email = '#trim(email)#')
			</cfquery>
			
			<cfif not find_cust.recordcount>
			
				<cfquery name="insert_cust" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					INSERT into customers
					(
						LNAME,
						FNAME,
						PHONE,
						EMAIL
					)
					VALUES
					(
						'#BILLNAME#', 
						'#BILLNAMEF#',
						'#makeoffer_phone#',
						'#EMAIL#'
					)
					SELECT @@identity as uid 
				</cfquery>
				
				<cfset customerId = insert_cust.uid />
				
			<cfelse>
			
				<cfset customerId = find_cust.id />
				
			</cfif>
			
				<cfquery datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					INSERT into makeoffer
					(
						fk_customers,
						fk_products,
						offer,
						makeoffer_phone,
						best_time
					)
					VALUES
					(
						#customerId#, 
						#productinfo.uid#,
						#form.Offer#,
						'#form.makeoffer_phone#',
						'#form.best_time#'
					)
				</cfquery>
				<cfmail server="#servername#" username="gallart@onlinegalleryart.com"
password="re3objeC!P" to="#emailsupport#" cc="#emailsupportcc#"  from="#form.Email#" subject="GallArt.com <> We Buy & Sell Fine Art <> Make An Offer" type="HTML">
					<font style="font-size: 10pt; font-family: Arial;">
					The following user made an offer on the piece below:
					<br><br>
					Name: #form.BILLNAMEF# #form.BILLNAME#<br>
					Email Address: #form.Email#<br>
					Phone: #form.makeoffer_phone#<br>
					Best time to call: #form.best_time#<br>
					Offer: $#form.Offer#<br>
					Artist: #ucase(productinfo.manufacturer)#<br>
					Title: #productinfo.name#<br>
					Art ID: #productinfo.modelno#<br>
					Retail Price: #dollarFormat(productinfo.retail_price)#<br>
					Gallery Price: #dollarFormat(productinfo.gallery_price)#<br>
					<!--- removed for make offer 5/6/15 --->
					<!--- Sale Price: #dollarFormat(productinfo.sale_price)# --->
					<cfif productinfo.fk_users GT 1>
						<br>
						Seller: #productinfo.fname# #productinfo.lname#<br>
						Seller Email: #productinfo.email#<br>
						Seller Phone: #productinfo.phone#
					</cfif>
					<br><br>
					</font>
				</cfmail>
				
				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr>
						<td style="padding-top: 20px;" align="center">
							<span style="color:##dd3a7d; font-size: 16px; font-weight: bold;">THANK YOU FOR MAKING YOUR OFFER!<br>WE WILL BE IN TOUCH WITH YOU SHORTLY<br><br>
<a href="index.cfm?xss=#xss#" style="color:##dd3a7d; font-size: 16px; font-weight: bold; text-decoration: underline;">CLICK HERE</a> TO MAKE ANOTHER OFFER</span>
						</td>
					</tr>
				</table>
			
			<cfelse>
			
			<cfif productinfo.recordcount>
			<cfform action="" method="post" name="frm1">
			<table cellpadding="5" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="center">
						<div style="color:##dd3a7d; font-size: 20px; font-weight: bold; padding: 10px;">MAKE US AN OFFER - LIMITED TIME!</div>
					</td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="2" cellspacing="0" border="0" width="100%">
						<tr bgcolor="#centercolor#">
							<td valign="top" colspan="3" width="100%" align="center">
							<cfset imgFile = expandpath('.') & '\img\' & productinfo.uid &'.jpg' />
							<cfif fileExists(imgFile)>
								<img src="http://#server_name#/img/#productinfo.uid#.jpg" border="2" width="300"><br>
								<a href="http://#server_name#/img/#productinfo.uid#.jpg" rel="lightbox">[CLICK]</a> to view large image size in separate window.
							</cfif>
								
							
								<table cellpadding="3" cellspacing="0" border="0" width="75%">
									<tr>
										<td colspan=2><br></td>
									</tr>
									<tr>
										<td width="60%"><cfif productinfo.manufacturer gt 0><font size="1" face="arial, helvetica"><h1>Artist: #ucase(productinfo.manufacturer)#</h1></cfif></td>
										<td width="40%"><cfif productinfo.name gt 0><font size="1" face="arial, helvetica">Title: #productinfo.name#</cfif></td>
									</tr>
									
									<tr>
										<td><cfif productinfo.retail_price gt 0><font size="1" face="arial, helvetica">Retail Price: #DollarFormat(productinfo.retail_price)#</cfif></td>
										<td>
											<font size="1" face="arial, helvetica">
											<cfif productinfo.closeout eq 1 and productinfo.special_price gt 0>
												<!--- remove for make offer 4/30/15 --->
												<!--- <cfif application.showSalePrice EQ 1><span style="color: ##ff0000;">Sale Price: #DollarFormat(productinfo.special_price)#</span></cfif> --->
											<cfelseif productinfo.gallery_price gt 0>Gallery Price: #DollarFormat(productinfo.gallery_price)#
											</cfif>
											</font>
										</td>
									</tr>
									
									<tr>
										<td><cfif productinfo.overview gt 0><font size="1" face="arial, helvetica">Size: #productinfo.overview#</cfif></td>
										<td><cfif productinfo.specs gt 0><font size="1" face="arial, helvetica">Year: #productinfo.specs#</cfif></td>
									</tr>
									
									<cfset medium = replace(RemoveChars(productinfo.path,len(productinfo.path), 1),":","/","all")>
									<tr>
										<td><cfif medium gt 0><font size="1" face="arial, helvetica">Medium: #medium#</cfif></td>
										<td><cfif productinfo.edition gt 0><font size="1" face="arial, helvetica">Edition: #productinfo.edition#</cfif></td>
									</tr>
									
									<tr>
										<td colspan=2><cfif productinfo.caption gt 0><font size="1" face="arial, helvetica">Description: #trim(productinfo.caption)#</cfif></td>
									</tr>
								</table>
							</td>
						</tr>
						</table>
						<table cellpadding="2" cellspacing="0" border="0" width="100%">
							<tr>
								<Td colspan="2" align="Center">
									<span style="color:##dd3a7d; font-size: 16px; font-weight: bold;">MAKE AN OFFER FOR THIS PIECE!<br>SIMPLY SUBMIT THE FORM BELOW:</span>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Name</b> <i>(First Last)</i>
								</td>
								<td><cfinput type="text" name="billnamef" size="15" required="Yes" message="We require the billing first name to process the order.">&nbsp;<cfinput type="text" name="BillName" size="25" required="Yes" message="We require the billing last name to process the order.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Phone</b>
								</td>
								<td><cfinput type="text" name="makeoffer_phone" size="35" required="Yes" message="We require your Phone number.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Best time to call:</b>
								</td>
								<td><cfinput type="text" name="best_time" size="35" required="Yes" message="Best time to call is required." >
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Email</b>
								</td>
								<td><cfinput type="text" name="Email" size="35" required="Yes" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" message="Email is required." >
								</td>
							</tr>
							<tr>
								<td colspan="2">
								<hr>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td colspan="2" align="center" style="color:##dd3a7d; font-size: 13px;"><b>MAKE AN OFFER:</b>&nbsp;&nbsp;
								$<cfinput type="text" name="Offer" size="10" required="Yes" message="Please make an offer - enter a dollar amount, no $ or decimal." validate="integer" >
								</td>
							</tr>
							<Tr>
								<td colspan="2" align="center" style="padding-top: 20px;">
								<input type="submit" value="CLICK TO SUBMIT YOUR OFFER!" name="submit" class="pinkSubmit">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			</cfform>
			</cfif>
			</cfif>
			</cfoutput>
			<td valign="top" style="padding-top: 5px;">
				<cfoutput>
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
							<cfelse>
								<cfset artist_name = manufacturer />
								<cfset artist_name_url = manufacturer />
							</cfif>
						
						<tr>
					
							<td valign="top" align="center">
							
					<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
					<cfif fileExists(thisFile)>
					<img src="http://#server_name#/img/thumbnails/#similar.uid#.jpg" alt="#ucase(similar.manufacturer)# - #similar.name#" border="1">
					<cfelse>
					#ucase(similar.manufacturer)# - #similar.name#
					</cfif>
						<Br>
						<font size="1" face="verdana, arial">#name#</a>
							</td>
					
						</tr>
							</cfloop>
					</table>
					<br>
					</cfif>

					<input type="image" src="images/other_listings.gif" style="border: none;" onClick="location.href='index.cfm?xss=#xss#'">
			</cfoutput>
			
			</td>
			</td>
			</tr>
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