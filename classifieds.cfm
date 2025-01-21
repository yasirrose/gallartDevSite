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

     <!--- The below code is used for 4 dropdowns that on home page --->
     <script>
        document.addEventListener("DOMContentLoaded", function() {
            function drop(gothere, selectName) {
                var form = document.forms['dropdownSearchForclassifieds'];
               
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

    <!--- Toastr CDN  --->

    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>


<script id="scripts" type="text/javascript" src="/scripts_887a5339b2625a8970658c4f5f9bd94f1067ab7a.js"></script>
<meta name="referrer" content="same-origin" />

			<link rel="icon" sizes="16x16" type="image/png" href=/assets/favicon_16.png />
			<link rel="icon" sizes="32x32" type="image/png" href=/assets/favicon_32.png />
				<link rel="icon" sizes="any" type="image/svg+xml" href=/assets/favicon.svg />
<title>Techleadz</title><meta name="application-name" content="Techleadz"><meta name="apple-mobile-web-app-title" content="Techleadz">
<meta http-equiv="content-language" content=""><meta name="language" content="">
<meta name="robots" content="INDEX,FOLLOW">
<meta name="msvalidate.01" content="">
<meta name="google-site-verification" content="">
<meta property="fb:app_id" content="">

<base href="/">
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

    <!--- <cfquery name="getArtists" dbtype="query">
        SELECT DISTINCT manufacturer from allClassifieds
        ORDER BY manufacturer
    </cfquery> --->
    
    <cfquery name="getArtists" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
        SELECT DISTINCT manufacturer from products
        WHERE active = 1
        AND fk_users is not null
        ORDER by manufacturer 
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
					<!--- <div class="sidebar web-sidebar-modal">	
						<cfinclude template="left_.cfm">
					</div> --->
					<div class="content-section product-page classifieds-page new-listings">
						<div class="bottom-content-sec">
							<div class="banner-section">
								<div class="art-work-content">

                                    <div aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                          <li class="breadcrumb-item"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;" >Home</a></li>
                                          <li class="breadcrumb-item active" aria-current="page">Classifieds</li>
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
                                        <h3>CLASSIFIED LISTINGS</h3>
                                    </div>

                                    <cfoutput>
                                        <div class="search-box">
                                            <div class="search-form-group">
                                               <div class="row input-form">
                                               <form name="dropdownSearchForclassifieds" id="dropdownSearchForclassifieds">

                                                    <div class="row">

                                                        <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                           <div class="select-option">
                                                               <cfoutput>
                                                                   
                                                                       <select name="artist" id="artist" onChange="artistClick()">
                                                                           <option value="">Search by Artist</option>
                                                                               <cfloop query="getArtists">
                                                                                   <option value="#manufacturer#">#manufacturer#</option>
                                                                               </cfloop>
                                                                       </select>
                                                                   
                                                               </cfoutput>
                                                           </div>
                                                       </div>
              
                                                        <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                            <div class="select-option input-field">
                                                                
                                                                    <select name="artSubject" id="artSubject" class="chosen-select m-0" data-placeholder="Search by Subject" onChange="artistClick()">
                                                                        <option value="">Search by Subject</option>
                                                                        <!--- Loop through the query results to create option tags --->
                                                                        <cfloop query="qEmployees">
                                                                            <option value="#filterName#">#filterName#</option>
                                                                        </cfloop>
                                                                    </select>
                                                               
                                                            </div>
                                                        </div>
              
              
                                                        <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                            <div class="select-option input-field">
                                                                
                                                                    <select name="artStyle" id="artStyle" class="chosen-select m-0" data-placeholder="Search by Style" onChange="artistClick()">
                                                                        <option value="">Search by Style</option>
                                                                        <cfloop query="qGetStyle">
                                                                            <option value="#filterName#"  >#filterName#</option>
                                                                        </cfloop>
                                                                    </select>
                                                               
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                            <div class="select-option input-field">
                                                                
                                                                    <select name="artSize" id="artSize" class="chosen-select m-0" data-placeholder="Search by Size" onChange="artistClick()">
                                                                        <option value="">Search by Size</option>
                                                                        <cfloop query="qGetSize">
                                                                            <option value="#filterName#" >#filterName#</option>
                                                                        </cfloop>
                                                                       
                                                                    </select>
                                                               
                                                            </div>
                                                        </div>
              
                                                        <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                            <div class="select-option input-field">
                                                                
                                                                    <select name="artType" id="artType" class="chosen-select m-0" data-placeholder="Search by Type" onChange="artistClick()">
                                                                        <option value="">Search by Type</option>
                                                                        <cfloop query="qGetType">
                                                                            <option value="#filterName#" >#filterName#</option>
                                                                        </cfloop>
                                                                    </select>
                                                                
                                                            </div>
                                                        </div>
              
                                              
                                                        <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                            <div class="select-option">
                                                                <cfoutput>
                                                                    
                                                                        <select name="priceOrder" id="priceOrder" onChange="artistClick()">
                                                                            <option value="">Sort</option>
                                                                            <option value="newest" <cfif isDefined('form.priceOrder') and priceOrder eq 'newest'>selected</cfif>>Date Listed: Old to New</option>

                                                                            <option value="asc" <cfif isDefined('form.priceOrder') and priceOrder eq 'asc'>selected</cfif>>Price: Low to High</option>

                                                                            <option value="desc" <cfif isDefined('form.priceOrder') and priceOrder eq 'desc'>selected</cfif>>Price: High to Low</option>
                                                                        </select>
                                                                    
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
                       </style>

                        <script>

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
                        const form = document.getElementById('dropdownSearchForclassifieds');
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

                        function gotoTopFunction() {
                            document.body.scrollTop = 0;
                            document.documentElement.scrollTop = 0;
                            e.preventDefault();
                        }

                            var page = 1; // Start at page 1
                            var loading = false; // Flag to prevent multiple requests
                            var noMoreProducts = false; // Flag to check if there are no more products
                            var previousData = ''; // Variable to store previously fetched data
                            let lastArtist = ''; // Variable to store the last selected artist
                            // let lastpath = ''; // Variable to store the last selected artist
                            let lastPriceOrder = '';
                            // let lastartSubject = '';
                            let lastkeywords = '';
                            let lastartSubject = '';
                            let lastartType = '';
                            let lastartSize = '';
                            let lastartStyle = '';

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

                       let artSubject = document.getElementById('artSubject').value;
                       let artType = document.getElementById('artType').value;
                       let artSize = document.getElementById('artSize').value;
                       let artStyle = document.getElementById('artStyle').value;

                      
                   
                       let Artist = document.getElementById('artist').value;
                    //    let path = document.getElementById('path').value;
                       let priceOrder = document.getElementById('priceOrder').value;
                    //    let artSubject = document.getElementById('artSubject').value;
                       let keywords = document.getElementById('keywords').value;
                   
                       // Check if artist or path has changed, reset page and load new data
                       if ( Artist || priceOrder || keywords ) {
                           if (Artist !== lastArtist ||  priceOrder !==lastPriceOrder || keywords!==lastkeywords || artSubject!=lastartSubject || artType !=  lastartType || artSize != lastartSize || artStyle != lastartStyle) {
                               page = 1; 
                               $('#product-container').empty(); 
                                noMoreProducts = false; 
                                lastArtist = Artist; 
                            //    lastpath = path;
                                lastPriceOrder = priceOrder; 
                                lastkeywords = keywords;
                                lastartSubject = artSubject;
                                lastartType = artType;
                                lastartSize = artSize;
                                lastartStyle = artStyle;
                           }
                       } else if (urlArtist && !Artist) {
                           
                           Artist = urlArtist;
                       }
                   
                       console.log('Manufacturer:', Manufacturer);
                       console.log('Artist:', Artist);
                   
                       $.ajax({
                           url: 'getclassifieds.cfm',
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
                           success: function(data) {
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
                           error: function() {
                               $('#loading').html('Error loading products').show();
                               loading = false; // Reset the loading flag on error
                           }
                       });
                   }
                   
                   // Scroll event handler to load more products when near the bottom
                   $(window).scroll(function() {
                       if ($(window).scrollTop() + $(window).height() > $(document).height() - 400) {
                           if (!noMoreProducts && !loading) {
                               loadProducts(); // Load products only if not loading and no more products
                           }
                       }
                   });
                   
                   // Search button click event
                   $('#searchButton').on('click', function() {
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