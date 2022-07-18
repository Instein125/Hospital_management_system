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

if(isset($_POST['phnumber']))
{
    $phnumber=$_POST['phnumber'];
}
else return;

$query="INSERT INTO `pharmacy` (`Phar_ID`, `Name`, `address`, `ph_number`)
 VALUES ('$Phar_ID', '$name', '$address', '$phnumber')";
 $exe=mysqli_query($con,$query);

 $arr=[];
 if($exe){
   $arr["success"] =="true";
 }
 else{
    $arr["success"]="false";
  } 
 print(json_encode($arr));

?>