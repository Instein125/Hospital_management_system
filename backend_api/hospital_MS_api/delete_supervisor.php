<?php

include("connection.php");
$con=connection();

if(isset($_POST['id']))
{
    $id=$_POST['id'];
}
else return;

$query="DELETE FROM `supervisor` WHERE supervisor_ID = '$id'";
$exe=mysqli_query($con,$query);

$arr=[];

if($exe)
{
    $arr['success']='true';
}
else {
    $arr['success']='false';
}

print(json_encode($arr));
?>