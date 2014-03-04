<?php

//header('content-type: text/html; charset=utf-8');

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

getRoute()->get('/players', array('League', 'getPlayers'));
getRoute()->get('/factions', array('League', 'getFactions'));
getRoute()->get('/games', array('League', 'getGamesHistory'));
getRoute()->get('/ranking', array('League', 'getRanking'));
getRoute()->get('/ranking/(games_played|elo_rating|points)', array('League', 'getRanking'));

getRoute()->get('/factions/(\d+)/logo', array('League', 'getFactionLogo'));

getRoute()->post('/login', array('Admin', 'login'));
getRoute()->get('/logout', array('Admin', 'logout'));
getRoute()->get('/admins', array('Admin', 'getAdmins'));

getRoute()->post('/admins', array('Admin', 'addAdmin'));
getRoute()->post('/players', array('Admin', 'addPlayer'));
getRoute()->post('/factions', array('Admin', 'addFaction'));
getRoute()->post('/games', array('Admin', 'addGame'));

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
	

	public static function getPlayers() {
		$players = getDatabase()->all(
		'SELECT * FROM players ORDER BY nickname'
		);
		echo outputSuccess( array( 'players' => $players ) );
	}
	
	
	public static function getFactions() {
		$factions = getDatabase()->all(
		'SELECT * FROM factions ORDER BY name'
		);
		echo outputSuccess( array( 'factions' => $factions ) );
	}
	
	
	public static function getFactionLogo($faction_id) {
		$faction = getDatabase()->one(
			"SELECT child.logo AS child_logo, parent.logo AS parent_logo
			FROM factions AS child
			LEFT JOIN factions AS parent ON child.parent_faction_id = parent.faction_id
			WHERE child.faction_id = $faction_id"
		);
		
		$logo = $faction['child_logo'];
		if($logo=== NULL) $logo = $faction['parent_logo'];
		header('Content-Type: image/png');
		readfile($logo);
	}
	
	
	public static function getGamesHistory() {
		$skip = 0;
		$take = 20;
		
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
	
	public static $pointsDistribution = [
		'win' => 5,
		'draw' => 3,
		'loss' => 1
	];
	
	public static function getRanking($sort_method = 'default') {
	
		$games = getDatabase()->all(
			'SELECT * FROM games_history ORDER BY date ASC'
		);
		$players = getDatabase()->all(
			'SELECT *,
				1000 AS elo_rating,
				'.self::$pointsDistribution['win'].'*games_won + '.self::$pointsDistribution['draw'].'*games_tied + '.self::$pointsDistribution['loss'].'*games_lost AS points
				FROM players_ranking'
		);
		$players = ELO::getELORankings($games, $players);
		
		if ($sort_method == 'default') { $sort_method = 'games_played'; }
		
		switch ($sort_method) {
			case 'elo_rating':
				$sortList = [];
				foreach ($players as $key => $player) {
					$sortList[$key]  = $player['elo_rating'];
				}
				array_multisort($sortList, SORT_DESC, $players);
				break;
				
			case 'points':
				$sortList = [];
				foreach ($players as $key => $player) {
					$sortList[$key]  = $player['points'];
				}
				array_multisort($sortList, SORT_DESC, $players);
				break;
				
			case 'games_played':
				$sortList = [];
				foreach ($players as $key => $player) {
					$sortList[$key]  = $player['games_played'];
				}
				array_multisort($sortList, SORT_DESC, $players);
				break;
		}
		
		echo outputSuccess( array( 'ranking' => $sort_method, 'players' => $players) );
	}
	
}





class Admin {
	
	private static function checkFields($fields, $array) {
		$missingFields = array();
		foreach ($fields as $index => $field) {
			if( !array_key_exists($field, $array) ) {
				$missingFields[] = $field;
			}
		}
		
		if( count($missingFields) > 0 ) {
			echo outputError( array( 'missingFields' => $missingFields ) );
			exit();
		}
		
		return true;
	}

	
	private static function checkLogin($requiredTier) {
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
		self::checkLogin(1);
		
		$admins = getDatabase()->all(
		'SELECT username, tier FROM admins ORDER BY username'
		);
		echo outputSuccess( array( 'admins' => $admins ) );
	}
	
	
	
	public static function addAdmin() {
		self::checkLogin(1);
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
		self::checkLogin(3);
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
		self::checkLogin(3);
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
		self::checkLogin(3);
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
}







?>