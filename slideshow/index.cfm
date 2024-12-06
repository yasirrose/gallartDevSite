<cfoutput>
<script language="JavaScript">
	function goxss(url){
		parent.document.frmxss.action = url;
		parent.document.frmxss.submit();
	}
</script>
</cfoutput>

<cfif isDefined("url.pid")>
  <cfquery name="listings" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT top 100 *
    FROM products
      WHERE manufacturer  = '#url.artist#'
      AND active = 1
      AND uid <> #url.pid#
  </cfquery>
<cfelse>
  <cfquery name="listings" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT top 100 *
    FROM products
      WHERE 0=1
  </cfquery>
</cfif>



<cfif listings.recordcount GT 0>
    <!-- include the Tools -->
  <script src="scripts/jquery.tools.js"></script>


  <!--<link rel="stylesheet" type="text/css" href="css/standalone.css"/>-->

  <link rel="stylesheet" type="text/css" href="css/tabs-slideshow.css"/>
<!--
   fix IE "black box" problems with PNG images when opacity is being animated
-->
<!--[if IE]>
<style type="text/css">
  .images img {
    background:#efefef url(http://jquerytools.org/media/img/gradient/h300.png) repeat-x 0 -22px;
  }
</style>
<![endif]-->
<div id="slideshowTitle"> SLIDE SHOW </div>
<!-- "previous slide" button -->
<a class="backward">prev</a>

<!-- container for the slides -->
<div class="images">
<cfoutput query="listings">
<cfif listlen(manufacturer) gt 1>
	<cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
    <cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" />
    <cfset artist_name_alt = "#listlast(manufacturer)# #listfirst(manufacturer)#" />
<cfelse>
    <cfset artist_name = manufacturer />
    <cfset artist_name_url = manufacturer />
    <cfset artist_name_alt = manufacturer />
</cfif>
  <!-- slides -->
  <div>
    	<A HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artist=#ucase(manufacturer)#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
        	<img src="http://#server_name#/img/thumbnails/#uid#.jpg" alt="#uid#.jpg" width="140" height="140" border="0">
        </a>
  </div>
</cfoutput>
</div>

<!-- "next slide" button -->
<a class="forward">next</a>

<!-- the tabs -->
<div class="slidetabs">
<cfloop from="1" to="#listings.recordcount#" index="idx">
  <a href="#"></a>
</cfloop>
</div>
<div id="clickToView">Click to view details</div>
<div style="clear:both;margin:30px 0 0;text-align:center;">
    <button onClick='$(".slidetabs").data("slideshow").play();'>Play</button>
  	<button onClick='$(".slidetabs").data("slideshow").stop();'>Stop</button>
</div>

<script language="JavaScript">
  $(function() {
      $(".slidetabs").tabs(".images > div", {

    // enable "cross-fading" effect
    effect: 'fade',
    fadeOutSpeed: "slow",

    // start from the beginning after the last tab
    rotate: true

    // use the slideshow plugin. It accepts its own configuration
    }).slideshow();
    });
</script>

</cfif>


