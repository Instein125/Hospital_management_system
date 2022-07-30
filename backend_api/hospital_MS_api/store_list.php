<?php

include("connection.php");
$con=connection();

$query="SELECT Trade_name, SUM(Quantity) FROM `sell` GROUP BY Trade_name";
$exe=mysqli_query($con,$query);

$arr=[];

while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}

print(json_encode($arr));
?>