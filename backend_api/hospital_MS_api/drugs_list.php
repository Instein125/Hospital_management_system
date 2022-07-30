<?php

include("connection.php");
$con=connection();

$query="SELECT `Trade_name` FROM `drug`";
$exe=mysqli_query($con,$query);

$arr=[];

while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}

print(json_encode($arr));
?>