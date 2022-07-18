<?php

include("connection.php");
$con=connection();

if(isset($_POST['oldName']))
{
    $oldName=$_POST['oldName'];
}
else return;

if(isset($_POST['name']))
{
    $name=$_POST['name'];
}
else return;

if(isset($_POST['Ph_number']))
{
    $Ph_number=$_POST['Ph_number'];
}
else return;

$query ="UPDATE `pharmaceutical_company` SET `Company_name`='$name',`Ph_number`='$Ph_number' WHERE `Company_name`='$oldName'";


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