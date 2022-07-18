<?php

include("connection.php");
$con=connection();



if(isset($_POST['Trade_name']))
{
    $Trade_name=$_POST['Trade_name'];
}
else return;

if(isset($_POST['Formula']))
{
    $Formula=$_POST['Formula'];
}
else return;

$query="INSERT INTO `drug` (`Trade_name`, `Formula`)
 VALUES ('$Trade_name', '$Formula')";
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