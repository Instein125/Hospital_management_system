<?php

include("connection.php");
$con=connection();

$phar_id=$_POST['phar_id'];

$query="SELECT company_name FROM pharmaceutical_company 
WHERE company_name not in (SELECT company_name FROM contract WHERE phar_id='".$phar_id."');";
$exe=mysqli_query($con,$query);

$arr=[];

while($row=mysqli_fetch_array($exe))
{
    $arr[]=$row;
}

print(json_encode($arr));
?>