


/* POPULATE factions
============================================= */

INSERT INTO factions (faction_id, name) VALUES (1, 'Empire');
INSERT INTO factions (faction_id, name) VALUES (2, 'Alliance');



/* POPULATE players
============================================= */

INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (1, 'Klutz', 'Kevin', 'Bélisle');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (2, 'Mu0n', 'Michael', 'Juneau');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (3, 'GomJabbar', 'David', 'Bernier');



/* POPULATE games
============================================= */

INSERT INTO games (player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online) VALUES (1, 2, 2, 1, '2013-01-10 20:30:40', 0, 1, 0, 0 );
INSERT INTO games (player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online) VALUES (2, 2, 3, 1, '2013-01-10 20:30:40', 0, 1, 0, 0 );
INSERT INTO games (player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online) VALUES (1, 2, 2, 1, '2013-01-10 20:30:40', 0, 1, 0, 0 );
INSERT INTO games (player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online) VALUES (2, 1, 3, 2, '2013-01-10 20:30:40', 0, 1, 0, 0 );
INSERT INTO games (player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online) VALUES (1, 2, 2, 1, '2013-01-10 20:30:40', 0, 1, 0, 0 );
INSERT INTO games (player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online) VALUES (2, 1, 3, 1, '2013-01-10 20:30:40', 0, 1, 0, 0 );