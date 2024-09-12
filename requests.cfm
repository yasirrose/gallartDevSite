<!--- Kill extra output. --->
<cfsilent>
	

	<cfset arrValidChars = ListToArray(
		"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
		"2,3,4,5,6,7,8,9"
		) />
 
	<!--- Now, shuffle the array. --->
	<cfset CreateObject( "java", "java.util.Collections"	).Shuffle(	arrValidChars )	/>

	<cfset strCaptcha = (
		arrValidChars[ 1 ] &
		arrValidChars[ 2 ] &
		arrValidChars[ 3 ] &
		arrValidChars[ 4 ]
		) />

	<cfset FORM.captcha_check = Encrypt( strCaptcha,"gallart-is-the-best", "CFMX_COMPAT", "HEX" ) />
 
</cfsilent>


<cfparam name="xss" default="">

<cfquery name="getRequests" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT * from requests R
	WHERE fk_request_status = 2
	order by datestamp desc
</cfquery>

<cfquery name="getPages" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT * from pages
	WHERE pk_pages = 8
</cfquery>

<cfif structKeyExists(form,'requestFormNotes')>

	  <cfquery name="getRequest" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
          SELECT * from requests R
          WHERE pk_requests = #form.listingId#
      </cfquery>
      
      <cfquery name="insertResponse" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
          INSERT into request_responses
          (
              fk_requests,
              fname,
              lname,
              email,
              phone,
              notes
          )
          values
          (
              #form.listingId#,
              '#form.fname#',
              '#form.lname#',
              '#form.email#',
              '#form.phone#',
              '#form.requestFormNotes#'
          )
      </cfquery>
      <cfmail server="#servername#" username="onli16@onlinegalleryart.com"
  password="re3objec" to="#emailsupport#" cc="#emailsupportcc#" from="#form.email#" subject="GallArt.com <> Buying & Selling Fine Art <> Request Form" type="HTML">
          <font style="font-size: 10pt; font-family: Arial;">
          <strong>#form.fname# #form.lname#</strong> has submitted a response to a REQUEST on #dateformat(createodbcdate(now()))# at #timeformat(createodbcdatetime(now()))#.  <br><br>
          Title: #getRequest.title#<br>
          Artist: #getRequest.artist#<br><br>
          Notes: #form.requestFormNotes#<br><br>
          Email: #form.email#<br><br>
          Please put the requester in touch with the member that listed the request.
          <br><br>
      </cfmail>
      
      <cfmail server="#servername#" username="onli16@onlinegalleryart.com"
  password="re3objec" to="#form.email#" from="info@gallart.com" subject="Gallery Art  - REQUEST RESPONSE" type="HTML">
          <font style="font-size: 10pt; font-family: Arial;">
          Thank you, #form.fname# #form.lname#, for submitting your response to our request page at www.gallart.com. <br>
          We will put you in touch with the member that made the listing.
          Thanks,<br><br>
          <a href="http://3.235.23.60/">Gallery Art</a>
          <br><br>
      </cfmail>

</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
<script language="JavaScript" src="./js/utils.js"></script>
<script type="text/javascript" src="http://#server_name#/js/jquery-1.2.6.min.js" ></script>
<script type="text/javascript" src="http://#server_name#/js/thickbox-compressed.js" ></script>
<link rel="stylesheet" type="text/css" href="http://#server_name#/css/thickbox.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script>
</cfoutput>

<script language="JavaScript">
	function fillResponseForm(thisListingId,thisTitle,thisArtist){
		document.getElementById('listingId').value = thisListingId;
		document.getElementById('responseTitle').innerHTML = 'Title: '+thisTitle;
		document.getElementById('responseArtist').innerHTML = 'Artist: '+thisArtist;
	}
</script>

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


<cfoutput>
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
		<div class="inner-section">
			<div class="container-fluid">
				<div class="main-content">
					<div class="mobile-sidebar-logo">
						<div class="sidebar-Icon">
							<i class="fas fa-bars"></i>
						</div>
					</div>
					<div class="sidebar web-sidebar-modal">	
						<cfinclude template="left_.cfm">
					</div>
					<div class="content-section">
						<div class="bottom-content-sec">
							<div class="banner-section">
								<div class="art-work-content">
									<div class="bottom-content">
										<div class="top-heading text-left">
											<h3>REQUESTS</h3>
											<cfif structKeyExists(form,'requestFormNotes')>
												<p>Thank you for submitting a response to one of our REQUEST listings. <br>You can respond to as many as you'd like, simply by clicking the Contact Gallery Art button.</p>
											</cfif>
											<p>#getPages.page_content#</p>
										</div>
										<div class="table-responsive">
											<table cellspacing="0" cellpadding="0" border="0" width="100%" style="padding-right: 10px;">
												<tr>
													<td align="center" style="padding-top: 10px;">
														<table cellspacing="0" cellpadding="3" border="0" width="100%">
															<tr>
																<td colspan="3" align="center" style="padding-bottom: 10px;">
																	<table cellspacing="0" cellpadding="0" border="0" width="100%">
																		<tr>
																			<td>
																				Click <a href="requests_submit.cfm?xss=#xss#">HERE</a> to submit a request for a piece of art that you want listed on our REQUEST page.
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
															<cfif getRequests.recordcount>
																<tr class="row0">
																	<td width="65%" height="20" style="color: ##ffffff;padding:5px;"><b>Title</b></td>
																	<td width="25%" style="color: ##ffffff;"><b>Artist</b></td>
																	<td>&nbsp;</td>
																</tr>
																<cfloop query="getRequests">
																	<tr class="#this_row()#">
																		<td height="20" style="padding:5px;">
																			#title#
																		</td>
																			<td>
																			#artist#
																		</td>
																		<td>
																			<input type="Button" value="Contact Gallery Art" onMouseOver="fillResponseForm('#pk_requests#','#title#','#artist#')" alt="##TB_inline?height=540&width=450&inlineId=responseForm&modal=true"  style="font-size: 7pt;" class="thickbox">
																		</td>
																	</tr>
																</cfloop>
															<cfelse>
																<tr>
																	<td>
																		<div align="center" style="color: ##db3a7d;">Sorry, there are no requests in the system at this time.</div>
																	</td>
																</tr>
															</cfif>
														</table>
													</td>
												
												</tr>
										</table>
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
</cfoutput>
<cfinclude template="frmxss.cfm">

<div id="responseForm" style="display:none;">
	<div style="float: right;"><a href="#" onClick="tb_remove();" style="color: #dd3a7d; font-weight: bold; font-size: 10px;">CLOSE</a></div>
	<p>
		<cfform method="post" action="#script_name#" id="requestForm">
        <input type="hidden" name="listingId" id="listingId">
                
		<table cellspacing="3" cellpadding="3" border="0" width="100%">
			<tr>
				<td>
					<strong>Please submit this form to Gallart in response to this piece:</strong>
				</td>
			</tr>
			<tr>
				<td id="responseTitle">
					
				</td>
			</tr>
			<tr>
				<td id="responseArtist">
					
				</td>
			</tr>
			<tr>
				<td>
					Your name:
				</td>
			</tr>
			<tr>
				<td>
					<input type="Text" name="fname" size="20">&nbsp;<input type="Text" name="lname" size="30">
				</td>
			</tr>
			<tr>
				<td>
					Your email address:
				</td>
			</tr>
			<tr>
				<td>
					<cfinput type="Text" name="email" id="email" size="30" required="Yes" message="Please enter your email address.">
				</td>
			</tr>
			<tr>
				<td>
					Your phone number:
				</td>
			</tr>
			<tr>
				<td>
					<input type="Text" name="phone" size="30">
				</td>
			</tr>
			<tr>
				<td>
					You may enter notes or comments below:
				</td>
			</tr>
			<tr>
				<td>
					<textarea name="requestFormNotes" cols="40" rows="3"></textarea>
				</td>
			</tr>
            <tr>
                <td>
                    <cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="medium"	fonts="verdana,arial,times new roman,courier" fontsize="28"	/>
                <br><br>
                <span id="captchaError" style="color: #ff0000; font-weight: bold; display:none;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</span>
                <span id="captchaCopy"><b>Please enter the characters in the image above:</b></span><br><br>
                <cfinput type="text" name="captcha" id="captcha" required="true" message="Please enter the characters in the image.">
                
                </td>
            </tr>
			<tr>
				<td>
					<input type="Button" value="Submit" name="requestFormSubmit" onClick="validateCaptcha()">
				</td>
			</tr>
		</table>
		</cfform>
	</p>

</div>

<script>
	validateCaptcha = function(){
		var errorMsg = "";
		if($("#email").val() == "") errorMsg += "Please enter your email.\n"
		if($("#captcha").val() == "") errorMsg += "Please enter the characters in the image.\n"
		if(errorMsg == ""){
		   $.ajax({
			  url:"requests_decrypt.cfm?c=<cfoutput>#FORM.captcha_check#</cfoutput>",  
			  success:function(data) {
				  if(jstrim(data) == $("#captcha").val().toUpperCase()){
					  $("#requestForm").submit();
				  } else {
					  $("#captchaCopy").hide();
					  $("#captchaError").show();
				  }
			  }
		  });
		} else {
			alert(errorMsg);
		}
	}
</script>

</body>
</html>
