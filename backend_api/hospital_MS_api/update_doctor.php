<?php

include("connection.php");
$con=connection();

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

if(isset($_POST['speciality']))
{
    $speciality=$_POST['speciality'];
    
}
else return;

if(isset($_POST['experience']))
{
    
    $experience=$_POST['experience'];
}
else return;

$query ="UPDATE `doctor` SET `Name`='$name',`Speciality`='$speciality',`Experience`='$experience' WHERE `Doc_SSN`='$Doc_SSN'";

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