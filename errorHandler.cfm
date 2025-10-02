<cfmail 
    to="tldz.dev12@gmail.com" 
    from="sales@gallart.com" 
    subject="Site Error"
    server="smtp.gmail.com"
    username="Sales@GallArt.com"
    password="ylzwtvepstcsammm"
    port="587"
    useTLS="true">
Event: #error.diagnostics# <br>
Message: #error.message# <br>
Detail: #error.detail# <br>
Template: #error.template# <br>
Browser: #cgi.http_user_agent# <br>
IP: #cgi.remote_addr#
</cfmail>

<!--- <cfset session.errmsg = error.message> --->

<!--- <cfset errorPage = cgi.http_referer>
<cflocation url="/404.cfm?referrer=#URLEncodedFormat(errorPage)#" addtoken="false"> --->

<cflocation url="/404.cfm" addtoken="false">
<cfabort>
