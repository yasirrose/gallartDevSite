
<div class="inner-section gray-inner-sec">
    <div class="container-fluid">
       <div class="main-content">
          <div class="content-section">
             <div class="bottom-content-sec">
                <div class="banner-section">
                   <div class="art-work-content">
                      <div class="container user-registrations item-page new-item-page">
                         <div class="bottom-row">
                            <h2 class="title">YOU MAY ALSO LIKE</h2>
                            <div class="multi-slick-carousel">
                               <cfoutput>

                                  <cfloop query="listings">

                                     <div>
                                        <div class="slide-content">
                                           
                                          <a HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(HTMLEditFormat(manufacturer))#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
                                             <div class="img-sec">
                                                <!-- Dynamic image source -->
                                                <cfif fileexists("http://#server_name#/img/#listings.uid#.jpg")>
                                                   <img src="http://#server_name#/img/#uid#.jpg" alt="gallery-img">
                                                <cfelse>
                                                   <img src="http://#server_name#/img/thumbnails/noImage.jfif.jpeg">
                                                </cfif>
                                                
                                             </div>
                                          </a>


                                           <div class="content-sec">
                                              <div class="top-content">
                                                 <!-- Dynamic product title -->

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

                                                 <a HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(HTMLEditFormat(manufacturer))#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')" >
                                                   <h3 class="title-name">#updatedName#</h3>
                                                 </a>



                                                 <cfif structKeyExists(session, 'sellerinfo')>

                                                   <cfquery name="getwishList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
                                                      SELECT * FROM Wishlist 
                                                      WHERE product_id = <cfqueryparam value="#listings.uid#" cfsqltype="cf_sql_integer">
                                                      AND user_id = <cfqueryparam value="#session.sellerinfo.pk_users#" cfsqltype="cf_sql_integer">
                                                   </cfquery>



                                                         <cfform action="" method="POST">
                                                            <cfoutput>
                                                               <input type="hidden" id="Product_ID_#listings.uid#" name="ProductID" value="#listings.uid#">
                                                               <input type="hidden" id="User_ID" name="UserID" value="#session.sellerinfo.pk_users#">
                                                               <input type="hidden" id="addData" name="addData" value="AddWishlist">
                                                         </cfoutput>
                                                         
                                                         <!--- <button type="button" class="heart-btn" id="addWishButton" onclick="addWishListdata('#listings.uid#')">
                                                            <i class="fa fa-heart" id="heartIcon_#listings.uid#" <cfif getwishList.recordCount GT 0>style="color:red !important;"</cfif> ></i>
                                                            </button> --->                      
                                                            
                                                            <cfif getwishList.recordCount GT 0 >
                                                            
                                                               <input type="hidden" id="wishlist_pk_id_#getwishList.pk_id#" name="wishlist_pk_id" value="#getwishList.pk_id#">
                                                               <button type="button" class="heart-btn" id="addWishButton" onclick="deleteWishListdata('#getwishList.pk_id#')">
                                                                  <i class="fa fa-heart" id="heartIcon_#getwishList.pk_id#" style="color:red !important;" ></i>
                                                               </button>
                                                            <cfelse>
                                                               <button type="button" class="heart-btn" id="addWishButtonnn_#listings.uid#" onclick="addWishListdata('#listings.uid#')">
                                                                  <i class="fa fa-heart" id="heartIcon_#listings.uid#"  ></i>
                                                               </button>
                                                            </cfif>

                                                            
                                                         </cfform>

                                                         
                                                   <cfelse>

                                                      <button type="button" class="heart-btn" id="addWishButtonNotLoggedInnn" onclick="loinFirst('#listings.uid#')">
                                                         <i class="fa fa-heart"></i>
                                                      </button>
                                                   </cfif>



                                                 <!--- <button type="button" class="heart-btn">
                                                 <i class="fa fa-heart"></i>
                                                 </button> --->
                                              </div>
                                              <!-- Dynamic meta information -->

                                              <a HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(HTMLEditFormat(manufacturer))#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')" >

                                              <cfset nameParts = listToArray(listings.manufacturer, ",")>
                                              <cfif  arrayLen(nameParts) EQ 2 >
                                                 <cfset firstName = trim(nameParts[2])>
                                                 <cfset lastName = trim(nameParts[1])>
                                                 <cfset fullName = firstName & " " & lastName>

                                              <cfelse>
                                                 <cfset fullName = trim(listings.manufacturer)>

                                              </cfif>
                                              <cfset ArtistName = REReplace(fullName, "\b([a-zA-Z])([a-zA-Z]*)", "\u\1\L\2", "ALL")>
                                              <p class="meta">#ArtistName#</p>
                                             </a>
                                              <!-- Dynamic price -->
                                              <!--- <span class="price">$#numberformat(price, "999.99")#</span> --->
                                           </div>
                                          
                                        </div>
                                     </div>
                                  </cfloop>
                               </cfoutput>
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

 <script>
   // document.addEventListener("DOMContentLoaded", function() {
   //    // If user is not logged in, show alert
   //    document.getElementById("addWishButtonNotLoggedInnn")?.addEventListener("click", function() {
   //       alert("Please first login to add items to your wishlist.");
   //    })
   // });

   function loinFirst(id) {
         alert("Please first login to add items to your wishlist.");
      }

</script>


   <script>
         function addWishListdata(id) {
            var productID = $("#Product_ID_" + id).val();
            var userID = $("#User_ID").val();
            var addData = $("#addData").val();
            

            // console.log('product_id: ' + productID)
            // console.log('User_ID: ' + userID)
            

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
                  
                  $("#heartIcon_" + id).css("color", "red");
                  if(response == 'Your artwork has been added to your Wishlist '){
                     toastr.success(response);

                     updateWishlist(id);

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


        
         function updateWishlist(id) {
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
                     console.log("Updated Wishlist innner ID: ", response.pk_id);
                     // deleteWishListdata(response.pk_id);
                     $("#addWishButtonnn_" + id).attr("onclick", "deleteWishListdata('" + response.pk_id + "')");
                  }
               },
               error: function () {
                  toastr.error('Error fetching updated wishlist.');
               }
            });
         }

         function deleteWishListdata(id) {
           

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