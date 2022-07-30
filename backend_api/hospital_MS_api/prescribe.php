<?php

include("connection.php");
$con=connection();

if(isset($_POST['Doc_SSN']))
{
    $doc_ssn=$_POST['Doc_SSN'];
}
else return;

$query="SELECT * FROM `prescribe` WHERE Doc_SSN = '".$doc_ssn."'";
$exe=mysqli_query($con,$query);

$arr=[];

while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}

print(json_encode($arr));
?>