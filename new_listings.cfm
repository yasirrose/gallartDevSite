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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">	
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

<link rel="stylesheet" href="stylesheet_.css" type="text/css">

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-34565365-1']);
  _gaq.push(['_trackPageview']);

  (function () {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<!-- BEGIN ROBLY WIDGET CODE -->
<script type='text/javascript'>
  var _d_site = _d_site || 'ebb8c5f7da7077e127988b3276107648';
  (function (w, d, p, s, s2) {
    w[p] = w[p] || function () { (w[p].q = w[p].q || []).push(arguments) };
    s = d.createElement('script'); s.async = 1; s.src = '//s3.amazonaws.com/roblyimages/accounts/20559/forms/29541/signup_popup.js';
    s2 = d.getElementsByTagName('script')[0]; s2.parentNode.insertBefore(s, s2);
  })(window, document, 'Robly');
</script>

<!--- The below code is used for 4 dropdowns that on home page --->
<script>
	document.addEventListener("DOMContentLoaded", function() {
		function drop(gothere, selectName) {
			var form = document.forms['dropdownSearchForlistings'];
		   
			if (form) {
				var select = form.elements[selectName];
				console.log('yes'+selectName);
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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>

<!--- Toastr CDN  --->

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
     <!--- <div id="product-container">
        <!-- Products will be loaded here -->
        </div>
        <div id="loading" style="display: none;">Loading...</div> --->
       

        <cfquery name="allNewListings" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
            SELECT top 200 <!--- substring(path, 1, PATINDEX('%:%', path)-1) as ccat,  --->*
            FROM products 
            WHERE active = 1
            AND fk_users is null
            ORDER BY active_date desc
        </cfquery>
        
        <cfquery name="getArtists" dbtype="query">
            SELECT DISTINCT manufacturer from allNewListings
            ORDER BY manufacturer
        </cfquery>

        <!--- <cfquery name="getArtists" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
            SELECT DISTINCT manufacturer from products
            WHERE active = 1
            AND fk_users is not null
            ORDER by manufacturer
        </cfquery> --->

        <!--- <cfquery name="getArtists" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT DISTINCT manufacturer from allNewListings
        ORDER BY manufacturer
    </cfquery> --->

        <cfquery name="getMedium" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
            Select path from products
            WHERE fk_users is not null
            group by path
            order by path
        </cfquery>

<cfquery name="qEmployees" datasource="#application.dsource#">
    SELECT * 
    FROM filterOption
    WHERE filterType = 'Subject'
    ORDER BY filterName ASC
</cfquery>

<cfquery name="qGetStyle" datasource="#application.dsource#">
    SELECT * 
    FROM filterOption
    WHERE filterType = 'Style'
    ORDER BY filterName ASC
</cfquery>

<cfquery name="qGetSize" datasource="#application.dsource#">
    SELECT * 
    FROM filterOption
    WHERE filterType = 'Size'
    ORDER BY id ASC
</cfquery>

<cfquery name="qGetType" datasource="#application.dsource#">
    SELECT * 
    FROM filterOption
    WHERE filterType = 'Type'
    ORDER BY filterName ASC
</cfquery>

        <div class="main-container">
            <div id="Table_01">
                <div class="header-section">
                    <div class="top-header">
                        <cfinclude template="top_.cfm">
                    </div>
                    <div class="navbar-section">
                        <cfinclude template="navbar_.cfm">
                    </div>
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
                        <div class="content-section product-page new-listings">
                            <div class="bottom-content-sec">
                                <div class="banner-section">
                                    <div class="content-sec">

                                        <div class="art-work-content">

                                            <div aria-label="breadcrumb">
                                                <ol class="breadcrumb">
                                                  <li class="breadcrumb-item"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;">Home</a></li>
                                                  <li class="breadcrumb-item active" aria-current="page">Recent Acquisitions</li>
                                                </ol>
                                            </div>

                                            <cfif isDefined('url.Size') >
                                                <h3> Size: <cfoutput>"#url.Size#"</cfoutput> </h3>
                                            </cfif>
                  
                                            <cfif isDefined('url.Subject') >
                                                <h3> Subject: <cfoutput>"#url.Subject#"</cfoutput> </h3>
                                            </cfif>
                  
                                            <cfif isDefined('url.Style') >
                                                <h3> Style: <cfoutput>"#url.Style#"</cfoutput> </h3>
                                            </cfif>
                  
                                            <cfif isDefined('url.Type') >
                                                <h3> Type: <cfoutput>"#url.Type#"</cfoutput> </h3>
                                            </cfif>

                                            <div class="top-heading">
                                                <h3>RECENT ACQUISITIONS</h3>
                                            </div>
    
                                            <cfoutput>
                                                <div class="search-box">
                                                    <div class="search-form-group">
                                                        <!--- <cfinclude template="gallery_search_listings.cfm"> --->
                                                        <div class="row input-form">

                                                            <form name="dropdownSearchForlistings" id="dropdownSearchForlistings" >
                                                                <div class="row">

                                                                    <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                                        <div class="select-option">
                                                                            <cfoutput>
                                                                                <!--- <form name="dropdownSearchForlistings"> --->
                                                                                    <select name="artist" id="artist" class="select2" onChange="artistClick()">
                                                                                        <option value="">Search By Artist</option>
                                                                                            <cfloop query="getArtists">
                                                                                                <option value="#HTMLEditFormat(manufacturer)#">#HTMLEditFormat(manufacturer)#</option>
                                                                                            </cfloop>
                                                                                    </select>
                                                                                <!--- </form> --->
                                                                            </cfoutput>
                                                                        </div>
                                                                    </div>
                                                                    
                                                                    <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                                        <div class="select-option input-field">
                                                                            <!--- <form name="dropdownSearchForlistings" > --->
                                                                                <select name="artSubject" id="artSubject" class="chosen-select m-0" data-placeholder="Search by Subject" onChange="artistClick()">
                                                                                    <option value="">Search by Subject</option>
                                                                                    <!--- Loop through the query results to create option tags --->
                                                                                    <cfloop query="qEmployees">
                                                                                        <option value="#filterName#" >#filterName#</option>
                                                                                    </cfloop>
                                                                                </select>
                                                                            <!--- </form> --->
                                                                        </div>
                                                                    </div>
        
        
                                                                    <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                                        <div class="select-option input-field">
                                                                            <!--- <form name="dropdownSearchForlistings"> --->
                                                                                <select name="artStyle" id="artStyle" class="chosen-select m-0" data-placeholder="Search by Style" onChange="artistClick()">
                                                                                    <option value="">Search by Style</option>
                                                                                    <cfloop query="qGetStyle">
                                                                                        <option value="#filterName#">#filterName#</option>
                                                                                    </cfloop>
                                                                                </select>
                                                                            <!--- </form> --->
                                                                        </div>
                                                                    </div>
                                                                    
                                                                    <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                                        <div class="select-option input-field">
                                                                            <!--- <form name="dropdownSearchForlistings" > --->
                                                                                <select name="artSize" id="artSize" class="chosen-select m-0" data-placeholder="Search by Size" onChange="artistClick()">
                                                                                    <option value="">Search by Size</option>
                                                                                    <cfloop query="qGetSize">
                                                                                        <option value="#filterName#" <cfif isDefined('url.Size') and url.Size EQ filterName >selected</cfif> >#filterName#</option>
                                                                                    </cfloop>
                                                                                   
                                                                                </select>
                                                                            <!--- </form> --->
                                                                        </div>
                                                                    </div>
        
                                                                    <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                                        <div class="select-option input-field">
                                                                            <!--- <form name="dropdownSearchForlistings" > --->
                                                                                <select name="artType" id="artType" class="chosen-select m-0" data-placeholder="Search by Type" onChange="artistClick()">
                                                                                    <option value="">Search by Type</option>
                                                                                    <cfloop query="qGetType">
                                                                                        <option value="#filterName#" <cfif isDefined('url.Type') and url.Type EQ filterName >selected</cfif> >#filterName#</option>
                                                                                    </cfloop>
                                                                                </select>
                                                                            <!--- </form> --->
                                                                        </div>
                                                                    </div>
        
                                                                    <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                                        <div class="select-option">
                                                                            <cfoutput>
                                                                                <!--- <form > --->
                                                                                    <select name="priceOrder" id="priceOrder" onChange="artistClick()">
                                                                                        <!--- <option value="">Sort</option> --->

                                                                                        <option value="newest" selected>Newest </option>

                                                                                        <option value="asc" <cfif isDefined('form.priceOrder') and priceOrder eq 'asc'>selected</cfif>>Price: Low - High</option>
                                                                                        
                                                                                        <option value="desc" <cfif isDefined('form.priceOrder') and priceOrder eq 'desc'>selected</cfif>>Price: High - Low</option>
                                                                                    </select>
                                                                                <!--- </form> --->
                                                                            </cfoutput>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-12 mt-2 mb-2 text-center">
                                                                        <button type="button" class="btn btn-secondary" onclick="clearSearch()">Clear Search</button>
                                                                    </div>

                                                                </div>

                                                        </form>
                                                        </div>

                                                    </div>
                                                </div>
                                            </cfoutput>
    
                                            <div class="bottom-content">
                                                <div id="product-container" class="gallery-lists">
                                                    <!-- Products will be loaded here -->
                                                    <div id="loading" style="display: none;">Loading...</div>
                                                </div>

                                                <button type="button" style="display:none;" onclick="gotoTopFunction()" class="btn"  id="myBtn" title="Go to top">
                                                    <i class="fas fa-chevron-up"></i>
                                                 </button>

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

<style>
	#myBtn {
  display: none;
  position: fixed;
  bottom: 30px;
  right: 30px;
  z-index: 100;
  width: 50px; /* Small square size */
  height: 50px;
  background-color: white;
  color: black;
  border: none;
  border-radius: 10px; /* Rounded corners for style */
  cursor: pointer;
  font-size: 28px; /* Icon size */
  display: flex;
  justify-content: center;
  align-items: center;
  border: 1px solid black;
}

                body {
                    overflow-x: hidden;
                }

            .select2-container--default .select2-selection--single {
                background-color: #fff;
                border: 1px solid #C5C5C5;
                border-radius: 10px;
                height: 45px;
                color: #5E5E5E;
                font-size: 14px;
                line-height: 20px;
                font-weight: 800;
                width: 100%;
                padding: 10px 25px 10px 10px;
                appearance: none;
            }

            .select2-container--default .select2-selection--single .select2-selection__rendered {
                line-height: 23px;
                color: #5E5E5E;
            }

            .select2-container--default .select2-selection--single .select2-selection__arrow {
                /* height: 36px;
                top: 1px;
                right: 10px;
                width: 20px; */
                display: none;
            }

            .select2-container .select2-selection--single .select2-selection__rendered {
                display: flex !important;
            }

            /* Ensure full width */
            .select2-container {
                width: 100% !important;
            }


            .select2-container--default .select2-search--dropdown .select2-search__field {
                border: 1px solid #aaa;
                height: 30px;
                font-size: 14px;
            }


</style>


	<script>

            $(document).ready(function () {
                    $('.select2').select2({
                        matcher: function (params, data) {
                            if ($.trim(params.term) === '') {
                                return data;
                            }

                            // Prevent matching placeholder during search
                            if (data.id === '') {
                                return null;
                            }

                            var term = params.term.toLowerCase();
                            var text = data.text.toLowerCase();

                            // Starts with match
                            if (text.startsWith(term)) {
                                return data;
                            }

                            // Contains match (less priority)
                            if (text.indexOf(term) > -1) {
                                var modifiedData = $.extend({}, data, true);
                                modifiedData.text = data.text + ' ';
                                return modifiedData;
                            }

                            return null;
                        },

                        sorter: function (data) {
                            var term = $('.select2-search__field').val().toLowerCase();
                            return data.sort(function (a, b) {
                                var aStarts = a.text.toLowerCase().startsWith(term);
                                var bStarts = b.text.toLowerCase().startsWith(term);

                                if (aStarts && !bStarts) return -1;
                                if (!aStarts && bStarts) return 1;
                                return 0;
                            });
                        }
                    });
                });

                   //The above Functoin is use to search the data according to alphabetic letters in select2 plugin

        window.onscroll = function() {scrollFunction()};

        function scrollFunction() {
            if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
                document.getElementById("myBtn").style.display = "block";
            } else {
                document.getElementById("myBtn").style.display = "none";
            }
        }

     // the below code is use for clear the search values from advanced search form

            const xssValue = '<cfoutput>#encodeForJavaScript(xss)#</cfoutput>';
            function clearSearch() {
               const form = document.getElementById('dropdownSearchForlistings');
               if (form) {
                     form.reset();
                     // window.location.href = `sales.cfm?xss=${xssValue}`;
                     
                    // Reset select2 manually
                    $('#artist').val(null).trigger('change'); // Clear the Select2 dropdown

                    $('#artType').val(null).trigger('change'); 
                    $('#artSize').val(null).trigger('change'); 
                    $('#artStyle').val(null).trigger('change'); 
                    $('#artSubject').val(null).trigger('change');
                     
                     page = 1;
                     noMoreProducts = false;

                     $('#product-container').empty();
                     $('#loading').hide();
                     loadProducts();
               }
            }


            $(document).ready(function() {
                toastr.options = {
                    'closeButton': true,
                    'debug': false,
                    'newestOnTop': false,
                    'progressBar': true,
                    'positionClass': 'toast-top-right',
                    'preventDuplicates': false,
                    'showDuration': '1000',
                    'hideDuration': '1000',
                    'timeOut': '5000',
                    'extendedTimeOut': '1000',
                    'showEasing': 'swing',
                    'hideEasing': 'linear',
                    'showMethod': 'fadeIn',
                    'hideMethod': 'fadeOut',
                }
            });


		var page = 1; // Start at page 1
		var loading = false; // Flag to prevent multiple requests
		var noMoreProducts = false; // Flag to check if there are no more products
		var previousData = ''; // Variable to store previously fetched data
		var lastArtist = ''; // Variable to store the last selected artist
		// var lastpath = ''; // Variable to store the last selected artist
		var lastPriceOrder = '';
		// let lastkeywords = '';
        let lastartSubject = '';
        let lastartType = '';
        let lastartSize = '';
        let lastartStyle = '';

		function gotoTopFunction() {
			document.body.scrollTop = 0;
			document.documentElement.scrollTop = 0;
			e.preventDefault();
		}

		function submitForm() {
			loadProducts(); // Call your JS function
			document.getElementById('srchForm').submit(); // Submit the form
		}

		function loadProducts() {
			if (loading || noMoreProducts) return; // Prevent multiple AJAX calls if already loading or no more products
			loading = true;
			$('#loading').show();

			let currentUrl = window.location.href;
			let url = new URL(currentUrl);
			let params = new URLSearchParams(url.search);

			let Manufacturer = params.get('man');
			let Size = params.get('Size');
			let Subject = params.get('Subject');
			let Type = params.get('Type');
			let Style = params.get('Style');
			let urlArtist = params.get('artist');

			var Artist = document.getElementById('artist').value;
			// var path = document.getElementById('path').value;
			var priceOrder = document.getElementById('priceOrder').value;
			var keywords = document.getElementById('keywords').value;

            let artSubject = document.getElementById('artSubject').value;
            let artType = document.getElementById('artType').value;
            let artSize = document.getElementById('artSize').value;
            let artStyle = document.getElementById('artStyle').value;

			// Check if artist or path has changed, reset page and load new data
			if (Artist || priceOrder || keywords) {
			    if (Artist !== lastArtist ||  priceOrder !==lastPriceOrder || keywords!==lastkeywords || artSubject!=lastartSubject || artType !=  lastartType || artSize != lastartSize || artStyle != lastartStyle) {
			        page = 1;
			        $('#product-container').empty(); // Clear the product container for new results
			        noMoreProducts = false; // Reset the no more products flag
			        lastArtist = Artist; // Update lastArtist to the new artist value
			        // lastpath = path; // Update lastArtist to the new artist value
			        lastPriceOrder = priceOrder;
			        lastkeywords = keywords;
                    lastartSubject = artSubject;
                    lastartType = artType;
                    lastartSize = artSize;
                    lastartStyle = artStyle;
			    }
			} else if (urlArtist && !Artist) {
			    // If artist is obtained through URL params, set Artist to urlArtist
			    Artist = urlArtist;
			}

			console.log('Manufacturer:', Manufacturer);
			console.log('Artist:', Artist);

			$.ajax({
				url: 'getRecentAcquisitions.cfm',
				type: 'GET',
				data: {
					page: page,
					man: Manufacturer,
					Size: artSize,
					artist: Artist,
					
					priceOrder: priceOrder,
					Subject: artSubject,
					Type: artType,
					Style: artStyle,
					keywords: keywords
					
				},
				success: function (data) {
					if (data.trim() === '') {
						noMoreProducts = true;
						$('#loading').html('No more products').show();

						// toastr.warning('No more products');
						// $('#loading').hide();

					} else if (data === previousData && page !== 1) {
						// Prevent loading duplicate data on scroll (ignore check for page 1)
						noMoreProducts = true;
						$('#loading').html('No more products').show();

						// toastr.warning('No more products');
						// $('#loading').hide();

					} else {
						if (page === 1) {
							$('#product-container').empty(); // On first page, replace content
						}
						$('#product-container').append(data); // Append new data
						previousData = data;
						page++; // Increment the page number for the next request
						$('#loading').hide();
					}
					loading = false; // Reset the loading flag
				},
				error: function () {
					$('#loading').html('Error loading products').show();
					loading = false; // Reset the loading flag on error
				}
			});
		}

		// Scroll event handler to load more products when near the bottom
		$(window).scroll(function () {
			if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
				if (!noMoreProducts && !loading) {
					loadProducts(); // Load products only if not loading and no more products
				}
			}
		});


		// Search button click event
		$('#searchButton').on('click', function () {
			page = 1; // Reset page to 1 when search button is clicked
			noMoreProducts = false;
			loadProducts(); // Trigger product loading based on search

		});

		function artistClick() {
			page = 1; // Reset page to 1 when search button is clicked
			noMoreProducts = false;
			loadProducts();
		}

		// Initial load
		loadProducts();


	</script>
    
</body>

</html>