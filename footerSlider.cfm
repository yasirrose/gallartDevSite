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
                                           <a HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')" >
                                           <div class="img-sec">
                                              <!-- Dynamic image source -->
                                              <img src="http://#server_name#/img/#uid#.jpg" alt="gallery-img">
                                           </div>
                                           <div class="content-sec">
                                              <div class="top-content">
                                                 <!-- Dynamic product title -->
                                                 <h3 class="title">#name#</h3>
                                                 <button type="button" class="heart-btn">
                                                 <i class="fa fa-heart"></i>
                                                 </button>
                                              </div>
                                              <!-- Dynamic meta information -->

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
                                              <!-- Dynamic price -->
                                              <!--- <span class="price">$#numberformat(price, "999.99")#</span> --->
                                           </div>
                                           </a>
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