DELIMITER //
/* Do not copy first line into phpMyAdmin's SQL textarea - use the "delimiter" field below it to set delimiter to "//" */

DROP PROCEDURE IF EXISTS update_db //
CREATE PROCEDURE update_db ( )
BEGIN
	
	/* CREATE TABLES
	============================================= */
	
	CREATE TABLE IF NOT EXISTS admins ( admin_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE IF NOT EXISTS players ( player_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;  
	CREATE TABLE IF NOT EXISTS factions ( faction_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE IF NOT EXISTS games ( game_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

	
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
		WHERE is_draw = 0
	)
	UNION ALL
	(
		SELECT
			game_id,
			player2_id AS player_id,
			factions.parent_faction_id AS parent_faction_id,
			player2_faction_id AS faction_id,
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
		WHERE is_draw = 0
	)
	UNION ALL
	(
		SELECT
			game_id,
			player1_id AS player_id,
			factions.parent_faction_id AS parent_faction_id,
			player1_faction_id AS faction_id,
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
		WHERE is_draw = 1
	)
	UNION ALL
	(
		SELECT
			game_id,
			player2_id AS player_id,
			factions.parent_faction_id AS parent_faction_id,
			player2_faction_id AS faction_id,
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
	
	/* CREATE factions_games_split VIEW
	============================================= */
	
	CREATE OR REPLACE VIEW factions_games_split AS
		SELECT
			player1_parent_faction_id,
			player1_faction_id,
			player2_parent_faction_id,
			player2_faction_id,
			1 AS is_win,
			is_draw,
			0 AS is_loss
		FROM games_history
		WHERE is_draw = 0
	UNION ALL
		SELECT 
			player2_parent_faction_id,
			player2_faction_id,
			player1_parent_faction_id,
			player1_faction_id,
			0 AS is_win,
			is_draw,
			1 AS is_loss
		FROM games_history
		WHERE is_draw = 0
	UNION ALL
		SELECT
			player1_parent_faction_id,
			player1_faction_id,
			player2_parent_faction_id,
			player2_faction_id,
			0 AS is_win,
			is_draw,
			0 AS is_loss
		FROM games_history
		WHERE is_draw = 1
	UNION ALL
		SELECT 
			player2_parent_faction_id,
			player2_faction_id,
			player1_parent_faction_id,
			player1_faction_id,
			0 AS is_win,
			is_draw,
			0 AS is_loss
		FROM games_history
		WHERE is_draw = 1
		
	/* CREATE factions_centric VIEW
	============================================= */
	
	CREATE OR REPLACE VIEW factions_centric AS
	SELECT
		player1_parent_faction_id,
		player1_faction_id,
		player2_parent_faction_id,
		player2_faction_id,
        COALESCE(SUM(factions_games_split.is_win), 0) AS games_won,
        COALESCE(SUM(factions_games_split.is_draw), 0) AS games_tied,
        COALESCE(SUM(factions_games_split.is_loss), 0) AS games_lost,
        COALESCE(SUM(factions_games_split.is_win), 0) + COALESCE(SUM(factions_games_split.is_draw), 0) + COALESCE(SUM(factions_games_split.is_loss), 0) AS games_played
	FROM  factions_games_split factions_games_split
	GROUP BY player1_faction_id, player2_faction_id
	ORDER BY player1_faction_id
	
END //
DELIMITER ;
CALL update_db();
DROP PROCEDURE IF EXISTS update_db;
