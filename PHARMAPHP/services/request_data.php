<?php

include_once('connection.php');
$date_selected = $_POST['date'];
$sql = "CALL getMonthWiseData('$date_selected',@ch_year)";
$stmt = mysqli_query($conn,$sql);
$rowcount=mysqli_num_rows($stmt);
$data = array();
$sumation = array();
$sum_table = '';
$table = '<table class="table-bordered"><thead><tr>';
while($result = mysqli_fetch_assoc($stmt))
{
	array_push($data,$result);
	
}
$columName= array_keys(reset($data));
foreach($columName as $Values)
{
	$table .='<th>'.$Values.'</th>'; 	
	if($Values =='Company_Name')
	{
		$sum = 'aggregate';
		array_push($sumation,$sum);
	}
	else
	{
		$sum = array_sum(array_column($data, $Values));
		array_push($sumation,$sum);
	}

}
$sum_table .= '<table class="table-bordered"><thead><tr>';
foreach($sumation as $Values)
{
	$sum_table .='<th>'.$Values.'</th>'; 	
}
$sum_table .='</tr></thead></table>';
$table .='</tr></thead><tbody>';
foreach($data as $key=>$value)
{
	$table .='<tr>';
	foreach($value as $k=>$val)
	{
		$table .='<td>'.$val.'</td>';
	}
	$table .='</tr>';
}
$table .='</tbody>'; 
echo $sum_table.$table;
?>