<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js" type="text/javascript"></script>
   <script type="text/javascript">
     $(document).ready(function(){
       	$('#activeToggle').toggle(function(){
			$('.activeCheckbox').removeAttr('checked');
  			return false;
			}, function() {
  			$('.activeCheckbox').attr('checked','checked');
  			return false;
       	});
     });
     
   </script>

<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td valign="top">
        	
			<cfform method="post" action="index.cfm?event=massupdate.massUpdateProc">
			<table border="0" cellspacing="0" cellpadding="2" align="center">
				<tr>
					<td colspan="15">
						<cfoutput>
						<cfif  structKeyExists(form,'groups')>#getListingsMassUpdate.totalrecords.countall#<cfelse>#getListingsMassUpdate.qListings.recordcount#</cfif> listings found
						<cfif structKeyExists(form,'alphaCharNum')> where artist's name starts with the letter <cfoutput>#chr(form.alphaCharNum)#</cfoutput></cfif>
						<cfif  structKeyExists(form,'groups')>
							(from #(page-1)*groups+1# to
						<cfif (getListingsMassUpdate.totalrecords.countall-(page*groups)-page) GT 0> 
#page*groups#<cfelse>#getListingsMassUpdate.totalrecords.countall#</cfif>)
						</cfif>.
						</cfoutput>
					</td>
				</tr>
                <cfif isDefined('form.number_records') AND form.number_records neq ''>
                <cfset through = form.number_records + 49 />
                <cfif through GT getListingsMassUpdate.qListings.recordcount>
                	<cfset through = getListingsMassUpdate.qListings.recordcount />
                </cfif> 
                <tr>
					<td colspan="15">
						<cfoutput>Showing #form.number_records# through #through#</cfoutput>
					</td>
				</tr>
                </cfif>
				<tr>
                	<td colspan="3">
                    	<input type="Button" value="Back To Search" onclick="location.href='index.cfm?event=massupdate'">
                    </td>
					<td>
						<span style="font-size: 10px;">(click to uncheck)</span>
					</td>
					<td colspan="11" align="right">
                    	<!--- check to see if next alphaCharNum is lte value for letter Z --->
						<!---<cfoutput>
						<cfif structKeyExists(form,'groups')>
                        	<input type="Hidden" name="groups" value="#form.groups#">
							<input type="Hidden" name="alphaCharNum" value="#evaluate(form.alphaCharNum)#" />
                            <input type="Hidden" name="page" value="#form.page#">
                           	
                            <cfif form.page GT 1>
                                <input type="Submit" name="prev" value="<< PREV">
                            </cfif>
							<cfif (getListingsMassUpdate.totalrecords.countall-(page*groups)-page) GT 0>
								<input type="Submit" name="next" value="NEXT >>">
							</cfif>
							
                        <cfelse>
                        	<input type="Submit" value="Update All">
                        </cfif>
						</cfoutput>--->
						<input type="Submit" value="Update All">
					</td>
				</tr>
				<tr class="row0">
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Thumbnail')>
						<td>&nbsp;
							
						</td>
					</cfif>
					<td>
						Last Edited
					</td>
					 <td>
						Title
					</td>
					<td>
						<a href="" id="activeToggle" style="color: #ffffff;">Active</a>
					</td>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'ModelNo')>
				    <td>
						Model#
					</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Artist')>
						<td>
							Artist
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Medium')>
						<td>
							Medium
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'SellerInfo')>
						<td>
							Seller Info
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Year')>
					    <td>
							Year
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Size')>
					    <td>
							Size
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Edition')>
						<td>
							Edition
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Low')>
						<td>
							Low Estimate
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'High')>
						<td>
							High Estimate
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Retail')>
						<td>
							Retail Price
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Gallery')>
					    <td>
							Gallery Price
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Sale')>
					    <td>
							Sale Price
						</td>
					</cfif>
					<td>
                    	Show Sale Price
                    </td>
                    <td>
                    	Delete
                    </td>
				</tr>
                <cfparam name="thisStartrow" default="1">
                <cfparam name="thisMaxrows" default="#getListingsMassUpdate.qListings.recordcount#">
                <cfif isDefined('form.number_records') AND form.number_records neq ''>
            		<cfset thisStartrow = form.number_records />
                    <cfset thisMaxrows = 49 />
            	</cfif>
            	<cfif getListingsMassUpdate.qListings.recordcount>
            		
				<cfoutput query="getListingsMassUpdate.qListings" startrow="#thisStartrow#" maxrows="#thisMaxrows#">
				<input type="hidden" name="modelno_#uid#" value="#modelno#">
				<cfset this_manufacturer = manufacturer />
				<cfset this_path = path />
				<tr class="#this_row()#">
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Thumbnail')>
						<td>
							<a href="http://#server_name#/img/#uid#.jpg" target="_blank"><img src="http://#server_name#/img/thumbnails/#uid#.jpg" height="50" border="0"></a>
						</td>
					</cfif>
					<td>
						#dateFormat(lastedit)#
					</td>
					<td>
						<cfinput type="Text" name="name_#uid#" value="#name#" size="30" class="massupdate" required="Yes" message="NAME is required">
					</td>
					<td>
						<input type="Checkbox" name="active_#uid#" <cfif active eq 1>checked</cfif> class="activeCheckbox">
					</td>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'ModelNo')>
						<td>
							#modelno#
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Artist')>
					 	<td>
							<select name="manufacturer_#uid#" class="massupdate">
								<option value="">None</option>
								<cfloop query="getAllArtists">
									<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
									<option value="#manufacturer#" <cfif trim(this_manufacturer) eq trim(manufacturer)>selected</cfif>>#ucase(manufacturer)#
									</cfif>
								</cfloop>
							</select>
							
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Medium')>
						<td>
							<select name="path_#uid#" class="massupdate">
								<option value="">All
								<cfloop query="getAllMedium">
									<option value="#path#" <cfif trim(this_path) eq trim(path)>selected</cfif>>#ucase(path)#
								</cfloop>
							</select>
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'SellerInfo')>
						<td style="font-size: 8pt;">
							#full_seller_name#<br>#email#<br>#phone#
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Year')>
						<td>
							<input type="Text" name="specs_#uid#" value="#specs#" size="5" class="massupdate">
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Size')>
						<td>
							<input type="Text" name="overview_#uid#" value="#overview#" size="30" class="massupdate">
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Edition')>
						<td>
							<input type="Text" name="edition_#uid#" value="#edition#" size="10" class="massupdate">
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Low')>
						<td>
							<input type="Text" name="low_estimate_#uid#" value="#low_estimate#" size="10" class="massupdate">
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'High')>
						<td>
							<input type="Text" name="high_estimate_#uid#" value="#high_estimate#" size="10" class="massupdate">
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Retail')>
						<td nowrap>
							$<cfinput type="Text" name="retail_price_#uid#" value="#retail_price#" size="8" class="massupdate" validate="float" message="Please enter a dollar amount into the PRICE field - no $ and no ,">		 	
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Gallery')>
						<td nowrap>
							$<cfinput type="Text" name="gallery_price_#uid#" value="#gallery_price#" size="8" class="massupdate" validate="float" message="Please enter a dollar amount into the GALLERY PRICE field - no $ and no ,">		 	
						</td>
					</cfif>
					<cfif isDefined('form.displayFields') and listFind(form.displayFields,'Sale')>
						<td nowrap>
							$<cfinput type="Text" name="special_price_#uid#" value="#special_price#" size="8" class="massupdate" validate="float" message="Please enter a dollar amount into the SALE PRICE field - no $ and no ,">		 	
						</td>
					</cfif>
					<td align="center">
                    	<input type="checkbox" name="closeout_#uid#" <cfif closeout eq 1>checked</cfif> class="activeCheckbox" />
                    </td>
                    <td align="center">
                    	<input type="checkbox" name="delete_#uid#" />
                    </td>
				</tr>
				</cfoutput>
				</cfif>
				</cfform>
			</table>
		</td>
	</tr>
</table>

