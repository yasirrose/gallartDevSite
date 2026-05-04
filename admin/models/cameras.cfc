<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="cameras">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getCameras" access="remote">
	
	
		<cfset var qCameras='' />
	
	   	<cfquery name="qCameras" datasource="#application.dsource#">
	      	SELECT * from camera
	   	</cfquery>
	   	
   		<cfreturn qCameras />
	
   	</cffunction>

   	<cffunction name="editCameras" access="remote">


   		<cfloop collection="#form#" item="idx">

        	<cfif left(idx,9) EQ "location_">
    		<cfset cameraId = mid(idx,10,100) />
			<cfset location = evaluate('form.'&idx) />
				<cfquery name="editCameras" datasource="#application.dsource#"> 
	                UPDATE camera SET
	                location = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#location#">
	                WHERE pk_camera = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#cameraId#">
	            </cfquery>
			</cfif>
        
        </cfloop>
	
    </cffunction>
	
	
</cfcomponent>