<cfoutput>

	<!--- <form method="GET" action="index.cfm">
		<input type="hidden" name="event" value="artists">

		<label for="artistLetter">Filter by Alphabet:</label>
		<select name="letter" id="artistLetter" onchange="this.form.submit()">
			<option value="">-- All --</option>
			<cfloop from="65" to="90" index="i"> <!--- ASCII A–Z --->
				<cfset currentLetter = chr(i)>
				<option value="#currentLetter#" <cfif isDefined('url.letter') and url.letter eq currentLetter>selected</cfif>>#currentLetter#</option>
			</cfloop>
		</select>
	</form> --->

	<!--- Search Filter Box --->
	<!--- <div style="margin: 15px 0;">
		<label for="artistSearch"><strong>Search Artist:</strong></label>
		<input type="text" 
			   id="artistSearch" 
			   name="artistSearch" 
			   placeholder="Type to search artist..." 
			   onkeyup="filterArtists()"
			   style="padding: 5px; width: 250px; margin-left: 10px;">
		<span style="margin-left: 10px; color: ##666;">(Type to filter artists below)</span>
	</div> --->

	<script>
   		// Allow maximum 10 selected artists
		const MAX_ARTISTS = 10;

		function limitArtistSelection() {
			const checkboxes = document.querySelectorAll("input[type='checkbox'][name^='artist_']");
			let newSelectedCount = 0;
			let totalChecked = 0;

			checkboxes.forEach(cb => {
				if (cb.checked) {
					totalChecked++; // Count all checked boxes
				}

				// Count only newly selected (not already saved)
				if (cb.checked && !cb.hasAttribute("data-preselected")) {
					newSelectedCount++;
				}
			});

			// Stop empty form submission
			if (totalChecked === 0) {
				alert("Please select at least one artist before submitting.");
				return false;
			}

			// Limit new selections to max 10
			if (newSelectedCount > MAX_ARTISTS) {
				alert("You can select a maximum of 10 new artists only.");
				return false;
			}

        	return true;
    	}
	</script>

	<form method="POST" action="index.cfm?event=artists.processHighlightArtists" onsubmit="return limitArtistSelection() && disableSubmitBtn(this);">

		<table cellspacing="0" cellpadding="3" border="0" width="90%" bgcolor="##eeeeee" height="10">
			<tr>
				<td style="font-weight: bold;" valign="middle">
					Please select the artists that you want to be highlighted in the alphabetical search.<br><br>Artists that you have previously selected are already checked.
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="Submit"></td>
			</tr>
			<tr>
				<td>
					<cfset thisQuery = getAllArtists />
					<cfset columnNum = 8 />
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
											<td>
												<input type="Checkbox" name="artist_#HTMLEditFormat(manufacturer)#" value="#HTMLEditFormat(manufacturer)#" <cfif listfindnocase(valuelist(getHighlightedArtists.artist,'|'),manufacturer,'|')>checked data-preselected="true"</cfif>>#manufacturer#
											</td>
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
					<button type="button" onclick="scrollToTop()" id="scrollTopBtn" title="Go to top">Go to Top</button>
				</td>
			</tr>
		</table>
	</form>

	<style>
		/* Scroll to Top Button Style */
		##scrollTopBtn {
			display: none; 
			position: fixed;
			bottom: 30px;
			right: 30px;
			z-index: 99;
			font-size: 12px;
			border: none;
			outline: none;
			background-color: ##EC008C;
			color: black;
			cursor: pointer;
			padding: 10px 14px;
			border-radius: 6px;
			box-shadow: 0 2px 6px rgba(0,0,0,0.3);
			transition: opacity 0.3s ease;
		}

		##scrollTopBtn:hover {
			background-color: white;
			color: ##EC008C;
		}
	</style>

	<script>
		// Show or hide the button depending on scroll position
		window.onscroll = function() {
			const btn = document.getElementById("scrollTopBtn");
			if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
				btn.style.display = "block";
			} else {
				btn.style.display = "none";
			}
		};

		// Scroll smoothly to top
		function scrollToTop() {
			window.scrollTo({ top: 0, behavior: 'smooth' });
		}
	</script>

	<script>
		function disableSubmitBtn(frm) {
			const btn = frm.querySelector('input[type="submit"]');
			if (btn) {
				btn.disabled = true;           // disable button
				btn.value = 'Submitting...';   // show user feedback
			}
			return true; // allow form to submit
		}		

		// Search filter function for artists
		// function filterArtists() {
		// 	// Get the search input value
		// 	var searchInput = document.getElementById('artistSearch');
		// 	var filter = searchInput.value.toLowerCase();
			
		// 	// Get all checkboxes with artist names
		// 	var checkboxes = document.querySelectorAll("input[type='checkbox'][name^='artist_']");
			
		// 	// Loop through all artist checkboxes
		// 	checkboxes.forEach(function(checkbox) {
		// 		// Get the artist name (the text node next to the checkbox)
		// 		var artistName = checkbox.nextSibling.textContent.trim().toLowerCase();
				
		// 		// Get the parent row (tr)
		// 		var row = checkbox.closest('tr');
				
		// 		// Show or hide based on whether the name contains the search term
		// 		if (artistName.indexOf(filter) > -1) {
		// 			row.style.display = "";
		// 		} else {
		// 			row.style.display = "none";
		// 		}
		// 	});
		// }
	</script>

</cfoutput>