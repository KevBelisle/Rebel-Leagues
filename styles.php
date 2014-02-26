<?php
$directory = "styles";

require "scssphp/scss.inc.php";
scss_server::serveFrom($directory);
?>