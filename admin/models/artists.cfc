<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="artists">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getAllArtists" access="remote" returntype="query">
		
		<cfset var success = true />
		<cfset var qArtists = '' />
		
		<cftry>
	
		<cfquery name="qArtists" datasource="#application.dsource#"> 
           	SELECT distinct manufacturer FROM products
			ORDER BY manufacturer
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn qArtists />
	
	</cffunction>
    
    <cffunction name="getAllGallartArtists" access="remote" returntype="query">
		
		<cfset var success = true />
		<cfset var qArtists = '' />
		
		<cftry>
	
		<cfquery name="qArtists" datasource="#application.dsource#"> 
           	SELECT distinct manufacturer FROM products
            WHERE fk_users is null
            AND active = 1
			ORDER BY manufacturer
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn qArtists />
	
	</cffunction>
	
	<cffunction name="getHighlightedArtists" access="remote" returntype="query">
		
		<cfset var success = true />
		<cfset var qArtists = '' />
		
		<cftry>
	
		<cfquery name="qArtists" datasource="#application.dsource#"> 
           	SELECT * from highlighted_artists
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn qArtists />
	
	</cffunction>
	
	<cffunction name="processHighlightedArtists" access="remote">
	
		<cfargument name="form" type="struct" />
		
		<cfset var success = true />
		<cfset var qArtists = '' />
		
		
		<cftry>
	
			<cfquery name="delArtists" datasource="#application.dsource#">
				DELETE from highlighted_artists
			</cfquery>
			
			<cfloop collection="#form#" item="idx">

				<cfif left(idx,7) eq 'artist_'>
				
					<cfquery name="insertAlerts" datasource="#application.dsource#">
					    INSERT into highlighted_artists
						(
							artist
						)
						values
						(
							'#removechars(idx,1,7)#'
						)
					</cfquery>
					
					</cfif>
				
			</cfloop>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
		

	
		<cfreturn qArtists />
	
	</cffunction>

	<cffunction name="getArtistInfo" access="remote" returntype="query">
		
		<cfset var success = true />
		<cfset var qArtists = '' />
		
		<cftry>
	
		<cfquery name="qArtists" datasource="#application.dsource#"> 
           	SELECT distinct P.manufacturer, B.bio FROM products P
           	LEFT OUTER JOIN bios B on B.artist = P.manufacturer
			ORDER BY manufacturer
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn qArtists />
	
	</cffunction>
	 

	
</cfcomponent>