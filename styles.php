<?php
$directory = "styles";

require "scss.inc.php";
scss_server::serveFrom($directory);
?>