/* POPULATE faction_groups
============================================= */

INSERT INTO factiongroups (factiongroup_id, name, color, logo) VALUES (1,'Anarch', 'dc523e', 'uploads/factions/f8237a00e2beac45ab68d6c5fac72620.png');
INSERT INTO factiongroups (factiongroup_id, name, color, logo) VALUES (2,'Criminal', '5475bb', 'uploads/factions/c48eb09b2a29362563c94179ef4f7ca7.png');
INSERT INTO factiongroups (factiongroup_id, name, color, logo) VALUES (3,'Shaper', '789f3f', 'uploads/factions/d6f7455baf3d08ef1a960aaf15c9fdde.png');
INSERT INTO factiongroups (factiongroup_id, name, color, logo) VALUES (4,'Haas-Bioroid', '83678b', 'uploads/factions/73cb3c5bfc1349eb4b32b731b96c792b.png');
INSERT INTO factiongroups (factiongroup_id, name, color, logo) VALUES (5,'Jinteki', 'cc5238', 'uploads/factions/687500971bade8cbe8df67ccf17470c6.png');
INSERT INTO factiongroups (factiongroup_id, name, color, logo) VALUES (6,'NBN', 'edac32', 'uploads/factions/6a1ee2f2759ac311ee8b406b5807b80e.png');
INSERT INTO factiongroups (factiongroup_id, name, color, logo) VALUES (7,'Weyland Consortium', '6a7365', 'uploads/factions/ea26b6b08c39342155cc1fc575315d2f.png');


/* POPULATE factions
============================================= */

INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(1, 'Noise', 1, '', 'uploads/factions/f8237a00e2beac45ab68d6c5fac72620.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(2, 'Whizzard', 1, '', 'uploads/factions/f8237a00e2beac45ab68d6c5fac72620.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(3, 'Reina Roja', 1, '', 'uploads/factions/f8237a00e2beac45ab68d6c5fac72620.png');

INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(4, 'Gabriel Santiago', 2, '', 'uploads/factions/c48eb09b2a29362563c94179ef4f7ca7.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(5, 'Andromeda', 2, '', 'uploads/factions/c48eb09b2a29362563c94179ef4f7ca7.png');

INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(6, 'Kate Mac McCaffrey', 3, '', 'uploads/factions/d6f7455baf3d08ef1a960aaf15c9fdde.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(7, 'Chaos Theory', 3, '', 'uploads/factions/d6f7455baf3d08ef1a960aaf15c9fdde.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(8, 'Exile', 3, '', 'uploads/factions/d6f7455baf3d08ef1a960aaf15c9fdde.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(9, 'Rielle Kit Peddler', 3, '', 'uploads/factions/d6f7455baf3d08ef1a960aaf15c9fdde.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(10, 'The Professor', 3, '', 'uploads/factions/d6f7455baf3d08ef1a960aaf15c9fdde.png');

INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(11, 'Engineering the Future', 4, '', 'uploads/factions/73cb3c5bfc1349eb4b32b731b96c792b.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(12, 'Stronger Together', 4, '', 'uploads/factions/73cb3c5bfc1349eb4b32b731b96c792b.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(13, 'Cerebral Imaging', 4, '', 'uploads/factions/73cb3c5bfc1349eb4b32b731b96c792b.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(14, 'Custom Biotics', 4, '', 'uploads/factions/73cb3c5bfc1349eb4b32b731b96c792b.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(15, 'Next Design', 4, '', 'uploads/factions/73cb3c5bfc1349eb4b32b731b96c792b.png');

INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(16, 'Personal Evolution', 5, '', 'uploads/factions/687500971bade8cbe8df67ccf17470c6.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(17, 'Replicating Perfection', 5, '', 'uploads/factions/687500971bade8cbe8df67ccf17470c6.png');

INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(18, 'Making News', 6, '', 'uploads/factions/6a1ee2f2759ac311ee8b406b5807b80e.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(19, 'The World is Yours', 6, '', 'uploads/factions/6a1ee2f2759ac311ee8b406b5807b80e.png');

INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(20, 'Building a Better World', 7, '', 'uploads/factions/ea26b6b08c39342155cc1fc575315d2f.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(21, 'Because We Built It', 7, '', 'uploads/factions/ea26b6b08c39342155cc1fc575315d2f.png');
INSERT INTO factions (faction_id, name, factiongroup_id, color, logo) VALUES(22, 'GRNDL', 7, '', 'uploads/factions/ea26b6b08c39342155cc1fc575315d2f.png');


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

INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(1, 1, 7, 1, 7, '2013-11-02 19:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(2, 2, 5, 7, 1, '2013-11-02 20:30:00', 0, 1, 0, 0, '');