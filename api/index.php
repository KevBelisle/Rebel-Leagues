<?php

$jsonData = json_decode(file_get_contents('php://input'), true);
if ( count($_POST) == 0 && count($jsonData) > 0 ) {
	$_POST = $jsonData;
}

// Include Epiphany library
include_once 'lib/epiphany/Epi.php';
Epi::setPath('base', 'lib/epiphany/');
Epi::init('route');
Epi::init('database');
Epi::setSetting('exceptions', true);

include_once 'db_access.php';
include_once 'getELORankings.php';

EpiDatabase::employ('mysql', $db["database"], $db["host"], $db["username"], $db["password"]);

// Define routes
getRoute()->get('/', array('League', 'nope'));

getRoute()->get('/leagues(?:/?)', array('League', 'getLeague'));
getRoute()->get('/leagues/logo(?:/?)', array('League', 'getLeagueLogo'));

getRoute()->get('/players(?:/?)', array('League', 'getPlayers'));
getRoute()->get('/players/(\d+)(?:/?)', array('League', 'getPlayer'));
getRoute()->get('/players/(\d+)/stats(?:/?)', array('League', 'getPlayerStats'));

getRoute()->get('/games(?:/?)', array('League', 'getGamesHistory'));
getRoute()->get('/games/(\d+)(?:/?)', array('League', 'getGamesHistory'));
getRoute()->get('/games/(\d+)/(\d+)(?:/?)', array('League', 'getGamesHistory'));
getRoute()->get('/games(?:/?)/all', array('League', 'getGamesHistoryAll'));
getRoute()->get('/ranking(?:/?)', array('League', 'getRanking'));
getRoute()->get('/ranking/(\d+)(?:/?)', array('League', 'getRanking'));

getRoute()->get('/factions(?:/?)', array('League', 'getFactions'));
getRoute()->get('/factions/leafs(?:/?)', array('League', 'getLeafFactions'));
getRoute()->get('/factions/(\d+)(?:/?)', array('League', 'getFaction'));
getRoute()->get('/factions/(\d+)/stats(?:/?)', array('League', 'getFactionStats'));
getRoute()->get('/factions/(\d+)/logo(?:/?)', array('League', 'getFactionLogo'));

getRoute()->get('/stats(?:/?)', array('League', 'getStats'));

getRoute()->get('/login(?:/?)', array('Admin', 'checkLogin'));
getRoute()->post('/login(?:/?)', array('Admin', 'login'));
getRoute()->get('/logout(?:/?)', array('Admin', 'logout'));
getRoute()->get('/admins(?:/?)', array('Admin', 'getAdmins'));

getRoute()->post('/admins(?:/?)', array('Admin', 'addAdmin'));
getRoute()->post('/players(?:/?)', array('Admin', 'addPlayer'));
getRoute()->post('/factions(?:/?)', array('Admin', 'addFaction'));
getRoute()->post('/games(?:/?)', array('Admin', 'addGame'));
getRoute()->put('/games/(\d+)(?:/?)', array('Admin', 'editGame'));
getRoute()->delete('/games/(\d+)(?:/?)', array('Admin', 'deleteGame'));

// Run router
getRoute()->run();


// Define helper function
function sec_session_start() {
	
	// Forces sessions to only use cookies.
	if (ini_set('session.use_only_cookies', 1) === FALSE) {
		echo outputError( "Could not initiate a safe session (ini_set)" );
		exit();
	}
	
	$cookieParams = session_get_cookie_params();
	session_set_cookie_params(3600,
	$cookieParams["path"],
	$cookieParams["domain"],
	false,
	true);
	
	session_name('rebel_leagues');
	session_start();
}


function outputSuccess($data) {
	return json_encode( array('status' => 'success', 'data' => $data), JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES );
}
function outputError($data) {
	return json_encode( array('status' => 'error', 'data' => $data), JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES );
}



class League {
	public static function nope() {
		echo "Nope.";
	}
	
	public static function internal_getLeague($league_id = 1) {
		$league = getDatabase()->one(
		'SELECT
			title,
			subtitle,
			defaultGameNotes,
			pointsWinValue,
			pointsDrawValue,
			pointsLossValue,
			eloMasterRank,
			eloStartKFactor,
			eloSeasonedKFactor,
			eloMasterKFactor,
			eloSeasonedGameCountRequirement,
			eloStartRank
		FROM leagues
		WHERE league_id = :league_id',
			array( ':league_id' => $league_id )
		);
		
		$ranking_methods = getDatabase()->all(
		'SELECT
			rm.ranking_method_id,
			rm.ranking_method_name,
			lrm.default_ranking
		FROM ranking_methods rm
		LEFT OUTER JOIN leagues_ranking_methods lrm
			ON lrm.ranking_method_id = rm.ranking_method_id
			AND lrm.league_id = :league_id',
			array( ':league_id' => $league_id )
		);
		
		return array($league, $ranking_methods);
	}
	
	public static function getLeague($league_id = 1) {
		list($league, $ranking_methods) = self::internal_getLeague($league_id);
		echo outputSuccess( array( 'league' => $league, 'ranking_methods' => $ranking_methods ) );
	}
	
	
	public static function getLeagueLogo($league_id = 1) {
		$league = getDatabase()->one(
			"SELECT logo
			FROM leagues
			WHERE league_id = :league_id",
			array( ':league_id' => $league_id )
		);
		
		$logo = $league['logo'];
		if($logo === NULL) exit;
		header('Content-Type: image/png');
		readfile($logo);
	}
	

	public static function getPlayers() {
		$players = getDatabase()->all(
		'SELECT * FROM players ORDER BY nickname'
		);
		echo outputSuccess( array( 'players' => $players ) );
	}
	
	
	public static function getPlayer($player_id) {
		$player = getDatabase()->one(
		'SELECT
			player_id, nickname, firstname, lastname
		FROM players
		WHERE player_id = :player_id',
			array( ':player_id' => $player_id )
		);
		echo outputSuccess( $player );
	}
	
	
	public static function getFactions() {
		$factions = getDatabase()->all(
		'SELECT
			c.faction_id AS faction_id,
			c.name AS name,
			c.color AS color,
			c.parent_faction_id AS parent_faction_id,
			p.name AS parent_faction_name
		FROM factions c
		LEFT JOIN factions p ON c.parent_faction_id = p.faction_id
		ORDER BY c.faction_id'
		);
		echo outputSuccess( array( 'factions' => $factions ) );
	}
	
	public static function getLeafFactions() {
		$factions = getDatabase()->all(
		'SELECT
			c.faction_id AS faction_id,
			c.name AS name,
			c.color AS color,
			c.parent_faction_id AS parent_faction_id,
			p.name AS parent_faction_name
		FROM factions c
		LEFT JOIN factions p ON c.parent_faction_id = p.faction_id
		WHERE c.faction_id NOT IN (
				SELECT parent_faction_id AS faction_id
				FROM factions
				WHERE parent_faction_id IS NOT NULL
			)
		ORDER BY c.faction_id'
		);
		echo outputSuccess( array( 'factions' => $factions ) );
	}
	
	
	public static function getFaction($faction_id) {
		$faction = getDatabase()->one(
		'SELECT
			factions.faction_id AS faction_id,
			factions.name AS faction_name,
			factions.color AS faction_color,
			
			parent_factions.faction_id AS parent_faction_id,
			parent_factions.name AS parent_faction_name,
			parent_factions.color AS parent_faction_color
		FROM factions factions
		LEFT OUTER JOIN factions parent_factions ON parent_factions.faction_id = factions.parent_faction_id
		WHERE factions.faction_id = :faction_id',
			array( ':faction_id' => $faction_id )
		);
		echo outputSuccess( $faction );
	}
	
	
	public static function getFactionStats($faction_id) {
		$factions = getDatabase()->all(
			"SELECT * FROM factions_stats WHERE faction_id = :faction_id ORDER BY games_played DESC",
			array( ':faction_id' => $faction_id )
		);
		echo outputSuccess( array( 'factions' => $factions ) );
	}
	

	public static function getPlayerStats($player_id) {
		$players = getDatabase()->all(
			"SELECT * FROM players_stats WHERE player_id = :player_id ORDER BY games_played DESC",
			array( ':player_id' => $player_id )
		);
		echo outputSuccess( array( 'players' => $players ) );
	}
	
	
	public static function getFactionLogo($faction_id) {
		$faction = getDatabase()->one(
			"SELECT child.logo AS child_logo, parent.logo AS parent_logo
			FROM factions AS child
			LEFT JOIN factions AS parent ON child.parent_faction_id = parent.faction_id
			WHERE child.faction_id = :faction_id",
			array( ':faction_id' => $faction_id )
		);
		
		$logo = $faction['child_logo'];
		if($logo === NULL) $logo = $faction['parent_logo'];
		header('Content-Type: image/png');
		readfile($logo);
	}
	
	
	public static function getGamesHistory($skip = 0, $take = 20) {
		if( array_key_exists('skip', $_GET) ) {
			$skip = $_GET['skip'];
		}
		if( array_key_exists('take', $_GET) ) {
			$take = $_GET['take'];
		}
		
		$games = getDatabase()->all(
			'SELECT * FROM games_history ORDER BY date DESC LIMIT :skip, :take',
			array(':skip' => $skip, ':take' => $take)
		);
		echo outputSuccess( array( 'games' => $games ) );
	}
	
	
	public static function getGamesHistoryAll() {
		$games = getDatabase()->all(
			'SELECT * FROM games_history ORDER BY date DESC'
		);
		echo outputSuccess( array( 'games' => $games ) );
	}
	
	
	public static function getRanking($requested_ranking_method_id = -1) {
	
		list($league, $possible_ranking_methods) = self::internal_getLeague();
		
		$ranking_method = -1;
		$default_ranking_method = -1;
		foreach ($possible_ranking_methods as $possible_ranking_method) {
			if ($possible_ranking_method["default_ranking"] == 1) {
				// Found default sort
				$default_ranking_method = $possible_ranking_method["ranking_method_id"];
			} else if ( $requested_ranking_method_id == $possible_ranking_method["ranking_method_id"] && !is_null($possible_ranking_method["default_ranking"]) ) {
				// Requested ranking method is allowed
				$ranking_method = $requested_ranking_method_id;
				break;
			}
		}
		if ($default_ranking_method == -1) // No default ranking method defined -> assume default ranking of 1 (games_played)
			$default_ranking_method = 1;
		if ($ranking_method == -1) // Requested ranking method not allowed -> revert to default
			$ranking_method = $default_ranking_method;
	
		$games = getDatabase()->all(
			'SELECT * FROM games_history ORDER BY date ASC'
		);
		$players = getDatabase()->all(
			'SELECT *,
			1000 AS elo_rating, :winPoints*games_won + :drawPoints*games_tied + :lossPoints*games_lost AS points
			FROM players_ranking',
			array(":winPoints" => $league["pointsWinValue"], ":drawPoints" => $league["pointsDrawValue"], ":lossPoints" => $league["pointsLossValue"])
		);
		
		switch ($ranking_method) {
			// ELO rating
			case 3:
				$players = ELO::getELORankings($games, $players);
				$sortList = [];
				foreach ($players as $key => $player) {
					$sortList[$key]  = $player['elo_rating'];
				}
				array_multisort($sortList, SORT_DESC, $players);
				break;
			
			// Points
			case 2:
				$sortList = [];
				foreach ($players as $key => $player) {
					$sortList[$key]  = $player['points'];
				}
				array_multisort($sortList, SORT_DESC, $players);
				break;
			
			// Games played
			case 1:
			default:
				$sortList = [];
				foreach ($players as $key => $player) {
					$sortList[$key]  = $player['games_played'];
				}
				array_multisort($sortList, SORT_DESC, $players);
				break;
		}
		
		echo outputSuccess( array( 'ranking' => $ranking_method, 'players' => $players) );
	}
	
	
	public static function getStats() {
	
		$stats = getDatabase()->one("
			SELECT *
			FROM
				(
					SELECT COUNT(*) AS total_players
					FROM players
				) tp,
				(
					SELECT COUNT(DISTINCT player_id) AS active_players
					FROM games_split
					WHERE date > DATE_SUB(NOW(), INTERVAL 60 DAY)
				) ap,
				(
					SELECT COUNT(*) AS games_played
					FROM games
				) gp
		");
		
		echo outputSuccess( array( 'stats' => $stats ) );
		
	}
}





class Admin {
	
	private static function checkFields($fields, $array, $forceQuit = true) {
		$missingFields = array();
		foreach ($fields as $index => $field) {
			if( !array_key_exists($field, $array) ) {
				$missingFields[] = $field;
			}
		}
		
		if( count($missingFields) > 0 ) {
			if ($forceQuit) {
				echo outputError( array( 'missingFields' => $missingFields ) );
				exit();
			} else {
				return false;
			}
		}
		
		return true;
	}

	
	private static function checkTier($requiredTier) {
		sec_session_start();
		
		if (isset($_SESSION['login_string'], $_SESSION['username'], $_SESSION['tier'])) {
			
			$dbUser = getDatabase()->one("SELECT username, password, salt, tier FROM admins WHERE username = :username", array(':username' => $_SESSION['username']));
			
			// check if user exists
			if ( $dbUser ) {
				
				// confirme session login_string is correct
				if ( $_SESSION['login_string'] ==  hash('sha512', $dbUser['password'] . $dbUser['salt'] . $_SERVER['HTTP_USER_AGENT']) ) {
					
					if ( $_SESSION['tier'] <= $requiredTier ) {
						return true;
					} else {
						header("HTTP/1.1 401 Unauthorized");
						exit;
					}
				} else {
					header("HTTP/1.1 401 Unauthorized");
					exit;
				}
			} else {
				header("HTTP/1.1 401 Unauthorized");
				exit;
			}
		} else {
			header("HTTP/1.1 401 Unauthorized");
			exit;
		}
	}
	
	public static function checkLogin() {
		sec_session_start();
		
		if (self::checkFields(array('username', 'tier', 'login_string'), $_SESSION, false)) {
			$dbUser = getDatabase()->one("SELECT username, password, salt, tier FROM admins WHERE username = :username", array(':username' => $_SESSION['username']));
			
			if ($_SESSION['login_string'] == hash('sha512', $dbUser['password'] . $dbUser['salt'] . $_SERVER['HTTP_USER_AGENT'])) {
				$_SESSION['tier'] = $dbUser['tier'];
				echo outputSuccess(array( 'username' => $_SESSION['username'], 'tier' => $_SESSION['tier'] ));
			} else {
				# Données de session invalides.
				self::logout();
			}
		} else {
			# No session cookie available
			echo outputError( array( 'error' => 'Aucune session en cours.' ) );
		}
	}
	
	public static function login() {
		sec_session_start();
		
		self::checkFields( array('username', 'password'), $_POST );
		
		$dbUser = getDatabase()->one("SELECT username, password, salt, tier FROM admins WHERE username = :username", array(':username' => $_POST['username']));
		
		// check if user exists
		if ( $dbUser ) {
			
			// check if passwords match
			if ( $dbUser['password'] == hash('sha512', $_POST['password'].$dbUser['salt']) ) {
				// Password is correct!
				
				$_SESSION['login_string'] = hash('sha512', $dbUser['password'] . $dbUser['salt'] . $_SERVER['HTTP_USER_AGENT']);
				$_SESSION['username'] = $dbUser['username'];
				$_SESSION['tier'] = $dbUser['tier'];
				// Login successful.
				echo outputSuccess(array( 'username' => $_SESSION['username'], 'tier' => $_SESSION['tier'] ));
				
			} else {
				echo outputError( array( 'error' => 'Nom d\'utilisateur ou mot de passe invalid.' ) );
			}
			
		} else {
			echo outputError( array( 'error' => 'Nom d\'utilisateur ou mot de passe invalid.' ) );
		}
	}
	
	
	
	
	public static function logout() {
		sec_session_start();
		
		if ( array_key_exists('username', $_SESSION) ) {
			$ex_username = $_SESSION['username'];
		} else {
			$ex_username = "";
		}
		
		// Unset all session values 
		$_SESSION = array();
		// get session parameters 
		$params = session_get_cookie_params();
		// Delete the actual cookie. 
		setcookie(session_name(), '', time() - 42000, $params["path"], $params["domain"], $params["secure"], $params["httponly"]);
		// Destroy session 
		session_destroy();
		
		// Logout successful.
		echo outputSuccess(array( 'logout' => $ex_username ));
	}
	
	
	
	public static function getAdmins() {
		self::checkTier(1);
		
		$admins = getDatabase()->all(
		'SELECT username, tier FROM admins ORDER BY username'
		);
		echo outputSuccess( array( 'admins' => $admins ) );
	}
	
	
	
	public static function addAdmin() {
		self::checkTier(1);
		self::checkFields( array('username', 'password', 'tier'), $_POST );
		
		try {
			
			$salt = substr( hash('sha512', rand()), 0, 20);
			$password = hash('sha512', $_POST['password'].$salt);
			
			$admin_id = getDatabase()->execute('INSERT INTO admins (username, password, salt, tier) VALUES(:username, :password, :salt, :tier)',
			array(':username' => $_POST['username'], ':password' => $password, ':salt' => $salt, ':tier' => $_POST['tier']) );
			echo outputSuccess( array( 'admin_id' => $admin_id ) );
			
		} catch (Exception $e) {
			echo outputError($e->getMessage());
		}
	}
	
	
	
	public static function addPlayer() {
		//self::checkTier(3);
		self::checkFields( array('nickname', 'firstname', 'lastname'), $_POST );
		
		try {
			$player_id = getDatabase()->execute('INSERT INTO players (nickname, firstname, lastname) VALUES(:nickname, :firstname, :lastname)',
			array(':nickname' => $_POST['nickname'], ':firstname' => $_POST['firstname'], ':lastname' => $_POST['lastname']) );
			echo outputSuccess( array( 'player_id' => $player_id ) );
			
		} catch (Exception $e) {
			echo outputError($e->getMessage());
		}
		
	}
	
	
	public static function addFaction() {
		self::checkTier(3);
		self::checkFields( array('name', 'parent_faction_id', 'color'), $_POST );
		
		if ( count($_FILES) != 1 ) {
			echo outputError( array( 'missingFields' => array("logo") ) );
			return;
		}
		
		$file = $_FILES[0];
		
		$uploaddir = 'uploads/factions/';
		$extension = explode(".", $file['name']);
		$filename = $uploaddir . md5(microtime()) . "." . end( $extension );
		
		if( ! move_uploaded_file( $file['tmp_name'], $filename ) ) {
			echo outputError(  );
			return;
		}
		
		try {
			$faction_id = getDatabase()->execute('INSERT INTO factions (name, parent_faction_id, color, logo) VALUES (:name, :parent_faction_id, :color, :logo)',
			array(
			':name' => $_POST['name'],
			':parent_faction_id' => $_POST['parent_faction_id'],
			':color' => $_POST['color'],
			':logo' => $filename
			)
			);
			echo outputSuccess( array( 'faction_id' => $faction_id, 'logo' => $filename ) );
			
		} catch (Exception $e) {
			unlink( $filename );
			echo outputError($e->getMessage());
		}
	}
	
	
	public static function addGame() {
		//self::checkTier(3);
		
		print_r($_POST);
		
		self::checkFields( array('player1_id', 'player1_faction_id', 'player2_id', 'player2_faction_id', 'date', 'is_draw', 'is_ranked', 'is_time_runout', 'is_online'), $_POST );
		
		try {
			$game_id = getDatabase()->execute('INSERT INTO games (player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES (:player1_id, :player1_faction_id, :player2_id, :player2_faction_id, :date, :is_draw, :is_ranked, :is_time_runout, :is_online, :notes)',
			array(
				':player1_id' => $_POST['player1_id'],
				':player1_faction_id' => $_POST['player1_faction_id'],
				':player2_id' => $_POST['player2_id'],
				':player2_faction_id' => $_POST['player2_faction_id'],
				':date' => $_POST['date'],
				':is_draw' => $_POST['is_draw'],
				':is_ranked' => $_POST['is_ranked'],
				':is_time_runout' => $_POST['is_time_runout'],
				':is_online' => $_POST['is_online'],
				':notes' => $_POST['notes']
			)
			);
			echo outputSuccess( array( 'game_id' => $game_id ) );
			
		} catch (Exception $e) {
			echo outputError($e->getMessage());
		}
	}
	
	
	public static function editGame($gameId) {
		self::checkTier(2);
		
		print_r($_POST);
		
		self::checkFields( array('player1_id', 'player1_faction_id', 'player2_id', 'player2_faction_id', 'date', 'is_draw', 'is_ranked', 'is_time_runout', 'is_online'), $_POST );
		
		try {
			$game_id = getDatabase()->execute('UPDATE games SET
				player1_id = :player1_id,
				player1_faction_id = :player1_faction_id,
				player2_id = :player2_id,
				player2_faction_id = :player2_faction_id,
				date = :date,
				is_draw = :is_draw,
				is_ranked = :is_ranked,
				is_time_runout = :is_time_runout,
				is_online = :is_online,
				notes = :notes
				WHERE game_id = :game_id',
			array(
				':player1_id' => $_POST['player1_id'],
				':player1_faction_id' => $_POST['player1_faction_id'],
				':player2_id' => $_POST['player2_id'],
				':player2_faction_id' => $_POST['player2_faction_id'],
				':date' => $_POST['date'],
				':is_draw' => $_POST['is_draw'],
				':is_ranked' => $_POST['is_ranked'],
				':is_time_runout' => $_POST['is_time_runout'],
				':is_online' => $_POST['is_online'],
				':notes' => $_POST['notes'],
				':game_id' => $gameId
			)
			);
			echo outputSuccess( array( 'game_id' => $gameId ) );
			
		} catch (Exception $e) {
			echo outputError($e->getMessage());
		}
	}
	
	
	public static function deleteGame($gameId) {
		self::checkTier(1);
		
		try {
			$game_id = getDatabase()->execute('DELETE FROM games WHERE game_id = :game_id',
			array(
				':game_id' => $gameId
			)
			);
			echo outputSuccess( array( 'game_id' => $gameId ) );
			
		} catch (Exception $e) {
			echo outputError($e->getMessage());
		}
	}
}







?>