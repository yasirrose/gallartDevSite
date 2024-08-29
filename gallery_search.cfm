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
	<!--- <script>
		document.addEventListener("DOMContentLoaded", function() {
			function drop(gothere) {
				var form = document.forms['dropdown'];
				if (form) {
					// var select = form.elements['manufact'];
					var select = form.elements['artSubject'];
					if (select) {
						parent.location = gothere + select.options[select.selectedIndex].value;
					} else {
						console.error("Select element 'manufact' not found.");
					}
				} else {
					console.error("Form 'dropdown' not found.");
				}
				return true;
			}
				// Make the function globally available
			window.drop = drop;
		});
	</script> --->
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			function drop(gothere, selectName) {
				var form = document.forms['dropdownSearch'];
				if (form) {
					var select = form.elements[selectName];
					if (select) {
						parent.location = gothere + select.options[select.selectedIndex].value;
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
	</script>
</head>
<body>
	<div class="search-form-group">
		<form name="dropdownSearch">
			<div class="top-content">
				<!--- <label>Picture Gallery</label> --->
				<label></label>
				<a href="#TB_inline?height=200&width=300&inlineId=picturegallery_help&modal=true" class="thickbox">
					<span>What's this <span class="question-span">?</span></span>
				</a>
			</div>
			
				<!--- <select name="manufact" onChange="drop('products.cfm?xss=<cfoutput>#xss#</cfoutput>&artist=')" style="font-family: arial; font-size: 7pt;">
					<option value="" selected>PLEASE SELECT ARTIST</option>
					<cfoutput query="artistinfo">
						<cfif manufacturer EQ 'MAX, PETER'>
							<option value="#manufacturer#">MAX, PETER (ALL)</option>
						<cfelseif not isnumeric(manufacturer) and len(manufacturer) gt 1>
							<option value="#manufacturer#" <cfif parameterexists(manufact) and manufact eq '#manufacturer#'>Selected</cfif>>#ucase(manufacturer)#</option>
						</cfif>
					</cfoutput>
				</select> --->
				<cfquery name="qEmployees" datasource="#application.dsource#">
					SELECT * 
					FROM filterOption
					WHERE filterType = 'Subject'
					ORDER BY filterName ASC
				</cfquery>
				
				<div class="row">
						<div class="col-md-6 mb-3">
							<div class="select-option">
								<select name="artSubject" class="chosen-select" data-placeholder="Search by Subject" style="font-family: arial; font-size: 7pt;" onChange="drop('products.cfm?xss=<cfoutput>#xss#</cfoutput>&Subject=', 'artSubject')">
									<option value="">Search by Subject</option>
									<!--- Loop through the query results to create option tags --->
									<cfoutput query="qEmployees">
										<option value="#filterName#">#filterName#</option>
									</cfoutput>
								</select>
								<!--- <select name="artSubject" class="chosen-select" data-placeholder="Search by Subject" style="font-family: arial; font-size: 7pt;" onChange="drop('products.cfm?xss=<cfoutput>#xss#</cfoutput>&Subject=', 'artSubject')">
									<option value="">Search by Subject</option>
									<option value="Abstract">Abstract</option>
									<option value="Animals">Animals</option>
									<option value="Animation">Animation</option>
									<option value="Cityscapes">Cityscapes</option>
									<option value="Ethnic">Ethnic</option>
									<option value="Famous People">Famous People</option>
									<option value="Fantasy">Fantasy</option>
									<option value="Figures">Figures</option>
									<option value="Floral">Floral</option>
									<option value="Food/Wine">Food/Wine</option>
									<option value="Inspirational">Inspirational</option>
									<option value="Landscapes">Landscapes</option>
									<option value="Military">Military</option>
									<option value="Music">Music</option>
									<option value="Nudes">Nudes</option>
									<option value="Religious">Religious</option>
									<option value="Seascapes">Seascapes</option>
									<option value="Sports">Sports</option>
									<option value="Still Life">Still Life</option>
									<option value="Text">Text</option>
									<option value="Transportation">Transportation</option>
								</select> --->
							</div>
						</div>
						<cfquery name="qGetStyle" datasource="#application.dsource#">
							SELECT * 
							FROM filterOption
							WHERE filterType = 'Style'
							ORDER BY filterName ASC
						</cfquery>
						<div class="col-md-6 mb-3">
							<div class="select-option">
								<select name="artStyle" class="chosen-select" data-placeholder="Search by Style" style="font-family: arial; font-size: 7pt;" onChange="drop('products.cfm?xss=<cfoutput>#xss#</cfoutput>&Style=', 'artStyle')">
									<option value="">Search by Style</option>
									<cfoutput query="qGetStyle">
										<option value="#filterName#">#filterName#</option>
									</cfoutput>
								</select>
								<!--- <select name="artStyle" class="chosen-select" data-placeholder="Search by Style" style="font-family: arial; font-size: 7pt;" onChange="drop('products.cfm?xss=<cfoutput>#xss#</cfoutput>&Style=', 'artStyle')">
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
					<div class="col-md-6">
						<div class="select-option">
							<select name="artSize" class="chosen-select" data-placeholder="Search by Size" style="font-family: arial; font-size: 7pt;" onChange="drop('products.cfm?xss=<cfoutput>#xss#</cfoutput>&Size=', 'artSize')">
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
						SELECT * 
						FROM filterOption
						WHERE filterType = 'Type'
						ORDER BY filterName ASC
					</cfquery>
					<div class="col-md-6">
						<div class="select-option">
							<select name="artType" class="chosen-select" data-placeholder="Search by Type" style="font-family: arial; font-size: 7pt;" onChange="drop('products.cfm?xss=<cfoutput>#xss#</cfoutput>&Type=', 'artType')">
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