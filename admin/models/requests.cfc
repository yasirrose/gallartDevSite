<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="requests">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getRequests" access="remote">
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
		<cfargument name="Title" required="no" type="string" default="">
		<cfargument name="Artist" required="no" type="string" default="">
		<cfargument name="Status" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">
	
	
		<cfset var qRequests='' />

	   	<cfquery name="qRequests" datasource="#application.dsource#">
	      	SELECT CONVERT(CHAR(9),datestamp,6) as requestDate,U.email as req_email,*
	      	FROM requests R
			INNER JOIN users U on R.fk_users = U.pk_users
			WHERE 0=0
			<cfif arguments.Lname neq ''>
	      		AND lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND email like '#arguments.Email#%'
	      	</cfif>
			<cfif arguments.Title neq ''>
	      		AND title like '%#arguments.title#%'
	      	</cfif>
			<cfif arguments.Artist neq ''>
	      		AND artist like '%#arguments.artist#%'
	      	</cfif>
			<cfif arguments.Status neq ''>
	      		AND fk_request_status = #arguments.Status#
	      	</cfif>
			<cfif arguments.fromDate neq ''>
				AND datestamp >= '#dateFormat(arguments.fromDate)#'
			</cfif>
			<cfif arguments.toDate neq ''>
				AND datestamp <= '#dateFormat(arguments.toDate)#'
			</cfif>
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelseif gridsortcolumn eq 'REQUESTDATE'>
				ORDER BY datestamp #gridsortdirection#
			<cfelse>
				ORDER BY datestamp desc
	      	</cfif>
	   	</cfquery>
	   	
   		<cfreturn queryconvertforgrid(qRequests,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getRequestFromId" access="remote" returntype="struct">
	  	
      	<cfargument name="pk_requests" type="string" default="">
		
		<cfset var returnStruct = structNew() />
	
		<cfset var qRequests='' />

	   	<cfquery name="qRequests" datasource="#application.dsource#">
	      	SELECT U.email as req_email,*
	      	FROM requests R
			INNER JOIN users U on R.fk_users = U.pk_users
			WHERE pk_requests = '#arguments.pk_requests#'
	   	</cfquery>
		
		<cfquery name="qRequestResponses" datasource="#application.dsource#"> 
           	SELECT * from request_responses
			WHERE fk_requests = '#arguments.pk_requests#'
        </cfquery>
		
		<cfsavecontent variable="responseTable">
		<cfif qRequestResponses.recordcount>
		<table bgcolor="FFFFFF" cellpadding="3">
			<tr bgcolor="000000">
				<td width="150" style="color: #FFFFFF;">Name</td>
				<td width="125" style="color: #FFFFFF;">Email</td>
				<td width="100" style="color: #FFFFFF;">Phone</td>
				<td width="200" style="color: #FFFFFF;">Notes</td>
			</tr>
			<cfoutput query="qRequestResponses">
			<tr>
				<td>#fname# #lname#</td>
				<td><a href="mailto:#email#">#email#</a></td>
				<td>#phone#</td>
				<td>#notes#</td>
			</tr>
			</cfoutput>
		</table>
		<cfelse>
			NONE
		</cfif>
		</cfsavecontent>

		<cfset returnStruct['responseTable'] = responseTable />
		<cfloop list="#qRequests.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qRequests."&idx) />
		</cfloop>

		<cfreturn returnStruct />
		
   	</cffunction>
	
	<cffunction name="editRequestFromForm" access="remote" output="false" returntype="boolean">
	    <cfargument name="pk_requests" type="string" default="">
		<cfargument name="fk_request_status" type="string" default="">
		<cfargument name="title" type="string" default="">
		<cfargument name="artist" type="string" default="">

	    
	    <cfset var success = true />
		
	    	<cftry>
	    			
				<cfquery name="editRequests" datasource="#application.dsource#"> 
	                UPDATE requests SET 
						fk_request_status 	= #arguments.fk_request_status#,
						title 				= '#arguments.title#',
						artist 				= '#arguments.artist#'
	                WHERE pk_requests 		= #arguments.pk_requests#
	            </cfquery>
	    			
			<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>
			
		<cfreturn success> 
	        
	</cffunction>
	
	<cffunction name="deleteRequest" access="remote">
		<cfargument name="pk_requests" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
	
		<cfquery name="deleteRequest" datasource="#application.dsource#"> 
           	DELETE from requests
            WHERE pk_requests = #arguments.pk_requests#
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	<cffunction name="getRequestStatus" access="remote">
		
		<cfset var success = true />
		<cfset qRequestStatus = '' />
		
		<cftry>
	
		<cfquery name="qRequestStatus" datasource="#application.dsource#"> 
           	SELECT * from request_status
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn qRequestStatus />
	
	</cffunction>
	
	
</cfcomponent>