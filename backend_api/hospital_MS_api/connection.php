<?php

function connection()
{
   $con =mysqli_connect("localhost","root","","hospital");
   return $con;
}



?>