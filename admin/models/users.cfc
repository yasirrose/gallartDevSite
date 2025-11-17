<cfcomponent>
	<!--- initializes the component --->
	<cffunction name="init" access="public" output="No" returntype="users">
		<cfscript>
				return this;
		</cfscript>
	</cffunction>
	

	<cffunction name="getUsers" access="remote">
	  	
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
		<cfargument name="Lname" required="no" type="string" default="">
		<cfargument name="Email" required="no" type="string" default="">
		<cfargument name="Title" required="no" type="string" default="">
		<cfargument name="Artist" required="no" type="string" default="">
		<cfargument name="Listed" required="no" type="string" default="">
	
		<cfset var qUsers='' />
		
		<!--- <cfdump var="#arguments#" abort="true"> --->

	   	<cfquery name="qUsers" datasource="#application.dsource#">
	      	SELECT pk_users,fname,lname,email as seller_email,phone,cellPhone,businessPhone,otherphone,website,password
	      	FROM users U
			LEFT OUTER JOIN products P on U.pk_users = P.fk_users
			WHERE 0=0
			<cfif arguments.Lname neq '' and arguments.Lname neq 'searchLname'>
	      		AND U.lname like '#arguments.Lname#%'
	      	</cfif>
			<cfif arguments.Email neq '' and arguments.Email neq 'searchEmail'>
	      		AND U.email like '#arguments.Email#%'
	      	</cfif>
			<cfif arguments.Title neq '' and arguments.Title neq 'searchTitle'>
				and name like '%#arguments.Title#%'
			</cfif>
			<cfif arguments.Artist neq '' and arguments.Artist neq 'searchArtist'>
				and manufacturer like '%#arguments.Artist#%'
			</cfif>
			<cfif arguments.Listed neq '' and arguments.Listed neq 'searchListed'>
				<cfif arguments.Listed eq 'Yes'>
					AND P.name is not null
				</cfif>
				<cfif arguments.Listed eq 'No'>
					AND P.name is null
				</cfif>
			</cfif>
			GROUP BY pk_users,fname,lname,email,phone,cellPhone,businessPhone,otherphone,website,password
	      	<cfif gridsortcolumn neq ''>
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
			<cfelse>
				ORDER BY pk_users DESC
	      	</cfif>
	   	</cfquery>
	   	
   		<cfreturn queryconvertforgrid(qUsers,page,pagesize)/>
	
   	</cffunction>
	
	<cffunction name="getUserFromId" access="remote" returntype="struct">
		<cfargument name="pk_users" type="numeric">
		
		<cfset var returnStruct = structNew() />

		<cfset var qUser = '' />
		<cfset var qListings = '' />
		
		<cfquery name="qUser" datasource="#application.dsource#"> 
           	SELECT * from users
            WHERE pk_users = #arguments.pk_users#
        </cfquery>
		
		<cfquery name="qListings" datasource="#application.dsource#"> 
           	SELECT * from products
            WHERE fk_users = #arguments.pk_users#
        </cfquery>
		
		<cfset returnStruct.listings = qListings.recordcount />
		
		<cfloop list="#qUser.ColumnList#" index="idx">
			<cfset returnStruct[idx] = evaluate("qUser."&idx) />
		</cfloop>
		
		<cfreturn returnStruct />
	
	</cffunction>
	
	
	<cffunction name="editUserFromGrid" access="remote" output="false">
	    <cfargument name="gridaction">
	    <cfargument name="gridrow">
	    <cfargument name="gridchanged">
	    	     
	    <cfif isStruct(gridrow) and isStruct(gridchanged)>
	        <cfif gridaction eq "U">
	            <cfset colname = structkeylist(gridchanged)>
	            <cfset value = structfind(gridchanged, colname)>
	            <cfquery name="editUser" datasource="#application.dsource#"> 
	                UPDATE users SET 
	                #colname# = '#value#'
	                WHERE pk_users = '#gridrow.pk_users#'
	            </cfquery>
	        <cfelse>
	            <cfquery name="deleteUser" datasource="#application.dsource#"> 
	                DELETE from users 
	                WHERE pk_users = '#gridrow.pk_users#'
	            </cfquery> 
	        </cfif>
	    </cfif>
	</cffunction>

	<cffunction name="editUserFromForm" access="remote" output="false" returntype="any">
	    <cfargument name="pk_users" type="string" default="">
	    <cfargument name="fname" type="string" default="">
	    <cfargument name="lname" type="string" default="">
	    <cfargument name="seller_email" type="string" default="">
		<cfargument name="phone" type="string" default="">
		<cfargument name="password" type="string" default="">
		<cfargument name="moduleName" type="string" default="">

		<!--- <cfdump var="#arguments#" abort="true"> --->

		<cfif len(trim(arguments.phoneNumber)) AND arguments.phoneType EQ "Home Phone">
			<cfset phone = arguments.phoneNumber>
		<cfelse>
			<cfset phone = "">
		</cfif>

		<cfif len(trim(arguments.phoneNumber)) AND arguments.phoneType EQ "Cell Phone">
			<cfset Cellphone = arguments.phoneNumber>
		<cfelse>
			<cfset Cellphone = "">
		</cfif>

		<cfif len(trim(arguments.phoneNumber)) AND arguments.phoneType EQ "Business Phone">
			<cfset businessphone = arguments.phoneNumber>
		<cfelse>
			<cfset businessphone = "">
		</cfif>

		<cfif len(trim(arguments.phoneNumber)) AND arguments.phoneType EQ "OutsideUS">
			<cfset otherphone = arguments.phoneNumber>
		<cfelse>
			<cfset otherphone = "">
		</cfif>
	    
	    <cfset var response = 'success' />
	    
	    	<cftry>
	    
				<cfif arguments.pk_users eq ''>

					<cfquery name="checkEmail" datasource="#application.dsource#">
						SELECT pk_users FROM users 
						WHERE LOWER(email) = LOWER(<cfqueryparam value="#arguments.seller_email#" cfsqltype="cf_sql_varchar">)
					</cfquery>

					<cfif checkEmail.recordCount GT 0>
						<!--- Email already exists --->
						<cfset response = "duplicate" />
						<cfreturn response>
					</cfif>
					
					<cfquery name="addUser" datasource="#application.dsource#"> 
						INSERT into users
						(
							fname,
							lname,
							email,
							phone,
							cellphone,
							businessphone,
							otherphone,
							password
						)
						values
						(
							'#arguments.fname#',
							'#arguments.lname#',
							'#arguments.seller_email#',
							'#phone#',
							'#cellphone#',
							'#businessphone#',
							'#otherphone#',
							'#arguments.password#'
						)
						SELECT @@identity as newId
					</cfquery>

					<cfset thisId = addUser.newId />
					<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
					<cfset date = now()>				
					<cfset action = 'Insert'>

					<cfquery name="addLog" datasource="#application.dsource#" >
						INSERT INTO logs 
							( moduleName, ipAddress, date, action, sellerUser)
							VALUES
							( '#arguments.moduleName#', '#ipAddress#', #date#, '#action#', #thisId#)
					</cfquery>
			
				
				<cfelse>
				
					<cfquery name="editUser" datasource="#application.dsource#"> 
						UPDATE users SET 
						fname = '#arguments.fname#',
						lname = '#arguments.lname#',
						email = '#arguments.seller_email#',
						phone = '#phone#',
						cellphone = '#cellphone#',
						businessphone = '#businessphone#',
						otherphone = '#otherphone#',
						password = '#arguments.password#'
						WHERE pk_users = '#arguments.pk_users#'
					</cfquery>

					<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
					<cfset date = now()>				
					<cfset action = 'Update'>

					<cfquery name="addLog" datasource="#application.dsource#" >
						INSERT INTO logs 
							( moduleName, ipAddress, date, action, sellerUser)
							VALUES
							( '#arguments.moduleName#', '#ipAddress#', #date#, '#action#', '#arguments.pk_users#')
					</cfquery>
				
				</cfif>
	    
	    			
				<cfcatch type="any">
					<cfset response = 'error' />
				</cfcatch>
			</cftry>
			
		<cfreturn response> 
	        
	</cffunction>
	
	<cffunction name="deleteUser" access="remote">
		<cfargument name="pk_users" type="string" default="">
		<cfargument name="moduleName" type="string" default="">
		
		<cfset var success = true />

		<cfset deleteID = arguments.pk_users>
		
		<cftry>
	
			<cfquery name="deleteUser" datasource="#application.dsource#"> 
				DELETE from users WHERE pk_users = '#arguments.pk_users#'
			</cfquery>

			<cfquery name="deleteUserListings" datasource="#application.dsource#">
				DELETE from products WHERE fk_users = '#arguments.pk_users#'
			</cfquery>

			<cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
			<cfset date = now()>				
			<cfset action = 'Delete'>

			<cfquery name="addLog" datasource="#application.dsource#" >
				INSERT INTO logs 
					( moduleName, ipAddress, date, action, sellerUser)
					VALUES
					( '#arguments.moduleName#', '#ipAddress#', #date#, '#action#',#deleteID#)
			</cfquery>
		
			<cfcatch type="any">
				<cfset success = false />
			</cfcatch>
		</cftry>
	
		<cfreturn success />
	
	</cffunction>

	<cffunction name="getAllUsers" access="remote">
      	<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
      	<cfargument name="gridsortcolumn" required="yes">
      	<cfargument name="gridsortdirection" required="yes">
	
		<cfset var qUsers='' />

		   <cfquery name="qUsers" datasource="#application.dsource#">
		      SELECT *
		      FROM users where fname != 'CXU0VLNWVHP8HBNQQ1MZ0UXC http://google.com/245'
		      <cfif gridsortcolumn neq "" or gridsortdirection neq ""> 
		      order by #gridsortcolumn# #gridsortdirection#
		      </cfif>
		   </cfquery>
	   
   		<cfreturn queryconvertforgrid(qUsers,page,pagesize)/>
	
   </cffunction>

	<cffunction name="findEmail" access="remote" returntype="boolean">
      <cfargument name="email" required="yes">
	
		<cfset var found = false />

	   <cfquery name="qUsers" datasource="#application.dsource#">
	      SELECT *
	      FROM users
	      WHERE email = '#arguments.email#'
	   </cfquery>

		<cfif qUsers.recordcount>
			<cfset found = true />
		</cfif>

   		<cfreturn found />
   
	</cffunction>
	

	
	<cffunction name="lookupUsers" access="remote" returntype="string">
    	<cfargument name="search" type="any" required="false" default="">

		<!--- Do search --->
		<cfquery datasource="#application.dsource#" name="data">
			SELECT email
			FROM users
			WHERE email LIKE '#ARGUMENTS.search#%'
			ORDER BY email
		</cfquery>
		<!--- And return it --->
   		<cfreturn ValueList(data.email)>
   </cffunction> 



	<cffunction name="findUsers" access="remote">
		<cfargument name="role" type="string">
		
		<cfset var qUsers='' />
	
	   <cfquery name="qUsers" datasource="#application.dsource#">
	      SELECT *
	      FROM users
		  WHERE roles like '%#arguments.role#%'		
	   </cfquery>
	   <cfreturn qUsers/>
	 </cffunction>
	 
	 
	 <cffunction name="getUsersListings" access="remote" returntype="query">
	
		<cfset var qUsers='' />

		   <cfquery name="qUsers" datasource="#application.dsource#">
		      SELECT lname +', '+ fname  as full_seller_name,*
		      FROM users WHERE fname is not null and fname !='' and lname is not null and lname !='' and fname !='?????' and fname !='88952634' and fname != 'CXU0VLNWVHP8HBNQQ1MZ0UXC http://google.com/245' 
		      order by lname, fname
		   </cfquery>
	   
   		<cfreturn qUsers />
	
   </cffunction>
	 

	
</cfcomponent>