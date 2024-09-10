<cfoutput><form method="POST" action="index.cfm?event=artists.processHighlightArtists">
<table cellspacing="0" cellpadding="3" border="0" width="90%" bgcolor="##eeeeee" height="10">
	<tr>
		<td style="font-weight: bold;" valign="middle">
			Please select the artists that you want to be highlighted in the alphabetical search.<br><br>Artists that you have previously selected are already checked.
		</td>
	</tr>
	<tr>
		<td><input type="submit" value="Submit"></td>
	</tr>
	<tr>
		<td>
			<cfset thisQuery = getAllArtists />
			<cfset columnNum = 5 />
			<cfset column = round(thisQuery.recordcount/columnNum)>
			<cfset rem = thisQuery.recordcount MOD columnNum>
			<cfset x = 1 />
			<cfif rem EQ 1>
				<cfset val = evaluate(-1) />
			<cfelse>
				<cfset val = 0 />
			</cfif>
			
			<table>
				<tr>
			  		<td valign="top">
			      
					 	<table>
					 	<cfloop query="thisQuery">
					    	<tr>
					        	<td><input type="Checkbox" name="artist_#manufacturer#" value="#manufacturer#" <cfif listfindnocase(valuelist(getHighlightedArtists.artist,'|'),manufacturer,'|')>checked</cfif>>#manufacturer#</td>
					    	</tr>
					      	<cfif x IS column>
					    		</table></td><td valign="top"><table>
					    		<cfset x = val>
					      	</cfif>
					   	<cfset x = x + 1>    
					 	</cfloop>
					  	</table>
			  		</td>
			    </tr>
			</table>
		</td>
	</tr>
</table>
</form></cfoutput>