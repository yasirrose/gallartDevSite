
<table cellspacing="0" cellpadding="0" border="0" width="100%" align="left">
    <cfform method="post" action="index.cfm?event=massupdate.results">
	<input type="hidden" name="page" value="1" />
    <tr>
    	<td colspan="2"><br>
			<input type="submit" value="ALPHABETICAL ENTRY IN GROUPS - DEFAULT DISPLAY FIELDS" />&nbsp;Groups of:&nbsp;<input type="text" name="groups" value="25" size="2" />&nbsp;
            Letter:&nbsp;
            <select name="alphaCharNum">
            	<option value="65">A</option>
                <option value="66">B</option>
                <option value="67">C</option>
                <option value="68">D</option>
                <option value="69">E</option>
                <option value="70">F</option>
                <option value="71">G</option>
                <option value="72">H</option>
                <option value="73">I</option>
                <option value="74">J</option>
                <option value="75">K</option>
                <option value="76">L</option>
                <option value="77">M</option>
                <option value="78">N</option>
                <option value="79">O</option>
                <option value="80">P</option>
                <option value="81">Q</option>
                <option value="82">R</option>
                <option value="83">S</option>
                <option value="84">T</option>
                <option value="85">U</option>
                <option value="86">V</option>
                <option value="87">W</option>
                <option value="88">X</option>
                <option value="89">Y</option>
                <option value="90">Z</option>
            </select>
		<br><br>
		</td>
  	</tr>
  	<tr>
		<td>
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td width="106" style="font-size: 10px;">
						<strong>Gallery Price from:</strong>
					</td>
					<td width="100">
						$<cfinput name="FromPrice" size="10" />
					</td>
					<td width="25" style="font-size: 10px;">
						<strong>to:</strong>
					</td>
					<td nowrap>
						$<cfinput name="ToPrice" size="10" />
					</td>
				</tr>
			</table>
			<br><br>					
		</td>
	</tr>
    </cfform>
    <!---<form method="post" action="index.cfm?event=massupdate.results">
    <!-- set alphaCharNum to coldfusion chr for letter A -->
    <input type="hidden" name="alphaCharNum" value="65" />
	<tr>
    	<td colspan="2"><input type="submit" value="ALPHABETICAL ENTRY - DEFAULT DISPLAY FIELDS" /></td>
  	</tr>
    </form>
    <form method="post" action="index.cfm?event=massupdate.results">
	<input type="hidden" name="alphaCharNum" value="65" />
	<input type="hidden" name="page" value="1" />
    <tr>
    	<td colspan="2"><br>
			<input type="submit" value="ALPHABETICAL ENTRY IN GROUPS - DEFAULT DISPLAY FIELDS" />&nbsp;Groups of:&nbsp;<input type="text" name="groups" value="25" size="2" />
		<br><br>
		</td>
  	</tr>
    </form>--->
	<tr>
		<td colspan="2">
			<cfform method="post" action="index.cfm?event=massupdate.results">
			<table cellspacing="0" cellpadding="0" border="0" width="75%" align="left">
				<tr>
			    	<td colspan="2" style="font-size: 11px;"><strong>SEARCH:</strong></td>
			  	</tr>
				<tr>
					<td valign="top" width="50%">
						<table cellspacing="0" cellpadding="3" border="0" width="100%">
							<tr>
								<td width="100" style="font-size: 10px;">
									<strong>Art ID:</strong>
								</td>
								<td>
									<cfinput name="modelno" size="10" />
								</td>
			
							</tr>
							<tr>
								<td style="font-size: 10px;">
									<strong>Title:</strong>
								</td>
								<td>
									<cfinput name="name" size="30" />
								</td>
			
							</tr>
							<tr>
								<td style="font-size: 10px;">
									<strong>Artist:</strong>
								</td>
								<td>
									<select name="manufacturer">
										<option value="">All
										<cfoutput query="getAllArtists" group="manufacturer">
										<cfif not isnumeric(manufacturer) and len(manufacturer) gt 1>
											<option value="#manufacturer#">#ucase(manufacturer)#
										</cfif>
										</cfoutput>
										</select>
								</td>
			
							</tr>
							<tr>
								<td style="font-size: 10px;">
									<strong>Medium:</strong>
								</td>
								<td>
									<select name="path">
										<option value="">All
										<cfoutput query="getAllMedium">
											<option value="#path#">#ucase(path)#
										
									</cfoutput></select>
								</td>
			
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="106" style="font-size: 10px;">
												<strong>Year:</strong>
											</td>
											<td width="100">
												<cfinput name="Year" size="10" />
											</td>
											<td width="50" style="font-size: 10px;">
												<strong>Size:</strong>
											</td>
											<td>
												<cfinput type="Text" name="Height" style="width: 50px;">&nbsp;x&nbsp;<cfinput type="Text" name="Width" style="width: 50px;"> (HEIGHT X WIDTH)
											</td>
										</tr>
									</table>					
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;">
									<strong>Description:</strong> (keywords)
								</td>
								<td>
									<cfinput name="caption" size="30" />
								</td>
			
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="106" style="font-size: 10px;">
												<strong>Gallery Price from:</strong>
											</td>
											<td width="100">
												$<cfinput name="FromPrice" size="10" />
											</td>
											<td width="25" style="font-size: 10px;">
												<strong>to:</strong>
											</td>
											<td nowrap>
												$<cfinput name="ToPrice" size="10" />
											</td>
										</tr>
									</table>					
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="106" style="font-size: 10px;">
												<strong>Date from:</strong>
											</td>
											<td width="100">
												<cfinput name="FromDate" type="datefield" validate="date" size="10" />
											</td>
											<td width="25" style="font-size: 10px;">
												<strong>to:</strong>
											</td>
											<td nowrap>
												<cfinput name="ToDate" type="datefield" validate="date" size="10" />
											</td>
										</tr>
									</table>					
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="106" style="font-size: 10px;">
												<strong>Last Edit from:</strong>
											</td>
											<td width="100">
												<cfinput name="FromLastedit" type="datefield" validate="date" size="10" />
											</td>
											<td width="25" style="font-size: 10px;">
												<strong>to:</strong>
											</td>
											<td nowrap>
												<cfinput name="ToLastedit" type="datefield" validate="date" size="10" />
											</td>
										</tr>
									</table>					
								</td>
							</tr>
							<tr>
								<td style="font-size: 10px;" colspan="2">
									<strong>Gallery Listings Only:</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="gallery_only" value="1" checked>
								</td>
			
							</tr>
							<tr>
								<td style="font-size: 10px;">
									<strong>Seller:</strong>
								</td>
								<td>
									<select name="SellerId">
										<option value="">All
										<option value="0">Only Seller Listings
										<cfoutput query="getAllSellers">
											<option value="#pk_users#">#full_seller_name#
										
									</cfoutput></select>
								</td>
			
							</tr>
							<tr>
								<td style="font-size: 10px;">
									<strong>Active/Inactive:</strong>
								</td >
								<td style="font-size: 10px;">
									<input type="radio" name="Active" value="1" checked>Active
									<input type="radio" name="Active" value="0">Inactive
									<input type="radio" name="Active" value="">All
								</td>
			
							</tr>
                            <tr>
								<td style="font-size: 10px;">
									<strong>Number of Records:</strong>
								</td >
								<td style="font-size: 10px;">
									<select name="number_records">
                                    	<option value="">All</option>
                                        <option value="1">1 - 50</option>
                                        <option value="51">51 - 100</option>
                                        <option value="101">101 - 150</option>
                                        <option value="151">151 - 200</option>
                                        <option value="201">201 - 250</option>
                                        <option value="251">251 - 300</option>
                                    </select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="106" style="font-size: 10px;">&nbsp;
												
											</td>
											<td width="20">
												<input type="Checkbox" name="OnSale" value="1">
												<input type="Hidden" name="OnSale" value="">
											</td>
											<td width="75" style="font-size: 10px;">
												On Sale
											</td>
											<td width="20">
												<input type="Checkbox" name="Trump" value="1">
												<input type="Hidden" name="Trump" value="">
											</td>
											<td width="75" style="font-size: 10px;">
												Trump Site
											</td>
											<td width="20">
												<input type="Checkbox" name="Auction" value="1">
												<input type="Hidden" name="Auction" value="">
											</td>
											<td>
												Auction Site
											</td>
											<td width="20">
												<input type="Checkbox" name="Slideshow">
												<input type="Hidden" name="Slideshow">
											</td>
											<td>
												Slideshow
											</td>
										</tr>
									</table>					
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="0" cellpadding="0" border="0" width="100%">
										<tr>
											<td width="50" style="font-size: 10px;">&nbsp;
												
											</td>
											<td width="10">
												<input type="Checkbox" name="Frontshow">
												<input type="Hidden" name="Frontshow">
											</td>
											<td width="70" style="font-size: 10px;">
												Featured on Home Page
											</td>
											<td width="10">
												<input type="Checkbox" name="BottomHome">
												<input type="Hidden" name="BottomHome">
											</td>
											<td width="70" style="font-size: 10px;">
												Bottom of Home Page
											</td>
										</tr>
									</table>					
								</td>
							</tr>
						</table>
					</td>
					<td valign="top" width="50%">
						<table cellspacing="0" cellpadding="3" border="0" width="100%">
							<tr>
								<td style="font-size: 10pt;">
									<b>Choose Fields You Want To Display:</b>
								</td>
							</tr>
							<tr>
								<td style="font-size: 9pt;">
									<input type="Checkbox" name="displayFields" value="ModelNo" checked>Art ID<br>
									<input type="Checkbox" name="displayFields" value="Artist" checked>Artist<br>
									<input type="Checkbox" name="displayFields" value="Medium" checked>Medium<br>
									<input type="Checkbox" name="displayFields" value="Year">Year<br>
									<input type="Checkbox" name="displayFields" value="Size">Size<br>
									<input type="Checkbox" name="displayFields" value="Edition">Edition<br>
									<input type="Checkbox" name="displayFields" value="Low" checked>Low Estimate<br>
									<input type="Checkbox" name="displayFields" value="High" checked>High Estimate<br>
									<input type="Checkbox" name="displayFields" value="Retail" checked>Retail Price<br>
									<input type="Checkbox" name="displayFields" value="Gallery" checked>Gallery Price<br>
									<input type="Checkbox" name="displayFields" value="Sale" checked>Sale Price<br>
									<input type="Checkbox" name="displayFields" value="SellerInfo">Seller Info<br>
									<input type="Checkbox" name="displayFields" value="Thumbnail" checked>Thumbnail
									
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
			    	<td colspan="2" style="padding-top: 10px;" align="center">
						<input type="Reset" value="Reset"><input type="Submit" value="Search">
					</td>
			  	</tr>
			</table>
			</cfform>
		</td>
	</tr>
</table>
