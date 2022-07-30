<?php

include("connection.php");
$con=connection();

$doc_ssn=$_POST['doc_ssn'];
$name=$_POST['name'];

$query="SELECT * FROM `doctor` WHERE Doc_SSN = '".$doc_ssn."' AND Name ='".$name."'";
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