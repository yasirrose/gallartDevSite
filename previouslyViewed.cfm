<script>
    // Function to execute when the page loads
    document.addEventListener("DOMContentLoaded", function() {
        // Retrieve the `pid` value from the URL
        const pid = "<cfoutput>#url.pid#</cfoutput>"; // ColdFusion dynamically sets the value from the URL parameter

        // Check if the cookie already exists
        const existingRecentCookie = document.cookie.split('; ').find(row => row.startsWith('RecentViewlistItem='))?.split('=')[1];
        let recentViewlist = existingRecentCookie ? JSON.parse(decodeURIComponent(existingRecentCookie)) : [];

        // Check if the current `pid` is already in the wishlist
        const pidExists = recentViewlist.some(item => item.pid === pid);

        // If `pid` is not in the wishlist, add it
        if (!pidExists) {
            recentViewlist.push({ pid: pid });

            // Convert the updated wishlist array back to a JSON string
            const updatedRecentViewlist = JSON.stringify(recentViewlist);

            // Set the updated cookie (valid for 7 days)
            document.cookie = `RecentViewlistItem=${encodeURIComponent(updatedRecentViewlist)}; path=/; max-age=${7 * 24 * 60 * 60};`;

            // Optional: Notify the user or perform any action if needed
            console.log("Item added to wishlist!");
        } else {
            console.log("Item is already in the wishlist.");
        }
    });
</script>



<div class="form-row row">
    <div class="col-md-12">
       <!--- <cfinclude template="sendtofriend.cfm"> --->
       <!--- <h2 class="title">PREVIOUSLY VIEWED</h2>
       <div class="cards-row"> --->
        <!--- <cfdump var="#cookie#" abort="true"> --->
       <cfif StructKeyExists(cookie, "RecentViewlistItem") >
          <cfset wishlistData = DeserializeJSON(URLDecode(cookie.RecentViewlistItem))>
          

          <cfif isArray(wishlistData) AND arrayLen(wishlistData) GT 0 >

             <cfset pidArray = []>
             <cfloop array="#wishlistData#" index="item">
                   <cfif StructKeyExists(item, "pid")>
                      <cfset ArrayAppend(pidArray, item.pid)>
                   </cfif>
             </cfloop>

             <cfset pidList = ArrayToList(pidArray)>

             

             <cfquery name="productData" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                SELECT *
                FROM products
                WHERE uid IN (#pidList#) and uid != #url.pid#
            </cfquery>

            <!--- <cfdump var="#productData#"> --->

             <cfoutput query="productData" >
                <cfif listlen(manufacturer) gt 1>
                <cfset artist_namee = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
                <cfset artist_name_urll = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
                <cfset artist_name_altt = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
                <cfelse>
                <cfset artist_namee = manufacturer />
                <cfset artist_name_urll = manufacturer />
                <cfset artist_name_altt = manufacturer />
                </cfif>
             </cfoutput>

            <!--- <cfif productData.recordCount GT 0 >
                <cfoutput query="productData" > --->
                   <div class="container user-registrations item-page new-item-page">
                      <div class="bottom-row">

                        <cfif productData.recordCount GT 0 >
                           <h2 class="title">PREVIOUSLY VIEWED</h2>
                         <div class="multi-slick-carousel">
                          
                               <cfoutput query="productData" >
                                  <div>
                                     <div class="slide-content">
                                        <a HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(HTMLEditFormat(manufacturer))#&artistname=#urlencodedformat(trim(artist_name_urll))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
                                          <div class="img-sec">
                                           <!-- Dynamic image source -->
                                           <cfif fileexists("http://23.20.226.157/img/#productData.uid#.jpg")>
                                             <img src="http://23.20.226.157/img/#uid#.jpg" alt="gallery-img">
                                           <cfelse>
                                             <img src="http://23.20.226.157/img/thumbnails/noImage.jfif.jpeg">
                                           </cfif>
                                          
                                          </div>
                                        </a>
                                        
                                        <div class="content-sec">
                                           <div class="top-content">
                                              <!-- Dynamic product title -->

                                              <a HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(HTMLEditFormat(manufacturer))#&artistname=#urlencodedformat(trim(artist_name_urll))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')" >
                                                <h3 class="title">#name#</h3>
                                              </a>
                                              

                                              <cfif structKeyExists(session, 'sellerinfo')>

                                                <cfquery name="getwishList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                                                   SELECT * FROM Wishlist 
                                                   WHERE product_id = <cfqueryparam value="#uid#" cfsqltype="cf_sql_integer">
                                                   AND user_id = <cfqueryparam value="#session.sellerinfo.pk_users#" cfsqltype="cf_sql_integer">
                                                </cfquery>

                                                      <cfform action="" method="POST">
                                                         <cfoutput>
                                                            <input type="hidden" id="pre_productID_#productData.uid#" name="ProductID" value="#productData.uid#">
                                                            <input type="hidden" id="pre_userID" name="UserID" value="#session.sellerinfo.pk_users#">
                                                            <input type="hidden" id="addData" name="addData" value="AddWishlist">
                                                      </cfoutput>
                                                      
                                                      <!--- <button type="button" class="heart-btn" id="addWishButton" onclick="pre_addWishListdata('#productData.uid#')">
                                                         <i class="fa fa-heart" id="pre_heartIcon_#productData.uid#" <cfif getwishList.recordCount GT 0>style="color:red !important;"</cfif> ></i>
                                                      </button> --->

                                                      <cfif getwishList.recordCount GT 0 >
                                                            
                                                         <input type="hidden" id="wishlist_pk_id_#getwishList.pk_id#" name="wishlist_pk_id" value="#getwishList.pk_id#">
                                                         <button type="button" class="heart-btn" id="pre_addWishButton" onclick="pre_deleteWishListdata('#getwishList.pk_id#')">
                                                            <i class="fa fa-heart" id="pre_heartIcon_#getwishList.pk_id#" style="color:red !important;" ></i>
                                                         </button>
                                                      <cfelse>
                                                         <button type="button" class="heart-btn" id="pre_addWishButtonnn_#productData.uid#" onclick="pre_addWishListdata('#productData.uid#')">
                                                            <i class="fa fa-heart" id="pre_heartIcon_#productData.uid#"  ></i>
                                                         </button>
                                                      </cfif>

                                                      </cfform>

                                                      
                                                <cfelse>
                                                   <button type="button" class="heart-btn" id="pre_addWishButtonNotLoggedIn" onclick="pre_loginFirst('#productData.uid#')">
                                                      <i class="fa fa-heart"></i>
                                                   </button>
                                                </cfif>


                                              <!--- <button type="button" class="heart-btn">
                                              <i class="fa fa-heart"></i> 
                                              </button> --->
                                           </div>
                                           <!-- Dynamic meta information -->

                                           <a HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(HTMLEditFormat(manufacturer))#&artistname=#urlencodedformat(trim(artist_name_urll))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')" >

                                             <cfset nameParts = listToArray(productData.manufacturer, ",")>
                                             <cfif  arrayLen(nameParts) EQ 2 >
                                                <cfset firstName = trim(nameParts[2])>
                                                <cfset lastName = trim(nameParts[1])>
                                                <cfset fullName = firstName & " " & lastName>

                                             <cfelse>
                                                <cfset fullName = trim(productData.manufacturer)>

                                             </cfif>
                                             <cfset ArtistName = REReplace(fullName, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")>
                                             <p class="meta">#ArtistName#</p>
                                           </a>
                                           <!-- Dynamic price -->
                                           <!--- <span class="price">$#numberformat(price, "999.99")#</span> --->
                                        </div>
                                        
                                     </div>
                                  </div>
                               <!--- </cfloop> --->
                              </cfoutput>
                          
                         </div>
                        </cfif>

                         
                      </div>
                   </div>
                     
            

          </cfif>

       </cfif>

    </div>

    </div>
 </div>


 <script>
   // document.addEventListener("DOMContentLoaded", function() {
   //    // If user is not logged in, show alert
   //    document.getElementById("pre_addWishButtonNotLoggedIn")?.addEventListener("click", function() {
   //       alert("Please first login to add items to your wishlist.");
   //    })
   // });


   function pre_loginFirst(id) {
      alert("Please first login to add items to your wishlist.");
   }

</script>

<script>
   function pre_addWishListdata(id) {
      var productID = $("#pre_productID_" + id).val();
      var userID = $("#pre_userID").val();
      var addData = $("#addData").val();
      

      console.log('product_id: ' + productID)
      console.log('User_ID: ' + userID)
      

      $.ajax({
         url: "inquiry.cfm", // ColdFusion file handling the request
         type: "POST",
         data: {
               ProductID: productID,
               UserID: userID,
               addData: addData
         },
         success: function (response) {
            console.log(response);
            
            $("#pre_heartIcon_" + id).css("color", "red");
            if(response == 'Your artwork has been added to your Wishlist '){
               toastr.success(response);

               updatePreviousList(id);

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

         function updatePreviousList(id) {
            $.ajax({
               url: "inquiry.cfm",
               type: "POST",
               data: {
                  action: "getUpdatedWishlist",
                  product_id: id
               },
               dataType: "json",
               success: function (response) {
                  if(response.status == "success") {
                     console.log("Updated Wishlist ID: ", response.pk_id);
                     // deleteWishListdata(response.pk_id);
                     $("#pre_addWishButtonnn_" + id).attr("onclick", "pre_deleteWishListdata('" + response.pk_id + "')");
                  }
               },
               error: function () {
                  toastr.error('Error fetching updated wishlist.');
               }
            });
         }


         function pre_deleteWishListdata(id) {
           

           // var wishlist_pk_id = $("#wishlist_pk_id_" + id).val();
           var wishlist_pk_id = id;
           var userID = $("#User_ID").val();

           // console.log('product_id: ' + productID)
           // console.log('User_ID: ' + userID)
           console.log('wishlist_pk_id: ' + wishlist_pk_id)

           $.ajax({
              url: "inquiry.cfm", // ColdFusion file handling the request
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
                    $("#heartIcon_" + id).css("color", "black");

                       setTimeout(function () {
                          location.reload();
                       }, 1000); 
                    }
                 // else{
                 //    toastr.warning(response);
                 // }
                  // Show response from ColdFusion
              },
              error: function () {
                    // alert("Error adding item to wishlist.");
                    toastr.error('Error adding item to wishlist.');
              }
           });

        }


</script>