
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

         <!--- The below code is used for 4 dropdowns that on home page --->
         <script>
            document.addEventListener("DOMContentLoaded", function() {
                function drop(gothere, selectName) {
                    var form = document.forms['dropdownSearchForsales'];
                   
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

      <!-- END ROBLY WIDGET CODE -->
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

      <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

   </head>
   <body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
      <cfquery name="getArtists" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
         SELECT DISTINCT manufacturer from products
         WHERE active = 1
         AND closeout = 1
         AND fk_users is null
         ORDER by manufacturer 
      </cfquery>
      <cfquery name="getMedium" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
         Select path from products
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
               <div class="content-section product-page new-listings">
                  <div class="bottom-content-sec">
                     <div class="banner-section">
                        <div class="art-work-content">

                           <div aria-label="breadcrumb">
                              <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="index.cfm?xss=<cfoutput>#xss#</cfoutput>" style="color:black;">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Sales</li>
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
                                <h3>SALE ITEMS</h3>
                            </div>
                           <cfoutput>
                                <div class="search-box">
                                    <div class="search-form-group">
                                       <div class="row input-form">
                                       <form name="dropdownSearchForsales">
                                          <div class="row">

                                             <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                <div class="select-option">
                                                    <cfoutput>
                                                        
                                                            <select name="artist" id="artist" onChange="artistClick()">
                                                                <option value="">Search By Artist</option>
                                                                    <cfloop query="getArtists">
                                                                        <option value="#manufacturer#">#manufacturer#</option>
                                                                    </cfloop>
                                                            </select>
                                                        
                                                    </cfoutput>
                                                </div>
                                            </div>

                                             <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                 <div class="select-option input-field">
                                                     
                                                         <select name="artSubject" class="chosen-select m-0" data-placeholder="Search by Subject" onChange="drop('sales.cfm?xss=<cfoutput>#xss#</cfoutput>&Subject=', 'artSubject')">
                                                             <option value="">Search by Subject</option>
                                                             <!--- Loop through the query results to create option tags --->
                                                             <cfloop query="qEmployees">
                                                                 <option value="#filterName#" <cfif isDefined('url.Subject') and url.Subject EQ filterName >selected</cfif> >#filterName#</option>
                                                             </cfloop>
                                                         </select>
                                                    
                                                 </div>
                                             </div>
   
                                             <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                 <div class="select-option input-field">
                                                     
                                                         <select name="artStyle" class="chosen-select m-0" data-placeholder="Search by Style" onChange="drop('sales.cfm?xss=<cfoutput>#xss#</cfoutput>&Style=', 'artStyle')">
                                                             <option value="">Search by Style</option>
                                                             <cfloop query="qGetStyle">
                                                                 <option value="#filterName#" <cfif isDefined('url.Style') and url.Style EQ filterName >selected</cfif> >#filterName#</option>
                                                             </cfloop>
                                                         </select>
                                                    
                                                 </div>
                                             </div>
                                             
                                             <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                 <div class="select-option input-field">
                                                     
                                                         <select name="artSize" class="chosen-select m-0" data-placeholder="Search by Size" onChange="drop('sales.cfm?xss=<cfoutput>#xss#</cfoutput>&Size=', 'artSize')">
                                                             <option value="">Search by Size</option>
                                                             <cfloop query="qGetSize">
                                                                 <option value="#filterName#" <cfif isDefined('url.Size') and url.Size EQ filterName >selected</cfif> >#filterName#</option>
                                                             </cfloop>
                                                            
                                                         </select>
                                                    
                                                 </div>
                                             </div>
   
                                             <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                 <div class="select-option input-field">
                                                     
                                                         <select name="artType" class="chosen-select m-0" data-placeholder="Search by Type" onChange="drop('sales.cfm?xss=<cfoutput>#xss#</cfoutput>&Type=', 'artType')">
                                                             <option value="">Search by Type</option>
                                                             <cfloop query="qGetType">
                                                                 <option value="#filterName#" <cfif isDefined('url.Type') and url.Type EQ filterName >selected</cfif> >#filterName#</option>
                                                             </cfloop>
                                                         </select>
                                                     
                                                 </div>
                                             </div>
   
                                             <div class="col-lg-2 col-md-4 col-sm-6 col-12 mt-2 mb-2">
                                                 <div class="select-option">
                                                     <cfoutput>
                                                         <form >
                                                             <select name="priceOrder" id="priceOrder" onChange="artistClick()">
                                                                 <option value="" >Sort</option>
                                                                 <option value="newest" <cfif isDefined('form.priceOrder') and priceOrder eq 'newest'>selected</cfif>>Date Listed: Old to New</option>

                                                                  <option value="asc" <cfif isDefined('form.priceOrder') and priceOrder eq 'asc'>selected</cfif>>Price: Low to High</option>
                                                                  
                                                                  <option value="desc" <cfif isDefined('form.priceOrder') and priceOrder eq 'desc'>selected</cfif>>Price: High to Low</option>
                                                             </select>
                                                         </form>
                                                     </cfoutput>
                                                 </div>
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
         let lastArtist = ''; // Variable to store the last selected artist
         // let lastpath = ''; // Variable to store the last selected artist
         let lastPriceOrder = '';
         let lastkeywords = '';

         function gotoTopFunction() {
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
            e.preventDefault();
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
         
         let Artist = document.getElementById('artist').value;
         // let path = document.getElementById('path').value;
         let priceOrder = document.getElementById('priceOrder').value;
         let keywords = document.getElementById('keywords').value;
         
         // Check if artist or path has changed, reset page and load new data
         if ( Artist || priceOrder || keywords) {
            if (Artist !== lastArtist ||  priceOrder !==lastPriceOrder || keywords!==lastkeywords) {
                    page = 1; 
                    $('#product-container').empty(); // Clear the product container for new results
                    noMoreProducts = false; // Reset the no more products flag
                    lastArtist = Artist; // Update lastArtist to the new artist value
                  //   lastpath = path; // Update lastArtist to the new artist value
                    lastPriceOrder = priceOrder;
                    lastkeywords = keywords;
            }
         } else if (urlArtist && !Artist) {
         // If artist is obtained through URL params, set Artist to urlArtist
            Artist = urlArtist;
         }
         
         console.log('Manufacturer:', Manufacturer);
         console.log('Artist:', Artist);
         
         $.ajax({
         url: 'getsales.cfm',
         type: 'GET',
         data: {
            page: page,
            man: Manufacturer,
            Size: Size,
            artist: Artist,
          
            priceOrder: priceOrder,
            Subject: Subject,
            Type: Type,
            Style: Style,
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
