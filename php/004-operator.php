<?php
$intA = 1;
$intB = 2;
$intC = $intA + $intB;
echo $intC;

$strA = "a";
$strB = "b";
$strC = $strA . $strB;
echo $strC;

$nullVar = null;
$notNullVar = 'not null';
$result = $nullVar ?? $notNullVar; // PHP7
echo $result;
