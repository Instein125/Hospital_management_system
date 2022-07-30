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

if(isset($_POST['Trade_name']))
{
    $Trade_name=$_POST['Trade_name'];
}
else return;

if(isset($_POST['Prescribe_date']))
{
    $Prescribe_date=$_POST['Prescribe_date'];
}
else return;
if(isset($_POST['Quantity']))
{
    $Quantity=$_POST['Quantity'];
}
else return;

$query ="UPDATE `prescribe` SET `Trade_name`='$Trade_name',`Prescribe_date`='$Prescribe_date',`Quantity`='$Quantity'
 WHERE Doc_SSN = '".$Doc_SSN."' AND SSN ='".$SSN."'";

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