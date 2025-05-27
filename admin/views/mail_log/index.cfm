<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>EMAIL LOG</title>
<link type="text/css" href="/css/jquery/ui.all.css" rel="stylesheet" />
<script src="/js/jquery-1.3.2.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.ui.accordion.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
    $("#accordion").accordion({ autoHeight: false });
  });
  </script>
</head>

<body>
<div style="float: right;">
	<a href="#" onclick="parent.closeMailLog()" style="font-family: Arial; font-size: .7em; font-weight: bold; color: #000;">CLOSE</a>
</div>
<div style="clear: both; text-align: center; font-family: arial;"><strong>EMAIL LOG</strong></div>
<cfif getMail.recordcount>
<cfoutput>
<div id="accordion">
	<cfloop query="getMail">
	<h3>
		<a href="##">
		To: #recipientEmail#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		From: #senderEmail#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		#dateFormat(datestamp)# #timeFormat(datestamp)#
		</a>
	</h3>
	<div>
		<p>
		#body#
		</p>
	</div>
	</cfloop>
</div>
</cfoutput>
<cfelse>
<div style="font-family: Arial; font-size: .7em; font-weight: bold; color: #000;">
	NO EMAILS SENT
</div>
</cfif>

</body>
</html>