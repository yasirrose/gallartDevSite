<!--- include main top layout --->
 <!--- <cfif session.loggedin eq false > --->
    <cfinclude template="../views/layout.top.cfm" />

<!--- get the Action from the event --->
    <cfset Action = listlast(URL.event, '.') />

    <cfset ViewPath = "../views/login" />
    
    <cfif session.loggedin EQ true >
        <cflocation url="index.cfm?event=orders.manage" addtoken="No">
    </cfif>
        
    <cfswitch expression="#Action#">

        <cfdefaultcase>

            <cfinclude template="#ViewPath#/index.cfm">
            
        </cfdefaultcase>
        
        <!--- <cfcase value="eventRegistrations">

            <cfinclude template="#ViewPath#/event_registrations.cfm">
            
        </cfcase> --->
        
        
    </cfswitch>

    <!--- include main bottom layout --->
    <cfinclude template="../views/layout.bottom.cfm" />

 <!--- </cfif>    --->

