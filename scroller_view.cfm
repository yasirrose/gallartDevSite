<cfquery name="data" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
	SELECT top 25 uid,imageurl FROM PRODUCTS
	WHERE  Active = 1
	and imageurl is not null and imageurl <> ''
	order by newid()
</cfquery>

<CFIF NOT IsDefined("Application.image_info")>

<cfsavecontent variable="image_info">

	<cfoutput query="data">
	<a href="item.cfm?pid=#uid#&xss=#xss#"><img src="#imageurl#" alt="" border="0" height="75" /></a>
	</cfoutput>

</cfsavecontent>

<CFLOCK SCOPE="Application" TYPE="Exclusive" TIMEOUT=3000>
	<CFSET Application.image_info = image_info>
</CFLOCK>

</cfif>

<style type="text/css">
marquee { width: 100%; padding: 5px; height: 75px; }
marquee img { border: 1px solid #ffffff;  filter:progid:DXImageTransform.Microsoft.Alpha(opacity=80); -moz-opacity: .8; }
marquee img:hover { border: 1px solid #000000; filter:progid:DXImageTransform.Microsoft.Alpha(opacity=100); -moz-opacity: 1; }
</style>
<script>
 function scrollit() {
	document.getElementById('scroller').innerHTML = '<marquee id="marquee" onmouseover="this.stop()" onmouseout="this.start()" scrollAmount="4">'+document.getElementById('scroller').innerHTML+'</marquee>';
	document.getElementById('marquee').start()
}
</script>

<div id="scroller">
	<cfoutput>#Application.image_info#</cfoutput>
</div>

<script language="JavaScript">
	scrollit();
</script>
