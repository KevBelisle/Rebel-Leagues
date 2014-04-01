
/* POPULATE leagues
============================================= */

INSERT INTO leagues (league_id, title, subtitle, logo, defaultGameNotes) VALUES (1,'Star Wars X-Wing Miniatures Game', 'RebelLeagues Québec', 'uploads/leagues/e034fb6b66aacc1d48f445ddfb08da98.png','Suggestion: ajouter des liens webs vers les squads utilisés dans Yet Another Squad Builder, description des faits saillants, etc.');


/* POPULATE factions
============================================= */

INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES (2,'Empire',NULL,'248717','uploads/factions/84935fe3eba50ea4e3d70b7f7964b9c0.png');
INSERT INTO factions (faction_id, name, parent_faction_id, color, logo) VALUES (1,'Alliance',NULL,'a90c0c','uploads/factions/81edf7d428e9f21aefab65d440a2c1a1.png');



/* POPULATE players
============================================= */

INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (1, 'Klutz', 'Kevin', 'Bélisle');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (2, 'GomJabbar', 'David', 'Bernier');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (3, 'Slimjim', 'Steve', 'Coulterman');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (4, 'pat', 'Patrick', 'Couturier');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (5, 'Rokiu', 'Martin', 'Lévesque');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (6, 'Mu0n', 'Michaël', 'Juneau');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (7, 'Hugo', 'Hugo', 'Robichaud');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (8, 'Khei', 'François', 'Beaumont');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES (9, 'Zomby', 'François', 'Couture');



/* POPULATE games
============================================= */

INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (1, 1, 2, '2014-01-21 19:30:00', 0, 0, 1, 3, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (2, 2, 1, '2014-01-21 21:00:00', 0, 0, 3, 7, 1, NULL, 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (3, 1, 2, '2014-01-21 19:00:00', 0, 0, 6, 7, 1, 'Mic: ma liste était = <a href="http://xwing-builder.co.uk/view/22730/ibtie-and-friends-2">http://xwing-builder.co.uk/view/22730/ibtie-and-friends-2</a> ', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (4, 2, 2, '2014-01-21 21:30:00', 0, 0, 6, 1, 1, NULL, 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (5, 1, 2, '2014-01-21 21:00:00', 0, 0, 8, 9, 1, NULL, 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (6, 2, 1, '2014-01-13 17:00:00', 0, 0, 5, 6, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (7, 2, 1, '2014-01-13 18:30:00', 0, 0, 5, 6, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (8, 2, 1, '2014-01-13 20:30:00', 0, 0, 5, 6, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (9, 1, 2, '2014-01-13 21:30:00', 0, 0, 6, 3, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (10, 1, 2, '2014-01-13 20:00:00', 0, 0, 1, 4, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (11, 2, 1, '2014-01-27 19:00:00', 0, 0, 2, 1, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (12, 2, 1, '2014-01-27 19:15:00', 0, 0, 6, 7, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (13, 2, 2, '2014-01-27 19:00:00', 0, 0, 3, 8, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (14, 2, 2, '2014-01-27 22:30:00', 0, 0, 8, 3, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (15, 1, 2, '2014-01-27 22:30:00', 0, 0, 6, 1, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (16, 2, 1, '2014-02-03 18:30:00', 0, 0, 6, 2, 1, 'très très serré', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (17, 1, 1, '2014-02-03 20:30:00', 0, 0, 6, 8, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (18, 2, 2, '2014-02-03 21:00:00', 0, 0, 3, 2, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (19, 2, 1, '2014-02-03 21:30:00', 0, 0, 1, 7, 1, 'Klutz : <a href="http://xwing-builder.co.uk/view/45430/swarm-leaders">Mon squad</a>', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (20, 1, 1, '2014-02-04 01:00:00', 0, 0, 6, 1, 0, '1st use of online flag...', 1);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (21, 1, 2, '2014-02-09 23:00:00', 0, 0, 6, 3, 1, 'Chewie is the last Wookie standing à 1 hp', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (22, 2, 2, '2014-02-09 23:30:00', 0, 0, 3, 6, 1, 'faits saillants: bounty Hunter à Steve à 1 shield 6 hull sort de la map par mégarde. 2 vaisseaux perdus au même tour par Michaël. Une fin ultra longue entre un Saber amoché vs Soontir + Academy pilot', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (23, 1, 1, '2014-02-10 20:00:00', 0, 0, 7, 8, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (24, 1, 2, '2014-02-10 18:00:00', 0, 0, 1, 3, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (25, 1, 2, '2014-02-17 18:00:00', 0, 0, 8, 3, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (26, 2, 2, '2014-02-17 21:00:00', 0, 0, 5, 3, 1, 'Parked the bus on a rock!', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (34, 2, 1, '2014-02-17 08:30:00', 0, 0, 1, 2, 1, 'Squad à Klutz : http://xwing-builder.co.uk/view/48750/jonus-missile-trio', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (35, 2, 2, '2014-02-24 18:00:00', 0, 0, 3, 1, 1, '', 0);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (36, 1, 2, '2014-02-26 00:30:00', 0, 0, 1, 6, 1, 'sacrifié Carnor Jax comme un idiot (i.e. un radis) vers la fin, Roark a tout bouffé mes 4 vaisseaux tapochés.\n', 1);
INSERT INTO games (game_id, player1_faction_id, player2_faction_id, date, is_time_runout, is_draw, player1_id, player2_id, is_ranked, notes, is_online) VALUES (37, 1, 1, '2014-02-28 01:30:00', 0, 0, 6, 1, 1, 'Chewie full health wins!\n(Chewbacca+Expert Handling + Merc Copilot + Luke Skywalker + MF title, 2x Blue\n\nvs \n\nRoark + RecSpec + Blaster\nDutch + R2 + ion cannon turret\n2x rookie + R2)\n', 1);
