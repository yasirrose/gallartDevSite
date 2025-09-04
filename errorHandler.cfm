<cfmail 
    to="tldz.dev12@gmail.com" 
    from="sales@gallart.com" 
    subject="Site Error"
    server="smtp.gmail.com"
    username="Sales@GallArt.com"
    password="ylzwtvepstcsammm"
    port="587"
    useTLS="true">
Event: #error.diagnostics#
Message: #error.message#
Detail: #error.detail#
Template: #error.template#
Browser: #cgi.http_user_agent#
IP: #cgi.remote_addr#
</cfmail>

<!--- <cfset session.errmsg = error.message> --->

<!--- <cfset errorPage = cgi.http_referer>
<cflocation url="/404.cfm?referrer=#URLEncodedFormat(errorPage)#" addtoken="false"> --->

<cflocation url="/404.cfm" addtoken="false">
<cfabort>
