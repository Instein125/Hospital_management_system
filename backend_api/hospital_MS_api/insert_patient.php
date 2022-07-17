<?php

include("connection.php");
$con=connection();

if(isset($_POST['SSN']))
{
    $SSN=$_POST['SSN'];
}
else return;

if(isset($_POST['Doc_SSN']))
{
    $Doc_SSN=$_POST['Doc_SSN'];
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

if(isset($_POST['age']))
{
    $age=$_POST['age'];
}
else return;

$query="INSERT INTO `patient`(`SSN`, `Name`, `Address`, `Age`, `Doc_SSN`) 
VALUES ('$SSN','$name','$address','$age','$Doc_SSN')";
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