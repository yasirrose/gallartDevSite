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
<cfquery name="cats" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" cachedwithin="#createTimespan(0,1,0,0)#">
Select path from products
WHERE active = 1
<!--- AND fk_users is null --->
group by path
order by path
</cfquery>

<cfoutput>
		<div class="input-form">
			<form action="products.cfm?xss=#xss#" method="get" id="searchForm">
				<div class="row">
					<div class="col-md-6">
						<div class="input-field">
							<label>Title</label>
							<input type="Text" name="adv_title" id="adv_title">
						</div>
					</div>
					<div class="col-md-6">
						<div class="input-field">
							<label>Artist</label>
							<select name="adv_artist" id="adv_artist" >
								<option value="" selected>ALL
									<cfloop query="artistinfo">
										<cfif manufacturer EQ 'MAX, PETER'>
											<option value="#manufacturer#">MAX, PETER (ALL)
										<cfelseif not isnumeric(manufacturer) and len(manufacturer) gt 1>
											<option value="#manufacturer#" <cfif parameterexists(manufact) and manufact eq '#manufacturer#'>Selected</cfif>>#ucase(manufacturer)#
										</cfif>
									</cfloop>
							</select>
						</div>
					</div>
					<div class="col-md-6">
						<div class="input-field">
							<label>Keyword in Description</label>
							<input type="text" name="adv_desc_keyword" id="adv_desc_keyword">
						</div>
					</div>
					<div class="col-md-6">
						<div class="input-field">
							<label>Year</label>
							<input type="text" name="adv_year" id="adv_year">
						</div>
					</div>
					<div class="col-md-6">
						<div class="input-field">
							<label>Price Range</label>
							<select name="adv_price_range">
								<option value="">ALL
								<option value="1">$0 - $1,000
								<option value="2">$1,000 - $5,000
								<option value="3">$5,000 - $10,000
								<option value="4">$10,000 - $100,000
								<option value="5">over $100,000
							</select>
						</div>
					</div>
					<div class="col-md-6">
						<div class="input-field">
							<label>Medium</label>
							<select name="adv_medium" id="adv_medium">
								<option value="">ALL
								<cfloop query="cats">
									<option value="#path#">#ucase(path)#
								</cfloop>
							</select>
						</div>
					</div>
					
					<div class="col-md-12">
						<div class="input-button">
							<input type="hidden" name="xss" value="#xss#">
							<button type="submit" class="SeeMore" style="margin: 0;"  >Search</button>
							<button type="reset" value="" class="SeeMore" style="margin: 0;">Reset</button>
						</div>
					</div>
				</div>
			</form>
		</div>

		<script>
			 document.getElementById("searchForm").addEventListener("submit", function(event) {
            // Loop through each form element and remove empty ones
            const formElements = event.target.elements;
            for (let i = formElements.length - 1; i >= 0; i--) {
                const element = formElements[i];
                if (element.type !== "submit" && element.type !== "reset" && element.name !== "xss" && element.value === "") {
                    element.parentNode.removeChild(element); // Remove empty fields except xss
                }
            }
        });
		</script>

</cfoutput>


<!--- <script>
    function artistClick() {
        const title = document.getElementById('adv_title').value;
        const artist = document.getElementById('adv_artist').value;
        const path = document.getElementById('adv_medium').value;
        const year = document.getElementById('adv_year').value;
		const xss = document.getElementById('xss').value;

		console.log('Artist' + artist);
		// return false;

        $.ajax({
            url: 'fetch_products.cfm',
            type: 'post',
            data: {
                Title: title,
                Artist: artist,
                path: path,
                year: year
            },
            success: function(data) {
                window.location.href = 'products.cfm?xss=' + encodeURIComponent(xss);
				alert('data is ok ');
            },
            error: function() {
                alert('data is not ok');
            }
        });
    }
</script> --->