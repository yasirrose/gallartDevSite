<table border="0" cellpadding="0" cellspacing="0" width="90%">
	<tr>
		<td><br>
		<h3>EXPORT INVENTORY TO CSV</h3>
		<br>
		<cfif isDefined('form.artists')>
	
			<cfquery name="getProducts" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" timeout="60000">
				SELECT modelno,manufacturer,name,gallery_price,year FROM products P
				WHERE P.active = 1
				AND 
				<cfloop list="#form.artists#" index="idx">
					P.manufacturer like '%#trim(listlast(idx,' '))#%' OR
				</cfloop>
				0=1
				AND fk_users is null
				ORDER by P.manufacturer
			</cfquery>
			

			<cfif getProducts.recordcount GTE 66000>
			
			    <!--- Excel can only handle 66000 rows --->
			    Too many records
			
			<cfelse>
			
				<cfset fieldlist = "modelno,manufacturer,name,gallery_price,year" />
			
			       <cffile action="write"
			             file="#expandPath('.')#\data\export.csv"
			             output="Art ID,Artist,Title,Gallery Price,Year"
			             addnewline="yes">
			
			    <cfoutput>
				
					<cfloop query="getProducts">
				
						<cfset dataList = '' />
						
						<cfset num = 1 />
						
						<cfloop list="#fieldlist#" index="idx">
						
						
							<cfset idxVal = evaluate(idx) />
							
							<!--- remove commas  --->
							<cfset idxVal = replace(idxVal,',','_') />
							
							<cfif not len(idxVal)>
								<!--- workaround for empty int field --->
								<cfset idxVal = 0 />
							<cfelseif not len(idxVal)>
								<!--- replace empty cells with ||  --->
								<cfset idxVal = '||' />
							</cfif>
							
							<!--- replace double quotes --->
							<cfset idxVal = replace(idxVal, """","""""", "all")>
									
							<cfset dataList = listappend(dataList,'"#idxVal#"')>
						
						</cfloop>
			
						<cffile action="append"
							file="#expandPath('.')#\data\export.csv"
							output='#dataList#' 
							addnewline="yes"> 
					
					</cfloop>
			    </cfoutput>
			
			   	<!--- Set the content type and disposition headers to prompt the user to download the file --->
				<cfheader name="Content-Disposition" value="attachment; filename=export.csv">
				<cfcontent type="application/octet-stream" file="#expandPath('.')#\data\export.csv" reset="true">
			
			</cfif>
			<cfabort>
			
			
			<!--- <cfheader name="Content-Disposition" value="attachment; filename=""Gallart Inventory Listing #DateFormat(createodbcdate(now()))#.csv""">
			
			<cfcontent type="application/ms-excel" reset="Yes">
			
			
			<cfoutput>
				<table border="1" cellpadding="0" cellspacing="0">
					<tr bgcolor="##000000">
						<td style="color: ##FFFFFF;" valign="top">
							<strong>Artist</strong>
						</td>
						<td style="color: ##FFFFFF;" valign="top" width="350">
							<strong>Title</strong>
						</td>
						<td style="color: ##FFFFFF;" valign="top">
							<strong>Price</strong>
						</td>
					</tr>
					<cfloop query="getProducts">
					<tr>
						<td valign="top">
							#Manufacturer#
						</td>
						<td valign="top">
							#Name#
						</td>
						<td valign="top" align="right">
							<cfif not price eq 0>
								#DollarFormat(Price)#
							<cfelse>
								N/A
							</cfif>
							
						</td>
					</tr>
					</cfloop>
				</table>
			</cfoutput> --->
			
			<cfelse>
			
			
			<cfoutput>
			
			<form method="post" action="index.cfm?event=exports.artistsCsv">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td>
						<strong>ENTER LIST OF ARTIST NAMES:</strong>
					</td>
				</tr>
				<tr>
					<td>
						<textarea name="artists" cols="40" rows="5"></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<input type="Submit" value="CREATE CSV LISTING">
					</td>
				</tr>
			</table>
			</form>
			
			</cfoutput>
			
			</cfif>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<input type="Button" value="Back" onclick="location.href='index.cfm?event=exports'" />
		</td>
	</tr>
</table>	
