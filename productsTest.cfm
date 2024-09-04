
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

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


                    <tr>
                            <td colspan="2" valign="baseline">
                                <cfinclude template="footer_.cfm">
                            </td>
                        </tr>


    <script>
        var page = 1; // Start at page 1
        var loading = false; // Flag to prevent multiple requests
        var noMoreProducts = false; // Flag to check if there are no more products

        function loadProducts() {
            if (loading || noMoreProducts) return;
            loading = true;
            $('#loading').show();


            let currentUrl = window.location.href;
            console.log(currentUrl);

            let url = new URL(window.location.href);
            let params = new URLSearchParams(url.search);
            
            let Manufacturer = params.get('man');
            let Size = params.get('Size');
            let Subject = params.get('Subject');
            let Type = params.get('Type');
            let Style = params.get('Style');

            console.log('Manufacturer:', Manufacturer);

            $.ajax({
                url: 'fetch_products.cfm',
                type: 'GET',
                data: {
                    page: page,
                    man: Manufacturer,
                    Size: Size,
                    url: currentUrl
                },
                success: function(data) {
                    if (data.trim() === '') {
                        // No data means all records have been loaded
                        noMoreProducts = true;
                        $('#loading').html('No more products').show();
                    } else {
                        $('#product-container').append(data);
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
        $(window).scroll(function() {
            if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
                loadProducts();
            }
        });

        // Initial load
        loadProducts();
    </script>
</body>
</html>

