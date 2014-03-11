<?php
require "../scss.inc.php";
$scss = new scssc();

header("Content-type: text/css");
echo $scss->compile('@import "styles/style.scss"');
?>