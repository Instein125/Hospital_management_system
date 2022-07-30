<?php

include("connection.php");
$con=connection();

$Phar_ID=$_POST['Phar_ID'];
$name=$_POST['name'];



$query="SELECT * FROM `pharmacy` WHERE Phar_ID = '".$Phar_ID."' AND Name = '".$name."'";
$exe = mysqli_query($con,$query);

$count = mysqli_num_rows($exe);

if($count >= 1)
{
   echo json_encode("success");
}
else {
    echo json_encode("error");
}
?>