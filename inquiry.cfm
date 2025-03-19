<cfif structKeyExists(form, "wishlist_pk_id") AND isNumeric(form.wishlist_pk_id)>
   <!--- <cfdump var="#form#" abort="true"> --->
   <!--- Delete from Wishlist --->
   <cfset userID = session.sellerinfo.pk_users>
   <cfquery name="deleteWishlistItem" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
       DELETE FROM Wishlist
       WHERE pk_id = <cfqueryparam value="#form.wishlist_pk_id#" cfsqltype="cf_sql_integer">
   </cfquery>

   <!--- Return JSON response and stop further execution --->
   <cfoutput>
      {"status":"success", "message":"Item deleted successfully"}
   </cfoutput>
   <cfabort> <!-- Stop further execution -->

</cfif>



<!--- Wishlist Add Query --->
<cfif structKeyExists(form, "addData") AND form.addData EQ "AddWishlist">
   <cfquery name="getwishList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
      SELECT * FROM Wishlist 
      WHERE product_id = <cfqueryparam value="#form.ProductID#" cfsqltype="cf_sql_integer">
      AND user_id = <cfqueryparam value="#form.UserID#" cfsqltype="cf_sql_integer">
   </cfquery>

   <cfif getwishList.recordCount EQ 0>
      <cfquery name="addtowishList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
         INSERT INTO Wishlist 
         (user_id, product_id, date)
         VALUES(
            <cfqueryparam value="#form.UserID#" cfsqltype="cf_sql_integer">,
            <cfqueryparam value="#form.ProductID#" cfsqltype="cf_sql_integer">,
            <cfqueryparam value="#Now()#" cfsqltype="cf_sql_timestamp">
         )
      </cfquery>

      <cfoutput>Your artwork has been added to your Wishlist</cfoutput>
   <cfelse>
      <cfoutput>This product is already on your Wishlist</cfoutput>
   </cfif>
   <cfabort> <!-- Stop further execution -->
</cfif>



<cfif structKeyExists(FORM, "action") AND FORM.action EQ "getUpdatedWishlist">
   <cfquery name="getUpdatedWishList" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
      SELECT * FROM Wishlist 
      WHERE product_id = <cfqueryparam value="#FORM.product_id#" cfsqltype="cf_sql_integer">
      AND user_id = <cfqueryparam value="#session.sellerinfo.pk_users#" cfsqltype="cf_sql_integer">
   </cfquery>

   <cfif getUpdatedWishList.recordCount GT 0>
      <cfoutput>
         {"status": "success", "pk_id": "#getUpdatedWishList.pk_id#"}
      </cfoutput>
   <cfelse>
      <cfoutput>
         {"status": "error", "message": "No record found"}
      </cfoutput>
   </cfif>
   <cfabort> <!-- Stop further execution -->
</cfif>