<!--- <cfquery name="qArtists" datasource="#application.dsource#"> 
   	SELECT distinct manufacturer, slug, producturl FROM products
	ORDER BY manufacturer
</cfquery> --->

<cfquery name="qArtists" datasource="#application.dsource#"> 
   SELECT 
		manufacturer,
		MIN(slug) AS slug,
		MIN(producturl) AS producturl
	FROM products
	GROUP BY manufacturer
	ORDER BY manufacturer;
</cfquery>

<cfcontent type="application/vnd.ms-excel">
<cfheader name="Content-Disposition" value="attachment; filename=""Gallart Artist Info #DateFormat(createodbcdate(now()))#.xls""">

<cfoutput>


	<table border="1" cellpadding="0" cellspacing="0">
		<tr class="row0">
			<td>
				Artist
			</td>
			<td>
				Bio
			</td>
			<td>
				URL
			</td>
		</tr>
		<cfloop query="qArtists">
			<cfquery name="data" datasource="#application.dsource#" maxrows="1"> 
				SELECT * from bios
				WHERE bios.artist = '#manufacturer#'
			</cfquery>
			<tr>
				<td>
					#manufacturer#
				</td>
				<td>
					<cfif data.recordcount>
						<!--- #data.bio# --->
						<!--- http://gallart.com/artist_bio.cfm?bioId=#data.pk_bios# --->
						http://23.20.226.157/artist_bio/#data.pk_bios#
					</cfif>
					
				</td>
				<td>
					<!--- http://gallart.com/products.cfm?man=#ucase(manufacturer)# --->
						http://23.20.226.157/artists/#producturl#
					
				</td>
			</tr>
		</cfloop>
	</table>

</cfoutput>