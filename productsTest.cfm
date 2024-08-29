


<!DOCTYPE html>
<cfparam name="xss" default="">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <cfoutput>
        <title>#companyname# - #titletext#</title>
        </cfoutput>
    <link rel="stylesheet" href="stylesheet.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div id="product-container">
        <!-- Products will be loaded here -->
    </div>
    <div id="loading" style="display: none;">Loading...</div>

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

