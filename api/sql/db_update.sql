DELIMITER //
/* Do not copy first line into phpMyAdmin's SQL textarea - use the "delimiter" field below it to set delimiter to "//" */

DROP PROCEDURE IF EXISTS update_db //
CREATE PROCEDURE update_db ( )
BEGIN
	
	/* CREATE TABLES
	============================================= */
	
	CREATE TABLE IF NOT EXISTS admins ( admin_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE IF NOT EXISTS players ( player_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;  
	CREATE TABLE IF NOT EXISTS faction_groups ( factiongroup_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
	
	/* CREATE faction_groups COLUMNS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'faction_groups' AND column_name = 'name' ) = 0 THEN
		ALTER TABLE faction_groups ADD name VARCHAR(40) NOT NULL;
	END IF;
	
	ALTER TABLE faction_groups ADD UNIQUE (name);
	
	/* CREATE factions COLUMNS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'factions' AND column_name = 'name' ) = 0 THEN
		ALTER TABLE factions ADD name VARCHAR(40) NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'factions' AND column_name = 'factiongroup_id' ) = 0 THEN
		ALTER TABLE factions ADD factiongroup_id INT NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'factions' AND column_name = 'color' ) = 0 THEN
		ALTER TABLE factions ADD color VARCHAR(6) NOT NULL;
	END IF;
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'factions' AND column_name = 'logo' ) = 0 THEN
		ALTER TABLE factions ADD logo VARCHAR(20) NOT NULL;
	END IF;
	
	ALTER TABLE factions ADD UNIQUE (name);
	
	ALTER TABLE factions ADD
		FOREIGN KEY (factiongroup_id)
		REFERENCES faction_groups(factiongroup_id)
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
		factiongroup1.factiongroup_id 	AS player1_factiongroup_id,
		factiongroup1.name 				AS player1_factiongroup,
		games.player1_faction_id		AS player1_faction_id,
		faction1.name					AS player1_faction_name,
		
		games.player2_id				AS player2_id,
		player2.nickname 				AS player2_nickname,
		player2.firstname				AS player2_firstname,
		player2.lastname				AS player2_lastname,
		factiongroup2.factiongroup_id 	AS player2_factiongroup_id,
		factiongroup2.name 				AS player2_factiongroup,
		games.player2_faction_id		AS player2_faction_id,
		faction2.name					AS player2_faction_name,
		
		date, is_draw, is_ranked, is_time_runout, is_online
		
	FROM 		faction_groups AS factiongroup1, 
				faction_groups AS factiongroup2, 
				games
				
		LEFT JOIN players player1 ON games.player1_id = player1.player_id
		LEFT JOIN players player2 ON games.player2_id = player2.player_id
		LEFT JOIN factions faction1 ON games.player1_faction_id = faction1.faction_id
		LEFT JOIN factions faction2 ON games.player2_faction_id = faction2.faction_id
	
	WHERE 	factiongroup1.factiongroup_id = faction1.factiongroup_id
	AND 	factiongroup2.factiongroup_id = faction2.factiongroup_id;
	
	/* CREATE games_split VIEW
	============================================= */

	CREATE OR REPLACE VIEW games_split AS
	(
		SELECT
			game_id,
			player1_id AS player_id,
			factions.factiongroup_id AS factiongroup_id,
			player1_faction_id AS faction_id,
			date,
			1 AS is_win,
			is_draw,
			0 AS is_loss,
			is_ranked,
			is_time_runout,
			is_online
		FROM games, factions
		WHERE is_draw = 0 AND factions.faction_id = games.player1_faction_id
	)
	UNION ALL
	(
		SELECT
			game_id,
			player2_id AS player_id,
			factions.factiongroup_id AS factiongroup_id,
			player2_faction_id AS faction_id,
			date,
			0 AS is_win,
			is_draw,
			1 AS is_loss,
			is_ranked,
			is_time_runout,
			is_online
		FROM games, factions
		WHERE is_draw = 0 AND factions.faction_id = games.player2_faction_id
	)
	UNION ALL
	(
		SELECT
			game_id,
			player1_id AS player_id,
			factions.factiongroup_id AS factiongroup_id,
			player1_faction_id AS faction_id,
			date,
			0 AS is_win,
			is_draw,
			0 AS is_loss,
			is_ranked,
			is_time_runout,
			is_online
		FROM games, factions
		WHERE is_draw = 1 AND factions.faction_id = games.player1_faction_id
	)
	UNION ALL
	(
		SELECT
			game_id,
			player2_id AS player_id,
			factions.factiongroup_id AS factiongroup_id,
			player2_faction_id AS faction_id,
			date,
			0 AS is_win,
			is_draw,
			0 AS is_loss,
			is_ranked,
			is_time_runout,
			is_online
		FROM games, factions
		WHERE is_draw = 1 AND factions.faction_id = games.player2_faction_id
	);

	
	
	/* CREATE players_ranking VIEW
	============================================= */
	
	CREATE OR REPLACE VIEW players_ranking AS
	SELECT
		players.player_id,
		players.nickname,
		players.firstname,
		players.lastname,
        SUM(games_split.is_win) AS games_won,
        SUM(games_split.is_draw) AS games_tied,
        SUM(games_split.is_loss) AS games_lost,
        COUNT(*) AS games_played
	FROM  games_split games_split
		RIGHT JOIN players players on games_split.player_id = players.player_id
	GROUP BY players.player_id;
	
	
	
	
END //
DELIMITER ;
CALL update_db();
DROP PROCEDURE IF EXISTS update_db;
