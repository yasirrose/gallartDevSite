<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">
<link rel="shortcut icon" href="favicon.ico" >

<link href="stylesheet.css" rel="stylesheet" type="text/css">
<link type="text/css" href="/css/jquery/ui.all.css" rel="stylesheet" />
<script src="/js/jquery-1.3.2.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.ui.accordion.js"></script>
<script type="text/javascript">
  $(document).ready(function(){
    $("#accordion").accordion({ autoHeight: false });
  });
  
function closeReplyMail(){
document.getElementById('replyMail').style.display = 'none';
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<cfset url.pk_employees = 1 />
<cfset url.pk_modules = 4 />
<cfset url.moduleId = 12856 />
<cfset url.recipientEmail = 'threlkeldbt@hotmail.com' />
<cfscript>
	getMail = application.objectFactoryAdmin.getInstance('mail_log').getMail(#url.pk_employees#,#url.pk_modules#,#url.moduleId#,#url.recipientEmail#);
	getListingFromId = application.objectFactoryAdmin.getInstance('art').getListingFromId('12856');
</cfscript>

<style>
.ui-accordion .ui-accordion-header a {
font-size:1em;
}
.ui-accordion .ui-accordion-content p{
font-size:1em;
}
</style>
<cfoutput>
<table id="Table_01" width="900" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="900" height="125" valign="top" bgcolor="##000000">
			<cfinclude template="top.cfm">
		</td>
	</tr>
		<td colspan="2" valign="top">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td align="center" valign="top" style="font-size: 14px; padding: 10px;">
						<strong>EMAIL LOG</strong>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<table cellspacing="0" cellpadding="4" border="0" width="300">
							<tr>
								<td>
									Title:
								</td>
								<td>
									#getListingFromId.name#
								</td>
							</tr>
							<tr>
								<td>
									Artist:
								</td>
								<td>
									#getListingFromId.manufacturer#
								</td>
							</tr>
							<tr>
								<td>
									Gallery Pric:
								</td>
								<td>
									#getListingFromId.gallery_price#
								</td>
							</tr>
							<tr>
								<td>
									Medium:
								</td>
								<td>
									#getListingFromId.path#
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<img src="http://www.gallart.com/img/thumbnails/12856.jpg" width="100" border="0">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="font-size: .7em;">
					<cfif getMail.recordcount>
						<div id="accordion">
							<cfloop query="getMail">
							<h3>
								<a href="##">
								To: #recipientEmail#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								From: #senderEmail#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								#dateFormat(datestamp)# #timeFormat(datestamp)#
								</a>
							</h3>
							<div>
								<p>
								#body#
								</p>
							</div>
							</cfloop>
						</div>
					<cfelse>
						<div style="font-family: Arial; font-size: .7em; font-weight: bold; color: ##000;">
							NO EMAILS SENT
						</div>
					</cfif>
					
					</td>	
			
				</tr>
				<tr>
					<td align="center" style="padding: 10px;">
						<input type="Button" value="REPLY" onclick="document.getElementById('replyMail').style.display = 'block';">
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
</cfoutput>
<cfinclude template="frmxss.cfm">
<iframe id="replyMail" src="admin/controllers/mail_log.cfm?event=replyMail" style="display: none; position: absolute; top: 200px; left: 300px; z-index: 1000; background-color: #fff;" height="400" width="350" frameborder="1">
</iframe>
</body>
</html>