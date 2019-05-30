<?php
$servername = "localhost";
$username = "root";
$password = "";
$db = "dummy";
$conn = mysqli_connect($servername, $username, $password,$db);
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$company_deets = array(1,2,3,4,5,6);
$service_deets = array(1,2,3,4);
$start = strtotime("10 September 2000");
$end = strtotime("22 March 2019");

for($i=0;$i<=100;$i++)
{
	$key_c = array_rand($company_deets);
	$company = $company_deets[$key_c];
	$key_s = array_rand($service_deets);
	$service = $service_deets[$key_s];
	$timestamp = mt_rand($start, $end);
	$date = date("Y-m-d", $timestamp);
	$sql="INSERT INTO `service_provided` (`company_id`, `service_id`, `date_added`) VALUES('$company','$service','$date')";
	mysqli_query($conn,$sql);
	
}

// $sql = "select * from company_master";
// $stmt = mysqli_query($conn,$sql);
// $res = mysqli_fetch_array($stmt);
 
?>