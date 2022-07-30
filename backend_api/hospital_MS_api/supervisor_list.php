<?php

include("connection.php");
$con=connection();


$query="SELECT supervisor_id, name FROM supervisor ;";
$exe=mysqli_query($con,$query);

$arr=[];

while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}

print(json_encode($arr));
?>