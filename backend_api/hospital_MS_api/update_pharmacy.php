<?php

include("connection.php");
$con=connection();

if(isset($_POST['Phar_ID']))
{
    $Phar_ID=$_POST['Phar_ID'];
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

if(isset($_POST['Ph_number']))
{
    
    $Ph_number=$_POST['Ph_number'];
}
else return;

$query ="UPDATE `pharmacy` SET `Name`='$name',`address`='$address',`Ph_number`='$Ph_number' WHERE `Phar_ID`='$Phar_ID'";

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