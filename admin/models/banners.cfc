<cfcomponent>
    <cffunction name="updateBanner" access="remote" output="false" returntype="struct">
        <cfargument name="id" type="string" default="">
        <cfargument name="bannerName" type="string" default="">
        <cfargument name="bannerType" type="string" default="">
        <cfargument name="bannerImage" type="string" default="">
        <cfargument name="bannerImagesUrl" type="string" default="">
        
        <!--- <cfdump var="#arguments#" abort="true"> --->

        
        <cfset var fileupload = {} />
        <cfset var path = "" />
        <cfset var fileName = "" />

        <cfset var result = { success = true, message = "" }>
    
        <cftry>
            
            <cfif arguments.id eq ''>

                <cfquery name="qSaveData" datasource="#application.dsource#">
                    INSERT INTO banners (
                        bannerName,
                        bannerImagesUrl,
                        bannerType,
                        active
                    )
                    VALUES (
                        <cfqueryparam value="#form.bannerName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.bannerImagesUrl#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.bannerType#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#form.active#" cfsqltype="cf_sql_varchar">
                    )
                    SELECT @@identity as newId
                </cfquery>
                <cfset thisId = qSaveData.newId />

                <cfset moduleName = 'Banners Module'>
                <cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
                <cfset date = now()>				
                <cfset action = 'Insert'>

                <cfquery name="addLog" datasource="#application.dsource#" >
                    INSERT INTO logs 
                        ( moduleName, ipAddress, date, action)
                        VALUES
                        ( '#moduleName#', '#ipAddress#', #date#, '#action#')
                </cfquery>

                <cfset result.success = true>
    			<cfset result.message = "Banners added successfully.">

             <cfelse>

                <cfquery name="qUpdateData" datasource="#application.dsource#">
                    UPDATE banners
                    SET
                        bannerName = <cfqueryparam value="#arguments.bannerName#" cfsqltype="cf_sql_varchar">,
                        bannerType = <cfqueryparam value="#arguments.bannerType#" cfsqltype="cf_sql_varchar">,
                        bannerImagesUrl = <cfqueryparam value="#arguments.bannerImagesUrl#" cfsqltype="cf_sql_varchar">,
                        active = <cfqueryparam value="#arguments.active#" cfsqltype="cf_sql_varchar">
                    WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
                </cfquery>

                <cfset moduleName = 'Banners Module'>
                <cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
                <cfset date = now()>				
                <cfset action = 'Update'>

                <cfquery name="addLog" datasource="#application.dsource#" >
                    INSERT INTO logs 
                        ( moduleName, ipAddress, date, action)
                        VALUES
                        ( '#moduleName#', '#ipAddress#', #date#, '#action#')
                </cfquery>

                <cfset result.success = true>
    			<cfset result.message = "Banners Updated successfully.">

            </cfif>
              
        
            <!--- Handle image upload if a file is provided --->
            <cfif isDefined("arguments.bannerImage") AND len(arguments.bannerImage)>
                <cfset path = "#application.ppath#/images/banners/" />
                <cffile 
                    action="upload" 
                    nameconflict="overwrite" 
                    filefield="bannerImage" 
                    destination="#path#" 
                    result="fileupload">
                    <cfdump var="#fileupload#" />
                      
                    

                <cfif fileupload.fileWasSaved>
                    <cfset fileName = fileupload.CLIENTFILE />
                    <!--- Update banner image path in the database --->
                    <cfquery name="qUpdateImage" datasource="#application.dsource#">
                        UPDATE banners
                        SET bannerImage = <cfqueryparam value="#fileName#" cfsqltype="cf_sql_varchar">
                        WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
                    </cfquery>
                <cfelse>
                    <cfset result.success = false />
                    <cfset result.message = "File upload failed. Please check the file and try again." />
                    <cfreturn result />
                </cfif>
            </cfif>
    
            <!--- Return success message --->
            
    
            <cfcatch>
                <!--- Handle errors and return error message --->
                <cfset result.success = false />
                <cfset result.message = cfcatch.detail />
            </cfcatch>
        </cftry>
        
        <cfreturn result />
    </cffunction>
    

<!--- <cffunction name="addFilterRecord" access="remote" output="false" returntype="boolean">
    <cfargument name="id" type="string" default="">
    <cfargument name="filterName" type="string" default="">
    <cfargument name="filterType" type="string" default="">

    

    <cfset var success = true />

    <cftry>
        <cfif arguments.id eq ''>
            <cfquery name="addFilterData" datasource="#application.dsource#">
                INSERT INTO filterOption (
                    filterName, 
                    filterType
                ) 
                VALUES (
                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.filterName#">,
                    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.filterType#">
                )
            </cfquery>
        <cfelse>
            <cfquery name="updateFilterData" datasource="#application.dsource#">
                UPDATE filterOption SET 
                    filterName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.filterName#">,
                    filterType = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.filterType#">
                WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
            </cfquery>

            <!--- <cfquery name="deleteFilterData" datasource="#application.dsource#"> 
                DELETE from filterOption
                WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
            </cfquery> --->

        </cfif>
        <cfcatch type="any"><cfset success = false /></cfcatch>
    </cftry>
    
    <!--- Returning true if the execution reaches this point --->
    <cfreturn success>
</cffunction> --->

<cffunction name="deleteEmployee" access="remote" output="false" returntype="struct">
    <cfargument name="id" type="string" required="true">

    <!--- <cfdump var="test delete" abort="true"> --->
    
    <!--- <cfset var success = true /> --->

    <cfset var result = { success = true, message = "" }>
    
    <cftry>
        <!--- Check if the ID is provided --->
        <cfif arguments.id neq ''>
            <cfquery name="deleteFilterData" datasource="#application.dsource#">
                DELETE FROM banners
                WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
            </cfquery>
            
            <cfset moduleName = 'Banner Module'>
            <cfset ipAddress = CGI.HTTP_X_FORWARDED_FOR>
            <cfset date = now()>				
            <cfset action = 'Delete'>

            <cfquery name="addLog" datasource="#application.dsource#" >
                INSERT INTO logs 
                    ( moduleName, ipAddress, date, action)
                    VALUES
                    ( '#moduleName#', '#ipAddress#', #date#, '#action#')
            </cfquery>

            <cfset result.success = true>
    		<cfset result.message = "Record is Deleted successfully.">

        </cfif>
        <cfcatch type="any">
            <!--- <cfset success = false /> --->
            <cfset result.success = false>
            <cfset result.message = cfcatch.detail>
        </cfcatch>
    </cftry>
    
    <!--- Returning true if the execution reaches this point --->
    <cfreturn result>
</cffunction>


    <!--- <cffunction name="getBannerRecord" access="remote">
        <cfquery name="getFilterData" datasource="#application.dsource#">
            SELECT * FROM filterOption
        </cfquery>
    </cffunction> --->

    <cffunction name="getBannerRecord" access="remote">
      
        <cfargument name="page" required="yes">
        <cfargument name="pageSize" required="yes">
        <cfargument name="gridsortcolumn" required="yes">
        <cfargument name="gridsortdirection" required="yes">
        <cfargument name="searchLname" required="no" type="string" default="">
      
  
      <cfset var qEmployees='' />

         <cfquery name="qEmployees" datasource="#application.dsource#">
            SELECT * 
            FROM banners 
          
          WHERE 0=0
          <cfif arguments.searchLname neq ''>
                AND bannerName like '#arguments.searchLname#%'
            </cfif>
        
          
          
            <cfif gridsortcolumn neq ''>
                ORDER BY #gridsortcolumn# #gridsortdirection#
          <cfelse>
              ORDER BY id DESC
            </cfif>
         </cfquery>
         
         
         <cfreturn queryconvertforgrid(qEmployees,page,pagesize)/>
  
     </cffunction>

     <!--- <cffunction name="getFilterdataFromID" access="remote" returntype="struct">
        <cfargument name="id" type="numeric">
        <cfdump var="test">
        <cfdump var="#arguments.id#" >
        
        <cfset var returnStruct = structNew() />

        <!--- <cfset var qfilterdata = '' />
        <cfset var qEmployeeRoles = '' /> --->
        
        <cfquery name="qfilterdata" datasource="#application.dsource#"> 
               SELECT * from filterOption
            WHERE id = #arguments.id#
        </cfquery>
    
       
        
        <!--- <cfset returnStruct.emp_email = qEmployee.emp_email />
        <cfset returnStruct.roles = valueList(qEmployeeRoles.fk_roles) /> --->
        
        <cfreturn true />
    
    </cffunction> --->

    <cffunction name="getFilterdataFromID" access="remote" returntype="struct">
        <cfargument name="id" type="numeric" required="true">
        
        <cfset var returnStruct = structNew() />
        
        <cfquery name="qfilterdata" datasource="#application.dsource#">
            SELECT * 
            FROM banners
            WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
        </cfquery>
        
        <cfif qfilterdata.RecordCount GT 0>
            <cfset returnStruct.bannerName = qfilterdata.bannerName[1] />
            <cfset returnStruct.bannerType = qfilterdata.bannerType[1] />
            <cfset returnStruct.bannerImage = qfilterdata.bannerImage[1] />
            <cfset returnStruct.bannerActive = qfilterdata.active[1] />
        <cfelse>
            
            <cfset returnStruct.message = "No data found for the given ID." />
        </cfif>
        
        <cfreturn returnStruct />
    </cffunction>

</cfcomponent>
