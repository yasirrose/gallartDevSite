<cfcomponent>
        <cffunction name="addFilterRecord" access="remote" output="false" returntype="struct">
            <cfargument name="id" type="string" default="">
            <cfargument name="filterName" type="string" required="true">
            <cfargument name="filterType" type="string" required="true">
            
            <cfset var result = structNew()>
            <cfset result.success = false>
            <cfset result.message = "">
    
            <cftry>
                <!-- Check if the filterName and filterType combination already exists -->
                <cfquery name="checkExisting" datasource="#application.dsource#">
                    SELECT id
                    FROM filterOption
                    WHERE filterName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.filterName#">
                      AND filterType = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.filterType#">
                      <cfif arguments.id neq "">
                          AND id != <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
                      </cfif>
                </cfquery>
    
                <!-- If no existing records found, proceed with insert or update -->
                <cfif checkExisting.recordCount EQ 0>
                    <cfif arguments.id eq "">
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
                        <cfset result.message = "Record added successfully.">
                    <cfelse>
                        <cfquery name="updateFilterData" datasource="#application.dsource#">
                            UPDATE filterOption SET 
                                filterName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.filterName#">,
                                filterType = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.filterType#">
                            WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
                        </cfquery>
                        <cfset result.message = "Record updated successfully.">
                    </cfif>
                    <cfset result.success = true>
                <cfelse>
                    <cfset result.message = "The combination of Filter Name and Filter Type already exists.">
                </cfif>
                <cfcatch type="any">
                    <cfset result.success = false>
                    <cfset result.message = "An error occurred: #cfcatch.message#">
                </cfcatch>
            </cftry>
    
            <cfreturn result>
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
                    DELETE FROM filterOption
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
    

        <!--- <cffunction name="getFilterRecord" access="remote">
            <cfquery name="getFilterData" datasource="#application.dsource#">
                SELECT * FROM filterOption
            </cfquery>
        </cffunction> --->

        <cffunction name="getFilterRecord" access="remote">
	  	
            <cfargument name="page" required="yes">
            <cfargument name="pageSize" required="yes">
            <cfargument name="gridsortcolumn" required="yes">
            <cfargument name="gridsortdirection" required="yes">
            <cfargument name="searchLname" required="no" type="string" default="">
          
      
          <cfset var qEmployees='' />
  
             <cfquery name="qEmployees" datasource="#application.dsource#">
                SELECT * 
                FROM filterOption 
              
              WHERE 0=0
              <cfif arguments.searchLname neq ''>
                    AND filterName like '#arguments.searchLname#%'
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
                FROM filterOption
                WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#">
            </cfquery>
            
            <cfif qfilterdata.RecordCount GT 0>
                <cfset returnStruct.filterName = qfilterdata.filterName[1] />
                <cfset returnStruct.filterType = qfilterdata.filterType[1] />
            <cfelse>
                
                <cfset returnStruct.message = "No data found for the given ID." />
            </cfif>
            
            <cfreturn returnStruct />
        </cffunction>

</cfcomponent>
