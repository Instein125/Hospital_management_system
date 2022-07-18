<?php

include("connection.php");
$con=connection();

$query="SELECT COUNT(*) FROM `pharmacy`";
$exe=mysqli_query($con,$query);

$arr=[];

while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}

print(json_encode($arr));
?>