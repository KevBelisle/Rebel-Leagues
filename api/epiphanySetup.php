<?php

	// Include Epiphany library
	include_once 'lib/epiphany/Epi.php';
	Epi::setPath('base', 'lib/epiphany/');
	Epi::init('route');
	Epi::init('database');
	Epi::setSetting('exceptions', true);

	include_once 'db_access.php';
	include_once 'elo_rating.php';

	EpiDatabase::employ('mysql', $db["database"], $db["host"], $db["username"], $db["password"]);

?>