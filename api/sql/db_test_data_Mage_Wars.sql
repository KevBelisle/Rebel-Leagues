/* POPULATE faction_groups
============================================= */

INSERT INTO factiongroups (factiongroup_id, name) VALUES (1,'Beastmaster');
INSERT INTO factiongroups (factiongroup_id, name) VALUES (2,'Priest');
INSERT INTO factiongroups (factiongroup_id, name) VALUES (3,'Warlord');
INSERT INTO factiongroups (factiongroup_id, name) VALUES (4,'Forcemaster');
INSERT INTO factiongroups (factiongroup_id, name) VALUES (5,'Wizard');
INSERT INTO factiongroups (factiongroup_id, name) VALUES (6,'Druid');
INSERT INTO factiongroups (factiongroup_id, name) VALUES (7,'Warlock');
INSERT INTO factiongroups (factiongroup_id, name) VALUES (8,'Necromancer');


/* POPULATE factions
============================================= */

INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(1, 'Straywood Forest', 1, '', 'uploads/factions/4fc615d57869cde839de93529f96f66c.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(2, 'Johktari', 1, '', 'uploads/factions/55d7145a5473f45cae1dab30f39ab757.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(3, 'Westlock', 2, '', 'uploads/factions/f6883edd93f07e9f0177433f954a5135.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(4, 'Malakai', 2, '', 'uploads/factions/493be5af12217fc449073dee53e6b791.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(5, 'Pellian', 4, '', 'uploads/factions/5cdb4f3933c7ec974f9ef66fcb29831f.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(6, 'Arraxian Crown', 7, '', 'uploads/factions/77ec843a45098a32e8a29a129aabcffa.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(7, 'Bloodwave', 3, '', 'uploads/factions/412061162194656905a6109ea2e34e94.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(8, 'Air Sortilege', 5, '', 'uploads/factions/6c2a92aa4e53e386c5bf8658de388974.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(9, 'Earth Sortilege', 5, '', 'uploads/factions/2c8e7aa99d7708852e6791c3a6eeef2f.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(10, 'Fire Sortilege', 5, '', 'uploads/factions/0d0566ed7bc32b79df498f4311bdc229.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(11, 'Water Sortilege', 5, '', 'uploads/factions/a303a10ecc68afdd4a7b4fd0f5d79187.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(12, 'Wychwood', 6, '', 'uploads/factions/20aa554893c7f677fa1aaf1e9e4a5f66.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(13, 'Darkfenne', 7, '', 'uploads/factions/14b22ddbcdbb13e8d9bae05119bd18cd.png');

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

INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(1, 3, 3, 2, 7, '2013-11-02 19:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(2, 2, 11, 3, 3, '2013-11-02 21:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(3, 1, 11, 2, 7, '2013-11-11 19:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(4, 2, 1, 6, 8, '2013-11-12 19:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(5, 2, 8, 7, 5, '2013-12-02 19:00:00', 1, 1, 1, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(6, 2, 6, 4, 1, '2013-12-10 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(7, 2, 6, 4, 1, '2013-12-10 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(8, 2, 6, 3, 13, '2013-12-11 21:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(9, 2, 6, 5, 1, '2013-12-16 19:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(10, 5, 6, 2, 13, '2013-12-16 20:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(11, 5, 2, 2, 6, '2013-12-16 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(12, 5, 3, 2, 6, '2013-12-16 22:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(13, 3, 8, 2, 6, '2014-01-03 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(14, 6, 7, 4, 12, '2014-01-14 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(15, 2, 8, 5, 7, '2014-01-14 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(16, 5, 1, 2, 9, '2014-01-14 22:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(17, 5, 5, 4, 8, '2014-01-22 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(18, 2, 11, 3, 1, '2014-01-22 19:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(19, 2, 1, 1, 13, '2014-01-28 20:45:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(20, 2, 4, 1, 13, '2014-01-28 22:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(21, 5, 1, 3, 7, '2014-01-29 21:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(22, 2, 1, 1, 13, '2014-02-01 16:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(23, 2, 6, 1, 13, '2014-02-01 16:45:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(24, 2, 4, 1, 13, '2014-02-01 17:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(25, 4, 2, 6, 6, '2014-02-19 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(26, 2, 11, 5, 7, '2014-02-19 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(27, 2, 4, 4, 4, '2014-02-19 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(28, 5, 1, 6, 12, '2014-02-19 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(29, 2, 4, 8, 1, '2014-02-24 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(30, 2, 1, 8, 1, '2014-02-24 21:15:00', 0, 1, 0, 1, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(31, 8, 6, 2, 1, '2014-02-24 22:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(32, 5, 1, 1, 13, '2014-02-24 22:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(33, 9, 6, 1, 13, '2014-02-26 20:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(34, 9, 6, 1, 13, '2014-02-26 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(35, 8, 6, 1, 13, '2014-02-27 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(36, 1, 9, 8, 6, '2014-02-27 22:00:00', 0, 1, 0, 0, NULL);
  