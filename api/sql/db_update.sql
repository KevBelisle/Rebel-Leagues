DELIMITER //
/* Do not copy first line into phpMyAdmin's SQL textarea - use the "delimiter" field below it to set delimiter to "//" */

DROP PROCEDURE IF EXISTS update_db //
CREATE PROCEDURE update_db ( )
BEGIN
	
	/* CREATE TABLES
	============================================= */
	
	CREATE TABLE IF NOT EXISTS leagues ( league_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE IF NOT EXISTS ranking_methods ( ranking_method_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE IF NOT EXISTS leagues_ranking_methods ( league_id INT NOT NULL, ranking_method_id INT NOT NULL ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE IF NOT EXISTS admins ( admin_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE IF NOT EXISTS players ( player_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;  
	CREATE TABLE IF NOT EXISTS factions ( faction_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE IF NOT EXISTS games ( game_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

	
	/* CREATE leagues COLUMNS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'title' ) = 0 THEN
		ALTER TABLE leagues ADD title VARCHAR(60) NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'subtitle' ) = 0 THEN
		ALTER TABLE leagues ADD subtitle VARCHAR(60) NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'logo' ) = 0 THEN
		ALTER TABLE leagues ADD logo VARCHAR(60);
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'defaultGameNotes' ) = 0 THEN
		ALTER TABLE leagues ADD defaultGameNotes VARCHAR(500);
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'pointsWinValue' ) = 0 THEN
		ALTER TABLE leagues ADD pointsWinValue INT NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'pointsDrawValue' ) = 0 THEN
		ALTER TABLE leagues ADD pointsDrawValue INT NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'pointsLossValue' ) = 0 THEN
		ALTER TABLE leagues ADD pointsLossValue INT NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'eloStartRank' ) = 0 THEN
		ALTER TABLE leagues ADD eloStartRank INT NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'eloMasterRank' ) = 0 THEN
		ALTER TABLE leagues ADD eloMasterRank INT NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'eloStartKFactor' ) = 0 THEN
		ALTER TABLE leagues ADD eloStartKFactor INT NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'eloSeasonedKFactor' ) = 0 THEN
		ALTER TABLE leagues ADD eloSeasonedKFactor INT NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'eloMasterKFactor' ) = 0 THEN
		ALTER TABLE leagues ADD eloMasterKFactor INT NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues' AND column_name = 'eloSeasonedGameCountRequirement' ) = 0 THEN
		ALTER TABLE leagues ADD eloSeasonedGameCountRequirement INT NOT NULL;
	END IF;
	
	
	/* CREATE ranking_methods COLUMNS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'ranking_methods' AND column_name = 'ranking_method_name' ) = 0 THEN
		ALTER TABLE ranking_methods ADD ranking_method_name VARCHAR(60) NOT NULL;
	END IF;
	
	INSERT INTO ranking_methods (ranking_method_id, ranking_method_name) VALUES (1, "games_played")
		ON DUPLICATE KEY UPDATE ranking_method_id=ranking_method_id;
	INSERT INTO ranking_methods (ranking_method_id, ranking_method_name) VALUES (2, "points")
		ON DUPLICATE KEY UPDATE ranking_method_id=ranking_method_id;
	INSERT INTO ranking_methods (ranking_method_id, ranking_method_name) VALUES (3, "elo_rating")
		ON DUPLICATE KEY UPDATE ranking_method_id=ranking_method_id;
	
	
	/* CREATE leagues_ranking_methods COLUMNS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'leagues_ranking_methods' AND column_name = 'default_ranking' ) = 0 THEN
		ALTER TABLE leagues_ranking_methods ADD default_ranking BOOLEAN NOT NULL;
	END IF;
	
	ALTER TABLE leagues_ranking_methods
		ADD UNIQUE INDEX(league_id, ranking_method_id);
	
	ALTER TABLE leagues_ranking_methods ADD
		FOREIGN KEY (league_id)
		REFERENCES leagues(league_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
	
	ALTER TABLE leagues_ranking_methods ADD
		FOREIGN KEY (ranking_method_id)
		REFERENCES ranking_methods(ranking_method_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
	
	
	/* CREATE admins COLUMNS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'admins' AND column_name = 'username' ) = 0 THEN
		ALTER TABLE admins ADD username VARCHAR(40) NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'admins' AND column_name = 'password' ) = 0 THEN
		ALTER TABLE admins ADD password VARCHAR(128) NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'admins' AND column_name = 'salt' ) = 0 THEN
		ALTER TABLE admins ADD salt VARCHAR(20) NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'admins' AND column_name = 'tier' ) = 0 THEN
		ALTER TABLE admins ADD tier INT NOT NULL;
	END IF;
	
	ALTER TABLE admins ADD UNIQUE (username);
	
	
	/* CREATE players COLUMNS
	============================================= */

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'players' AND column_name = 'nickname' ) = 0 THEN
		ALTER TABLE players ADD nickname VARCHAR(20) NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'players' AND column_name = 'firstname' ) = 0 THEN
		ALTER TABLE players ADD firstname VARCHAR(20) NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'players' AND column_name = 'lastname' ) = 0 THEN
		ALTER TABLE players ADD lastname VARCHAR(20) NOT NULL;
	END IF;
	
	ALTER TABLE players ADD UNIQUE (nickname);
	
	
	/* CREATE factions COLUMNS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'factions' AND column_name = 'name' ) = 0 THEN
		ALTER TABLE factions ADD name VARCHAR(40) NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'factions' AND column_name = 'parent_faction_id' ) = 0 THEN
		ALTER TABLE factions ADD parent_faction_id INT;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'factions' AND column_name = 'color' ) = 0 THEN
		ALTER TABLE factions ADD color VARCHAR(6);
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'factions' AND column_name = 'logo' ) = 0 THEN
		ALTER TABLE factions ADD logo VARCHAR(60);
	END IF;
	
	ALTER TABLE factions ADD UNIQUE (name);
	
	ALTER TABLE factions ADD
		FOREIGN KEY (parent_faction_id)
		REFERENCES factions(faction_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
	
	
	/* CREATE games COLUMNS + FOREIGN KEY CONSTRAINTS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'player1_id' ) = 0 THEN
		ALTER TABLE games ADD player1_id INT NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'player1_faction_id' ) = 0 THEN
		ALTER TABLE games ADD player1_faction_id INT NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'player2_id' ) = 0 THEN
		ALTER TABLE games ADD player2_id INT NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'player2_faction_id' ) = 0 THEN
		ALTER TABLE games ADD player2_faction_id INT NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'date' ) = 0 THEN
		ALTER TABLE games ADD date DATETIME NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'is_draw' ) = 0 THEN
		ALTER TABLE games ADD is_draw BOOL NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'is_ranked' ) = 0 THEN
		ALTER TABLE games ADD is_ranked BOOL NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'is_time_runout' ) = 0 THEN
		ALTER TABLE games ADD is_time_runout BOOL NOT NULL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'is_online' ) = 0 THEN
		ALTER TABLE games ADD is_online BOOL NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'notes' ) = 0 THEN
		ALTER TABLE games ADD notes VARCHAR(500);
	END IF;
	
	
	ALTER TABLE games ADD
		FOREIGN KEY (player1_faction_id)
		REFERENCES factions(faction_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
	
	ALTER TABLE games ADD
		FOREIGN KEY (player2_faction_id)
		REFERENCES factions(faction_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
	
	ALTER TABLE games ADD
		FOREIGN KEY (player1_id)
		REFERENCES players(player_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
	
	ALTER TABLE games ADD
		FOREIGN KEY (player2_id)
		REFERENCES players(player_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
	
	
	/* CREATE games_history VIEW
	============================================= */
	
	CREATE OR REPLACE VIEW games_history AS
	SELECT
		games.game_id					AS game_id,
	
		games.player1_id				AS player1_id,
		player1.nickname				AS player1_nickname,
		player1.firstname				AS player1_firstname,
		player1.lastname				AS player1_lastname,
		
		parentfaction1.faction_id 		AS player1_parent_faction_id,
		parentfaction1.name 			AS player1_parent_faction_name,
		parentfaction1.color 			AS player1_parent_faction_color,
		
		games.player1_faction_id		AS player1_faction_id,
		faction1.name					AS player1_faction_name,
		faction1.color					AS player1_faction_color,
		
		games.player2_id				AS player2_id,
		player2.nickname 				AS player2_nickname,
		player2.firstname				AS player2_firstname,
		player2.lastname				AS player2_lastname,
		
		parentfaction2.faction_id 		AS player2_parent_faction_id,
		parentfaction2.name 			AS player2_parent_faction_name,
		parentfaction2.color 			AS player2_parent_faction_color,
		
		games.player2_faction_id		AS player2_faction_id,
		faction2.name					AS player2_faction_name,
		faction2.color					AS player2_faction_color,
		
		date, is_draw, is_ranked, is_time_runout, is_online, notes
		
	FROM games
	LEFT OUTER JOIN	players AS player1 ON games.player1_id = player1.player_id
	LEFT OUTER JOIN players AS player2 ON games.player2_id = player2.player_id
	LEFT OUTER JOIN factions AS faction1 ON games.player1_faction_id = faction1.faction_id
	LEFT OUTER JOIN factions AS faction2 ON games.player2_faction_id = faction2.faction_id
	LEFT OUTER JOIN factions AS parentfaction1 ON parentfaction1.faction_id = faction1.parent_faction_id
	LEFT OUTER JOIN factions AS parentfaction2 ON parentfaction2.faction_id = faction2.parent_faction_id;
	
	
	/* CREATE games_split VIEW
	============================================= */

	CREATE OR REPLACE VIEW games_split AS
	(
		SELECT
			game_id,
			player1_id AS player_id,
			factions.parent_faction_id AS parent_faction_id,
			player1_faction_id AS faction_id,
			
			player2_id AS rival_player_id,
			factions2.parent_faction_id AS rival_parent_faction_id,
			player2_faction_id AS rival_faction_id,
			date,
			1 AS is_win,
			is_draw,
			0 AS is_loss,
			is_ranked,
			is_time_runout,
			is_online
		FROM games
		LEFT OUTER JOIN factions ON factions.faction_id = games.player1_faction_id
		LEFT OUTER JOIN factions AS parent_factions ON factions.parent_faction_id = parent_factions.faction_id
		
		LEFT OUTER JOIN factions AS factions2 ON factions2.faction_id = games.player2_faction_id
		LEFT OUTER JOIN factions AS rival_parent_factions ON factions2.parent_faction_id = factions2.faction_id
		WHERE is_draw = 0
	)
	UNION ALL
	(
		SELECT
			game_id,
			player2_id AS player_id,
			factions.parent_faction_id AS parent_faction_id,
			player2_faction_id AS faction_id,
			
			player1_id AS rival_player_id,
			factions1.parent_faction_id AS rival_parent_faction_id,
			player1_faction_id AS rival_faction_id,
			date,
			0 AS is_win,
			is_draw,
			1 AS is_loss,
			is_ranked,
			is_time_runout,
			is_online
		FROM games
		LEFT OUTER JOIN factions ON factions.faction_id = games.player2_faction_id
		LEFT OUTER JOIN factions AS parent_factions ON factions.parent_faction_id = parent_factions.faction_id
		
		LEFT OUTER JOIN factions AS factions1 ON factions1.faction_id = games.player1_faction_id
		LEFT OUTER JOIN factions AS rival_parent_factions ON factions1.parent_faction_id = factions1.faction_id
		WHERE is_draw = 0
	)
	UNION ALL
	(
		SELECT
			game_id,
			player1_id AS player_id,
			factions.parent_faction_id AS parent_faction_id,
			player1_faction_id AS faction_id,
			
			player2_id AS rival_player_id,
			factions2.parent_faction_id AS rival_parent_faction_id,
			player2_faction_id AS rival_faction_id,
			date,
			0 AS is_win,
			is_draw,
			0 AS is_loss,
			is_ranked,
			is_time_runout,
			is_online
		FROM games
		LEFT OUTER JOIN factions ON factions.faction_id = games.player1_faction_id
		LEFT OUTER JOIN factions AS parent_factions ON factions.parent_faction_id = parent_factions.faction_id
		
		LEFT OUTER JOIN factions AS factions2 ON factions2.faction_id = games.player2_faction_id
		LEFT OUTER JOIN factions AS rival_parent_factions ON factions2.parent_faction_id = factions2.faction_id
		WHERE is_draw = 1
	)
	UNION ALL
	(
		SELECT
			game_id,
			player2_id AS player_id,
			factions.parent_faction_id AS parent_faction_id,
			player2_faction_id AS faction_id,
			
			player1_id AS rival_player_id,
			factions1.parent_faction_id AS rival_parent_faction_id,
			player1_faction_id AS rival_faction_id,
			date,
			0 AS is_win,
			is_draw,
			0 AS is_loss,
			is_ranked,
			is_time_runout,
			is_online
		FROM games
		LEFT OUTER JOIN factions ON factions.faction_id = games.player2_faction_id
		LEFT OUTER JOIN factions AS parent_factions ON factions.parent_faction_id = parent_factions.faction_id
		
		LEFT OUTER JOIN factions AS factions1 ON factions1.faction_id = games.player1_faction_id
		LEFT OUTER JOIN factions AS rival_parent_factions ON factions1.parent_faction_id = factions1.faction_id
		WHERE is_draw = 1
	);

	
	/* CREATE players_ranking VIEW
	============================================= */
	
	CREATE OR REPLACE VIEW players_ranking AS
	SELECT
		players.player_id,
		players.nickname,
		players.firstname,
		players.lastname,
        COALESCE(SUM(games_split.is_win), 0) AS games_won,
        COALESCE(SUM(games_split.is_draw), 0) AS games_tied,
        COALESCE(SUM(games_split.is_loss), 0) AS games_lost,
        COALESCE(SUM(games_split.is_win), 0) + COALESCE(SUM(games_split.is_draw), 0) + COALESCE(SUM(games_split.is_loss), 0) AS games_played
	FROM  games_split games_split
		RIGHT JOIN players players on games_split.player_id = players.player_id
	GROUP BY players.player_id;
	
	
	/* CREATE factions_ranking VIEW
	============================================= */
	
	CREATE OR REPLACE VIEW factions_ranking AS
	SELECT
		factions_games_split.parent_faction_id,
		parent_faction.name AS parent_faction_name,
		factions_games_split.faction_id,
		child_faction.name AS faction_name,
		
		COALESCE(SUM(is_win),0) AS games_won,
		COALESCE(SUM(is_draw),0) AS games_tied,
		COALESCE(SUM(is_loss),0) AS games_lost,
		COALESCE(SUM(is_win), 0) + COALESCE(SUM(is_draw), 0) + COALESCE(SUM(is_loss), 0) AS games_played,
		games_won / games_played AS ratio
	FROM factions_games_split
		LEFT OUTER JOIN factions child_faction ON child_faction.faction_id = factions_games_split.faction_id
		LEFT OUTER JOIN factions parent_faction ON parent_faction.faction_id = factions_games_split.parent_faction_id
	GROUP BY faction_id
	ORDER BY games_won DESC

	
	/* CREATE factions_games_split VIEW
	============================================= */
	
	CREATE OR REPLACE VIEW factions_games_split AS
		SELECT
			player1_parent_faction_id AS parent_faction_id,
			player1_faction_id AS faction_id,
			player2_parent_faction_id AS rival_parent_faction_id,
			player2_faction_id AS rival_faction_id,
			1 AS is_win,
			is_draw,
			0 AS is_loss
		FROM games_history
		WHERE is_draw = 0
	UNION ALL
		SELECT
			player2_parent_faction_id AS parent_faction_id,
			player2_faction_id AS faction_id,
			player1_parent_faction_id AS rival_parent_faction_id,
			player1_faction_id AS rival_faction_id,
			0 AS is_win,
			is_draw,
			1 AS is_loss
		FROM games_history
		WHERE is_draw = 0
	UNION ALL
		SELECT
			player1_parent_faction_id AS parent_faction_id,
			player1_faction_id AS faction_id,
			player2_parent_faction_id AS rival_parent_faction_id,
			player2_faction_id AS rival_faction_id,
			0 AS is_win,
			is_draw,
			0 AS is_loss
		FROM games_history
		WHERE is_draw = 1
	UNION ALL
		SELECT
			player2_parent_faction_id AS parent_faction_id,
			player2_faction_id AS faction_id,
			player1_parent_faction_id AS rival_parent_faction_id,
			player1_faction_id AS rival_faction_id,
			0 AS is_win,
			is_draw,
			0 AS is_loss
		FROM games_history
		WHERE is_draw = 1;
		
		
	/* CREATE factions_stats VIEW -- factions against other factions
	============================================= */
	
	CREATE OR REPLACE VIEW factions_stats AS
	SELECT
		factions_games_split.faction_id,
		
		rival_factions.faction_id AS rival_faction_id,
		rival_factions.name AS rival_faction_name,
		rival_factions.color AS rival_faction_color,
		
		rival_parent_factions.faction_id AS rival_parent_faction_id,
		rival_parent_factions.name AS rival_parent_faction_name,
		rival_parent_factions.color AS rival_parent_faction_color,
		
        COALESCE(SUM(is_win), 0) AS games_won,
        COALESCE(SUM(is_draw), 0) AS games_tied,
        COALESCE(SUM(is_loss), 0) AS games_lost,
        COALESCE(SUM(is_win), 0) + COALESCE(SUM(is_draw), 0) + COALESCE(SUM(is_loss), 0) AS games_played
	FROM  factions_games_split factions_games_split
		LEFT OUTER JOIN factions rival_factions ON rival_factions.faction_id = factions_games_split.rival_faction_id
		LEFT OUTER JOIN factions rival_parent_factions ON rival_parent_factions.faction_id = factions_games_split.rival_parent_faction_id
	GROUP BY faction_id, rival_faction_id
	ORDER BY factions_games_split.faction_id, factions_games_split.rival_parent_faction_id, factions_games_split.rival_faction_id;
	
	
	/* CREATE players_stats VIEW -- players against other players (use this to detect rivalries + dominations with a future view)
	============================================= */
	
	CREATE OR REPLACE VIEW players_stats AS
	SELECT
		games_split.player_id,
		
		rival_players.player_id AS rival_player_id,
		rival_players.nickname AS rival_nickname,
		rival_players.firstname AS rival_firstname,
		rival_players.lastname AS rival_lastname,
		
        COALESCE(SUM(is_win), 0) AS games_won,
        COALESCE(SUM(is_draw), 0) AS games_tied,
        COALESCE(SUM(is_loss), 0) AS games_lost,
        COALESCE(SUM(is_win), 0) + COALESCE(SUM(is_draw), 0) + COALESCE(SUM(is_loss), 0) AS games_played
	FROM  games_split games_split
		LEFT OUTER JOIN players players ON players.player_id = games_split.player_id
		LEFT OUTER JOIN players rival_players ON rival_players.player_id = games_split.rival_player_id
	GROUP BY player_id, rival_player_id
	ORDER BY games_split.player_id, games_split.rival_player_id;
	
	
	/* CREATE players_factions_stats VIEW -- how does a player fare with/against the different factions?
	============================================= */
	
	CREATE OR REPLACE VIEW players_factions_stats AS
	SELECT
		games_played.player_id as player_id,
		players.nickname as player_nickname,
		players.firstname as player_firstname,
		players.lastname as player_lastname,
		
		games_played.faction_id as faction_id,
		factions.name AS faction_name,
		factions.color AS faction_color,
		
		parent_factions.faction_id AS parent_faction_id,
		parent_factions.name AS parent_faction_name,
		parent_factions.color AS parent_faction_color,
		
		SUM(games_played.games_won_with) AS games_won_with,
		SUM(games_played.games_tied_with) AS games_tied_with,
		SUM(games_played.games_lost_with) AS games_lost_with,
		SUM(games_played.games_played_with) AS games_played_with,
		SUM(games_played.games_won_against) AS games_won_against,
		SUM(games_played.games_tied_against) AS games_tied_against,
		SUM(games_played.games_lost_against) AS games_lost_against,
		SUM(games_played.games_played_against) AS games_played_against
	FROM
	(
		SELECT
			player_id,
			faction_id,
			
			COALESCE(SUM(is_win), 0) AS games_won_with,
			COALESCE(SUM(is_draw), 0) AS games_tied_with,
			COALESCE(SUM(is_loss), 0) AS games_lost_with,
			COALESCE(SUM(is_win), 0) + COALESCE(SUM(is_draw), 0) + COALESCE(SUM(is_loss), 0) AS games_played_with,
			
			0 AS games_won_against,
			0 AS games_tied_against,
			0 AS games_lost_against,
			0 AS games_played_against
			
	
		FROM games_split
		GROUP BY player_id, faction_id
	UNION
		SELECT
			player_id,
			rival_faction_id AS faction_id,
			
			0 AS games_won_with,
			0 AS games_tied_with,
			0 AS games_lost_with,
			0 AS games_played_with,
			
			COALESCE(SUM(is_win), 0) AS games_won_against,
			COALESCE(SUM(is_draw), 0) AS games_tied_against,
			COALESCE(SUM(is_loss), 0) AS games_lost_against,
			COALESCE(SUM(is_win), 0) + COALESCE(SUM(is_draw), 0) + COALESCE(SUM(is_loss), 0) AS games_played_against
			
	
		FROM games_split
		GROUP BY player_id, rival_faction_id
	) AS games_played
	
	LEFT OUTER JOIN players players ON players.player_id = games_played.player_id
	LEFT OUTER JOIN factions factions ON factions.faction_id = games_played.faction_id
	LEFT OUTER JOIN factions parent_factions ON parent_factions.faction_id = factions.parent_faction_id
	
	GROUP BY games_played.player_id, games_played.faction_id
		
	
	
END //
DELIMITER ;
CALL update_db();
DROP PROCEDURE IF EXISTS update_db;
