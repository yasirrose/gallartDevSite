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
               <div class="content-section product-page">
                  <div class="bottom-content-sec">
                     <div class="banner-section">
                        <div class="art-work-content">
                           <cfoutput>
                              <table width="600" border="0" cellspacing="0" cellpadding="0" background="images/sales_browse_notext.jpg" style="background-repeat: no-repeat; background-position: -10px top;" width="627" height="127" >
                                 <tr>
                                    <td valign="top" width="100%">
                                       <form method="post" action="salesTest.cfm?xss=#xss#" name="srchForm">
                                          <table width="100%" border="0">
                                             <tr>
                                                <td width="150" style="font-size: 9pt; font-weight: bold; padding: 8px 0 0 10px;">
                                                   Search By Artist:
                                                </td>
                                             </tr>
                                             <tr>
                                                <td valign="top" style="padding: 0 0 0 10px;">
                                                   <select name="artist" id="artist">
                                                      <option value="">Please Select</option>
                                                      <cfloop query="getArtists">
                                                         <option value="#manufacturer#">#manufacturer#</option>
                                                      </cfloop>
                                                   </select>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td style="font-size: 9pt; font-weight: bold; padding: 0 0 0 10px;">
                                                   Search By Medium:
                                                </td>
                                             </tr>
                                             <tr>
                                                <td valign="top" style="padding: 0 0 0 10px;">
                                                   <select name="path" id="path">
                                                      <option value="">Please Select</option>
                                                      <cfloop query="getMedium">
                                                         <option value="#path#">#path#</option>
                                                      </cfloop>
                                                   </select>
                                                </td>
                                             </tr>
                                             <tr>
                                                <td align="center" style="padding: 13px 0 0 10px;">
                                                   <!--- <input type="image" src="images/search.gif"  style="border: none; height: 24px;"> --->
                                                   <button type="button" onclick="loadProducts()" id="searchButton">
                                                   search
                                                   </button>
                                                   <!--- <input type="Reset" value="RESET" style="background-color:  ##dd3a7d; color: ##ffffff; font-weight: bold;"> --->
                                                </td>
                                             </tr>
                                          </table>
                                       </form>
                                    </td>
                                 </tr>
                                 <tr>
                                    <td valign="top" height="32" style="padding: 0 0 0 290px;">
                                        <form method="post" action="salesTest.cfm?xss=#xss#" name="orderForm">
                                        <cfif parameterexists(keywords)>
                                        <input type="hidden" name="keywords" value="#keywords#">
                                        </cfif>
                                        <cfif parameterexists(artist)>
                                        <input type="hidden" name="artist" value="#artist#">
                                        </cfif>
                                        <cfif parameterexists(path)>
                                        <input type="hidden" name="path" value="#path#">
                                        </cfif>
                                        <table cellspacing="0" cellpadding="0" border="0" width="275">
                                            <tr>
                                                <td style="font-size: 11pt; font-weight: bold; padding: 0 0 0 0;">
                                                    Order By Sale Price:
                                                </td>
                                                <td>
                                                    <select name="priceOrder"  id="priceOrder" onChange="loadProducts();">
                                                        <option value="">Please Select</option>
                                                        <option value="newest" <cfif isDefined('form.priceOrder') and priceOrder eq 'newest'>selected</cfif>>Newest</option>

                                                        <option value="asc" <cfif isDefined('form.priceOrder') and priceOrder eq 'asc'>selected</cfif>>Lowest To Highest</option>

                                                        <option value="desc" <cfif isDefined('form.priceOrder') and priceOrder eq 'desc'>selected</cfif>>Highest To Lowest</option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </table>
                                        </form>	
                                    </td>
                                    </tr>
                              </table>
                           </cfoutput>
                           <div class="bottom-content">
                              <div align="center" style="font-size: 24px; font-weight: bold; padding: 0 0 3px 0;" class="pinkText"><em>SALE ITEMS!</em></div>
                              <div id="product-container" class="gallery-lists">
                                 <!-- Products will be loaded here -->
                                 <div id="loading" style="display: none;">Loading...</div>
                              </div>
                              <button type="button" onclick="gotoTopFunction()" class="btn  mt-2" style="float: right; background-color: #ec008c; color:white;" id="myBtn" title="Go to top">Back to Top</button>
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
var lastPriceOrder = ''; // Variable to store the last selected artist

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

    var Artist = document.getElementById('artist').value;
    var path = document.getElementById('path').value;
    var priceOrder = document.getElementById('priceOrder').value;

    // Check if artist or path has changed, reset page and load new data
    if (path || Artist || priceOrder) {
        if (Artist !== lastArtist || path !==lastpath || priceOrder !==lastPriceOrder) {
            page = 1; 
            $('#product-container').empty(); // Clear the product container for new results
            noMoreProducts = false; // Reset the no more products flag
            lastArtist = Artist; // Update lastArtist to the new artist value
            lastpath = path; // Update lastArtist to the new artist value
            lastPriceOrder = priceOrder; // Update lastArtist to the new artist value
        }
    } else if (urlArtist && !Artist) {
        // If artist is obtained through URL params, set Artist to urlArtist
        Artist = urlArtist;
    }else if(priceOrder){
      page = 1; 
      $('#product-container').empty(); // Clear the product container for new results
            noMoreProducts = false;
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
            path: path,
            priceOrder: priceOrder
        },
        success: function(data) {
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


// Initial load
loadProducts();

         
      </script>
   </body>
</html>