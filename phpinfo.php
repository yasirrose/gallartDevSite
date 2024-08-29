<?php 
mssql_connect('localhost','onli16_gallart','re3objec') or die('could not connect');
mssql_select_db('onli16_gallart') or die('could not select');
echo phpinfo();
?>