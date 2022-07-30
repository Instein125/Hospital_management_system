<?php

include("connection.php");
$con=connection();

if(isset($_POST['Phar_ID']))
{
    $Phar_ID=$_POST['Phar_ID'];
}
else return;

if(isset($_POST['Company_name']))
{
    $Company_name=$_POST['Company_name'];
}
else return;

if(isset($_POST['supervisor_ID']))
{
    $supervisor_ID=$_POST['supervisor_ID'];
}
else return;

if(isset($_POST['start_date']))
{
    $start_date=$_POST['start_date'];
}
else return;

if(isset($_POST['end_date']))
{
    $end_date=$_POST['end_date'];
}
else return;

$query="INSERT INTO `contract` (`Phar_ID`, `Company_name`, `supervisor_ID`, `start_date`, `end_date`)
 VALUES ('$Phar_ID', '$Company_name', '$supervisor_ID', '$start_date', '$end_date')";


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