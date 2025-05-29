<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">

<cfquery name="getBio" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT * from bios
	WHERE 0=0 <cfif isDefined('url.bioid') > and pk_bios = #url.bioId# </cfif>
</cfquery>

<!--- <cfdump var="#getBio#" abort="true"> --->

<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">

<cfoutput>
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
	<script language="JavaScript" src="./js/utils.js"></script>
</cfoutput>

<link href="stylesheet_.css" rel="stylesheet" type="text/css">

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
						<!--- <div class="sidebar web-sidebar-modal">	
							<cfinclude template="left_.cfm">
						</div> --->
						<div class="content-section">
							<div class="bottom-content-sec">
								<div class="banner-section">
									<div class="art-work-content">
										<div class="bottom-content">
											<div class="top-heading m-0">
												<!--- <h3>
													<cfparam name="artistName" default="#getBio.artist#">
													<cfif find(',',getBio.artist)><cfset artistName = "#listlast(getBio.artist,',')# #listfirst(getBio.artist,',')#" /></cfif>
													ARTIST BIO: #artistName#
													</h3> --->

													<div class="bio-content" style="text-align: left;">
														<!-- Output the content from the database -->
														#getBio.bio#
													</div>
												<!--- <cfset bioImage = reReplace(getBio.bio, ".*?(<img[^>]+>).*", "\1", "ALL")>
												<cfset bioText = reReplaceNoCase(getBio.bio, "<img[^>]+>", "", "ALL")>

												<!-- Display image at the top -->
													<!--- <div>
														#bioImage#
													</div> --->

												<!-- Always show full content but initially hide anything after 500 characters -->
													<div id="bio-content" class="bio-container">
														<cfif not refind('<img[^>]+>', bioImage)>
															<cfset bioImage = ''>
														</cfif>
														#bioImage#
														<!-- The content will be truncated using CSS, but the full HTML is present -->
														<div id="bio-preview" class="bio-preview">
															<cfset bioText = reReplaceNoCase(bioText, 'text-align:\s?center;', '', 'ALL')>
															#bioText#
														</div>
														
														<!--- Step 1: Strip HTML tags --->
														<cfset strippedBioText = REReplaceNoCase(bioText, "<[^>]*>", "", "ALL")>

														<!--- Step 2: Replace non-breaking spaces (&nbsp;) and trim the result --->
														<cfset strippedBioText = Trim(REReplaceNoCase(strippedBioText, "&nbsp;", "", "ALL"))>


														<!--- <cfif strippedBioText NEQ "" >
															<!-- Button to toggle between full and truncated content -->
														<p style="font-weight: bold; cursor: pointer;" id="toggle-btn" onclick="toggleBio()">Show More</p>
														</cfif> --->

														
													</div> --->
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
</cfoutput>
<cfinclude template="frmxss.cfm">

<!--- <style>
    /* Initially, only show the first 500 characters, hide the rest */
    .bio-preview {
        display: -webkit-box;
        -webkit-line-clamp: 5; /* Limiting the number of lines (adjust as needed) */
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    /* When expanded, show full content */
    .bio-preview.expanded {
        -webkit-line-clamp: unset;
        display: inline;
    }
	
</style> --->

<style>
    .bio-content img {
        display: block;
        margin: 0; /* Ensures no auto margin on the image that may center it */
        float: left; /* Aligns the image to the left */
        max-width: 200px; /* Adjust size as needed */
        margin-right: 20px; /* Space between image and text */
    }

    .bio-content p {
        text-align: left !important; /* Force left alignment for text */
    }
</style>


<script>
    function toggleBio() {
        // Get the elements for the preview and the button
        var preview = document.getElementById('bio-preview');
        var button = document.getElementById('toggle-btn');
    
        // Toggle between showing truncated and full content
        if (preview.classList.contains('expanded')) {
            // If currently showing full content, collapse it
            preview.classList.remove('expanded');
            button.innerText = 'Show More'; // Change the button text
        } else {
            // If currently showing truncated content, expand it
            preview.classList.add('expanded');
            button.innerText = 'Show Less';  // Change the button text
        }
    }
</script>

</body>
</html>