<!--- Check that fieldnames exists --->
<cfif #ParameterExists(FORM.fieldnames)#>
<!--- Create empty list of processed variables --->
<cfset #fieldnames_processed# = "">
<!--- Loop through fieldnames --->
<cfloop index ="form_element" LIST="#FORM.fieldnames#">
<!--- Process only option elements --->
<cfif form_element is "option">
<!--- Try to find current element in list --->
<cfif #ListFind(#fieldnames_processed#, #form_element#)# IS 0>
<!--- Make fully qualified copy of it (to prevent acessing the wrong field type) --->
<cfset #form_element_qualified# = "FORM." & #form_element#>
<!--- Loop through option list --->
<cfset opt_name="">
<cfset opt_value="">
<cfloop index="val" list="#Evaluate(form_element_qualified)#" delimiters="||">
<cfif opt_name is "">
<!--- Parse individual option names --->
<cfset opt_name="#Trim(GetToken(val,1,","))#">
<cfset opt_value="#Trim(Replace(RemoveChars(val,1,len(opt_name)),",",""))#">
<cfelse>
<cfset opt_name=opt_name&","&"#Trim(GetToken(val,1,","))#">
<cfset opt_value=opt_value&","&"#Trim(Replace(RemoveChars(val,1,len((GetToken(val,1,",")))),",",""))#">
</cfif>
</cfloop> 
<!--- And add it to the processed list --->
<cfset #fieldnames_processed# = #ListAppend(#fieldnames_processed#, #form_element#)#>
</cfif>
</cfif>
</cfloop>
</cfif>
