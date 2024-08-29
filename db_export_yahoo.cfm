<!--- <cfquery name="getProducts" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT top 5 * FROM products P
	LEFT OUTER JOIN users U
	on P.fk_users = U.pk_users
	WHERE P.active = 1
	order by manufacturer,name
</cfquery>


<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Product Details #DateFormat(createodbcdate(now()))#.xls""">

<cfcontent type="application/ms-excel" reset="Yes">


<cfoutput>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr bgcolor="##000000">
			<td style="color: ##FFFFFF;" valign="top">
				<strong>Path</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Name</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Code</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Price</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Sale-price</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Options</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Headline</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Caption</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Abstract</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Label</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Ship-weight</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Availability</strong>
			</td>
			<td style="color: ##FFFFFF; valign="top"">
				<strong>Ypath</strong>
			</td>
		</tr>
		<cfloop query="getProducts">
		<tr>
			<td valign="top">
				#Path#
			</td>
			<td valign="top">
				#Name#
			</td>
			<td valign="top">
				#Code#
			</td>
			<td valign="top">
				#DollarFormat(Price)#
			</td>
			<td valign="top">
				#DollarFormat(Sale_Price)#
			</td>
			<td valign="top">
				
			</td>
			<td valign="top">
				#Manufacturer#
			</td>
			<td valign="top">
				#Overview#
			</td>
			<td valign="top">
				
			</td>
			<td valign="top">
				
			</td>
			<td valign="top">
				#Ship_Weight#
			</td>
			<td valign="top">
				
			</td>
			<td valign="top">
				
			</td>
		</tr>
		</cfloop>
	</table>
</cfoutput> --->

<cfquery name="getProducts" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT top 5 * FROM products P
	LEFT OUTER JOIN users U
	on P.fk_users = U.pk_users
	WHERE P.active = 1
	order by manufacturer,name
</cfquery>

<!--- <cfdump var="#getProducts#"><cfabort> --->

<cffile action="write"
         file="#expandPath('.')#\adminpage\data\export.csv"
         output="Path,Name,Code,Retail-Price,Gallery-price,Options,Headline,Caption,Abstract,Label,Ship-weight"
         addnewline="yes">

<cfoutput>
    <cfloop query="getProducts">

    <cffile action="append"
             file="#expandPath('.')#\adminpage\data\export.csv"
              output='"#TRIM(Path)#","#TRIM(Name)#","#TRIM(Code)#","#DollarFormat(retail_price)#","#DollarFormat(gallery_price)#","","#TRIM(Manufacturer)#","#replace(caption,'"','''','all')#","","","#TRIM(Ship_Weight)#"' 
             addnewline="yes">

    </cfloop>
</cfoutput>

<cflocation url="http://#server_name#/adminpage/data/export.csv">