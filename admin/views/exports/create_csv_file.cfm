<cfheader name="Content-Disposition" value='attachment; filename="Gallart_Inventory_Listing_#DateFormat(createodbcdate(now()), "yyyymmdd")#.csv"'>
<cfcontent type="text/csv" reset="Yes">
"Art ID","Artist","Title","Year","Gallery Price","Thumbnail"
<cfoutput>
    <cfif isDefined('url.artists') AND url.artists NEQ ''>
        <cfloop query="getCsvListingsByArtist">
            #modelno#,"#Manufacturer#","#Name#","#year#","<cfif not gallery_price eq 0>#DollarFormat(replace(gallery_price, ',', ''))#<cfelse>N/A</cfif>",http://#server_name#/img/#uid#.jpg#chr(13)##chr(10)#
        </cfloop>
    </cfif> 
</cfoutput>
