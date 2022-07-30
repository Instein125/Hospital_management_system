<?php

include("connection.php");
$con=connection();

if(isset($_POST['Phar_ID']))
{
    $Phar_ID=$_POST['Phar_ID'];
}
else return;


$query="SELECT * FROM `contract` WHERE `Phar_ID`='".$Phar_ID."'";
$exe=mysqli_query($con,$query);

$arr=[];

while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}

print(json_encode($arr));
?>