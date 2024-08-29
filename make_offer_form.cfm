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
<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT path FROM products
	group by path
	order by path
</cfquery>
<cfset fileSizeLimitKb = '200KB' />
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
			<table cellpadding="0" cellspacing="0" border="0" width="600">
			<Tr>
				<Td  valign="top">
			<cfoutput>
			
			<cfif isDefined('form.offer')>
			
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
				<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="#emailsupport#" cc="#emailsupportcc#"  from="#form.Email#" subject="Gallart Make An Offer Form" type="HTML">
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
					Sale Price: #dollarFormat(productinfo.sale_price)#
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
			

			<cfform action="" method="post" name="frm1">
			<table cellpadding="5" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="center">
						<div style="color:##dd3a7d; font-size: 20px; font-weight: bold; padding: 10px;">MAKE US AN OFFER!</div>
					</td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="2" cellspacing="0" border="0" width="100%">
							<tr>
								<Td colspan="2" align="Center">
									<span style="color:##dd3a7d; font-size: 16px; font-weight: bold;">Submit the form below to make us an offer:</span>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Name</b> <i>(First Last)</i>
								</td>
								<td><cfinput type="text" name="billnamef" size="15" required="Yes" message="We require the billing first name to process the order.">&nbsp;<cfinput type="text" name="BillName" size="25" required="Yes" message="We require the billing last name to process the order.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Email</b>
								</td>
								<td><cfinput type="text" name="Email" size="35" required="Yes" validate="regular_expression" pattern="^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-|\_)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$" message="Email is required." >
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Phone</b>
								</td>
								<td><cfinput type="text" name="makeoffer_phone" size="35" required="Yes" message="We require your Phone number.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Artist</b>
								</td>
								<td><cfinput type="text" name="makeoffer_artist" size="35" required="Yes" message="We require the artist name.">
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Title</b>
								</td>
								<td><cfinput type="text" name="makeoffer_title" size="35" required="Yes" message="We require the title of the listing.">
								</td>
							</tr>
							<tr class="#this_row()#" nowrap>
								<td colspan="2"><b>Select Medium:</b>
									<select name="makeoffer_medium">
										<option value="">Select here ...</option>
										<cfloop query="cats">
											<option value="#path#">#ucase(path)#
										
										</cfloop>
									</select>
								</td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Size:</b></td>
								<td><input type="text" name="makeoffer_size" size="25">&nbsp;<font face="Verdana, Arial,helvetica" size="1">(HEIGHT x WIDTH)</font></td>
							</tr>
							<tr class="#this_row()#">
								<td><b>Asking Price:</b>
								</td>
								<td><input type="text" name="makeoffer_price" size="25" maxlength="13"></td>
							</tr>
							<tr class="#this_row()#">
								<td colspan="2"><b>Description:</b></td>
							</tr>
							<tr>
								<td colspan="2"><textarea name="makeoffer_description" cols="90" rows="4"></textarea></td>
							</tr>
							<tr class="#this_row()#">
								<td colspan="2">
								<b>Upload Photo</b> <span style="color: ##ff0000; font-size: 8pt;">(THE FILE MUST BE A .JPG, AND MUST BE LESS THAN #fileSizeLimitKb# IN SIZE)</span><br><br>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td valign="top" width="50%">
												<input type="file" name="fileup" size="22" style="font-size: xx-small;">
											</td>
										</tr>
									</table>
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
			</cfoutput>
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