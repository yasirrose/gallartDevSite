<!DOCTYPE html>
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

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
        <!--- <div id="product-container">
        <!-- Products will be loaded here -->
        </div>
        <div id="loading" style="display: none;">Loading...</div> --->


        <cfquery name="getArtists" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
            SELECT DISTINCT manufacturer from products
            WHERE active = 1
            AND fk_users is not null
            ORDER by manufacturer
        </cfquery>

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
                        <div class="sidebar web-sidebar-modal">
                            <cfinclude template="left_.cfm">
                        </div>
                        <div class="content-section product-page new-listings">
                            <div class="bottom-content-sec">
                                <div class="banner-section">
                                    <div class="content-sec">
                                        <div class="art-work-content">
                                            <div class="top-heading">
                                                <h3>RECENT ACQUISITIONS</h3>
                                            </div>
    
                                            <cfoutput>
                                                <div class="search-box">
                                                    <div class="search-form-group">
                                                        <form method="post" action="new_listings.cfm?xss=#xss#" name="srchForm">
                                                            <div class="row">
                                                                <div class="col-md-6 mb-3">
                                                                    <label>Search By Artist:</label>
                                                                    <div class="select-option">
                                                                        <select name="artist" id="artist">
                                                                            <option value="">Please Select</option>
                                                                            <cfloop query="getArtists">
                                                                                <option value="#manufacturer#">#manufacturer#</option>
                                                                            </cfloop>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6 mb-3">
                                                                    <label>Search By Medium:</label>
                                                                    <div class="select-option">
                                                                        <select name="path" id="path">
                                                                            <option value="">Please Select</option>
                                                                            <cfloop query="getMedium">
                                                                                <option value="#path#">#path#</option>
                                                                            </cfloop>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-12">
                                                                    <button class="SeeMore" type="button" onclick="loadProducts()" id="searchButton">
                                                                        Search
                                                                    </button>
                                                                </div>
                                                                <div class="col-md-12">
                                                                    <div class="select-field">
                                                                        <label>Order By Sale Price:</label>
                                                                        <div class="select-option">
                                                                            <select name="priceOrder" id="priceOrder" onChange="loadProducts();">
                                                                                <option value="">Please Select</option>
                                                                                <option value="asc" <cfif isDefined('form.priceOrder') and priceOrder eq 'asc'>selected</cfif>>Lowest To Highest</option>
                                                                                <option value="desc" <cfif isDefined('form.priceOrder') and priceOrder eq 'desc'>selected</cfif>>Highest To Lowest</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </cfoutput>
    
                                            <div class="bottom-content">
                                                <div id="product-container" class="gallery-lists">
                                                    <!-- Products will be loaded here -->
                                                    <div id="loading" style="display: none;">Loading...</div>
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

        <cfinclude template="frmxss.cfm">


            <script>
                var page = 1; // Start at page 1
                var loading = false; // Flag to prevent multiple requests
                var noMoreProducts = false; // Flag to check if there are no more products
                var previousData = ''; // Variable to store previously fetched data
                var lastArtist = ''; // Variable to store the last selected artist
                var lastpath = ''; // Variable to store the last selected artist

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
                    var path = document.getElementById('path').value;

                    // Check if artist or path has changed, reset page and load new data
                    if (path || Artist) {
                        if (Artist !== lastArtist || path !== lastpath) {
                            page = 1;
                            $('#product-container').empty(); // Clear the product container for new results
                            noMoreProducts = false; // Reset the no more products flag
                            lastArtist = Artist; // Update lastArtist to the new artist value
                            lastpath = path; // Update lastArtist to the new artist value
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
                            Size: Size,
                            artist: Artist,
                            path: path
                        },
                        success: function (data) {
                            if (data.trim() === '') {
                                noMoreProducts = true;
                                $('#loading').html('No more products').show();
                            } else if (data === previousData && page !== 1) {
                                // Prevent loading duplicate data on scroll (ignore check for page 1)
                                noMoreProducts = true;
                                $('#loading').html('No more products').show();
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

                // Initial load
                loadProducts();


            </script>
    </body>

    </html>