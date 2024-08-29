<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="artist_info" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT distinct manufacturer
	FROM products 
	WHERE active = 1 
	AND (path <> '') 
	AND (path IS NOT NULL)
	ORDER BY manufacturer 
</cfquery>


<cfif isDefined('form.alerts_proc') and isDefined('session.sellerinfo.pk_users')>

<cfset session.alertlst = '' />

<cfquery name="delAlerts" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	DELETE from alerts
	WHERE fk_users = #session.sellerinfo.pk_users#
</cfquery>

<cfloop collection="#form#" item="idx">

	<cfif left(idx,7) eq 'artist_'>

		<cfquery name="insertAlerts" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		    INSERT into alerts
			(
				artist,
				fk_users,
				datestamp
			)
			values
			(
				'#removechars(idx,1,7)#',
				#session.sellerinfo.pk_users#,
				#createodbcdate(now())#
			)
		</cfquery>
		
		<cfset session.alertlst = listappend(session.alertlst,removechars(idx,1,7),'|') />
	
	</cfif>

</cfloop>

<cflocation url="#script_name#?xss=#xss#&alertthanks=1" addtoken="No">

</cfif>


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
<cfoutput>
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="100%" height="125" valign="top" bgcolor="##000000">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="100%" valign="top" height="37" bgcolor="##000000">
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
			<table cellspacing="0" cellpadding="0" border="0" width="627">
				<tr>
					<td align="center" style="padding-top: 10px;">
						<strong>EMAIL ALERTS</strong><br><br>
						Click <a href="alerts_info.cfm?xss=#xss#">HERE</a> for more information.
					</td>
				</tr>
				<cfif not isDefined('session.sellerinfo.fname')>
				<tr>
					<td style="padding-top: 10px;">
						You must be a registered member in order to submit email alerts.  Please login below or click <a href="alerts_registration.cfm?xss=#xss#">HERE </a> to register.<br><br>
					</td>
				</tr>
				<tr>
					<td style="padding-top: 10px;">
						<cfif structKeyExists(session,'sellerinfo') AND session.sellerinfo.login EQ 0>
							<span style="color: red;">Sorry, we couldn't find that username/password combination in our system.  Please try again.</span>
						</cfif>
						<cfinclude template="alerts_login.cfm">
					</td>
				</tr>
				<cfelse>
				<tr>
					<td style="padding-top: 10px;">
						<cfif isDefined('url.alertthanks')>
							Thank you for entering your alerts into our system. <br>When art is added by these artists, you will be notified by email:<br><br>
							<cfif len(session.alertlst)>
							
								<cfloop list="#session.alertlst#" index="idx" delimiters="|">
									#idx#<br>							
								</cfloop>
								
							<cfelse>
							
								No artists were selected.
							
							</cfif>

						<cfelse>
						
						<cfquery name="getAlerts" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
						    SELECT * FROM alerts
							WHERE FK_USERS = #session.sellerinfo.pk_users#
						</cfquery>
						
						<form method="POST" action="#script_name#?#query_string#">
						<input type="Hidden" name="alerts_proc">
						<table cellspacing="0" cellpadding="3" border="0" width="100%" bgcolor="##eeeeee" height="10">
							<tr>
								<td style="font-weight: bold;" valign="middle">
									Please select the artists for which you would like to receive alerts.<br><br>Artists that you have previously selected are already checked.
								</td>
								<td valign="middle"><input type="submit" value="Submit" style="color: ##d9387c; font-size: 11pt; font-weight: bold; background-color: transparent; border: 1px solid ##eeeeee; cursor: pointer;"><input type="image" src="images/arrow.jpg" alt="Submit" align="top" style="border: 1px solid ##eeeeee;"></td>
							</tr>
						</table>
						
						<table cellspacing="0" cellpadding="2" border="0" width="100%">
							<tr>
								<td>
									<cfset thisQuery = artist_info />
									<cfset columnNum = 4 />
									<cfset column = round(thisQuery.recordcount/columnNum)>
									<cfset rem = thisQuery.recordcount MOD columnNum>
									<cfset x = 1 />
									<cfif rem EQ 1>
										<cfset val = evaluate(-1) />
									<cfelse>
										<cfset val = 0 />
									</cfif>
									
									<table>
										<tr>
									  		<td valign="top">
									      
											 	<table>
											 	<cfloop query="thisQuery">
											    	<tr>
											        	<td style="font-size: 9px;"><input type="Checkbox" name="artist_#manufacturer#" value="#manufacturer#" <cfif listfindnocase(valuelist(getAlerts.artist,'|'),manufacturer,'|')>checked</cfif>>#manufacturer#</td>
											    	</tr>
											      	<cfif x IS column>
											    		</table></td><td valign="top"><table>
											    		<cfset x = val>
											      	</cfif>
											   	<cfset x = x + 1>    
											 	</cfloop>
											  	</table>
									  		</td>
									    </tr>
									</table>
								</td>
							</tr>
						</table>
						</form>
						</cfif>
					</td>
				</tr>
				</cfif>
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

</body>
</html>