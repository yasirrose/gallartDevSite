<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="events">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="getEvents" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
	
	
		<cfset var qEvents='' />

	   	<cfquery name="qEvents" datasource="#application.dsource#">
	      	SELECT *
	      	FROM  event_registration_title 
		
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY event_date desc
	      	</cfif>
	   	</cfquery>
	   	
   		<cfreturn queryconvertforgrid(qEvents,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getEvent" access="remote" returntype="struct">
	  	
      	<cfargument name="pk_event_registration_title" type="string" default="">
		
		<cfset var returnStruct = structNew() />
	
		<cfset var qEvent='' />

	   	<cfquery name="qEvent" datasource="#application.dsource#">
	      	SELECT *
	      	FROM event_registration_title
			WHERE pk_event_registration_title = '#arguments.pk_event_registration_title#'
	   	</cfquery>

		<cfset returnStruct.isCurrent = qEvent.isCurrent />
		
		<cfreturn returnStruct />
		
   	</cffunction>
	
	
	<cffunction name="editEventsFromForm" access="remote" output="false" returntype="boolean">
	    <cfargument name="pk_event_registration_title" type="string" default="">
	    <cfargument name="event_title" type="string" default="">
		<cfargument name="event_date" type="string" default="">
		<cfargument name="event_location" type="string" default="">
		<cfargument name="isCurrent" type="string" default="">
		
		
	    
	    <cfset var success = true />
		
		
	    	<cftry>
	    
	    	<cfif arguments.pk_event_registration_title eq ''>
		    	
		    	<cfquery name="addRegistrationTitle" datasource="#application.dsource#"> 
	               INSERT into event_registration_title
					(	
						event_title,
						event_date,
						event_location,
						isCurrent
					)
					values
					(
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.event_title#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.event_date#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.event_location#">,
						<cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#iif(len(arguments.isCurrent),DE('1'),DE('0'))#">
					)
					SELECT @@identity as uid 
	            </cfquery>
		
				<cfset thisId =  addRegistrationTitle.uid />
			
			<cfelse>
			
				<cfquery name="editRegistrationTitle" datasource="#application.dsource#"> 
	                UPDATE event_registration_title SET 
		                event_title = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.event_title#">,
						event_date = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.event_date#">,
						event_location = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.event_location#">,
						isCurrent = <cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#iif(len(arguments.isCurrent),DE('1'),DE('0'))#">
	                WHERE pk_event_registration_title = #arguments.pk_event_registration_title#
	            </cfquery>
				
				<cfset thisId =  arguments.pk_event_registration_title />
			
			</cfif>
			
			<cfif len(arguments.isCurrent)>
				<cfquery datasource="#application.dsource#"> 
	               UPDATE  event_registration_title SET
				   isCurrent = 0
				   WHERE pk_event_registration_title <> #thisId#
	            </cfquery>
			</cfif>
	    			
			<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry> 
			
		<cfreturn success> 
	        
	</cffunction>

	<cffunction name="deleteEvent" access="remote">
		<cfargument name="pk_event_registration_title" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
	
		<cfquery name="deleteRegistrationTitle" datasource="#application.dsource#"> 
           	DELETE from event_registration_title
            WHERE pk_event_registration_title = #arguments.pk_event_registration_title#
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	<cffunction name="getRegistrations" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
		<cfargument name="EventTitle" required="no" type="string" default="">
		<cfargument name="fromDate" required="no" type="string" default="">
		<cfargument name="toDate" required="no" type="string" default="">
	
	
		<cfset var qRegistrations='' />

	   	<cfquery name="qRegistrations" datasource="#application.dsource#">
	      	SELECT ER.datestamp as regdate,*
	      	FROM event_registration ER
			INNER JOIN event_registration_title ERT 
			ON ER.fk_event_registration_title = ERT.pk_event_registration_title
			WHERE 0=0
			<cfif arguments.Lname neq ''>
	      		AND ER.lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq ''>
	      		AND ER.email like '%#arguments.Email#%'
	      	</cfif>
			<cfif arguments.EventTitle neq ''>
	      		AND ERT.event_title like '%#arguments.EventTitle#%'
	      	</cfif>
			<cfif arguments.fromDate neq ''>
				AND ER.regdate >= '#dateFormat(arguments.fromDate)#'
			</cfif>
			<cfif arguments.toDate neq ''>
				AND ER.regdate <= '#dateFormat(arguments.toDate)#'
			</cfif>
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY ER.regdate desc
	      	</cfif>
	   	</cfquery>
	   	
   		<cfreturn queryconvertforgrid(qRegistrations,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getRegistration" access="remote" returntype="struct">
	  	
      	<cfargument name="pk_event_registration" type="string" default="">
		
		<cfset var returnStruct = structNew() />
	
		<cfset var qRegistration='' />

	   	<cfquery name="qRegistration" datasource="#application.dsource#">
	      	SELECT *
	      	FROM event_registration
			WHERE pk_event_registration = '#arguments.pk_event_registration#'
	   	</cfquery>
		
		<cfloop list="#qRegistration.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qRegistration."&idx) />
		</cfloop>

		<cfreturn returnStruct />
		
   	</cffunction>
	
	
	<cffunction name="editRegistrationsFromForm" access="remote" output="false" returntype="boolean">
	    <cfargument name="pk_event_registration" type="string" default="">
	    <cfargument name="LNAME" type="string" default="">
		<cfargument name="FNAME" type="string" default="">
		<cfargument name="ADDRESS1" type="string" default="">
		<cfargument name="CITY" type="string" default="">
		<cfargument name="STATE" type="string" default="">
		<cfargument name="ZIP" type="string" default="">
		<cfargument name="COUNTRY" type="string" default="">
		<cfargument name="PRIMARY_PHONE" type="string" default="">
		<cfargument name="SECONDARY_PHONE" type="string" default="">
		<cfargument name="EMAIL" type="string" default="">
		<cfargument name="ART_INTERESTED" type="string" default="">
		<cfargument name="OTHER_ARTIST" type="string" default="">
		<cfargument name="NUMBER_PEOPLE" type="string" default="">

	    
	    <cfset var success = true />
		
	    	<cftry>
	    
	    	<cfif arguments.pk_event_registration eq ''>
		    	
		    	<cfquery name="addRegistration" datasource="#application.dsource#"> 
	               INSERT into event_registration
					(	
						LNAME,
						FNAME,
						ADDRESS1,
						ADDRESS2,
						CITY,
						STATE,
						ZIP,
						COUNTRY,
						PRIMARY_PHONE,
						SECONDARY_PHONE,
						EMAIL,
						ART_INTERESTED,
						OTHER_ARTIST,
						NUMBER_PEOPLE
					)
					values
					(
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LNAME#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FNAME#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ADDRESS1#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ADDRESS2#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CITY#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.STATE#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ZIP#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.COUNTRY#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PRIMARY_PHONE#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SECONDARY_PHONE#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.EMAIL#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ART_INTERESTED#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.OTHER_ARTIST#">,
						<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NUMBER_PEOPLE#">
					)
	            </cfquery>
		
			
			<cfelse>
			
				<cfquery name="editRegistrations" datasource="#application.dsource#"> 
	                UPDATE event_registration SET 
		                LNAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.LNAME#">,
						FNAME = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.FNAME#">,
						ADDRESS1 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ADDRESS1#">,
						ADDRESS2 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ADDRESS2#">,
						CITY = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.CITY#">,
						STATE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.STATE#">,
						ZIP = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ZIP#">,
						COUNTRY = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.COUNTRY#">,
						PRIMARY_PHONE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.PRIMARY_PHONE#">,
						SECONDARY_PHONE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SECONDARY_PHONE#">,
						EMAIL = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.EMAIL#">,
						ART_INTERESTED = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ART_INTERESTED#">,
						OTHER_ARTIST = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.OTHER_ARTIST#">,
						NUMBER_PEOPLE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NUMBER_PEOPLE#">
	                WHERE pk_event_registration = #arguments.pk_event_registration#
	            </cfquery>
			
			</cfif>
	    
	    			
			<cfcatch type="any"><cfset success = false /></cfcatch>
			</cftry>
			
		<cfreturn success> 
	        
	</cffunction>
	
	<cffunction name="deleteRegistration" access="remote">
		<cfargument name="pk_event_registration" type="string" default="">
		
		<cfset var success = true />
		
		<cftry>
	
		<cfquery name="deleteRegistration" datasource="#application.dsource#"> 
           	DELETE from event_registration
            WHERE pk_event_registration = #arguments.pk_event_registration#
        </cfquery>
		
		<cfcatch type="any"><cfset success = false /></cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>
	
	
</cfcomponent>