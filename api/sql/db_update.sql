DELIMITER //
/* Do not copy first line into phpMyAdmin's SQL textarea - use the "delimiter" field below it to set delimiter to "//" */

DROP PROCEDURE IF EXISTS update_db //
CREATE PROCEDURE update_db ( )
BEGIN
	
	/* CREATE TABLES
	============================================= */
	
	CREATE TABLE IF NOT EXISTS admins ( admin_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY );
	CREATE TABLE IF NOT EXISTS players ( player_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY );
	CREATE TABLE IF NOT EXISTS teams ( team_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY );
	CREATE TABLE IF NOT EXISTS factions ( faction_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY );
	CREATE TABLE IF NOT EXISTS games ( game_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY );

	
	/* CREATE admins COLUMNS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'admins' AND column_name = 'username' ) = 0 THEN
		ALTER TABLE admins ADD username VARCHAR(20);
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'admins' AND column_name = 'password' ) = 0 THEN
		ALTER TABLE admins ADD password VARCHAR(20);
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'admins' AND column_name = 'salt' ) = 0 THEN
		ALTER TABLE admins ADD salt VARCHAR(20);
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'admins' AND column_name = 'tier' ) = 0 THEN
		ALTER TABLE admins ADD tier INT;
	END IF;
	
	
	/* CREATE players COLUMNS
	============================================= */

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'players' AND column_name = 'nickname' ) = 0 THEN
		ALTER TABLE players ADD nickname VARCHAR(20);
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'players' AND column_name = 'firstname' ) = 0 THEN
		ALTER TABLE players ADD firstname VARCHAR(20);
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'players' AND column_name = 'lastname' ) = 0 THEN
		ALTER TABLE players ADD lastname VARCHAR(20);
	END IF;
	
	
	/* CREATE factions COLUMNS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'factions' AND column_name = 'name' ) = 0 THEN
		ALTER TABLE factions ADD name VARCHAR(20);
	END IF;
	
	
	/* CREATE games COLUMNS + FOREIGN KEY CONSTRAINTS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'team1_id' ) = 0 THEN
		ALTER TABLE games ADD team1_id INT;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'team1_faction_id' ) = 0 THEN
		ALTER TABLE games ADD team1_faction_id INT;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'team2_id' ) = 0 THEN
		ALTER TABLE games ADD team2_id INT;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'team2_faction_id' ) = 0 THEN
		ALTER TABLE games ADD team2_faction_id INT;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'date' ) = 0 THEN
		ALTER TABLE games ADD date DATETIME;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'is_draw' ) = 0 THEN
		ALTER TABLE games ADD is_draw BOOL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'is_ranked' ) = 0 THEN
		ALTER TABLE games ADD is_ranked BOOL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'is_time_runout' ) = 0 THEN
		ALTER TABLE games ADD is_time_runout BOOL;
	END IF;

	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'games' AND column_name = 'is_online' ) = 0 THEN
		ALTER TABLE games ADD is_online BOOL;
	END IF;
	
	ALTER TABLE games ADD
		FOREIGN KEY (team1_faction_id, team2_faction_id)
		REFERENCES factions(faction_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
	
	
	/* CREATE teams COLUMNS
	============================================= */
	
	IF ( SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'teams' AND column_name = 'player_id' ) = 0 THEN
		ALTER TABLE teams ADD player_id VARCHAR(20);
	END IF;
	
	ALTER TABLE teams ADD
		FOREIGN KEY (team_id)
		REFERENCES games(team1_id, team2_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
	
	ALTER TABLE teams ADD
		FOREIGN KEY (player_id)
		REFERENCES players(player_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
	
	
	/* CREATE gamelog VIEW
	============================================= */
	
	
	
	
	
END //
DELIMITER ;
CALL update_db();
DROP PROCEDURE IF EXISTS update_db;