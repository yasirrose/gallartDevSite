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
				var form = document.forms['dropdownSearchforProducts'];
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
	<div class="search-form-group gallary-product">
		<form name="dropdownSearchforProducts" id="dropdownSearchforProducts">
			<div class="top-content">
				<!--- <label>Picture Gallery</label> --->
				<!--- <label></label>
				<a href="#TB_inline?height=200&width=300&inlineId=picturegallery_help&modal=true" class="thickbox">
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
						<div class="product-form-columns">
							<div class="select-option input-field">
								<select name="artSubject" id="artSubject" class="chosen-select m-0" data-placeholder="Search by Subject" onChange="artistClick()">
									<option value="">Search by Subject</option>
									<!--- Loop through the query results to create option tags --->
									<cfoutput query="qEmployees">
										<option value="#filterName#" <cfif isDefined('url.Subject') and url.Subject EQ filterName >selected</cfif> >#filterName#</option>
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
						<div class="product-form-columns">
							<div class="select-option input-field">
								<select name="artStyle" id="artStyle" class="chosen-select m-0" data-placeholder="Search by Style" onChange="artistClick()">
									<option value="">Search by Style</option>
									<cfoutput query="qGetStyle">
										<option value="#filterName#" <cfif isDefined('url.Style') and url.Style EQ filterName >selected</cfif>>#filterName#</option>
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
					<div class="product-form-columns">
						<div class="select-option input-field">
							<select name="artSize" id="artSize" class="chosen-select m-0" data-placeholder="Search by Size" onChange="artistClick()">
								<option value="">Search by Size</option>
								<cfoutput query="qGetSize">
									<option value="#filterName#" <cfif isDefined('url.Size') and url.Size EQ filterName >selected</cfif>>#filterName#</option>
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
					<div class="product-form-columns">
						<div class="select-option input-field">
							<select name="artType" id="artType" class="chosen-select m-0" data-placeholder="Search by Type" onChange="artistClick()">
								<option value="">Search by Type</option>
								<cfoutput query="qGetType">
									<option value="#filterName#" <cfif isDefined('url.Type') and url.Type EQ filterName >selected</cfif> >#filterName#</option>
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
					<div class="product-form-columns">
						<div class="select-field">
							
							<!--- <label>Order By Sale Price:</label> --->
							<div class="select-option">
							   <select name="priceOrder" id="priceOrder" onChange="artistClick();">
									 <!--- <option value="">Sort</option> --->
									 
									 <option value="newest" <cfif isDefined('form.priceOrder') and priceOrder eq 'newest'>selected</cfif>>Newest</option>

									<option value="asc" <cfif isDefined('form.priceOrder') and priceOrder eq 'asc'>selected</cfif>>Price: Low - High</option>
									
									<option value="desc" selected>Price: High - Low</option>
							   </select>
							</div>
						</div>
					</div>

					<div class="col-12 mt-2 mb-2 text-center">
						<button type="button" class="btn btn-secondary" onclick="clearSearch()">Clear Search</button>
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