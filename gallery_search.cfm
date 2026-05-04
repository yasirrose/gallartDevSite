<cfquery name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" cachedwithin="#createTimespan(0,1,0,0)#">
	SELECT distinct manufacturer from products
	where active = 1
	<!--- AND fk_users is null --->
	order by manufacturer
</cfquery>
<!--- <cfset temp = QueryAddRow(data)>
<cfset Temp = QuerySetCell(data, "manufacturer", "MAX, PETER")>  --->
<cfquery dbtype="query" name="artistinfo">
	select *
	from data
	ORDER BY manufacturer
</cfquery>
<!DOCTYPE html>
<html>
<head>
	<style>
		.search-form-group form select {
			font-weight: 800;
		}
	</style>
	<title>Search</title>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			function drop(gothere, selectName) {
				var form = document.forms['dropdownSearch'];
				if (form) {
					var select = form.elements[selectName];
					if (select) {
						let value = select.options[select.selectedIndex].value;

						// Sanitize: trim, remove dangerous chars, replace slashes with hyphens, replace spaces with +
						const cleanedValue = decodeURIComponent(value.trim())
							.replace(/[<>"'&]/g, '') // Remove dangerous characters
							.replace(/\//g, '-')     // Replace slashes with hyphens
							.replace(/\s+/g, '+')    // Replace spaces with +
							.replace(/%20/g, '%2B'); // Replace %20 with %2B

						// Encode final value to make it URL-safe
						const encodedValue = encodeURIComponent(cleanedValue);

						// Build the sanitized URL and redirect
						parent.location = gothere + encodedValue;

					} else {
						console.error("Select element '" + selectName + "' not found.");
					}
				} else {
					console.error("Form 'dropdown' not found.");
				}
				return true;
			}
			// Make the function globally available
			window.drop = drop;
		});
		function slugify(text) {
			return text
				.normalize("NFD").replace(/[\u0300-\u036f]/g, "") // remove accents (ñ → n, é → e)
				.replace(/[^a-zA-Z0-9\s]/g, '') // remove special characters
				.trim()
				.toLowerCase()
				.replace(/\s+/g, '-'); // spaces → hyphens
		}
	</script>
</head>
<body>
	<div class="search-form-group">
		<form name="dropdownSearch">
			<div class="top-content">
				<!--- <label>Picture Gallery</label> --->
				<label></label>
				<!--- <a href="#TB_inline?height=200&width=300&inlineId=picturegallery_help&modal=true" class="thickbox">
					<span>What's this <span class="question-span">?</span></span>
				</a> --->
			</div>
			
				<cfquery name="qEmployees" datasource="#application.dsource#">
					SELECT * 
					FROM filterOption
					WHERE filterType = 'Subject'
					ORDER BY filterName ASC
				</cfquery>
				
				<div class="row input-form">
						<div class="col-lg-3 col-md-4 col-sm-6 col-12 mt-2 mb-2">
							<div class="select-option input-field">
								<select name="artSubject" class="chosen-select m-0" data-placeholder="Search by Subject" onChange="drop('/artists/subject/', 'artSubject')">
									<option value="">Search by Subject</option>
									<!--- Loop through the query results to create option tags --->
									<cfoutput query="qEmployees">
										<option value="#filterName#">#filterName#</option>
									</cfoutput>
								</select>
							</div>
						</div>
						<cfquery name="qGetStyle" datasource="#application.dsource#">
							SELECT * 
							FROM filterOption
							WHERE filterType = 'Style'
							ORDER BY filterName ASC
						</cfquery>
						<div class="col-lg-3 col-md-4 col-sm-6 col-12 mt-2 mb-2">
							<div class="select-option input-field">
								<select name="artStyle" class="chosen-select m-0" data-placeholder="Search by Style" onChange="drop('/artists/style/', 'artStyle')">
									<option value="">Search by Style</option>
									<cfoutput query="qGetStyle">
										<option value="#filterName#">#filterName#</option>
									</cfoutput>
								</select>
								<!--- <select name="artStyle" class="chosen-select m-0" data-placeholder="Search by Style" onChange="drop('products.cfm?xss=<cfoutput>#xss#</cfoutput>&Style=', 'artStyle')">
									<option value="">Search by Style</option>
									<option value="Abstract">Abstract</option>
									<option value="Art Deco">Art Deco</option>
									<option value="Contemporary Art">Contemporary Art</option>
									<option value="Cubism">Cubism</option>
									<option value="Pop Art">Pop Art</option>
									<option value="Realism">Realism</option>
									<option value="Surrealism">Surrealism</option>
									<option value="Urban Art">Urban Art</option>
									<option value="Figurative">Figurative</option>
									<option value="Animation">Animation</option>
									<option value="Memorabilia">Memorabilia</option>
								</select> --->
							</div>
						</div>
						<cfquery name="qGetSize" datasource="#application.dsource#">
							SELECT * 
							FROM filterOption
							WHERE filterType = 'Size'
							ORDER BY id ASC
						</cfquery>
					<div class="col-lg-3 col-md-4 col-sm-6 col-12 mt-2 mb-2">
						<div class="select-option input-field">
							<select name="artSize" class="chosen-select m-0" data-placeholder="Search by Size" onChange="drop('/artists/size/', 'artSize')">
								<option value="">Search by Size</option>
								<cfoutput query="qGetSize">
									<option value="#filterName#">#filterName#</option>
								</cfoutput>
								<!--- <option value="small">Small (up to 12 inches)</option>
								<option value="medium">Medium (13 to 36 inches)</option>
								<option value="large">Large (37 to 60 inches)</option>
								<option value="Oversized">Oversized (over 60 inches)</option> --->
							</select>
						</div>
					</div>
					<cfquery name="qGetType" datasource="#application.dsource#">
						SELECT DISTINCT filterName 
						FROM filterOption
						WHERE filterType = 'Type'
						ORDER BY filterName ASC
					</cfquery>
					<div class="col-lg-3 col-md-4 col-sm-6 col-12 mt-2 mb-2">
						<div class="select-option input-field">
							<select name="artType" class="chosen-select m-0" data-placeholder="Search by Type" onChange="drop('/artists/type/', 'artType')">
								<option value="">Search by Type</option>
								<cfoutput query="qGetType">
									<option value="#filterName#">#filterName#</option>
								</cfoutput>
								<!--- <option value="Paintings">Paintings</option>
								<option value="Drawings and Watercolor">Drawings and Watercolor</option>
								<option value="Mixed Media">Mixed Media</option>
								<option value="Prints and Editions">Prints and Editions</option>
								<option value="Photography">Photography</option>
								<option value="Sculptures">Sculptures</option> --->
							</select>
						</div>
					</div>
				
				</div>
		</form>
	</div>
	<script>
	function dropSanitized(baseURL, selectName) {
		const value = document.getElementsByName(selectName)[0].value;
		if (value !== '') {
			const sanitizedURL = baseURL + encodeURIComponent(value);
			window.location.href = sanitizedURL;
		}
	}
	// Handle page load and back/forward navigation
	window.addEventListener('pageshow', function (event) {
		if (event.persisted || performance.getEntriesByType("navigation")[0].type === "back_forward") {
			// Clear all form fields
			document.querySelectorAll('form').forEach(form => form.reset());
			// Temporarily disable onchange
			const select = document.querySelector('select[name="manufact"]');
			const oldOnChange = select.onchange;
			select.onchange = null;

			// Reset Select2
			$('.select2').val(null).trigger('change.select2'); // Only updates UI, doesn't trigger real onchange

			// Restore onchange after short delay
			setTimeout(() => {
				select.onchange = oldOnChange;
			}, 100); // Wait just enough for reset to finish
		}
	});
</script>
</body>
</html>

<!--- <table cellpadding="0" cellspacing="0" border="0" width="100%">
<form name="dropdown">
	<tr>
		<td width="200">
			<select name="manufact" onChange="drop('products.cfm?xss=<cfoutput>#xss#</cfoutput>&artist=')" style="font-family: verdana; font-size: 7pt;">
				<option value="" selected>PLEASE SELECT ARTIST
					<cfoutput query="artistinfo">
						<cfif manufacturer EQ 'MAX, PETER'>
							<option value="#manufacturer#">MAX, PETER (ALL)
						<cfelseif not isnumeric(manufacturer) and len(manufacturer) gt 1>
							<option value="#manufacturer#" <cfif parameterexists(manufact) and manufact eq '#manufacturer#'>Selected</cfif>>#ucase(manufacturer)#
						</cfif>
					</cfoutput>
			</select>
		</td>
		<td style="padding: 0 0 3px 0;">
		<a href="#TB_inline?height=200&width=300&inlineId=picturegallery_help&modal=true" class="thickbox" style="color: ##dd3a7d; text-decoration: underline;"><img src="images/question.jpg" border="0"></a>
			<!--- <a href="javascript:helpWin('help.cfm?helpID=PictureGallery')"><img src="images/question.jpg" border="0"></a> --->
		</td>
	</tr>
</form>
</table> --->