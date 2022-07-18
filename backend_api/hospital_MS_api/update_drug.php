<?php

include("connection.php");
$con=connection();

if(isset($_POST['oldName']))
{
    $oldName=$_POST['oldName'];
}
else return;

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

$query ="UPDATE `drug` SET `Trade_name`='$Trade_name',`Formula`='$Formula' WHERE `Trade_name`='$oldName'";


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