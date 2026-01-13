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
			AND NOT (
					pk_users BETWEEN 29662 AND 30649
					OR pk_users BETWEEN 15398 AND 29264
					OR pk_users BETWEEN 29423 AND 29660
					OR pk_users BETWEEN 15121 AND 29395
					OR pk_users BETWEEN 14793 AND 29419
				)
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

		<cfset var encryptionKey = "k7vASHylotO9mtMuRTfa2g==">
		
		<cfquery name="qUser" datasource="#application.dsource#"> 
           	SELECT * from users
            WHERE pk_users = #arguments.pk_users#
        </cfquery>
		
		<cfquery name="qListings" datasource="#application.dsource#"> 
           	SELECT * from products
            WHERE fk_users = #arguments.pk_users#
        </cfquery>

		<cfset var decryptedPassword = "">

		 <cfif len(trim(qUser.password))>
			<cftry>
				<!--- Try decrypting (new encrypted records) --->
				<cfset decryptedPassword = decrypt(
					qUser.password,
					encryptionKey,
					"AES",
					"Base64"
				)>
				<cfcatch>
					<!--- Old plain-text passwords --->
					<cfset decryptedPassword = qUser.password>
				</cfcatch>
			</cftry>
		</cfif>
		
		<cfset returnStruct.listings = qListings.recordcount />
		
		<cfloop list="#qUser.ColumnList#" index="idx">
    <cfif ucase(idx) NEQ "PASSWORD">
        <cfset returnStruct[ucase(idx)] = qUser[idx][1] />
    </cfif>
</cfloop>

<cfset returnStruct["PASSWORD"] = decryptedPassword>

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
		<cfargument name="website" type="string" default="">

		<!--- <cfset generatedKey = generateSecretKey("AES")>
		<cfdump var="#generatedKey#" abort="true"> --->

		<cfset var encryptionKey = "k7vASHylotO9mtMuRTfa2g==">

		<cfif len(trim(arguments.password))>
			<cfset encryptedPassword = encrypt(
				arguments.password, encryptionKey, "AES", "Base64"
			)>
		 <cfelse>
			<cfset encryptedPassword = "">
		</cfif>

		<!--- <cfdump var="#arguments#" abort="true"> --->
		<cfset phone = "">
		<cfset cellphone = "">
		<cfset businessphone = "">
		<cfset otherphone = "">

		<cfif len(trim(arguments.phoneNumber))>
			<cfswitch expression="#arguments.phoneType#">
				<cfcase value="Home Phone">
					<cfset phone = arguments.phoneNumber>
				</cfcase>

				<cfcase value="Cell Phone">
					<cfset cellphone = arguments.phoneNumber>
				</cfcase>

				<cfcase value="Business Phone">
					<cfset businessphone = arguments.phoneNumber>
				</cfcase>

				<cfcase value="OutsideUS">
					<cfset otherphone = arguments.phoneNumber>
				</cfcase>
			</cfswitch>
		</cfif>
	    
	    <!--- <cfset var response = 'success' /> --->

		<cfset var result = { response = true, message = "" }>
	    
	    	<cftry>
	    
				<cfif arguments.pk_users eq ''>

					<cfquery name="checkEmail" datasource="#application.dsource#">
						SELECT pk_users FROM users 
						WHERE LOWER(email) = LOWER(<cfqueryparam value="#arguments.seller_email#" cfsqltype="cf_sql_varchar">)
					</cfquery>

					<cfif checkEmail.recordCount GT 0>
						<!--- Email already exists --->
						<!--- <cfset response = "duplicate" />
						<cfreturn response> --->
						<cfset result.success = false>
						<cfset result.message = "Email already exists.">
						<cfreturn result>
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
							password,
							datestamp,
							website
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
							'#encryptedPassword#',
							<cfqueryparam value="#now()#" cfsqltype="CF_SQL_TIMESTAMP" maxlength="100">,
							'#arguments.website#'
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

					<cfset result.success = true>
            		<cfset result.message = "Seller added  successfully.">
				
				 <cfelse>

					<cfquery name="checkEmailUpdate" datasource="#application.dsource#">
						SELECT pk_users 
						FROM users
						WHERE LOWER(email) = LOWER(
							<cfqueryparam value="#arguments.seller_email#" cfsqltype="cf_sql_varchar">
						)
						AND pk_users <> 
							<cfqueryparam value="#arguments.pk_users#" cfsqltype="cf_sql_varchar">
					</cfquery>

					<cfif checkEmailUpdate.recordCount GT 0>
						<cfset result.success = false>
						<cfset result.message = "Email already exists for another user.">
						<cfreturn result>
					</cfif>
				
					<cfquery name="editUser" datasource="#application.dsource#"> 
						UPDATE users SET 
						fname = '#arguments.fname#',
						lname = '#arguments.lname#',
						email = '#arguments.seller_email#',
						phone = '#phone#',
						cellphone = '#cellphone#',
						businessphone = '#businessphone#',
						otherphone = '#otherphone#',
						password = '#encryptedPassword#',
						website = '#arguments.website#',
						datestamp = <cfqueryparam value="#now()#" cfsqltype="CF_SQL_TIMESTAMP" maxlength="100">
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

					<cfset result.success = true>
            		<cfset result.message = "Seller updated successfully.">
				
				</cfif>
	    
	    			
				<cfcatch type="any">
					<!--- <cfset response = 'error' /> --->
					<cfset result.success = false>
       				<cfset result.message = cfcatch.detail>
				</cfcatch>
			</cftry>
			
		<cfreturn result> 
	        
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
		      FROM users where fname != 'CXU0VLNWVHP8HBNQQ1MZ0UXC http://google.com/245' and pk_users NOT BETWEEN 29662 AND 30649 and pk_users NOT BETWEEN 15398 and 29264 and pk_users NOT BETWEEN 29423 and 29660 and pk_users NOT BETWEEN 15121 and 29395 and pk_users NOT BETWEEN 14793 and 29419
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
		      FROM users WHERE fname is not null and fname !='' and lname is not null and lname !='' and fname !='?????' and fname !='88952634' and fname != 'CXU0VLNWVHP8HBNQQ1MZ0UXC http://google.com/245' and pk_users NOT BETWEEN 29662 AND 30649 and pk_users NOT BETWEEN 15398 and 29264 and pk_users NOT BETWEEN 29423 and 29660 and pk_users NOT BETWEEN 15121 and 29395 and pk_users NOT BETWEEN 14793 and 29419
		      order by lname, fname
		   </cfquery>
	   
   		<cfreturn qUsers />
	
    </cffunction>
	 

	
</cfcomponent>