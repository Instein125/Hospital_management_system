<?php

include("connection.php");
$con=connection();

if(isset($_POST['Supervisor_ID']))
{
    $Supervisor_ID=$_POST['Supervisor_ID'];
}
else return;

if(isset($_POST['name']))
{
    $name=$_POST['name'];
}
else return;

if(isset($_POST['address']))
{
    $address=$_POST['address'];
}
else return;


$query ="UPDATE `supervisor` SET `Name`='$name',`Address`='$address' WHERE `supervisor_ID`='$Supervisor_ID'";

$exe=mysqli_query($con,$query);

$arr=[];
 if($exe){
   $arr["success"] ="true";
 }
 else{
    $arr["success"]="false";
  } 
 print(json_encode($arr));

?>