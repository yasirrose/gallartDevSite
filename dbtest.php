<?php
//echo phpinfo();

$connection_string = 'DRIVER={SQL Server};SERVER=localhost\MSSQLServer;DATABASE=onli16_gallart';

$user = 'onli16_gallart';
$pass = 're3objec';

$conn = odbc_connect( $connection_string, $user, $pass );
if( $conn ) {
     echo "Connection established.<br />";
}else{
     echo "Connection could not be established.<br />";
     die( print_r( odbc_error(), true));
}



$q="select * from onli16_gallart.dbo.appraisal";
//print $q;
$my_datum=odbc_exec($conn, $q);
while($my_data = odbc_fetch_array($my_datum)){
print_r($my_data);
echo"<br/><br/>";
echo $my_data['fname'];
echo"<br/><br/>";
}
?>












