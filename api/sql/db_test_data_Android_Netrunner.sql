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


/* POPULATE games
============================================= */

INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(1, 1, 12, 1, 20, '2013-11-02 19:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(2, 2, 18, 7, 8, '2013-11-02 20:30:00', 0, 1, 0, 0, '');
