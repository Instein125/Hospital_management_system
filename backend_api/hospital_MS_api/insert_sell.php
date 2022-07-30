<?php

include("connection.php");
$con=connection();


if(isset($_POST['Phar_ID']))
{
    $Phar_ID=$_POST['Phar_ID'];
}
else return;

if(isset($_POST['Trade_name']))
{
    $Trade_name=$_POST['Trade_name'];
}
else return;


if(isset($_POST['Price']))
{
    $Price=$_POST['Price'];
}
else return;

if(isset($_POST['Quantity']))
{
    $Quantity=$_POST['Quantity'];
}
else return;

$query="INSERT INTO `sell`(`Trade_name`, `Phar_ID`, `Price`, `Quantity`)
 VALUES ('$Trade_name','$Phar_ID','$Price','$Quantity')";
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