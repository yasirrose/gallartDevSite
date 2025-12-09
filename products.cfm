
<!DOCTYPE html>
<cfparam name="xss" default="">
<cfparam name="url.man" default="">
<cfparam name="url.keywords" default="">
<cfset decodedKeyword = urlDecode(url.keywords)>
<cfset url.keywords = decodedKeyword>
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
        <script language="JavaScript" src="/js/utils.js"></script>
    </cfoutput>

    <link href="/stylesheet_.css" rel="stylesheet" type="text/css">
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

    <!--- <cfif isDefined('url.man') >
        <cfquery name="getBio" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
            SELECT * from bios
            WHERE artist = '#url.man#' 
        </cfquery>   
    </cfif> --->

  <cfif isDefined('url.man') AND len(trim(url.man)) GT 0>
    <!--- Split the name by comma and trim any extra whitespace --->
    <cfset nameParts = listToArray(url.man, ",")>
    
    <!--- Check if we have both first and last name parts --->
    <cfif arrayLen(nameParts) EQ 2>
        <!--- Assign first and last name correctly --->
        <cfset firstName = trim(nameParts[2])>
        <cfset lastName = trim(nameParts[1])>
        <cfset fullName = firstName & " " & lastName>
    <cfelse>
        <!--- If the format is unexpected, just display it as is --->
        <cfset fullName = trim(url.man)>
    </cfif>
    
    <!--- Query to fetch the bio --->
    <cfquery name="getBio" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT * FROM bios
        WHERE slug = '#url.man#'
    </cfquery>
    <cfquery name="getManufacturer" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT DISTINCT TOP 1 manufacturer
        FROM products
        WHERE producturl = <cfqueryparam value="#url.man#" cfsqltype="cf_sql_varchar">
    </cfquery>
</cfif>


<cfquery name="getArtists" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT DISTINCT producturl from products
    WHERE active = 1
    AND fk_users is not null
    ORDER by producturl 
</cfquery>

<cfquery name="getMedium" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    Select path from products
    WHERE fk_users is not null
    group by path
    order by path
</cfquery>

<cfquery name="qEmployees" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
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
					<div class="content-section product-page">
						<div class="bottom-content-sec">
							<div class="banner-section">
								<div class="art-work-content">

                                    <div aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                          <li class="breadcrumb-item"><a href="/" style="color:black;" >Home</a></li>
                                          <li class="breadcrumb-item active" aria-current="page">Products</li>
                                        </ol>
                                    </div>

									<div class="bottom-content">
                                        
                                        <cfif isDefined('url.keywords')  AND len(trim(url.keywords)) GT 0>
                                            <h3> Results for <cfoutput>"#url.keywords#"</cfoutput> </h3>
                                        </cfif>

                                        <cfif isDefined('url.Size') AND len(trim(url.Size)) GT 0 >
                                            <h3> Size:  <cfoutput>"#url.Size#"</cfoutput> </h3>
                                        </cfif>

                                         <cfif isDefined('url.Subject') AND len(trim(url.Subject)) GT 0>
                                            <!--- <cfset subject = URLDecode(CGI.QUERY_STRING.Subject)> --->
                                            <cfset subject = Replace(url.Subject, "-", "/", "ALL")>
                                            <h3> Subject: <cfoutput>"#subject#"</cfoutput> </h3>
                                        </cfif>

                                        <cfif isDefined('url.Style') AND len(trim(url.Style)) GT 0>
                                            <h3> Style: <cfoutput>"#url.Style#"</cfoutput> </h3>
                                        </cfif>

                                        <cfif isDefined('url.Type') AND len(trim(url.Type)) GT 0>
                                            <h3> Type: <cfoutput>"#url.Type#"</cfoutput> </h3>
                                        </cfif>

                                        

                                        <cfif isDefined('url.man') AND len(trim(url.man)) GT 0>
                                            <!--- <cfquery name="getArtistName"  datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                                                SELECT manufacturer from products where manufacturer LIKE  '%#url.man#'
                                            </cfquery>

                                                <cfdump var="#getArtistName.manufacturer#">
                                                <cfdump var="#getBio.artist#"> --->

                                            <cfif getBio.recordCount NEQ 0 >

                                                
                                                <div class="top-heading m-0">
                                                    <h3>
                                                        <cfparam name="artistName" default="#getBio.artist#">
                                                        <cfif find(',',getBio.artist)>
                                                            <cfset artistName = "#listlast(getBio.artist,',')# #listfirst(getBio.artist,',')#" />
                                                        </cfif>

                                                        <cfset capitalize_artistName = REReplace(artistName, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")>
                                                        
                                                        <cfoutput>#capitalize_artistName#</cfoutput>

                                                        

                                                    </h3>
                                                    <cfset bioImage = reReplace(getBio.bio, ".*?(<img[^>]+>).*", "\1", "ALL")>
                                                    <cfset bioText = reReplaceNoCase(getBio.bio, "<img[^>]+>", "", "ALL")>

                                                        <div id="bio-content" >

                                                            <cfif not refind('<img[^>]+>', bioImage)>
                                                                <cfset bioImage = ''>
                                                            </cfif>

                                                            <div class="image">
                                                                <cfoutput>#bioImage#</cfoutput>
                                                            </div>

                                                            <!-- The content will be truncated using CSS, but the full HTML is present -->
                                                            <div id="bio-preview" class="bio-preview"  >
                                                                
                                                                <p>
                                                                    <cfoutput>
                                                                    
                                                                        #bioText#
                                                                    </cfoutput>
                                                                </p>
                                                            </div>
                                                            
                                                            <cfset strippedBioText = REReplaceNoCase(bioText, "<[^>]*>", "", "ALL")>
                                                            <cfset strippedBioText = Trim(REReplaceNoCase(strippedBioText, "&nbsp;", "", "ALL"))>

                                                            <cfif strippedBioText NEQ "" >

                                                            <p style="font-weight: bold; cursor: pointer;" id="toggle-btn" onclick="toggleBio()">Show More</p>

                                                            </cfif>
                                                        </div>
                                                </div>
                                            <cfelse>
                                                 <cfif getManufacturer.recordCount NEQ 0>
                                                    <h3 class="h3"> 
                                                        <cfoutput>
                                                            <cfset manufacturerName = getManufacturer.manufacturer>

                                                            <!--- If there's a comma, swap the names --->
                                                            <cfif find(',', manufacturerName)>
                                                                <cfset manufacturerName = "#trim(listlast(manufacturerName, ','))# #trim(listfirst(manufacturerName, ','))#">
                                                            </cfif>

                                                            <!--- Convert to UPPERCASE --->
                                                            <cfset manufacturerName = ucase(manufacturerName)>

                                                            #manufacturerName#
                                                        </cfoutput>
                                                    </h3>
                                                </cfif>
                                            </cfif>
                                        </cfif>
                                        <cfoutput>
                                            <div class="search-box">
                                                <div class="search-form-group">
                                                    <cfinclude template="gallery_search_products.cfm">
                                                    
                                                </div>
                                            </div>
                                       </cfoutput>

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


        <tr>
            <td colspan="2" valign="baseline">
                <cfinclude template="footer_.cfm">
            </td>
        </tr>

        <cfinclude template="frmxss.cfm">

        <style>
            /* Initially, only show the first 500 characters, hide the rest */
            .bio-preview {
                display: -webkit-box;
                -webkit-line-clamp: 5; /* Limiting the number of lines (adjust as needed) */
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            /* .bio-preview p{
                text-align: left !important;
                display:bloc;
            } */
        
            /* When expanded, show full content */
            .bio-preview.expanded {
                -webkit-line-clamp: unset;
                display: inline;
            }
            /* .bio-preview.expanded p{
                text-align: left !important;
                display: inline;
            } */
            .h3 {
                font-size: 25px;
                line-height: 30px;
                font-weight: 700;
                color: #000;
                text-align: center;
            }

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
                const form = document.getElementById('dropdownSearchforProducts');
                if (form) {
                        form.reset();
                        // window.location.href = `sales.cfm?xss=${xssValue}`;
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
            let lastkeywords = '';
            let lastPriceOrder = '';
            let lastartSubject = '';
            let lastartType = '';
            let lastartSize = '';
            let lastartStyle = '';

            function gotoTopFunction() {
                document.body.scrollTop = 0;
                document.documentElement.scrollTop = 0;
                e.preventDefault();
            }

            function loadProducts() {
                if (loading || noMoreProducts) return;
                loading = true;
                $('#loading').show();



                let url = new URL(window.location.href);
                let params = new URLSearchParams(url.search);

                               // Safely handle url.man
                let Manufacturer = '<cfoutput>#isDefined("url.man") ? encodeForJavaScript(url.man) : ""#</cfoutput>';
                let Size = '<cfoutput>#isDefined("url.Size") ? encodeForJavaScript(url.Size) : ""#</cfoutput>';
                <cfset subjectValue = isDefined("url.Subject") ? Replace(url.Subject, "-", "/", "ALL") : "">
                let Subject = '<cfoutput>#encodeForJavaScript(subjectValue)#</cfoutput>';
                let Type = '<cfoutput>#isDefined("url.Type") ? encodeForJavaScript(url.Type) : ""#</cfoutput>';
                let Style = '<cfoutput>#isDefined("url.Style") ? encodeForJavaScript(url.Style) : ""#</cfoutput>';
                let Artist = '<cfoutput>#isDefined("url.adv_artist") ? encodeForJavaScript(url.adv_artist) : ""#</cfoutput>';
                let title = '<cfoutput>#isDefined("url.adv_title") ? encodeForJavaScript(url.adv_title) : ""#</cfoutput>';
                let year = '<cfoutput>#isDefined("url.adv_year") ? encodeForJavaScript(url.adv_year) : ""#</cfoutput>';
                let path = '<cfoutput>#isDefined("url.adv_medium") ? encodeForJavaScript(url.adv_medium) : ""#</cfoutput>';
                let desc_keyword = '<cfoutput>#isDefined("url.adv_desc_keyword") ? encodeForJavaScript(url.adv_desc_keyword) : ""#</cfoutput>';
                let keywords = '<cfoutput>#isDefined("url.keywords") ? encodeForJavaScript(url.keywords) : ""#</cfoutput>';
                let priceRange = '<cfoutput>#isDefined("url.adv_price_range") ? encodeForJavaScript(url.adv_price_range) : ""#</cfoutput>';
                let priceOrder = document.getElementById('priceOrder') ? document.getElementById('priceOrder').value : '';
                let artSubject = document.getElementById('artSubject') ? document.getElementById('artSubject').value : '';
                let artType = document.getElementById('artType') ? document.getElementById('artType').value : '';
                let artSize = document.getElementById('artSize') ? document.getElementById('artSize').value : '';
                let artStyle = document.getElementById('artStyle') ? document.getElementById('artStyle').value : '';

                // Build SEO-friendly URL with /artists
                let ajaxUrl = '/artists';
                let queryParams = [];
                if (Manufacturer) ajaxUrl += `/artist/${encodeURIComponent(Manufacturer)}`;
                if (keywords) ajaxUrl += `/search/${encodeURIComponent(keywords)}`;
                if (artSize || Size) ajaxUrl += `/size/${encodeURIComponent(artSize || Size)}`;
                if (artSubject || Subject) ajaxUrl += `/subject/${encodeURIComponent(artSubject || Subject)}`;
                if (artStyle || Style) ajaxUrl += `/style/${encodeURIComponent(artStyle || Style)}`;
                if (artType || Type) ajaxUrl += `/type/${encodeURIComponent(artType || Type)}`;
                if (Artist) ajaxUrl += `/adv_artist/${encodeURIComponent(Artist)}`;
                if (title) ajaxUrl += `/adv_title/${encodeURIComponent(title)}`;
                if (year) ajaxUrl += `/adv_year/${encodeURIComponent(year)}`;
                if (path) ajaxUrl += `/adv_medium/${encodeURIComponent(path)}`;
                if (desc_keyword) ajaxUrl += `/adv_desc_keyword/${encodeURIComponent(desc_keyword)}`;
                if (priceRange) ajaxUrl += `/adv_price_range/${encodeURIComponent(priceRange)}`;
                if (priceOrder) queryParams.push(`priceOrder=${encodeURIComponent(priceOrder)}`);

                if (queryParams.length > 0) {
                    ajaxUrl += `?${queryParams.join('&')}`;
                }

                $.ajax({
                    url: '/fetch_products.cfm',
                    type: 'GET',
                    data: {
                         page: page,
                        man: Manufacturer,
                        Size: artSize || Size,
                        Subject: artSubject || Subject,
                        Type: artType || Type,
                        Style: artStyle || Style,
                        adv_artist: Artist,
                        adv_title: title,
                        adv_year: year,
                        adv_medium: path,
                        adv_desc_keyword: desc_keyword,
                        keywords: keywords,
                        adv_price_range: priceRange,
                        priceOrder: priceOrder,
                        a: priceRange ? (priceRange == 1 ? '0' : priceRange == 2 ? '1000' : priceRange == 3 ? '5000' : '10000') : '',
                        b: priceRange ? (priceRange == 1 ? '1000' : priceRange == 2 ? '5000' : priceRange == 3 ? '10000' : '100000') : ''                    
                    },
                    success: function(data) {
                        if (data.trim() === '') {
                            noMoreProducts = true;
                            $('#loading').html('No more products').show();
                        } else if (data === previousData && page !== 1) {
                            noMoreProducts = true;
                            $('#loading').html('No more products').show();
                        } else {
                            if (page === 1) {
                                $('#product-container').empty();
                            }
                            $('#product-container').append(data); 
                            previousData = data;
                            page++; 
                            $('#loading').hide();
                        }
                        loading = false; 
                            },
                        error: function() {
                    $('#loading').html('Error loading products').show();
                    loading = false; 
                    }
                });
            }

                     // Load more products when user scrolls near the bottom
            $(window).scroll(function () {
                if ($(window).scrollTop() + $(window).height() > $(document).height() - 400) {
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

