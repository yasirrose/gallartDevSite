<cfhtmlhead text='<script type="text/javascript" src="../js/jquery-1.3.2.js" language="JavaScript"></script>'>
    <cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/sales.js" language="JavaScript"></script>'>
    <style>
        .disabled {
            border: 0;
            background: transparent;
            color: #000;
            text-align: right;
        }
        a {
            cursor: pointer;
            text-decoration: underline;
        }
    </style>
    
        <!--- <cfdump var="#getListingsForBulk#" abort="true"> --->
    
    <div style="text-align: center"><input type="Button" value="Back To Bulk Menu" onclick="location.href='index.cfm?event=bulk'"></div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="500">
            <tr>
                <td colspan="2">
                    <form>
                        <input type="button" value="Back to Search Record" onclick="location.href='index.cfm?event=bulk.bulkSearch'">
                    </form>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    NUMBER OF RECORDS FOUND: <cfoutput>#getListingsForBulk.recordcount#</cfoutput>
                </td>
            </tr>
            <tr>
                <td width="100%" valign="top" colspan="2">
                    <cfif getListingsForBulk.recordcount>
                    <table>
    
                        <!--- <tr>
                            <td>
                                <cfform method="post" action="index.cfm?event=sales.saleSearchResults">
                                    <strong>Search Artist</strong>
                                    <select name="searchArtist" id="searchArtist">
                                        <option value="">All</option>
                                            <cfoutput query="getAllArtists" group="manufacturer">
                                            <cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
                                                <option value="#manufacturer#" <cfif isDefined('form.searchArtist') and form.searchArtist EQ manufacturer >selected</cfif> >#ucase(manufacturer)#</option>
                                            </cfif>
                                            </cfoutput>
                                    </select>
                                    <br><br>
                                    <strong>Order by Price</strong>
                                        <select name="priceOrder"  id="priceOrder"  >
                                            <option value="">Please Select</option>
                                            <option value="asc">Lowest To Highest</option>
                                            <option value="desc">Highest To Lowest</option>
                                    </select>
                                        
                                    <br>
                                    <input type="Submit" value="Search ">
    
                                </cfform>	
                                <br>
                            </td>
                        </tr> --->
    
                        <!--- <tr>
                            <td>
                                <cfform method="post" action="index.cfm?event=sales.saleSearchResults">
                                    <strong>Order by Price</strong>
                                    <select name="priceOrder"  id="priceOrder"  >
                                        <option value="">Please Select</option>
                                        <option value="asc">Lowest To Highest</option>
                                        <option value="desc">Highest To Lowest</option>
                                    </select>
                                    <input type="Submit" value="Price Order">
                                </cfform>
                            </td>
                        </tr> --->
    
                        <!--- <tr>
                            <td>
                                <strong>Compute sale prices as a percentage of the Gallery Price</strong><br />
                                <ul>
                                    <li>
                                        <!--- Enter percentage of Gallery Price to be used as discount: <input type="text" name="salePercent" id="salePercent" size="2">% --->
                                        Enter percentage of Gallery Price to be used as discount: <select name="salePercent" id="salePercent"  >
                                            <option value="20" >20%</option>
                                            <option value="25" >25%</option>
                                            <option value="30" >30%</option>
                                            <option value="35" >35%</option>
                                            <option value="40" >40%</option>
                                            <option value="45" >45%</option>
                                            <option value="50" >50%</option>
                                            <option value="55" >55%</option>
                                            <option value="60" >60%</option>
                                            <option value="65" >65%</option>
                                            <option value="70" >70%</option>
                                            <option value="75" >75%</option>
                                        </select>
                                    </li>
                                    <li>
                                        Click this button to discount this percentage from Gallery Price and compute new Sales Price: <input type="button" value="COMPUTE" onclick="setSalePricesFromPercentage()" /> <br />
                                        (If the result set is large, this could take awhile, and possibly time out.  If possible, keep the result sets small.)
                                    </li>
                                </ul>
                            </td>
                        </tr> --->
                    </table>
                    <table>
                        <tr>
                            <td>
                                <strong>Add Listings to Sale</strong><br />
                                <ul>
                                    <li>
                                        For each listing, check radio button next to the High Estimate Price or the Sale Price to select which price should be used for the sale.
                                    </li>
                                    <li>
                                        If you want to select the entire column, click on the column header: "High Estimate" or "Sale Price."
                                    </li>
                                    <li>
                                        For each listing that you want to add to the sale, check the checkbox at the far right of the row for that listing.
                                    </li>
                                    <li>
                                        If you want to check all listings, click on the column header: "Add To Sale."
                                    </li>
                                    <li>
                                        When all computations and selections have been made, click the "ENTER CHECKED PRICES INTO DATABASE" button.
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                    <cfform method="post" action="index.cfm?event=sales.saleProc">
                    <table border=0 cellpadding=2 cellspacing=0 width="98%" align="center">
                        <tr>
                            <td colspan="10" align="right">
                                <!--- <input type="Submit" value="ENTER CHECKED PRICES INTO DATABASE"> --->
                            </td>
                        </tr>
                        <tr class="row0">
                            <td>
                                Thumbnails
                            </td>
                            <td>
                                Art ID
                            </td>
                            <td>
                                Artist
                            </td>
                            <td>
                                Title
                            </td>
                            <td>
                                Medium
                            </td>
                            <td>
                                Retail Price
                            </td>
                            <td>
                                Gallery Price
                            </td>
                            <!--- <td>
                                <a onclick="useHE()">High Estimate</a>
                            </td> --->
                             <td>
                                <a onclick="useSP()">Sale Price</a>
                            </td>
                            <td align="center">
                                <a id="addAllListings">Add To Sale</a>
                            </td>
                            <td align="center">
                                <a id="removeAllListings">Remove From Sale</a>
                            </td>
                        </tr>
                        <cfoutput query="getListingsForBulk">
                        <cfset this_manufacturer = manufacturer />
                        <cfset this_path = path />
                        <tr class="#this_row()#">
                            <td>
                                <cfif fileexists("http://23.20.226.157/img/thumbnails/#uid#.jpg")>
                                     <img src="http://23.20.226.157/img/#uid#.jpg?x=randrange(1,99)" alt="#name#" title="#name#" border="0" style="height: 100px; width: 100px;" align="center">
                                <cfelse>
                                    <div align="center" style="padding: 20px;"><strong>NO IMAGE <br>AVAILABLE</strong></div>
                                </cfif>
                            </td>
                            <td>
                                #modelno#
                            </td>
                             <td>
                                #manufacturer#									
                            </td>
                            <td>
                                #name#
                            </td>
                            <td>
                                #path#
                            </td>
                            <td nowrap>
                                $#retail_price#		 	
                            </td>
                            <td>
                                $<input type="text" name="gallery_price" value="#gallery_price#" id="GP_#uid#" size="8" class="disabled" disabled="disabled" />
                            </td>
                            <!--- <td nowrap>
                                <input type="radio" name="usePrice_#uid#" class="useH" value="H" <cfif use_highestimate EQ 1>checked</cfif> />$#high_estimate#		 	
                            </td> --->
                            <td>
                                <input type="radio" name="usePrice_#uid#" class="useS" value="S" <cfif use_highestimate EQ 0>checked</cfif> />$<input type="text" name="special_price_#uid#" value="#special_price#" class="GP_#uid# disabled" size="8" />
                            </td>
                            <td align="center">
                                <input type="Checkbox" name="add_to_sale_#uid#" id="add_to_sale_#uid#" class="addAll" value="1" onclick="validateRemove('#uid#')" <cfif closeout EQ true>checked</cfif>>
                            </td>
                            <td align="center">
                                <input type="Checkbox" name="remove_from_sale_#uid#" id="remove_from_sale_#uid#" class="removeAll" value="1" onclick="validateAdd('#uid#')">
                            </td>
                        </tr>
                        </cfoutput>
                        </cfform>
                    </table>			
                    <cfelse>
                    No Results Found
                    </cfif>	
                    <br><br><br><br><br>										
                </td>
            </tr>	
    </table>
    
    
    
    
    