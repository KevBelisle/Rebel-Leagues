/* POPULATE faction_groups
============================================= */



/* POPULATE factions
============================================= */

INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES (1,'Beastmaster', NULL, '', NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES (2,'Priest', NULL, '', NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES (3,'Warlord', NULL, '', NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES (4,'Forcemaster', NULL, '', NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES (5,'Wizard', NULL, '', NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES (6,'Druid', NULL, '', NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES (7,'Warlock', NULL, '', NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES (8,'Necromancer', NULL, '', NULL);

INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(9,  'Straywood Forest', 1, '', 'uploads/factions/4fc615d57869cde839de93529f96f66c.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(10, 'Johktari', 1, '', 'uploads/factions/55d7145a5473f45cae1dab30f39ab757.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(11, 'Westlock', 2, '', 'uploads/factions/f6883edd93f07e9f0177433f954a5135.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(12, 'Malakai', 2, '', 'uploads/factions/493be5af12217fc449073dee53e6b791.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(13, 'Pellian', 4, '', 'uploads/factions/5cdb4f3933c7ec974f9ef66fcb29831f.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(14, 'Arraxian Crown', 7, '', 'uploads/factions/77ec843a45098a32e8a29a129aabcffa.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(15, 'Bloodwave', 3, '', 'uploads/factions/412061162194656905a6109ea2e34e94.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(16, 'Air Sortilege', 5, '', 'uploads/factions/6c2a92aa4e53e386c5bf8658de388974.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(17, 'Earth Sortilege', 5, '', 'uploads/factions/2c8e7aa99d7708852e6791c3a6eeef2f.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(18, 'Fire Sortilege', 5, '', 'uploads/factions/0d0566ed7bc32b79df498f4311bdc229.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(19, 'Water Sortilege', 5, '', 'uploads/factions/a303a10ecc68afdd4a7b4fd0f5d79187.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(20, 'Wychwood', 6, '', 'uploads/factions/20aa554893c7f677fa1aaf1e9e4a5f66.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(21, 'Darkfenne', 7, '', 'uploads/factions/14b22ddbcdbb13e8d9bae05119bd18cd.png');

/* POPULATE players
============================================= */

INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (1, 'Mu0n', 'Michaël', 'Juneau');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (2, 'Wildhorn', 'Jonathan', 'Maisonneuve');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (3, 'Cyberbob666', 'Robert', 'Laliberté');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (4, 'Chucklinus', 'Charles', 'Veilleux');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (5, 'Remi', 'Remi', 'Roy');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (6, 'dubejeff', 'Jean-François', 'Dubé');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (7, 'Seb', 'Sébastien', 'Martel');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (8, 'Dan', 'Daniel', 'Lavoie');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (9, 'GomJabbar', 'David', 'Bernier');

/* POPULATE games
============================================= */

INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(1, 3, 11, 2, 15, '2013-11-02 19:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(2, 2, 19, 3, 11, '2013-11-02 21:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(3, 1, 19, 2, 15, '2013-11-11 19:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(4, 2, 9, 6, 16, '2013-11-12 19:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(5, 2, 16, 7, 13, '2013-12-02 19:00:00', 1, 1, 1, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(6, 2, 14, 4, 9, '2013-12-10 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(7, 2, 14, 4, 9, '2013-12-10 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(8, 2, 14, 3, 21, '2013-12-11 21:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(9, 2, 14, 5, 9, '2013-12-16 19:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(10, 5, 14, 2, 21, '2013-12-16 20:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(11, 5, 8, 2, 14, '2013-12-16 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(12, 5, 11, 2, 14, '2013-12-16 22:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(13, 3, 16, 2, 14, '2014-01-03 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(14, 6, 15, 4, 20, '2014-01-14 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(15, 2, 16, 5, 15, '2014-01-14 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(16, 5, 9, 2, 17, '2014-01-14 22:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(17, 5, 13, 4, 16, '2014-01-22 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(18, 2, 19, 3, 9, '2014-01-22 19:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(19, 2, 9, 1, 21, '2014-01-28 20:45:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(20, 2, 12, 1, 21, '2014-01-28 22:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(21, 5, 9, 3, 15, '2014-01-29 21:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(22, 2, 9, 1, 21, '2014-02-01 16:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(23, 2, 14, 1, 21, '2014-02-01 16:45:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(24, 2, 12, 1, 21, '2014-02-01 17:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(25, 4, 10, 6, 14, '2014-02-19 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(26, 2, 19, 5, 15, '2014-02-19 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(27, 2, 12, 4, 12, '2014-02-19 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(28, 5, 9, 6, 20, '2014-02-19 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(29, 2, 12, 8, 9, '2014-02-24 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(30, 2, 9, 8, 9, '2014-02-24 21:15:00', 0, 1, 0, 1, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(31, 8, 14, 2, 9, '2014-02-24 22:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(32, 5, 9, 1, 21, '2014-02-24 22:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(33, 9, 14, 1, 21, '2014-02-26 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(34, 9, 14, 1, 21, '2014-02-26 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(35, 8, 14, 1, 21, '2014-02-27 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(36, 1, 17, 8, 14, '2014-02-27 22:00:00', 0, 1, 0, 0, NULL);
  