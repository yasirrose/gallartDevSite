<?php
// Server in the this format: <computer>\<instance name> or 
// <server>,<port> when using a non default port number
$server = 'dbtest.onlinegalleryart.com';

// Connect to MSSQL
$link = mssql_connect($server, 'onli16_gallart2', 're3objec');

if (!$link) {
    die('Something went wrong while connecting to MSSQL');
}
else
{
echo "successfully connected";
}


$q=mssql_query('SELECT * FROM products');
$q1=mssql_fetch_array($q);
echo "<pre>";
print_r($q1);
echo "</pre>";
?>
