<cfcomponent>
    <cffunction name="updateBanner" access="remote" output="false" returntype="struct">
        <cfargument name="id" type="numeric" required="true">
        <cfargument name="bannerName" type="string" required="true">
        <cfargument name="bannerType" type="string" required="true">
        <cfargument name="bannerImage" type="file" required="false">
    
        <cfset var result = {} />
        <cfset var fileupload = {} />
        <cfset var path = "" />
        <cfset var fileName = "" />
    
        <cftry>
            <!--- Validate inputs --->
            <cfif len(arguments.bannerName) EQ 0>
                <cfthrow message="Banner Name is required." />
            </cfif>
            <cfif len(arguments.bannerType) EQ 0>
                <cfthrow message="Banner Type is required." />
            </cfif>
            <!--- Update banner details in the database --->
            <cfquery name="qUpdateData" datasource="#application.dsource#">
                UPDATE banners
                SET
                    bannerName = <cfqueryparam value="#arguments.bannerName#" cfsqltype="cf_sql_varchar">,
                    bannerType = <cfqueryparam value="#arguments.bannerType#" cfsqltype="cf_sql_varchar">
                WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
            </cfquery>
    
        
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
                    <cfset fileName = fileupload.CLIENTFILE />\
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
            <cfset result.success = true />
            <cfset result.message = "Banner updated successfully." />
    
            <cfcatch>
                <!--- Handle errors and return error message --->
                <cfset result.success = false />
                <cfset result.message = "Error updating banner: #cfcatch.message#" />
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

<cffunction name="deleteEmployee" access="remote" output="false" returntype="boolean">
    <cfargument name="id" type="string" required="true">
    
    <cfset var success = true />
    
    <cftry>
        <!--- Check if the ID is provided --->
        <cfif arguments.id neq ''>
            <cfquery name="deleteFilterData" datasource="#application.dsource#">
                DELETE FROM banners
                WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
            </cfquery>
        </cfif>
        <cfcatch type="any">
            <cfset success = false />
        </cfcatch>
    </cftry>
    
    <!--- Returning true if the execution reaches this point --->
    <cfreturn success>
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
        <cfelse>
            
            <cfset returnStruct.message = "No data found for the given ID." />
        </cfif>
        
        <cfreturn returnStruct />
    </cffunction>

</cfcomponent>
