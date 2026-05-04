
<cfif isDefined("form.upload")>
    <cftry>
        <cffile action="upload" 
                destination="#ExpandPath('/img/ck-editor/')#" 
                filefield="upload"
                nameconflict="makeunique"
                result="uploadResult">
        
        <cfoutput>
            <cfset result = { 
                "uploaded": true, 
                "url": "/img/ck-editor/#uploadResult.serverFile#" 
            }>
            <cfcontent type="application/json">
            <cfoutput>#serializeJSON(result)#</cfoutput>
        </cfoutput>
        
        <cfcatch>
            <cfoutput>
                <cfset result = { 
                    "uploaded": false, 
                    "error": { 
                        "message": "#cfcatch.message#" 
                    } 
                }>
                <cfcontent type="application/json">
                <cfoutput>#serializeJSON(result)#</cfoutput>
            </cfoutput>
        </cfcatch>
    </cftry>
</cfif>

