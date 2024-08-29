<!--- 6598 --->

<cfparam name="url.startRow" default="6598" />
<cfset startRow = url.startRow />

<cfpop 
  server = "#application.email_server#"
  username = "info@onlinegalleryart.us"
  password = "#application.email_password#"
  action = "GETALL"
  name = "popmail"
  timeout = "120"
  startRow = "#startRow#"
  generateUniqueFilenames = "no" maxrows="10">
  
  <cfdump var="#popmail#"><cfabort>

 <cfif len(popmail.recordcount)>
 <cfoutput query="popmail">
	 	
	<cfif left(from,13) EQ 'MAILER-DAEMON'>
		<cfset pointer1 = find('The mail system',TEXTBODY) />
		<cfset pointer2 = findnocase(': host',TEXTBODY) />
		<cfset stringLength = pointer2 - pointer1 - 21 />
		
		<cfif stringLength GT 0>
			<cfset emailAddress = mid(TEXTBODY,pointer1+20,stringLength) />
			<cfquery name="insertEmail" datasource="#application.dsource#">
				INSERT into email_undeliverables
				(messagenumber,email)
				values
				(#messagenumber#,'#emailAddress#')
			</cfquery>
			<cfset nextMessagenumber = messagenumber + 1 />
		
		</cfif>
			
	</cfif>
 </cfoutput>
 
 <cfelse>
 
 DONE
 
 </cfif>
 
<cflocation url="email_pop.cfm?startRow=#nextMessagenumber#" addtoken="No" />