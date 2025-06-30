<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>
<cfinclude template="meta.cfm">
<cfoutput>
<!--- <script language="JavaScript" src="http://#server_name#/js/utils.js"></script> --->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
         <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
         <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
         <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
         <script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script>
         <script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>
<link href="stylesheet_.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<cfquery name="searchresult" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT *
    FROM products
    WHERE (products.manufacturer like '#form.manufact#'
    <cfif form.manufact EQ 'MAX, PETER'>
    	OR products.manufacturer like 'MAX, PETER%')
   	<cfelse>
   		)
    </cfif>
	AND active = 1
	order by gallery_price desc
</CFQUERY>
<div class="main-container registration-page">
	<div id="Table_01">
	   <div class="header-section">
		  <div class="top-header">
			 <cfinclude template="top_.cfm">
		  </div>
		  <div class="navbar-section">
			 <cfinclude template="navbar_.cfm">
		  </div>
	   </div>
	<div class="inner-section alerts-registration-screen">
		<div class="container-fluid">
		   <div class="main-content">
			  <div class="content-section">
				 <div class="bottom-content-sec">
					<div class="banner-section">
					   <div class="art-work-content">
						  <div class="bottom-content">
							 <div class="user-registrations">
								<div aria-label="breadcrumb">
								   <ol class="breadcrumb">
									  <li class="breadcrumb-item"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;" >Home</a></li>
									  <li class="breadcrumb-item"><a href="searchpage.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;" >search</a></li>
									  <li class="breadcrumb-item active" aria-current="page">Database</li>
								   </ol>
								</div>
		<div class="table-responsive">
			<cfif SearchResult.recordcount>
			<cfoutput><strong>#SearchResult.recordcount# pieces found.</strong></cfoutput>
						<!--- CONTENT STARTS --->		
			<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<TR class="row0">
				<TD>Artist</TD>
				<TD>Medium</TD>
			    <TD>Size</TD>
			    <TD>Name of Piece</TD>
			    <TD COLSPAN="2" align="center">Gallery Price</TD>
			</TR>
			<CFOUTPUT query="SearchResult">
			<TR class="#this_row()#">
			 	<TD style="font-family: arial; font-size: 8pt;"><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#')">#manufacturer#</a></TD>
				<TD style="font-family: arial; font-size: 8pt;"><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#')">#replace(path,':','')#</a></TD>
				<TD style="font-family: arial; font-size: 8pt;"><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#')">#overview#</a></TD>
				<TD style="font-family: arial; font-size: 8pt;"><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#')">#name#</a></TD>
				<TD style="font-family: arial; font-size: 8pt;" align="right"><A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#')">#dollarformat(gallery_price)#</a>&nbsp;&nbsp;&nbsp;</TD>
				<TD>&nbsp;</td>
			</TR>
			</CFOUTPUT>
			</TABLE>	
			<cfelse>
				Sorry, no results found.  Please try another search.
			</cfif>
			</div>
		</div>
	 </div>
  </div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer_.cfm">
		</td>
	</tr>
<cfinclude template="frmxss.cfm">
</body>
</html>