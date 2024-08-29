<!---<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>Magnifier</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="A replacement zoomer for Magento by Huy Dinh" />
<meta name="keywords" content="magento,javascript,js,zoom,zoomer,image zoom,magnify,magifier" />
<meta name="author" content="Huy Dinh" />
<!--<link type="text/css" rel="stylesheet" href="http://www.huydinh.co.uk/demo/magnifier/css/magnifier.css" media="all"></link>-->
<script type="text/javascript" src="http://www.huydinh.co.uk/demo/magnifier/js/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="http://www.huydinh.co.uk/demo/magnifier/js/magnifier.js"></script>

<style type="text/css">
p {
	width:400px;
	margin:50px;
	float:left;
}
#huy-magnifier {
	width:300px;
	height:200px;
	border:1px solid #000;
}
</style>
<script type="text/javascript">
	$(function() {
		$("p img").each(function() {
			$(this).hide().load(function(){
				$(this).magnify().fadeIn("fast");
			});
		});
	});
</script>
	</head>
	<body>
		<p><img alt="Earth" src="http://www.huydinh.co.uk/demo/magnifier/img/Earth.jpg" id="image"/></p>
		<p><img alt="Sea mist" src="http://www.huydinh.co.uk/demo/magnifier/img/SeaMist.jpg" id="image"/></p>
		<p><img alt="Stones" src="http://www.huydinh.co.uk/demo/magnifier/img/Stones.jpg" id="image"/></p>
		<p><img alt="Beautiful place" src="http://www.huydinh.co.uk/demo/magnifier/img/img16.jpg" id="image"/></p>
		<p><a href="http://www.huydinh.co.uk/blog/2008/09/04/my-jquery-magnify-plugin">View the original post</a></p>
	</body>
</html>--->


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">
<!--<link type="text/css" rel="stylesheet" href="http://www.huydinh.co.uk/demo/magnifier/css/magnifier.css" media="all"></link>-->
<script type="text/javascript" src="http://www.huydinh.co.uk/demo/magnifier/js/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="http://www.huydinh.co.uk/demo/magnifier/js/magnifier.js"></script>

<style type="text/css">
p {
	width:400px;
	margin:50px;
	float:left;
}
#huy-magnifier {
	width:300px;
	height:200px;
	border:1px solid #000;
}
</style>
<script type="text/javascript">
	$(function() {
		$("p img").each(function() {
			$(this).hide().load(function(){
				$(this).magnify().fadeIn("fast");
			});
		});
	});
</script>
<!---
<cfoutput>
<script language="JavaScript" src="./js/utils.js"></script>
<script language="JavaScript" src="http://#server_name#/js/jquery-1.2.6.min.js"></script>
<script language="JavaScript" src="http://#server_name#/js/magnifier.js"></script>
<script language="JavaScript" src="http://#server_name#/js/slimbox2.js"></script>
<link href="http://#server_name#/css/slimbox2.css" rel="stylesheet" type="text/css">
</cfoutput>

<script type="text/javascript">
	$(function() {
		$("p img").each(function() {
			$(this).hide().load(function(){
				$(this).magnify().fadeIn("fast");
			});
		});
	});
</script>

<style type="text/css">
p {
	width:400px;
	margin:50px;
	float:left;
}
#huy-magnifier {
	width:300px;
	height:200px;
	border:1px solid #000;
}
</style>--->




</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<p><img alt="car" src="http://www.geekologie.com/2007/12/07/future-car-1.jpg" id="auto"/></p>
<!---<p><img alt="Earth" src="http://www.huydinh.co.uk/demo/magnifier/img/Earth.jpg" id="image"/></p>--->
<!---<cfoutput>
<p><img src="http://#server_name#/img/11913.jpg" border="2" width="300"></p>
								
</cfoutput>--->

</body>
</html>