<?php

include("connection.php");
$con=connection();



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

$query="INSERT INTO `pharmaceutical_company` (`Company_name`, `Ph_number`)
 VALUES ('$name', '$Ph_number')";
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