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


 $query="INSERT INTO `prescribe`(`SSN`,`Doc_SSN`,`Quantity`) VALUES ('$SSN','$Doc_SSN','0')";

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