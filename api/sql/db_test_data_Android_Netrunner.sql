
/* POPULATE leagues
============================================= */

INSERT INTO leagues (league_id, title, subtitle, logo) VALUES (1,'Android: Netrunner', 'RebelLeagues Québec', 'uploads/leagues/e6db1baa29d3df1eb307ff6a12c778da.png');

/* POPULATE factions
============================================= */

INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(1, 'Anarch', NULL, 'dc523e', 'uploads/factions/f8237a00e2beac45ab68d6c5fac72620.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(2, 'Criminal', NULL, '5475bb', 'uploads/factions/c48eb09b2a29362563c94179ef4f7ca7.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(3, 'Shaper', NULL, '789f3f', 'uploads/factions/d6f7455baf3d08ef1a960aaf15c9fdde.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(4, 'Haas-Bioroid', NULL, '83678b', 'uploads/factions/73cb3c5bfc1349eb4b32b731b96c792b.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(5, 'Jinteki', NULL, 'cc5238', 'uploads/factions/687500971bade8cbe8df67ccf17470c6.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(6, 'NBN', NULL, 'edac32', 'uploads/factions/6a1ee2f2759ac311ee8b406b5807b80e.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(7, 'Weyland Consortium', NULL, '6a7365', 'uploads/factions/ea26b6b08c39342155cc1fc575315d2f.png');

INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(8, 'Noise', 1, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(9, 'Whizzard', 1, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(10, 'Reina Roja', 1, NULL, NULL);

INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(11, 'Gabriel Santiago', 2, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(12, 'Andromeda', 2, NULL, NULL);

INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(13, 'Kate Mac McCaffrey', 3, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(14, 'Chaos Theory', 3, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(15, 'Exile', 3, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(16, 'Rielle Kit Peddler', 3, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(17, 'The Professor', 3, NULL, NULL);

INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(18, 'Engineering the Future', 4, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(19, 'Stronger Together', 4, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(20, 'Cerebral Imaging', 4, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(21, 'Custom Biotics', 4, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(22, 'Next Design', 4, NULL, NULL);

INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(23, 'Personal Evolution', 5, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(24, 'Replicating Perfection', 5, NULL, NULL);

INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(25, 'Making News', 6, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(26, 'The World is Yours', 6, NULL, NULL);

INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(27, 'Building a Better World', 7, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(28, 'Because We Built It', 7, NULL, NULL);
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES(29, 'GRNDL', 7, NULL, NULL);


/* POPULATE players
============================================= */

INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (1, 'Mu0n', 'Michaël', 'Juneau');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (2, 'Pwhy5', 'Pierre Yves', 'Caron');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (3, 'Max', 'Maxime', 'Ste-Marie');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (4, 'Etienne', 'Etienne', 'Montminy');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (5, 'jay_bilo', 'Jason', 'Bilodeau');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (6, 'Fred', 'Frédéric', 'Herpe');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (7, 'GomJabbar', 'David', 'Bernier');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (8, 'Moyzan', 'Christian', 'Moisan');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (9, 'Hugo', 'Hugo', 'Lafleur');


/* POPULATE games
============================================= */
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES
(1, 2, 25, 3, 15, '2014-03-03 19:15:00', 0, 1, 0, 0, 'score: 7-5'),
(2, 3, 15, 2, 18, '2014-03-03 19:30:00', 0, 1, 0, 0, 'score: 7-4'),
(3, 3, 25, 2, 13, '2014-03-03 19:45:00', 0, 1, 0, 0, 'score: 7-6'),
(4, 3, 23, 2, 13, '2014-03-03 20:15:00', 0, 1, 0, 0, 'score: 6-4 flatline'),
(5, 2, 25, 3, 8, '2014-03-03 20:30:00', 0, 1, 0, 0, 'score: 7-4'),
(6, 1, 10, 7, 27, '2014-03-08 18:45:00', 0, 1, 0, 0, 'score: 7-5'),
(7, 1, 24, 7, 15, '2014-03-08 19:00:00', 0, 1, 0, 0, 'score: 8-2'),
(8, 1, 25, 7, 11, '2014-03-08 19:45:00', 0, 1, 0, 0, 'score: 0-0 flatline'),
(9, 7, 11, 1, 25, '2014-03-08 20:15:00', 0, 1, 0, 0, 'score: 7-3'),
(10, 6, 12, 9, 25, '2014-03-10 19:00:00', 1, 1, 1, 0, 'score: ?-?'),
(11, 6, 12, 3, 25, '2014-03-10 19:30:00', 0, 1, 0, 0, 'score: ?-?'),
(12, 6, 18, 3, 15, '2014-03-10 20:00:00', 1, 1, 1, 0, 'score: ?-?');
