<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="appraisals">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getAppraisals" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">
	
	
		<cfset var qAppraisals='' />

	   	<cfquery name="qAppraisals" datasource="#application.dsource#">
	      	SELECT *
	      	FROM appraisal
			WHERE 0=0
			<cfif arguments.Lname neq ''>
	      		AND lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND email like '#arguments.Email#%'
	      	</cfif>
			<cfif arguments.fromDate neq ''>
				AND datestamp >= '#dateFormat(arguments.fromDate)#'
			</cfif>
			<cfif arguments.toDate neq ''>
				AND datestamp <= '#dateFormat(arguments.toDate)#'
			</cfif>
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY datestamp desc
	      	</cfif>
	   	</cfquery>
	   	
   		<cfreturn queryconvertforgrid(qAppraisals,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getAppraisalFromId" access="remote" returntype="struct">
	  	
      	<cfargument name="pk_appraisal" type="string" default="">
		
		<cfset var returnStruct = structNew() />
	
		<cfset var qAppraisal='' />

	   	<cfquery name="qAppraisal" datasource="#application.dsource#">
	      	SELECT *
	      	FROM appraisal
			WHERE pk_appraisal = '#arguments.pk_appraisal#'
	   	</cfquery>
		
		<cfloop list="#qAppraisal.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qAppraisal."&idx) />
		</cfloop>

		<cfreturn returnStruct />
		
   	</cffunction>
	
	<cffunction name="editAppraisalsFromForm" access="remote" output="false" returntype="boolean">
	    <cfargument name="pk_appraisal" type="string" default="">
	    <cfargument name="LNAME" type="string" default="">
		<cfargument name="FNAME" type="string" default="">
		<cfargument name="ADDRESS" type="string" default="">
		<cfargument name="CITY" type="string" default="">
		<cfargument name="STATE" type="string" default="">
		<cfargument name="ZIP" type="string" default="">
		<cfargument name="EMAIL" type="string" default="">
		<cfargument name="PHONE" type="string" default="">
		<cfargument name="BESTTIME" type="string" default="">
		<cfargument name="THISIMAGE" type="string" default="">
		<cfargument name="ARTIST_LNAME" type="string" default="">
		<cfargument name="ARTIST_FNAME" type="string" default="">
		<cfargument name="TITLE" type="string" default="">
		<cfargument name="YEAR" type="string" default="">
		<cfargument name="EDITION" type="string" default="">
		<cfargument name="MEDIUM" type="string" default="">
		<cfargument name="GROUND" type="string" default="">
		<cfargument name="SIZE_UNFRAMED" type="string" default="">
		<cfargument name="SIZE_WITH_FRAME" type="string" default="">
		<cfargument name="CONDITION" type="string" default="">
		<cfargument name="SIGNATURE" type="string" default="">
		<cfargument name="DESCRIPTION" type="string" default="">
		<cfargument name="REASON" type="string" default="">
		<cfargument name="PURCHASED_FROM" type="string" default="">
		<cfargument name="APPRAISAL_WHERE" type="string" default="">
		<cfargument name="APPRAISAL_YEAR" type="string" default="">
		<cfargument name="APPRAISAL_AMOUNT" type="string" default="">
	    
	    <cfset var success = true />
		
	    <cfparam name="cffile.serverfile" default="" />
		<cfif len(arguments.THISIMAGE)>
			<cffile action="UPLOAD" filefield="thisImage" destination="#expandpath('../../../')#appraisal\images" nameconflict="MAKEUNIQUE">
		</cfif>
		
	    	<cftry>
	    
	    	<cfif arguments.pk_appraisal eq ''>
		    	
		    	<cfquery name="addAppraisal" datasource="#application.dsource#"> 
	               INSERT into appraisal
					(	
						LNAME,
						FNAME,
						ADDRESS,
						CITY,
						STATE,
						ZIP,
						EMAIL,
						PHONE,
						BESTTIME,
						IMAGE_NAME,
						ARTIST_LNAME,
						ARTIST_FNAME,
						TITLE,
						YEAR,
						EDITION,
						MEDIUM,
						GROUND,
						GROUNDOTHER,
						SIZE_UNFRAMED,
						SIZE_WITH_FRAME,
						CONDITION,
						SIGNATURE,
						DESCRIPTION,
						REASON,
						PURCHASED_FROM,
						APPRAISAL_WHERE,
						APPRAISAL_YEAR,
						APPRAISAL_AMOUNT
					)
					values
					(
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LNAME#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FNAME#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ADDRESS#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CITY#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.STATE#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ZIP#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.EMAIL#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PHONE#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.BESTTIME#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cffile.serverFile#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ARTIST_LNAME#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ARTIST_FNAME#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.TITLE#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.YEAR#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.EDITION#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.MEDIUM#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.GROUND#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.GROUNDOTHER#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIZE_UNFRAMED#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIZE_WITH_FRAME#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CONDITION#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIGNATURE#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.DESCRIPTION#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.REASON#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PURCHASED_FROM#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.APPRAISAL_WHERE#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.APPRAISAL_YEAR#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.APPRAISAL_AMOUNT#">
					)
	            </cfquery>
		
			
			<cfelse>
			
				<cfquery name="editAppraisals" datasource="#application.dsource#"> 
	                UPDATE appraisal SET 
		                LNAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LNAME#">,
						FNAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FNAME#">,
						ADDRESS = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ADDRESS#">,
						CITY = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CITY#">,
						STATE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.STATE#">,
						ZIP = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ZIP#">,
						EMAIL = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.EMAIL#">,
						PHONE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PHONE#">,
						BESTTIME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.BESTTIME#">,
						<cfif len(arguments.THISIMAGE)>
							IMAGE_NAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cffile.serverFile#">,
						</cfif>
						ARTIST_LNAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ARTIST_LNAME#">,
						ARTIST_FNAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ARTIST_FNAME#">,
						TITLE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.TITLE#">,
						YEAR = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.YEAR#">,
						EDITION = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.EDITION#">,
						MEDIUM = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.MEDIUM#">,
						GROUND = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.GROUND#">,
						GROUNDOTHER = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.GROUNDOTHER#">,
						SIZE_UNFRAMED = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIZE_UNFRAMED#">,
						SIZE_WITH_FRAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIZE_WITH_FRAME#">,
						CONDITION = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CONDITION#">,
						SIGNATURE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SIGNATURE#">,
						DESCRIPTION = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.DESCRIPTION#">,
						REASON = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.REASON#">,
						PURCHASED_FROM = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PURCHASED_FROM#">,
						APPRAISAL_WHERE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.APPRAISAL_WHERE#">,
						APPRAISAL_YEAR = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.APPRAISAL_YEAR#">,
						APPRAISAL_AMOUNT = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.APPRAISAL_AMOUNT#">
	                WHERE pk_appraisal = #arguments.pk_appraisal#
	            </cfquery>
			
			</cfif>
	    
	    			
			<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>
			
		<cfreturn success> 
	        
	</cffunction>
	
	<cffunction name="deleteAppraisal" access="remote">
		<cfargument name="pk_appraisal" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
	
		<cfquery name="deleteAppraisal" datasource="#application.dsource#"> 
           	DELETE from appraisal
            WHERE pk_appraisal = #arguments.pk_appraisal#
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	
</cfcomponent>