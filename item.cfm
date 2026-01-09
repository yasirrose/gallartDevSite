

<cfset fullURL = ""> <!-- Declare first -->
<!--- <cfparam name="url.slug" default=""> --->
<cfsilent>
   <cfparam name="form.fname" default="">
   <cfparam name="form.lname" default="">
   <cfparam name="form.name" default="">
   <cfparam name="form.comments" default="">
   <cfparam name="form.email" default="">
   <cfparam name="form.phone" default="">
   <cfparam name="form.otherphone" default="">
   <cfparam name="form.list" default="">
   <cfparam name="form.captchaError" default="0">
   <cfparam name="form.errorMsg" default="">
   <cfparam name="form.errorPhone" default="0">
   <cfparam
      name="FORM.captcha"	type="string"	default=""	/>
   <cfparam
      name="FORM.captcha_check"	type="string" default="" />
   <cftry>
      <cfparam
         name="FORM.submitted"	type="numeric"	default="0"	/>
      <cfcatch>
         <cfset FORM.submitted = 0 />
      </cfcatch>
   </cftry>
   <!--- Set a flag to see if this user is a bot or not. --->
   <cfset blnIsBot = true />
   <cfset phoneError = false />
   <!--- Check to see if the form has been submitted. --->
   <cfif FORM.submitted>
      <cfset errorMsg = "" />
      <cfif len(form.phone) AND NOT isValid("regex",form.phone,"^([\(]{1}[0-9]{3}[\)]{1}[ ]{1}[0-9]{3}[\-]{1}[0-9]{4})$")>
         <cfset errorMsg = "Please enter your phone number in the format (xxx) xxx-xxxx <br/>" />
      </cfif>
      <cfif errorMsg NEQ "">
         <cfset phoneError = true />
      <cfelse>
         <cftry>
            <!--- Decrypt the check value. --->
            <cfset strCaptcha = Decrypt( FORM.captcha_check, "gallart-is-the-best", "CFMX_COMPAT", "HEX"	) />
            <cfif (strCaptcha EQ FORM.captcha)>
               <cfset blnIsBot = false />
            </cfif>
            <cfcatch>
               <cfset blnIsBot = true />
            </cfcatch>
         </cftry>
      </cfif>
   </cfif>
   <cfset arrValidChars = ListToArray(
      "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
      "2,3,4,5,6,7,8,9"
   ) />
   <!--- Now, shuffle the array. --->
   <cfset CreateObject( "java", "java.util.Collections"	).Shuffle(	arrValidChars )	/>
   <cfset strCaptcha = (
      arrValidChars[ 1 ] &
      arrValidChars[ 2 ] 
   ) />
   <cfset FORM.captcha_check = Encrypt( strCaptcha,"gallart-is-the-best", "CFMX_COMPAT", "HEX" ) />
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
   <head>
      <cfoutput>
         <title>#companyname# - #titletext#</title>
      </cfoutput>
      <cfinclude template="meta.cfm">
      <cfoutput>
         <script language="JavaScript" src="/js/utils.js"></script>
         <!--- <script language="JavaScript" src="./js/jquery-1.2.6.min.js"></script> --->
         <!--- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> <!-- Ensure jQuery is loaded first --> --->
         <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
         <script language="JavaScript" src="/js/slimbox2.js"></script>
         <link href="/css/slimbox2.css" rel="stylesheet" type="text/css">
         <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
         <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
         <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
         <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
         <script src='https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js'></script>
         <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick.min.css'>
         <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.5.9/slick-theme.min.css'>


      

         <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
         <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
      
         <script type="text/javascript">
            // Ensure document is fully loaded before initializing slick
            $(document).ready(function() {
                // Initialize the slick slider
                $('.slider-for').slick({
                  slidesToShow: 1,
                  slidesToScroll: 1,
                  arrows: false,
                  fade: true,
                  asNavFor: '.slider-nav',
                  
               });
            
                $('.slider-nav').slick({
                  slidesToShow: 3,
                  slidesToScroll: 1,
                  asNavFor: '.slider-for',
                  dots: false,
                  focusOnSelect: true
               });
            
                // Additional slick carousel functionality
               $('.multi-slick-carousel').slick({
                  arrows: true,
                  rows: 1,
                  slidesToScroll: 1,
                  centerPadding: "0px",
                  dots: false,
                  slidesToShow: 4,
                  touchThreshold: 500,
                  infinite: true,
                  responsive: [
                     {
                        breakpoint: 1100,
                        settings: {
                           slidesToShow: 3
                        }
                     },
                     {
                        breakpoint: 768,
                        settings: {
                           slidesToShow: 2
                        }
                     },
                     {
                        breakpoint: 420,
                        settings: {
                           slidesToShow: 1,
                        }
                     }
                  ]
               });
            });
         </script>
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

      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.5.7/jquery.fancybox.min.css" />
    
      <script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.5.7/jquery.fancybox.min.js"></script>
      
   </head>
   <body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
      
      <!--- Add Edit or Delete this Item from the Cart --->
      <cfif parameterexists(process) AND structKeyExists(url, "pid") AND isNumeric(url.pid)>
         <cfif process is "Add" and qty gt 0>
            <cfset opt_name="">
            <cfset opt_value="">

            <cfquery name="getCartRecord" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                  SELECT * FROM cart where pid = #url.pid# and trackerid = '#session.xss#'
            </cfquery>
               

               <cfif getCartRecord.recordCount eq 0>
                  <cfquery name="addtocart" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                     Insert into cart (qty, pid, trackerid,charge,options,optionvalues)values(#qty#, '#url.pid#', '#session.xss#', #charge#,'#opt_name#','#opt_value#')
                  </cfquery>
                  
               </cfif>
               <cflocation url="checkout_new" addtoken="No">
            
         </cfif>
      </cfif>

      
      <!--- End of Add Items to Cart --->
      <!--- Gather Product Information for product(s) --->
      <cfset artistSlug = url.artist> <!--- from /artist/{artist}/{slug} --->
      <cfset productSlug = url.slug>  <!--- product slug --->
      <cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
         SELECT *
         FROM products where 0=0
         AND  slug = <cfqueryparam value="#slug#" cfsqltype="cf_sql_varchar"> 
         <cfif NOT isDefined('url.sellerlisting')>
         -- AND active = 1
         </cfif> 
         And (path <> '') AND (path IS NOT NULL)
      </cfquery>

       <!--- Check if product found --->
      <cfif productInfo.recordcount EQ 1>
         <cfset pid = productInfo.uid>
      <cfelse>
         <cflocation url="/404" addtoken="No">
      </cfif>
      <cfquery name="bio_info" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
         SELECT * from bios
         WHERE artist = '#productinfo.manufacturer#'
      </cfquery>
      <cfquery name="makeoffer_buttons" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
         SELECT show FROM makeoffer_buttons
         WHERE pk_makeoffer_buttons = 1
      </cfquery>
      <cfparam name="saleprice" default="#productinfo.special_price#">
      <cfif productinfo.use_highestimate EQ 1>
         <cfset saleprice = productinfo.high_estimate />
      </cfif>
      <cfif  structKeyExists(variables, "pid") AND pid NEQ 0>
         <cfquery name="listings" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
            SELECT top 100 *
            FROM products
            WHERE producturl = '#url.artist#'
            AND active = 1
            AND uid <> #pid#
         </cfquery>
      <cfelse>
         <cfquery name="listings" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
            SELECT top 100 *
            FROM products
            WHERE active = 1
         </cfquery>
      </cfif>

      <cfif  structKeyExists(variables, "pid") AND pid NEQ 0>
         <cfquery name="listingsForSlider" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
            SELECT top 100 *
            FROM products
            WHERE producturl = '#url.artist#'
            AND active = 1 
            ORDER BY CASE WHEN uid = <cfqueryparam value="#pid#" cfsqltype="cf_sql_integer"> THEN 0 ELSE 1 END, uid
         </cfquery>
      <cfelse>
         <cfquery name="listingsForSlider" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
            SELECT top 100 *
            FROM products
            WHERE active = 1
         </cfquery>
      </cfif>

      <!--- <cfdump var="#listingsForSlider.uid#" abort="true"> --->
      <cfoutput query="listings" >
         <cfif listlen(manufacturer) gt 1>
            <cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
            <cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
            <cfset artist_name_alt = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
         <cfelse>
            <cfset artist_name = manufacturer />
            <cfset artist_name_url = manufacturer />
            <cfset artist_name_alt = manufacturer />
         </cfif>
      </cfoutput>

      <cfoutput query="listingsForSlider" >
         <cfif listlen(manufacturer) gt 1>
            <cfset slider_artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
            <cfset slider_artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
            <cfset slider_artist_name_alt = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
         <cfelse>
            <cfset slider_artist_name = manufacturer />
            <cfset slider_artist_name_url = manufacturer />
            <cfset slider_artist_name_alt = manufacturer />
         </cfif>
      </cfoutput>

      <!--- <cfdump var="#bio_info#" abort="true"> --->
      <cfif bio_info.recordCount NEQ 0>
         <cfquery name="getBio" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
            SELECT * 
            FROM bios
            WHERE pk_bios = 
            <cfqueryparam value="#bio_info.pk_bios#" cfsqltype="cf_sql_integer">
         </cfquery>
      </cfif>


      <!--- <cfdump var="#bio_info.pk_bios#" abort="true"> --->
      <!--- </cfif> --->
      <!--- Search Individual Items --->
      <!--- <cfquery name="prodnav" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
         SELECT substring(path, 1, PATINDEX('%:%', path)-1) as ccat, uid FROM products 
         WHERE active = 1 And (path <> '') 
         AND (path IS NOT NULL)
         <cfif isDefined('keywords')>
         	AND (name like '%#keywords#%' or caption like '%#keywords#%' or modelno like '#keywords#%')
         <cfelseif isDefined('fam')>
         	AND family = '#fam#'
         <cfelseif isDefined('man')>
         	AND manufacturer like '#man#%'
         <cfelseif isDefined('manufact')>
         	AND manufacturer like '#manufact#%'
         <cfelseif isDefined('cat')>
         	AND path like '%#cat#%'
         </cfif>
         ORDER by ccat, gallery_price
         </cfquery>
         
         <cfset prodlist = "">
         <cfloop query="prodnav">
         <cfset prodlist = #ListAppend(prodlist, uid)#>
         </cfloop> --->
      <cftry>
         
         <cfoutput query="productinfo">
            <cfscript>
               // Assuming 'productinfo' is already defined elsewhere
               artist = URL.artist;
               slug = URL.slug;

               // Base URL
               baseURL = "http://23.20.226.157/artist/" & artist & "/" & slug;

               // // Example 'url' struct
               // url = {
               // artist: url.artist,
               // // artistname: url.artistname,
               // gallery: "GALLART",
               // pid: "#productinfo.uid#",
               // title: "#productinfo.name#"
               // };
               // // Construct the query string
               // queryString = "";
               // for (key in url) {
               // queryString &= (queryString EQ "" ? "" : "&") & key & "=" & URLEncodedFormat(url[key]);
               // }
               // // Combine the base URL with the query string
               // fullURL = baseURL & "?" & queryString;
                fullURL = baseURL;

               whatsappURL = "https://wa.me/?text=" & URLEncodedFormat(fullURL);

            </cfscript>
         </cfoutput>
        <cfoutput>
            <form method="post" action="#fullURL#" name="errorFrm">
               <input type="Hidden" name="fname">
               <input type="Hidden" name="lname">
               <input type="Hidden" name="name">
               <input type="Hidden" name="email">
               <input type="Hidden" name="phone">
               <input type="Hidden" name="otherphone">
               <input type="Hidden" name="comments">
               <input type="Hidden" name="errorMsg">
               <input type="Hidden" name="captchaError" value="0">
               <input type="Hidden" name="errorPhone" value="0">
            </form>
         </cfoutput>
         <div class="main-container registration-page item-pages">
         <div id="Table_01">
            <div class="header-section">
               <div class="top-header">
                  <cfinclude template="top_.cfm">
               </div>
               <div class="navbar-section">
                  <cfinclude template="navbar_.cfm">
               </div>
            </div>
            <div class="inner-section">
               <div class="container-fluid">
                  <div class="main-content">
                     <div class="content-section">
                        <div class="bottom-content-sec">
                           <div class="banner-section">
                              <div class="art-work-content">
                                 <div class="container user-registrations item-page new-item-page">
                                    <div aria-label="breadcrumb">
                                       <ol class="breadcrumb">
                                         <li class="breadcrumb-item"><a href="/" style="color:black;" >Home</a></li>
                              
                                         <li class="breadcrumb-item active" aria-current="page">Product Details</li>
                                       </ol>
                                     </div>
                                    <div class="row slider-top-row">
                                       <div class="col-md-6 mb-md-6">
                                          <div class="thumbnails-slider-sec">
                                             <div class="thumbnails-slider">
                                                <div class="main">
                                                   <cfoutput>

                                                      <div class="slider slider-for">
                                                         <div>
                                                            <div class="img-sec">
                                                              
                                                                  <cfif fileexists("http://#server_name#/img/#productinfo.uid#.jpg")>
                                                                     <a data-fancybox="slider-gallery" data-src="/img/#productinfo.uid#.jpg?x=randrange(1,99)" data-caption="Main Image">
                                                                        <img src="/img/#productinfo.uid#.jpg?x=randrange(1,99)" alt="slider-gallery-img">
                                                                    </a>
                                                                  <cfelse>
                                                                     <a data-fancybox="slider-gallery" data-src="http://#server_name#/img/thumbnails/noImage.jfif.jpeg" data-caption="Main Image">
                                                                     <img src="http://#server_name#/img/thumbnails/noImage.jfif.jpeg">
                                                                     </a>
                                                                  </cfif>
                                          
                                                            </div>
                                                         </div>
                                                   
                                                         <cfif isDefined("productinfo.additional_images") AND len(trim(productinfo.additional_images))>
                                                            <cfloop list="#productinfo.additional_images#" delimiters="," index="additionalImage">
                                                               <div>
                                                                  <div class="img-sec">



                                                                        <cfif fileexists("http://#server_name#/img/#additionalImage#")>

                                                                           
                                                                           <a data-fancybox="slider-gallery" data-src="/img/#additionalImage#?x=randrange(1,99)" data-caption="Main Image">
                                                                              <img src="/img/#additionalImage#?x=randrange(1,99)" alt="slider-gallery-img">
                                                                          </a>
                                                                           
                                                                           
                                                                        <cfelse>
                                                                           <a data-fancybox="slider-gallery" data-src="http://#server_name#/img/thumbnails/noImage.jfif.jpeg" data-caption="Main Image">
                                                                              <img src="http://#server_name#/img/thumbnails/noImage.jfif.jpeg">
                                                                              </a>
                                                                        </cfif>

                                                                    
                                                                  </div>
                                                               </div>
                                                            </cfloop>
                                                         </cfif>
                                                      </div>

                                                     


                                                      <script>
                                                         $(document).ready(function () {
                                                             // Initialize FancyBox for the slider images
                                                             $('slider-for').find('[data-fancybox="slider-gallery"]').fancybox({
                                                                 buttons: [
                                                                     "zoom",
                                                                     "slideShow",
                                                                     "fullScreen",
                                                                     "close"
                                                                 ],
                                                                 loop: true,
                                                                 protect: true,
                                                                 animationEffect: "zoom"
                                                             });
                                                         });
                                                     </script>
                                                   
                                                      
                                                      <div class="slider slider-nav">
                                                         <div>
                                                            <div class="nav-slide-item">
                                                               <div class="img-sec">
                                                                  
                                                                     <cfif fileexists("http://#server_name#/img/#productinfo.uid#.jpg") >
                                                                        <img src="/img/#productinfo.uid#.jpg?x=randrange(1,99)" alt="gallery-img">
                                                                     <cfelse>
                                                                        <img src="http://#server_name#/img/thumbnails/noImage.jfif.jpeg">
                                                                     </cfif>
                                                               </div>
                                                            </div>
                                                         </div>
                                                         <!--- </cfloop> --->

                                                         <cfif isDefined("productinfo.additional_images") AND len(trim(productinfo.additional_images))>
                                                            <cfloop list="#productinfo.additional_images#" delimiters="," index="additionalImage">
                                                               <div>
                                                                  <div class="nav-slide-item">
                                                                     <div class="img-sec">
                                                                        <cfif fileexists("http://#server_name#/img/#additionalImage#")>
                                                                           <img src="/img/#additionalImage#?x=randrange(1,99)" alt="gallery-img">
                                                                        <cfelse>
                                                                           <img src="http://#server_name#/img/thumbnails/noImage.jfif.jpeg">
                                                                        </cfif>
                                                                     </div>
                                                                  </div>
                                                               </div>
                                                            </cfloop>
                                                         </cfif>

                                                      </div>
                                                   </cfoutput>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                       <div class="col-md-6 mb-md-6">
                                          <div class="right-section">
                                             <cfoutput query="productinfo">
                                                
                                                <div class="item-text-content">
                                                   <div class="top-heading">
                                                      <cfif productinfo.manufacturer gt 0>
                                                         <cfset nameParts = listToArray(manufacturer, ",")>
                                                         <!--- Check if we have both first and last name parts --->
                                                         <cfif arrayLen(nameParts) EQ 2>
                                                         <!--- Assign first and last name correctly --->
                                                         <cfset firstName = trim(nameParts[2])>
                                                         <cfset lastName = trim(nameParts[1])>
                                                         <cfset fullName = firstName & " " & lastName>
                                                         <cfelse>
                                                         <!--- If the format is unexpected, just display it as is --->
                                                         <cfset fullName = trim(manufacturer)>
                                                         
                                                      </cfif>
                                                      <!--- <cfset capitalize = REReplace(fullName, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")> --->
                                                      <a href="/artists/#URLEncodedFormat(producturl)#" >
                                                         <h3 class="meta">#fullName#</h3>
                                                      </a>
                                                      <!--- <h3 class="meta">#ucase(manufacturer)#</h3> --->
                                                      </cfif>
                                                      <cfif productinfo.name gt 0 OR productinfo.name NEQ ''>
                                                         
                                                         <cfset romanNumerals = "I,II,III,IV,V,VI,VII,VIII,IX,X,XI,XII,XIII,XIV,XV,XVI,XVII,XVIII,XIX,XX">

                                                         <!--- Split the name into words --->
                                                         <cfset words = ListToArray(name, " ")>
                                                         <cfset updatedName = "">

                                                         <cfloop index="word" array="#words#">
                                                            <cfset cleanWord = REReplace(word, "[^a-zA-Z]", "", "ALL")>
                                                
                                                            <cfif cleanWord EQ "FS">
                                                               <!--- Preserve "FS" in uppercase --->
                                                               <cfset updatedName = updatedName & " " & UCase(word)>
                                                            <cfelse>
                                                               <!--- Keep the original case of other words --->
                                                               <cfset updatedName = updatedName & " " & word>
                                                            </cfif>
                                                         </cfloop>

                                                         <cfset updatedName = Trim(updatedName)>

															            <h2 class="title">#updatedName#</h2>

                                                      </cfif>
                                                   </div>
                                                  

                                                  


                                                   <p style="font-size: 20px">
                                                      <cfif retail_price gt 0 and retail_price gt gallery_price>
                                             
                                                         <cfif gallery_price gt 0 and  gallery_price gte special_price>
                                                
                                                            <cfif closeout eq 1 and special_price gt 0 >
                                                               <del>#DollarFormat(gallery_price)#</del>
                                                               &nbsp; 
                                                                <b>
                                                                  <span style="color: ##ff0000;">
                                                                     #DollarFormat(special_price)# 
                                                                  </span>
                                                               </b>
                                                             <cfelse>
                                                               <del>#DollarFormat(retail_price)#</del>
                                                               &nbsp; 
                                                               
                                                               <b> #DollarFormat(gallery_price)# </b>
                                                            </cfif>
                                                
                                                          <cfelse>
                                                            <!--- <span style="color: red;">
                                                                  Price On Request
                                                            </span> --->
                                                            <cfif gallery_price neq 0 and gallery_price LT special_price>
                                                               <del>#DollarFormat(retail_price)# </del>
                                                               &nbsp; 
                                                               <b> #DollarFormat(gallery_price)# </b>
                                                            <cfelse>
                                                            <cfif closeout eq 1 and special_price gt 0 and special_price LT retail_price>
                                                               <del>#DollarFormat(retail_price)# </del>
                                                               &nbsp; 
                                                                  <b>
                                                                     <span style="color: ##ff0000;">
                                                                     #DollarFormat(special_price)# 
                                                                     </span>
                                                                  </b>
                                                
                                                                  <cfelse>
                                                                     <b> #DollarFormat(retail_price)# </b>
                                                               </cfif>
                                                            </cfif>
                                                
                                                         </cfif>
                                                       <cfelse>
                                                         
                                                         <cfif gallery_price NEQ 0 and gallery_price NEQ ''>
                                                            
                                                            
                                                          
                                                            <cfif retail_price neq 0 and retail_price LT gallery_price >
                                                               
                                                               <cfif closeout eq 1 and special_price gt 0 and special_price LT retail_price>
                                                                  <del>#DollarFormat(retail_price)# </del>
                                                                  &nbsp; 
                                                                     <b>
                                                                        <span style="color: ##ff0000;">
                                                                        #DollarFormat(special_price)# 
                                                                        </span>
                                                                     </b>
                                                                  <cfelse>
                                                                     <b>#DollarFormat(retail_price)#</b>
                                                                  </cfif>

                                                                  <!--- <b>#DollarFormat(retail_price)#</b> --->
                                                             <cfelse>
                                                               <cfif closeout eq 1 and special_price gt 0 and special_price LT gallery_price>
                                                                  
                                                                  <del>#DollarFormat(gallery_price)# </del>
                                                                  &nbsp; 
                                                                     <b>
                                                                        <span style="color: ##ff0000;">
                                                                        #DollarFormat(special_price)# 
                                                                        </span>
                                                                     </b>
                                                   
                                                                     <cfelse>
                                                                        <b>#DollarFormat(gallery_price)#</b>
                                                               </cfif>
                                                            </cfif>
                                                         </cfif>
                                                
                                                      </cfif>
                                                   </p>

                                                   


                                                   <div class="product-description-sec">
                                                    
                                                      <cfif path gt 0>
                                                         <cfset c_medium = REReplace(path, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")>
                                                         <p> <b>Medium</b>: <span>#path#</span></p>
                                                      </cfif>
                                                      <cfif isNumeric(productinfo.year) AND productinfo.year GT 0>
                                                         <p> <b>Date</b>: <span>#productinfo.year#</span></p>
                                                         <cfelseif len(trim(productinfo.year))>
                                                            
                                                            <p> <b>Date</b>: <span>#htmlEditFormat(productinfo.year)#</span></p>
                                                         </cfif>
                                                      
                                                      <cfif edition gt 0>
                                                       
                                                         <cfset updatedEdition = REReplace(edition, "\bOF\b", "Of", "ALL")>
                                                         <p> <b>Edition</b>: <span>#updatedEdition#</span></p>
                                                      </cfif>
                                                      <cfif productinfo.size gt 0>
                                                         <p> <b>Size</b>: <span>#Replace(productinfo.size, "X", "x", "all")# inches</span></p>
                                                      </cfif>
                                                      <cfif len(trim(caption)) gt 0>
                                                         
                                                         
                                                         <p>
                                                            <b>Additional Details</b>: <span>#trim(caption)#</span>
                                                         </p>
                                                      </cfif>
                                                      <p> <b> Art ID</b>: <span>#productinfo.modelno#</span></p>
                                                      
                                                         
                                                         <cfif len(productinfo.fk_users)>
                                                            <span style="font-size: 12px; font-weight: bold; color: ##ff0000;">PRIVATE LISTING</span>
                                                         </cfif>
                                                         <div class="flex-button-group">
                                                            <button type="button" class="flex-btn" data-bs-toggle="modal" data-bs-target="##staticBackdrop">
                                                               <i class="fa fa-share"></i>
                                                               <span>
                                                                  Share
                                                               </span>
                                                            </button>


                                                            <cfif structKeyExists(session, 'sellerinfo')>

                                                               <cfquery name="getwishList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                                                                  SELECT * FROM Wishlist 
                                                                  WHERE product_id = <cfqueryparam value="#pid#" cfsqltype="cf_sql_integer">
                                                                  AND user_id = <cfqueryparam value="#session.sellerinfo.pk_users#" cfsqltype="cf_sql_integer">
                                                               </cfquery>

                                                               <cfform action="" method="POST">
                                                                  <cfoutput>
                                                                     <input type="hidden" id="ProductID" name="ProductID" value="#pid#">
                                                                     <input type="hidden" id="UserID" name="UserID" value="#session.sellerinfo.pk_users#">
                                                                     <input type="hidden" id="addData" name="addData" value="AddWishlist">
                                                                  </cfoutput>

                                                                  <cfif getwishList.recordCount GT 0 >
                                                                     <input type="hidden" id="wishlist_pk_id_#getwishList.pk_id#" name="wishlist_pk_id" value="#getwishList.pk_id#">
                                                                     <button type="button" class="flex-btn" id="addWishButton" onclick="deleteWishListRecord('#getwishList.pk_id#')">
                                                                        <i class="fa fa-heart" id="hearticon"  style="color:red !important;"></i>
                                                                        <span>
                                                                           Add to wishlist
                                                                        </span>
                                                                     </button>

                                                                     <cfelse>
                                                                     <button type="button" class="flex-btn" id="item_addWishButtonnn" onclick="addWishListRecord()">
                                                                        <i class="fa fa-heart" id="hearticon"  ></i>
                                                                        <span>
                                                                           Add to wishlist
                                                                        </span>
                                                                     </button>

                                                                  </cfif>
                                                                  
                                                               </cfform>

                                                               
                                                               <cfelse>
                                                                  <button type="button" class="flex-btn" id="addWishButtonNotLoggedIn">
                                                                     <i class="fa fa-heart"></i>
                                                                     <span>
                                                                        Add to wishlist
                                                                     </span>
                                                                  </button>
                                                            </cfif>
                                                         </div>
                                                         
                                                         <script>
                                                            document.addEventListener("DOMContentLoaded", function() {
                                                               // If user is not logged in, show alert
                                                               document.getElementById("addWishButtonNotLoggedIn")?.addEventListener("click", function() {
                                                                  alert("Please first login to add items to your wishlist.");
                                                               })
                                                            });
                                                         </script>
                                                        
                                                         
                                                         <div class="modal fade share-modal" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                            <div class="modal-dialog">
                                                               <div class="modal-content">
                                                                  <div class="modal-header">
                                                                     <h5 class="modal-title" id="staticBackdropLabel">Share Listing</h5>
                                                                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                  </div>
                                                                  <div class="modal-body">
                                                                     <div class="row">
                                                                        <div class="col-md-12">
                                                                           <div class="btn-link-group">
                                                                              <input type="text" id="urlCopy" value="#fullURL#">
                                                                              <button type="button" onclick="myFunction()" class="link-btn">
                                                                              <i class="fa fa-link"></i>
                                                                              </button>
                                                                              <span id="copyMessage" style="display:none; color:green; margin-left:10px;">Copied!</span>
                                                                           </div>
                                                                        </div>
                                                                     </div>
                                                                     <script>
                                                                        function myFunction() {
                                                                          var copyText = document.getElementById("urlCopy");
                                                                          var copyMessage = document.getElementById("copyMessage");
                                                                          copyText.select();
                                                                          copyText.setSelectionRange(0, 99999);
                                                                          
                                                                          if (navigator.clipboard && navigator.clipboard.writeText) {
                                                                            navigator.clipboard.writeText(copyText.value)
                                                                              .then(() => {
                                                                                copyMessage.style.display = 'inline';
                                                                                setTimeout(() => copyMessage.style.display = 'none', 2000);
                                                                              })
                                                                              .catch(err => console.error('Clipboard write failed:', err));
                                                                          } else {
                                                                            try {
                                                                              document.execCommand("copy");
                                                                              copyMessage.style.display = 'inline';
                                                                              setTimeout(() => copyMessage.style.display = 'none', 2000);
                                                                            } catch (err) {
                                                                              console.error('Fallback copy failed:', err);
                                                                            }
                                                                          }
                                                                        }
                                                                     </script>
                                                                     <div class="row">
                                                                        <div class="col-md-6 col-sm-6">
                                                                           <button type="button" class="flex-btn">
                                                                              <a href="https://www.facebook.com/" target="_blank">
                                                                                 <i class='fab fa-facebook-messenger'></i>
                                                                                 <span>Messenger</span>
                                                                              </a>
                                                                           
                                                                           </button>
                                                                        </div>
                                                                        <div class="col-md-6 col-sm-6">
                                                                           <button type="button" class="flex-btn">
                                                                              <a href="https://www.pinterest.com/" target="_blank">
                                                                                 <i class="fab fa-pinterest"></i>
                                                                                 <span>Pinterest</span>
                                                                              </a>
                                                                           
                                                                           </button>
                                                                        </div>
                                                                        <div class="col-md-6 col-sm-6">
                                                                           <button type="button" class="flex-btn">
                                                                              <a href="https://www.facebook.com/" target="_blank">
                                                                                 <i class="fab fa-facebook-square"></i>
                                                                                 <span>Facebook</span>
                                                                              </a>
                                                                           
                                                                           </button>
                                                                        </div>
                                                                        <div class="col-md-6 col-sm-6">
                                                                           <button type="button" class="flex-btn">
                                                                              <a href="https://www.reddit.com/" target="_blank">
                                                                                 <i class="fab fa-reddit"></i>
                                                                                 <span>Reddit</span>
                                                                              </a>
                                                                           
                                                                           </button>
                                                                        </div>
                                                                        <div class="col-md-6 col-sm-6">
                                                                           <button type="button" class="flex-btn" >
                                                                              <a href="https://twitter.com/" target="_blank">
                                                                                 <i class="fab fa-twitter"></i>
                                                                                 <span>Twitter</span>
                                                                              </a>
                                                                           
                                                                           </button>
                                                                        </div>
                                                                        <div class="col-md-6 col-sm-6">
                                                                           <button type="button" class="flex-btn">
                                                                              <a href="#whatsappURL#" target="_blank">
                                                                                 <i class="fab fa-whatsapp"></i>
                                                                                 <span>WhatsApp</span>
                                                                             </a>
                                                                           </button>
                                                                        </div>
                                                                        <div class="col-md-6 col-sm-6">
                                                                           <button type="button" class="flex-btn">
                                                                              <a href="https://pk.linkedin.com/" target="_blank">
                                                                                 <i class="fab fa-linkedin"></i>
                                                                                 <span>LinkdeIn</span>
                                                                              </a>
                                                                          
                                                                           </button>
                                                                        </div>
                                                                        <div class="col-md-6 col-sm-6">
                                                                           <button type="button" class="flex-btn">
                                                                           <i class="fa fa-envelope"></i>
                                                                           <span>Email</span>
                                                                           </button>
                                                                        </div>
                                                                     </div>
                                                                  </div>
                                                               </div>
                                                            </div>
                                                         </div>

                                                      <cfform action="/item.cfm?pid=#pid#" method="POST">
                                                         <input type="hidden" name="process" value="Add">
                                                         <cfif productinfo.closeout eq 1 and saleprice gt 0 and application.showSalePrice EQ 1>
                                                            <input type="hidden" name="charge" value="#saleprice#">
                                                          <cfelse>
                                                            <input type="hidden" name="charge" value="#productinfo.gallery_price#">
                                                         </cfif>
                                                         
                                                         <cfif productinfo.gallery_price neq 0 or (productinfo.closeout eq 1 and productinfo.special_price gt 0)>
                                                            <input type="HIDDEN" name="qty" value="1">
                                                            <div class="button-group">
                                                               <button type="submit" class="cart-btn" ><b>Add to Cart</b></button>
                                                               <a class="offer-btn" href="/epricing/#uid#"><b>Make An Offer</b></a>
                                                            </div>
                                                         
                                                         </cfif>
                                                      </cfform>
                                                     


                                                      <div class="bottom-row-fields">
                                                         <div>
                                                            <button class="inquire-Button" type="button" data-bs-toggle="collapse" data-bs-target="##collapseExample" aria-expanded="false" aria-controls="collapseExample">
                                                            <b>Inquire About this Artwork</b>
                                                            </button>
                                                         </div>
                                                         <div class="collapse" id="collapseExample">
                                                            <div class="card card-body" style="border: 1px solid black; background: white;">
                                                               <cfif FORM.submitted>
                                                                  <!--- Check for a bot. --->

                                                                  <cfset apikey="6LddEiMrAAAAAJdkOFhc6RFcBOQ4Ol15oaRHRwJb">

                                                                  <cfhttp url="https://www.google.com/recaptcha/api/siteverify" method="post">
                                                                     <cfhttpparam type="formField" name="secret" value="#apikey#">
                                                                     <cfhttpparam type="formField" name="response" value="#FORM['g-recaptcha-response']#">
                                                                     <cfhttpparam type="formField" name="remoteip" value="#CGI.REMOTE_ADDR#">
                                                                  </cfhttp>
                                                                        
                                                                  <cfset captchaResponse = DeserializeJSON(cfhttp.FileContent)>

                                                                  <cfif phoneError>
                                                                     <cfoutput>
                                                                        <!--- <cfdump var="testing 1" abort="true"> --->
                                                                        <script language="JavaScript">
                                                                           document.errorFrm.fname.value = '#form.fname#'
                                                                           document.errorFrm.lname.value = '#form.lname#'
                                                                           document.errorFrm.name.value = '#form.name#'
                                                                           document.errorFrm.email.value = '#form.email#'
                                                                           document.errorFrm.phone.value = '#form.phone#'
                                                                           document.errorFrm.otherphone.value = '#form.otherphone#'
                                                                           document.errorFrm.comments.value = '#form.comments#'
                                                                           document.errorFrm.errorMsg.value = '#errorMsg#'
                                                                           document.errorFrm.errorPhone.value = '1'
                                                                           document.errorFrm.submit();
                                                                        </script>
                                                                     </cfoutput>
                                                                   <cfelseif captchaResponse.success NEQ 'YES'>
                                                                        <cfoutput>
                                                                           <!--- <cfdump var="testing 2" abort="true"> --->
                                                                           <script language="JavaScript">
                                                                              document.errorFrm.fname.value = '#form.fname#'
                                                                              document.errorFrm.lname.value = '#form.lname#'
                                                                              document.errorFrm.name.value = '#form.name#'
                                                                              document.errorFrm.email.value = '#form.email#'
                                                                              document.errorFrm.phone.value = '#form.phone#'
                                                                              document.errorFrm.otherphone.value = '#form.otherphone#'
                                                                              document.errorFrm.comments.value = '#form.comments#'
                                                                              document.errorFrm.errorMsg.value = '#errorMsg#'
                                                                              document.errorFrm.captchaError.value = '1'
                                                                              document.errorFrm.submit();
                                                                           </script>
                                                                        </cfoutput>
                                                                   <cfelse>
                                                                     <cftry>

                                                                        <cfif len(trim(form.phone)) AND form.phoneType EQ "Home Phone">
                                                                           <cfset phone = form.phone>
                                                                        <cfelse>
                                                                           <cfset phone = "">
                                                                        </cfif>

                                                                        <cfif len(trim(form.phone)) AND form.phoneType EQ "Cell Phone">
                                                                           <cfset cellphone = form.phone>
                                                                        <cfelse>
                                                                           <cfset cellphone = "">
                                                                        </cfif>

                                                                        <cfif len(trim(form.phone)) AND form.phoneType EQ "Business Phone">
                                                                           <cfset businessphone = form.phone>
                                                                        <cfelse>
                                                                           <cfset businessphone = "">
                                                                        </cfif>

                                                                        <cfif len(trim(form.phone)) AND form.phoneType EQ "OutsideUS">
                                                                           <cfset otherphone = form.phone>
                                                                        <cfelse>
                                                                           <cfset otherphone = "">
                                                                        </cfif>
                                                                     
                                                                        
                                                                        <cfif form.name neq '' and form.email neq ''>
                                                                           <cfquery name="addgLead" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                                                                              insert into leads (name, notes, email, phone, otherphone, cellphone, businessphone, maillist, artists, titles)
                                                                              values('#form.name#', '#form.comments#', '#form.email#', '#phone#', '#otherphone#', '#cellphone#', '#businessphone#', '#form.list#','#productinfo.manufacturer#','#productinfo.name#')
                                                                           </cfquery>

                                                                           <cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
                                                                           <cfset date = now()>
                                                                           <cfset moduleName = 'Artwork Inquire'>
                                                                           <cfset action = 'Insert'>
                                                                           
                                                                           <cfquery name="addLog" datasource="#application.dsource#" >
                                                                              INSERT INTO logs 
                                                                                 ( moduleName, ipAddress, date, action)
                                                                                 VALUES
                                                                                 ( '#moduleName#', '#ipAddress#', #date#, '#action#')
                                                                           </cfquery>
                                                                     
                                                                           <cfmail 
                                                                                 server="#servername#" 
                                                                                 username="gallart@onlinegalleryart.com"
                                                                                 password="re3objeC!P" 
                                                                                 to="#emailsupport#" 
                                                                                 cc="#emailsupportcc#" 
                                                                                 from="#form.email#" 
                                                                                 subject="GallArt.com <> Buying & Selling Fine Art <> Contact Form" type="HTML">
                                                                                 <font style="font-size: 10pt; font-family: Arial;">
                                                                                 Client Information:
                                                                                 <br><br>
                                                                                 <!--- Name: #form.fname# #form.lname#<br> --->
                                                                                 Name: #form.name# <br>
                                                                                 Email Address: #form.email#<br>
                                                                                 Phone: #form.phone#<br>
                                                                                 Phone Outside the US: #form.otherphone#<br>
                                                                                 Comments: #form.comments#<br>
                                                                                 <br><br>
                                                                                 </font>
                                                                           </cfmail>
                                                                           <p>
                                                                              <b>
                                                                                 Thank you 
                                                                                 <!--- <cfoutput>#form.fname# #form.lname#</cfoutput> --->
                                                                                 <cfoutput>#form.name#</cfoutput>
                                                                                 . <br><br> Your Email has been sent to the respective personnel. <br><br>   We hope that your visit has been a pleasant experience so far.
                                                                              </b>
                                                                           </p>
                                                                        <cfelse>
                                                                           <cfoutput>
                                                                              <p style="color: red;">Error: Your data is not added. Please fill out all required fields before submitting the form.</p>
                                                                           </cfoutput>
                                                                        </cfif>

                                                                        <cfcatch type="Any">
                                                                           Sorry - we have encountered a processing error.  Please try again.
                                                                           <cfabort>
                                                                        </cfcatch>
                                                                     </cftry>

                                                                   </cfif>
                                                                   <cfelse>
                                                                     <cfoutput>
                                                                        <CFFORM ACTION="#fullURL#" METHOD="POST" name="guestFrm" onsubmit="return validateForm(event)">
                                                                           <input type="hidden" name="submitted" value="1" />
                                                                           <input	type="hidden" name="captcha_check"	value="#FORM.captcha_check#" />
                                                                           <div class="top-heading">
                                                                           
                                                                           </div>
                                                                           <cfif FORM.captchaError>
                                                                              <p style="color: ##ff0000; font-weight: bold;">PLEASE ENTER THE CHARACTERS IN THE IMAGE EXACTLY AS YOU SEE THEM</p>
                                                                           </cfif>
                                                                           <cfif FORM.errorPhone EQ 1>
                                                                              <p style="color: ##ff0000; font-weight: bold;">
                                                                                 #form.errorMsg#
                                                                              </p>
                                                                           </cfif>
                                                                           <p>Please contact us using the form below: <br><br>
                                                                              <span style="color: ##ff0000;">* Required</span></p>
                                                                        
                                                                           <div class="input-form">
                                                                              

                                                                              <div class="input-field">
                                                                              <cfinput type="text" name="name" maxLength="30" value="#form.name#" placeholder="Enter your Name*" id="name">
                                                                                 <span class="error-message" id="nameError"></span>
                                                                              </div>

                                                                              <div class="input-field">
                                                                              <cfinput type="text" name="email" maxLength="30" value="#form.email#" placeholder="Enter your Email Address*" id="email">
                                                                                 
                                                                                 <span class="error-message" id="emailError"></span>
                                                                              </div>

                                                                              <div class="input-field">
                                                                                    <select name="phoneType" id="phoneType" >
                                                                                       <option value="Cell Phone">Cell Phone</option>
                                                                                       <option value="Home Phone">Home Phone</option>
                                                                                       <option value="Business Phone">Business Phone</option>
                                                                                       <option value="OutsideUS">Outside US Phone</option>
                                                                                    </select>
                                                                                    <span class="error-message" id="phoneTypeError"></span>
                                                                              </div>

                                                                              <div class="input-field">
                                                                              <cfinput type="text" name="phone" maxLength="20" value="#form.phone#" required="No" placeholder="Enter your Phone Number" id="phone">
                                                                                 <!--- <span id="formatSign">(xxx) xxx-xxxx</span> --->
                                                                                 <span class="error-message" id="phoneError"></span>
                                                                              </div>
                                                                        
                                                                              <div class="input-field">
                                                                              
                                                                                 <TEXTAREA NAME="comments" id="comments" maxLength="500" ROWS=10 COLS=35 placeholder="Enter your Comments">#form.comments#</TEXTAREA>
                                                                                 <div id="charCount" class="mb-3">0 / 500 characters</div>
                                                                              </div>

                                                                           

                                                                              <div class="input-field pt-3">
                                                                                 <div class="g-recaptcha" id="gRecaptchaGeneral" data-sitekey="6LddEiMrAAAAAOnJRd03TsT_vYkEbebkW0T3u_ne"></div>
                                                                                 <span class="error-message" id="recaptchaError"></span>
                                                                              </div>

                                                                              <div class="input-button">
                                                                                 <button type="submit" class="SeeMore" id="submitBtn">Send</button>
                                                                                 <button type="reset" class="SeeMore" id="resetBtn-captcha">Reset</button>
                                                                              </div>
                                                                           </div>
                                                                        </CFFORM>
                                                                     </cfoutput>
                                                               </cfif>
                                                            </div>
                                                         </div>
                                                      </div>
                                                         

                                                      
                                                      <div class="bio-field">
                                                         <div>
                                                            <button class="artist-Button" type="button" data-bs-toggle="collapse" data-bs-target="##collapseExample2" aria-expanded="false" aria-controls="collapseExample">
                                                            <b>Artist Biography</b>
                                                            </button>
                                                         </div>
                                                         <div class="collapse" id="collapseExample2">
                                                            <div class="card card-body" style="border: 1px solid black;">
                                                               <div class="bio-content" style="text-align: left;">
                                                                  <!-- Output the content from the database -->
                                                                  <cfif bio_info.recordCount neq 0 >
                                                                     #getBio.bio#
                                                                     <cfelse>
                                                                     <p>
                                                                        There is no Artist Biography
                                                                     </p>
                                                                  </cfif>
                                                               </div>
                                                            </div>
                                                         </div>
                                                      </div>
                                                      
                                                   </div>
                                                </div>
                                             </cfoutput>
                                          </div>
                                       </div>
                                    </div>


                                    
                                    <cfinclude template="previouslyViewed.cfm">

                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>


            <cfinclude template="footerSlider.cfm">


         </div>
         <tr>
            <td colspan="2" valign="baseline">
               <cfinclude template="footer_.cfm">
            </td>
         </tr>
         <cfinclude template="frmxss.cfm">
         <cfcatch>
            <cfdump var="#cfcatch#" abort="true">
         </cfcatch>
      </cftry> 


      <script src="https://www.google.com/recaptcha/api.js" async defer></script>

      <script>
         function addWishListRecord() {
            
            var productID = $("#ProductID").val();
            var userID = $("#UserID").val();
            var addData = $("#addData").val();

            $.ajax({
               url: "/inquiry.cfm", // ColdFusion file handling the request
               type: "POST",
               data: {
                     ProductID: productID,
                     UserID: userID,
                     addData: addData
               },
               success: function (response) {
                  console.log(response);
                  $("#hearticon").css("color", "red");
                  if(response == 'Your artwork has been added to your Wishlist '){
                     toastr.success(response);

                     updateWishlistRecord(productID)

                  }else{
                     toastr.warning(response);
                  }
                   // Show response from ColdFusion
               },
               error: function () {
                     // alert("Error adding item to wishlist.");
                     toastr.error('Error adding item to wishlist.');
               }
            });
         }

         function updateWishlistRecord(id) {
            console.log(id);
            $.ajax({
               url: "/inquiry.cfm",
               type: "POST",
               data: {
                  action: "getUpdatedWishlist",
                  product_id: id
               },
               dataType: "json",
               success: function (response) {
                  if(response.status == "success") {
                     console.log("Updated Wishlist IDddd: ", response.pk_id);
                     // deleteWishListdata(response.pk_id);
                     $("#item_addWishButtonnn").attr("onclick", "deleteWishListRecord('" + response.pk_id + "')");
                  }
               },
               error: function () {
                  toastr.error('Error fetching updated wishlist.');
               }
            });
         }

         function deleteWishListRecord(id) {
           

           // var wishlist_pk_id = $("#wishlist_pk_id_" + id).val();
           var wishlist_pk_id = id;
           var userID = $("#User_ID").val();

           
           console.log('wishlist_pk_idddddd: ' + wishlist_pk_id)

           $.ajax({
              url: "/inquiry.cfm", // ColdFusion file handling the request
              type: "POST",
              data: {
                    wishlist_pk_id: wishlist_pk_id,
                    UserID: userID,
               },
               dataType: "json",
              success: function (response) {
                 console.log(response.message);
                 
                
                 if(response.status == 'success'){
                    toastr.error('Artwork remove from Your wishlist');
                    $("#heartIcon").css("color", "black");

                       setTimeout(function () {
                          location.reload();
                       }, 1000); 
                    }
              
              },
              error: function () {
                   
                    toastr.error('Error adding item to wishlist.');
              }
           });

         }

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


         function validateForm(e) {
            let isValid = true;
            
            // Clear previous error messages
            document.querySelectorAll('.error-message').forEach(error => error.textContent = '');
            
            
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const phoneType = document.querySelector("[name='phoneType']").value;

            const phoneRegex = /^\(\d{3}\) \d{3}-\d{4}$/;

            const submitButton = document.getElementById('submitBtn');
            
            
            var recaptcha = grecaptcha.getResponse();
            console.log(recaptcha.length);
            

            if (recaptcha.length == 0) {
               document.getElementById("recaptchaError").innerText = "Please confirm you are not a robot.";
               isValid = false;
            }

            if (!name) {
               document.getElementById('nameError').textContent = 'Please enter your name.';
               isValid = false;
            }
            
            // Validate EMAIL
            if (!email) {
               document.getElementById('emailError').textContent = 'Please enter your email address.';
               isValid = false;
            } else if (!/\S+@\S+\.\S+/.test(email)) {
               document.getElementById('emailError').textContent = 'Please enter a valid email address.';
               isValid = false;
            }

            

            if (!phoneType) {
               document.getElementById('phoneTypeError').textContent = 'Please Select phone type';
               isValid = false;
            }

            if(phoneType){
               if(phoneType === "Home Phone" || phoneType === "Cell Phone" || phoneType === "Business Phone"){
                  if (phone && !phoneRegex.test(phone)) {
                     document.getElementById('phoneError').textContent = 'Please enter phone number in format: (xxx) xxx-xxxx ';
                     document.getElementById('phone').focus();
                     isValid = false;
                  }
               }
            }

            if (!isValid) {		
               return false;
            } else {
               
               submitButton.disabled = true;
               submitButton.innerText = "Submitting…";

               // prevent default submit first
               e.preventDefault();

               // Now submit form manually after disabling button
               setTimeout(() => {
                  document.forms['guestFrm'].submit();
               }, 10);

               return false; // stop default submit
            }
            
            return isValid;
         }

      </script>


      <script>
			document.addEventListener("DOMContentLoaded", function() {
				const phoneInput = document.getElementById("phone");
				const phoneType = document.getElementById("phoneType");
				// const formatSign = document.getElementById("formatSign");

            if (!phoneInput || !phoneType ) {
					// Elements not on this page → exit
					return;
				}

				// function toggleFormatSign() {
				// 	if (phoneType.value === "OutsideUS") {
				// 		formatSign.style.display = "none";
				// 	} else {
				// 		formatSign.style.display = "inline";
				// 	}
				// }

				// run on load (in case form already has value)
				// toggleFormatSign();

				// run on change
				// phoneType.addEventListener("change", toggleFormatSign);

            phoneType.addEventListener("change", function() {
					if (this.value === "OutsideUS") {
						phoneInput.value = "+1"; 
					} else {
						
						if (phoneInput.value.startsWith("+1")) {
							phoneInput.value = "";
						}
					}
				});

				phoneInput.addEventListener("input", function(e) {
					// If type is OutsideUS → skip formatting
					if (phoneType.value === "OutsideUS") {
						return;
					}

					let value = e.target.value.replace(/\D/g, ""); // only digits
					if (value.length > 10) value = value.substring(0, 10);

					// Apply formatting as user types
					if (value.length > 6) {
						e.target.value = `(${value.substring(0,3)}) ${value.substring(3,6)}-${value.substring(6)}`;
					} else if (value.length > 3) {
						e.target.value = `(${value.substring(0,3)}) ${value.substring(3)}`;
					} else if (value.length > 0) {
						e.target.value = `(${value}`;
					} else {
						e.target.value = "";
					}
				});
			});

		</script>

      <script>
			document.addEventListener("DOMContentLoaded", function() {
				const textarea = document.getElementById("comments");
				const counter = document.getElementById("charCount");
				const maxLength = 500;

				if (textarea && counter) {
               function updateCount() {
                     const currentLength = textarea.value.length;
                     counter.textContent = `${currentLength} / ${maxLength} characters`;
               }

               // Update counter initially
               updateCount();

               // Update on input
               textarea.addEventListener("input", updateCount);
            }
			});
		</script>


      <style>

         .bio-content img {
            display: block;
            margin: 0; /* Ensures no auto margin on the image that may center it */
            text-align: center; /* Aligns the image to the left */
            max-width: 200px; /* Adjust size as needed */
            margin-right: 20px; /* Space between image and text */
         }
         .bio-content p {
            text-align: left !important; /* Force left alignment for text */
         }
         .error-message {
            color: #ff0000;
            font-size: 0.9em;
            margin-top: 5px;
            display: block;
         }
         .input-field {
				margin-bottom: 15px;
				position: relative;
			}
			.star{
				color: red;
				position: absolute;
				top: -8;
				right: 10;
			}
         .product-description-sec .flex-button-group form {
            width: 50%;
         }
         .product-description-sec .flex-button-group .flex-btn {
            width: 50%;
         }
         .product-description-sec .flex-button-group form .flex-btn {
            width: 100%;
         }
         @media (max-width: 767px){
            .row.slider-top-row .col-md-6.mb-md-6:first-child {
               order: 2;
            }
         }
      </style>

      <script>
         document.addEventListener("DOMContentLoaded", function() {
				const resetBtn = document.getElementById("resetBtn-captcha");

				if (resetBtn) {
					resetBtn.addEventListener("click", function() {
						if (typeof grecaptcha !== "undefined") {
							grecaptcha.reset(); // Reset the reCAPTCHA
						}

						// Also clear error messages if needed
						document.querySelectorAll('.error-message').forEach(function(el) {
							el.innerText = '';
						});
					});
				}
			});
      </script>
   </body>
</html>