<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="ebay">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getEbayResults" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
		<cfargument name="Artist" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">
	
	
		<cfset var qEbay='' />
		
		
	   	<cfquery name="qEbay" datasource="#application.dsource#">
	      	SELECT *
	      	FROM ebay 
			WHERE 0=0
			<cfif arguments.Lname neq ''>
	      		AND lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND email like '#arguments.Email#%'
	      	</cfif>
			<cfif arguments.Artist neq ''>
	      		AND artist like '#arguments.Artist#%'
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
		
		<cfif qEbay.recordcount EQ 0><cfset pagesize = 0 /></cfif>
	   	
   		<cfreturn queryconvertforgrid(qEbay,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getEbay" access="remote" returntype="struct">
		<cfargument name="pk_ebay" type="numeric">
		
		<cfset var returnStruct = structNew() />

		<cfset var qEbay = '' />
		
		<cfquery name="qEbay" datasource="#application.dsource#"> 
           	SELECT * from ebay
            WHERE pk_ebay = #arguments.pk_ebay#
        </cfquery>
		
		<cfset returnStruct.recordset = qEbay />
		
		<cfreturn returnStruct />
	
	</cffunction>
	
	<cffunction name="getEbayUploads" access="remote" returntype="struct">
		<cfargument name="pk_ebay" type="numeric">
		
		<cfset var returnStruct = structNew() />

		<cfset var qEbay = '' />
		
		<cfquery name="qEbayUploads" datasource="#application.dsource#"> 
           	SELECT * from ebay_uploads
            WHERE fk_ebay = #arguments.pk_ebay#
        </cfquery>
		
		<cfset returnStruct.recordset = qEbayUploads />
		
		<cfreturn returnStruct />
	
	</cffunction>
	
	<cffunction name="processEbay" access="remote" returntype="struct">
		<cfargument name="pk_ebay" type="numeric">
		<cfargument name="fname" type="string">
		<cfargument name="lname" type="string">
		<cfargument name="email" type="string">
		<cfargument name="artist" type="string">
		<cfargument name="comments" type="string">
		<cfargument name="ebayFiles" type="string">
		
		<cfset var returnStruct = structNew() />
		<cfset var qEbay = '' />
		
		<cfif arguments.pk_ebay EQ 0>
		
			<cfquery name="addEbay" datasource="#application.dsource#"> 
				INSERT INTO ebay
				(
					fname,
					lname,
					email,
					artist,
					comments,
					datestamp
				)
				values
				(
					'#arguments.fname#',
					'#arguments.lname#',
					'#arguments.email#',
					'#arguments.artist#',
					'#arguments.comments#',
					#createODBCdatetime(now())#
				)
				SELECT @@identity as newId 
			</cfquery>
			
			<cfset returnStruct.ebayId = addEbay.newId />
		
		<cfelse>
		
			<cfquery name="updateEbay" datasource="#application.dsource#"> 
				UPDATE ebay SET
					fname = '#arguments.fname#',
					lname = '#arguments.lname#',
					email = '#arguments.email#',
					artist = '#arguments.artist#',
					comments = '#arguments.comments#',
					datestamp = #createODBCdatetime(now())#
				WHERE pk_ebay = #arguments.pk_ebay#
			</cfquery>
			
			<cfif len(arguments.ebayFiles)>
			
				<cfset ebayUploaddir = "#application.ppath#/ebay_uploads">
				
					<cffile action="upload" nameconflict="makeunique" filefield="ebayFiles" destination="#ebayUploaddir#">
					
					<cfquery name="addEbay" datasource="#application.dsource#"> 
						INSERT INTO ebay_uploads
						(
							fk_ebay,
							serverfile
						)
						values
						(
							#arguments.pk_ebay#,
							'#file.serverfile#'
						)
					</cfquery>

			</cfif>
			
			<cfset returnStruct.ebayId = arguments.pk_ebay />
		
		</cfif>
		
		<cfreturn returnStruct />
	
	</cffunction>
	
		
	<cffunction name="deleteEbay" access="remote">
		<cfargument name="pk_ebay" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
		
			<cfset ebayUploaddir = "#application.ppath#/ebay_uploads">
		
			<cfquery name="qEbayUploads" datasource="#application.dsource#"> 
				SELECT * from ebay_uploads
				WHERE fk_ebay = #arguments.pk_ebay#
			</cfquery>
			
			<cfloop query="qEbayUploads">
				<cffile action="delete" file="#ebayUploaddir#\#serverfile#">
			</cfloop>
		
			<cfquery datasource="#application.dsource#"> 
				DELETE from ebay_uploads
				WHERE fk_ebay = #arguments.pk_ebay#
			</cfquery>
	
			<cfquery datasource="#application.dsource#"> 
				DELETE from ebay
				WHERE pk_ebay = '#arguments.pk_ebay#'
			</cfquery>
		
			<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	<cffunction name="deleteFile" access="remote">
		<cfargument name="uploadId" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
		
			<cfquery name="qEbayUploads" datasource="#application.dsource#"> 
				SELECT * from ebay_uploads
				WHERE pk_ebay_uploads = #arguments.uploadId#
			</cfquery>
			
			<cfset ebayUploaddir = "#application.ppath#/ebay_uploads">
			<cffile action="delete" file="#ebayUploaddir#\#qEbayUploads.serverfile#">
		
			<cfquery name="addEbay" datasource="#application.dsource#"> 
				DELETE from ebay_uploads
				WHERE pk_ebay_uploads = #arguments.uploadId#
			</cfquery>
	
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	
</cfcomponent>