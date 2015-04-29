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
include_once 'elo_rating.php';

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
getRoute()->get('/factions/(\d+)/ranking(?:/?)', array('League', 'getFactionRanking'));
getRoute()->get('/factions/rankings(?:/?)', array('League', 'getFactionsRankings'));
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

getRoute()->put('/leagues(?:/?)', array('Admin', 'editLeague'));

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


function check_property_equals($property = "", $value = 0) {
	// The "use" here binds $number to the function at declare time.
	// This means that whenever $number appears inside the anonymous
	// function, it will have the value it had when the anonymous
	// function was declared.
    return function($test) use($property, $value) { return $test[$property] == $value; };
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
		'SELECT
            p.player_id,
            p.nickname,
            p.firstname,
            p.lastname,
            IFNULL(MAX(g.date) > DATE_SUB(NOW(), INTERVAL 60 DAY), 0) AS active
        FROM
            players p
        LEFT JOIN
            games_split g
        ON p.player_id = g.player_id
        GROUP BY p.player_id
        ORDER BY nickname'
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
	
	public static function getFactionRanking($faction_id) {
		$factionRanking = getDatabase()->one(
		"SELECT * FROM factions_ranking
		WHERE faction_id = :faction_id",
			array( ':faction_id' => $faction_id )
		);
		echo outputSuccess( $factionRanking );
	}
	
	public static function getFactionsRankings() {
		$factionsRankings = getDatabase()->all(
		"SELECT * FROM factions_ranking"
		);
		echo outputSuccess( array( 'factionsRankings' => $factionsRankings) );
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
		
		error_reporting(E_ALL);
		ini_set('display_errors', 1);
		
		$efficiencyRatiosAgainst = getDatabase()->all("	
			SELECT *,
				FS.games_won/FS.games_played*100 AS efficiencyRatioAgainst
			FROM factions_stats AS FS
            WHERE games_played > 0 AND faction_id = :faction_id
			ORDER BY efficiencyRatioAgainst DESC",
			array( ':faction_id' => $faction_id )
		);
		
        /*
		$frequentUseList = getDatabase()->all("
			SELECT * FROM (
    SELECT *,  100*highest/total_games_played as percentage_played_with
			FROM
				(SELECT *, MAX(games_played_with) as highest
					, SUM(games_played_with) as total_games_played
				FROM
					(SELECT * FROM players_factions_with_stats ORDER BY games_played_with DESC) x
				GROUP BY player_id
				) y
			WHERE faction_id = :faction_id AND highest > 9
			ORDER BY percentage_played_with DESC
    ) z
WHERE percentage_played_with >=50
		",
		array( ':faction_id' => $faction_id)
		);
        */
        
		$frequentUseList = getDatabase()->all("
            SELECT
                a.player_id,
                a.player_nickname,
                a.player_firstname,
                a.player_lastname,
                a.games_played_with,
                100 * a.games_played_with / b.games_played AS percentage_played_with,
                b.games_played AS total_games_played
            FROM
                players_factions_with_stats AS a
                JOIN
                players_ranking AS b
                ON a.player_id = b.player_id
            WHERE
                b.games_played >= 10
                AND
                a.faction_id = :faction_id
            ORDER BY
                percentage_played_with DESC,
                games_played_with DESC,
                total_games_played DESC
		",
		array( ':faction_id' => $faction_id)
		);
		
		echo outputSuccess( array(
            'efficiencyRatiosAgainst' => $efficiencyRatiosAgainst,
			'frequentUseList' => $frequentUseList
		));
	}
	
	
	public static function getPlayerStats($player_id) {
		
		error_reporting(E_ALL);
		ini_set('display_errors', 1);
		
		$mostPlayedFaction = getDatabase()->one("	
			SELECT faction_id, faction_name, faction_color
			FROM players_factions_with_stats
			WHERE player_id = :player_id
			ORDER BY games_played_with
			DESC",
			array( ':player_id' => $player_id )
		);
		
		$gameCounts = getDatabase()->one("
			SELECT
                COUNT(*) AS total,
                SUM(is_online) AS online,
                COUNT(*)-SUM(is_online) AS in_person
			FROM games_split
			WHERE player_id = :player_id",
			array( ':player_id' => $player_id )
		);
        
        getDatabase()->execute("SET @row_numa = 0;");
        getDatabase()->execute("SET @row_numb = 0;");
        getDatabase()->execute("SET @row_numc = 0;");
        getDatabase()->execute("SET @row_numd = 0;");
        $longestStreak = getDatabase()->one("
            SELECT MIN( c.id ) - a.id + 1 as longestStreak

            FROM (SELECT @row_numa := @row_numa + 1 as id, is_win FROM games_split WHERE player_id = :player_id_a ORDER BY date asc) AS a

            LEFT JOIN (SELECT @row_numb := @row_numb + 1 as id, is_win FROM games_split WHERE player_id = :player_id_b ORDER BY date asc) AS b ON a.id = b.id + 1 AND b.is_win = 1

            LEFT JOIN (SELECT @row_numc := @row_numc + 1 as id, is_win FROM games_split WHERE player_id = :player_id_c ORDER BY date asc) AS c ON a.id <= c.id AND c.is_win = 1

            LEFT JOIN (SELECT @row_numd := @row_numd + 1 as id, is_win FROM games_split WHERE player_id = :player_id_d ORDER BY date asc) AS d ON c.id = d.id - 1 AND d.is_win = 1

            WHERE
                a.is_win = 1
                AND b.id IS NULL
                AND c.id IS NOT NULL
                AND d.id IS NULL
            GROUP BY a.id
            ORDER BY longestStreak DESC LIMIT 1;",
            array(
                ':player_id_a' => $player_id,
                ':player_id_b' => $player_id,
                ':player_id_c' => $player_id,
                ':player_id_d' => $player_id
            )
        );
        
        $gameCounts["longestStreak"] = $longestStreak["longestStreak"];
		
        if ( $gameCounts["total"] >= 20 ) {
            
            getDatabase()->execute("SET @row_numa = 0;");
            getDatabase()->execute("SET @row_numb = 0;");
            
            $performanceHistory = getDatabase()->all("			
                SELECT
                    a.is_win,
                    a.is_draw,
                    a.is_loss,
                    a.score,
                    a.date,
                    a.row_index,
                    (
                        SELECT
                            SUM(b.score) / COUNT(b.score) as movingAverage
                        FROM (
                            SELECT
                                is_win,
                                is_draw,
                                is_loss,
                                date,
                                IF(is_win, 1, IF(is_draw, 0.5, 0)) as score,
                                @row_numb := @row_numb + 1 as row_index
                            
                            FROM games_split
                            WHERE player_id = :player_id_b
                            ORDER BY date asc
                        ) as b
                        WHERE
                            b.row_index > a.row_index - 10
                            AND
                            b.row_index <= a.row_index
                    ) as tenGameAverage
                
                FROM (
                    SELECT
                        is_win,
                        is_draw,
                        is_loss,
                        date,
                        IF(is_win, 1, IF(is_draw, 0.5, 0)) as score,
                        @row_numa := @row_numa + 1 as row_index
                    
                    FROM games_split
                    WHERE player_id = :player_id_a
                    ORDER BY date asc
                ) as a
                WHERE a.row_index >= 10
                ORDER BY a.row_index ASC;",
                array(
                    ':player_id_a' => $player_id,
                    ':player_id_b' => $player_id
                )
            );
        } else {
            $performanceHistory = NULL;
        }
		
        $lastgame = getDatabase()->one("
			SELECT players.firstname, players.lastname, players.nickname, games_split.date as date
            FROM games_split
            JOIN players
            ON games_split.rival_player_id = players.player_id
            WHERE games_split.player_id = :player_id
			ORDER BY date
			DESC",
			array( ':player_id' => $player_id )
		);
		
		$factionEfficiencyRatiosWith = getDatabase()->all("	
			SELECT
				PFWS.faction_id AS faction_id,
				PFWS.faction_name AS faction_name,
				PFWS.games_won_with,
				PFWS.games_lost_with,
				PFWS.games_tied_with,
				PFWS.games_won_with/PFWS.games_played_with*100 AS efficiencyRatioWith,
				PFWS.games_played_with AS games_played_with
			FROM players_factions_with_stats AS PFWS
            WHERE games_played_with > 0 AND player_id = :player_id
			ORDER BY efficiencyRatioWith DESC",
			array( ':player_id' => $player_id)
		);
		
		$factionEfficiencyRatiosAgainst = getDatabase()->all("	
			SELECT
				PFAS.faction_id AS faction_id,
				PFAS.faction_name AS faction_name,
				PFAS.games_won_against,
				PFAS.games_lost_against,
				PFAS.games_tied_against,
				PFAS.games_won_against/PFAS.games_played_against*100 AS efficiencyRatioAgainst,
				PFAS.games_played_against AS games_played_against
			FROM players_factions_against_stats AS PFAS
            WHERE games_played_against > 0 AND player_id = :player_id
			ORDER BY efficiencyRatioAgainst DESC",
			array( ':player_id' => $player_id )
		);
		
		$opponents = getDatabase()->all("
			SELECT * FROM players_stats WHERE player_id = :player_id ORDER BY games_played DESC",
			array( ':player_id' => $player_id )
		);	
		
		echo outputSuccess( array(
			'opponents' => $opponents,
			'lastgame' => $lastgame,
			'mostPlayedFaction' => $mostPlayedFaction,
			'factionEfficiencyRatiosWith' => $factionEfficiencyRatiosWith,
			'factionEfficiencyRatiosAgainst' => $factionEfficiencyRatiosAgainst,
			'gameCounts' => $gameCounts,
			'performanceHistory' => $performanceHistory
		) );
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
	
		switch ($ranking_method) {
			// ELO rating
			case 3:
				$games = getDatabase()->all(
					'SELECT * FROM games_history ORDER BY date ASC'
				);
				$players = getDatabase()->all(
					'SELECT *,
					1000 AS elo_rating
					FROM players_ranking'
				);
				$players = ELO::getELORankings($games, $players);
				$sortList = [];
				foreach ($players as $key => $player) {
					$sortList[$key]  = $player['elo_rating'];
				}
				array_multisort($sortList, SORT_DESC, $players);
				break;
			
			// Points
			case 2:
				$players = getDatabase()->all(
					'SELECT *,
					:winPoints*games_won + :drawPoints*games_tied + :lossPoints*games_lost AS points
					FROM players_ranking
					ORDER BY points DESC, games_won DESC, games_tied DESC',
					array(":winPoints" => $league["pointsWinValue"], ":drawPoints" => $league["pointsDrawValue"], ":lossPoints" => $league["pointsLossValue"])
				);
				break;
			
			// Games played
			case 1:
			default:
				$players = getDatabase()->all(
					'SELECT * FROM players_ranking ORDER BY games_played DESC, games_won DESC'
				);
				$players_factions_stats = getDatabase()->all(
					'SELECT
						player_id,
						faction_id,
						faction_name,
						faction_color,
						parent_faction_id,
						parent_faction_name,
						parent_faction_color,
						games_played_with
					FROM players_factions_stats
					ORDER BY parent_faction_id, faction_id'
				);
				foreach ($players as $key => $player) {
					$eq_player_id = check_property_equals("player_id", $players[$key]['player_id']);
					$players[$key]['factions_stats'] = array_filter($players_factions_stats, $eq_player_id);
				
					if (count($players[$key]['factions_stats']) > 0) {
						$sortList = [];
						foreach ($players[$key]['factions_stats'] as $key2 => $faction_stats) {
							$sortList['parent_faction_id'][$key2]  = $faction_stats['parent_faction_id'];
							$sortList['faction_id'][$key2]  = $faction_stats['faction_id'];
						}
						array_multisort($sortList['parent_faction_id'], SORT_ASC, $sortList['faction_id'], SORT_ASC, $players[$key]['factions_stats']);
					}
				}
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
	
	
	public static function editLeague($leagueId = 1) {
		self::checkTier(1);
		
		self::checkFields( array('title',
							     'subtitle',
								 'defaultGameNotes',
								 'pointsWinValue',
								 'pointsDrawValue',
								 'pointsLossValue',
								 'eloStartRank',
								 'eloMasterRank',
								 'eloStartKFactor',
								 'eloSeasonedKFactor',
								 'eloMasterKFactor',
								 'eloSeasonedGameCountRequirement'),
						   $_POST );
		
		try {
			getDatabase()->execute('UPDATE leagues SET
					title = :title,
					subtitle = :subtitle,
					defaultGameNotes = :defaultGameNotes,
					pointsWinValue = :pointsWinValue,
					pointsDrawValue = :pointsDrawValue,
					pointsLossValue = :pointsLossValue,
					eloStartRank = :eloStartRank,
					eloMasterRank = :eloMasterRank,
					eloStartKFactor = :eloStartKFactor,
					eloSeasonedKFactor = :eloSeasonedKFactor,
					eloMasterKFactor = :eloMasterKFactor,
					eloSeasonedGameCountRequirement = :eloSeasonedGameCountRequirement
				WHERE league_id = :league_id',
			array(
				":title" => $_POST["title"],
				":subtitle" => $_POST["subtitle"],
				":defaultGameNotes" => $_POST["defaultGameNotes"],
				":pointsWinValue" => $_POST["pointsWinValue"],
				":pointsDrawValue" => $_POST["pointsDrawValue"],
				":pointsLossValue" => $_POST["pointsLossValue"],
				":eloStartRank" => $_POST["eloStartRank"],
				":eloMasterRank" => $_POST["eloMasterRank"],
				":eloStartKFactor" => $_POST["eloStartKFactor"],
				":eloSeasonedKFactor" => $_POST["eloSeasonedKFactor"],
				":eloMasterKFactor" => $_POST["eloMasterKFactor"],
				":eloSeasonedGameCountRequirement" => $_POST["eloSeasonedGameCountRequirement"],
				':league_id' => $leagueId
			)
			);
			echo outputSuccess( array( 'league_id' => $leagueId ) );
			
		} catch (Exception $e) {
			echo outputError($e->getMessage());
		}
		
	}
}







?>