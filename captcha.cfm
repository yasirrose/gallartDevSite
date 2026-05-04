<cfsetting enablecfoutputonly="yes">
<cfcontent reset="true" type="image/png">

<!--- Generate random CAPTCHA text --->
<cfset strCaptcha = "">

<cfloop from="1" to="6" index="i">
    <cfset charType = RandRange(1,2)>
    <cfif charType EQ 1>
        <cfset strCaptcha &= RandRange(0,9)>
    <cfelse>
        <cfset strCaptcha &= Chr(RandRange(65,90))>
    </cfif>
</cfloop>

<!--- Store it in session for later verification --->
<cfset session.captcha = strCaptcha>

<!--- Output the CAPTCHA image --->
<cfimage 
    action="captcha" 
    width="250" 
    height="60" 
    text="#strCaptcha#" 
    difficulty="medium" 
    fontsize="32"
/>
