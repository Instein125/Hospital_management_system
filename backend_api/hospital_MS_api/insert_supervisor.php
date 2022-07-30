<?php

include("connection.php");
$con=connection();

if(isset($_POST['supervisor_ID']))
{
    $supervisor_ID=$_POST['supervisor_ID'];
}
else return;

if(isset($_POST['name']))
{
    $name=$_POST['name'];
}
else return;

if(isset($_POST['Address']))
{
    $Address=$_POST['Address'];
}
else return;


$query="INSERT INTO `supervisor`(`supervisor_ID`, `Name`, `Address`)
 VALUES ('$supervisor_ID','$name','$Address')";
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