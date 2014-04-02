
/* POPULATE leagues
============================================= */

INSERT INTO leagues (league_id, title, subtitle, logo, defaultGameNotes, pointsWinValue, pointsDrawValue, pointsLossValue, eloStartRank, eloMasterRank, eloStartKFactor, eloSeasonedKFactor, eloMasterKFactor, eloSeasonedGameCountRequirement) VALUES (1,'Star Wars X-Wing Miniatures Game', 'RebelLeagues Québec', 'uploads/leagues/e034fb6b66aacc1d48f445ddfb08da98.png','Suggestion: ajouter des liens webs vers les squads utilisés dans Yet Another Squad Builder, description des faits saillants, etc.', 5, 3, 1, 1000, 2400, 25, 15, 10, 30);


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
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES(10, 'Borgoto', 'Mathieu', 'Borgeat');
INSERT INTO players (player_id, nickname, firstname, lastname) VALUES(11, 'Sim:)', 'Simon', 'Bélisle');


/* POPULATE games
============================================= */
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(1, 1, 1, 3, 2, '2014-01-21 19:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(2, 3, 2, 7, 1, '2014-01-21 21:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(3, 6, 1, 7, 2, '2014-01-21 19:00:00', 0, 1, 0, 0, 'Mic: ma liste était = <a href="http://xwing-builder.co.uk/view/22730/ibtie-and-friends-2">http://xwing-builder.co.uk/view/22730/ibtie-and-friends-2</a> ');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(4, 6, 2, 1, 2, '2014-01-21 21:30:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(5, 8, 1, 9, 2, '2014-01-21 21:00:00', 0, 1, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(6, 5, 2, 6, 1, '2014-01-13 17:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(7, 5, 2, 6, 1, '2014-01-13 18:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(8, 5, 2, 6, 1, '2014-01-13 20:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(9, 6, 1, 3, 2, '2014-01-13 21:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(10, 1, 1, 4, 2, '2014-01-13 20:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(11, 2, 2, 1, 1, '2014-01-27 19:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(12, 6, 2, 7, 1, '2014-01-27 19:15:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(13, 3, 2, 8, 2, '2014-01-27 19:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(14, 8, 2, 3, 2, '2014-01-27 22:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(15, 6, 1, 1, 2, '2014-01-27 22:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(16, 6, 2, 2, 1, '2014-02-03 18:30:00', 0, 1, 0, 0, 'très très serré');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(17, 6, 1, 8, 1, '2014-02-03 20:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(18, 3, 2, 2, 2, '2014-02-03 21:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(19, 1, 2, 7, 1, '2014-02-03 21:30:00', 0, 1, 0, 0, 'Klutz : <a href="http://xwing-builder.co.uk/view/45430/swarm-leaders">Mon squad</a>');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(20, 6, 1, 1, 1, '2014-02-04 01:00:00', 0, 0, 0, 1, '1st use of online flag...');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(21, 6, 1, 3, 2, '2014-02-09 23:00:00', 0, 1, 0, 0, 'Chewie is the last Wookie standing à 1 hp');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(22, 3, 2, 6, 2, '2014-02-09 23:30:00', 0, 1, 0, 0, 'faits saillants: bounty Hunter à Steve à 1 shield 6 hull sort de la map par mégarde. 2 vaisseaux perdus au même tour par Michaël. Une fin ultra longue entre un Saber amoché vs Soontir + Academy pilot');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(23, 7, 1, 8, 1, '2014-02-10 20:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(24, 1, 1, 3, 2, '2014-02-10 18:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(25, 8, 1, 3, 2, '2014-02-17 18:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(26, 5, 2, 3, 2, '2014-02-17 21:00:00', 0, 1, 0, 0, 'Parked the bus on a rock!');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(34, 1, 2, 2, 1, '2014-02-17 08:30:00', 0, 1, 0, 0, 'Squad à Klutz : http://xwing-builder.co.uk/view/48750/jonus-missile-trio');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(35, 3, 2, 1, 2, '2014-02-24 18:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(36, 1, 1, 6, 2, '2014-02-26 00:30:00', 0, 1, 0, 1, 'sacrifié Carnor Jax comme un idiot (i.e. un radis) vers la fin, Roark a tout bouffé mes 4 vaisseaux tapochés.\n');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(37, 6, 1, 1, 1, '2014-02-28 01:30:00', 0, 1, 0, 1, 'Chewie full health wins!\n(Chewbacca+Expert Handling + Merc Copilot + Luke Skywalker + MF title, 2x Blue\n\nvs \n\nRoark + RecSpec + Blaster\nDutch + R2 + ion cannon turret\n2x rookie + R2)\n');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(38, 2, 2, 1, 1, '2013-12-31 00:00:00', 0, 0, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(39, 2, 2, 1, 1, '2013-12-31 00:00:00', 0, 0, 0, 0, NULL);
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(40, 1, 2, 8, 1, '2014-03-10 20:00:00', 0, 1, 0, 0, 'Klutz essaye 2 Bombers avec Seismic Charges... et oublie de les utiliser au moment opportun...');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(41, 1, 1, 6, 1, '2014-03-12 22:30:00', 0, 1, 0, 1, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(42, 6, 1, 1, 2, '2014-03-13 01:45:00', 0, 1, 0, 1, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(43, 1, 1, 7, 2, '2014-03-17 20:00:00', 0, 1, 0, 0, 'Klutz: Wedge, Biggs + R2-F2, 2 x Rookies');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(44, 8, 1, 3, 2, '2014-03-17 20:15:00', 1, 1, 1, 0, 'Une partie qui s''étire sur 2h30...');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(45, 6, 1, 3, 2, '2014-03-23 22:30:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(46, 6, 2, 3, 1, '2014-03-24 00:45:00', 0, 1, 1, 0, 'arrêté alors que Darth Vader, 3 hull 1 shield vient d''achever Chewie dans un coin et n''a que dutch (full health) comme adversaire avec ion cannon turret + r2 astromech. ça aurait été vraiment long.....');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(47, 1, 1, 6, 1, '2014-03-25 01:00:00', 0, 1, 0, 1, 'speed game en 60 minutes (avec quelques minutes restantes)...ouf, je vois pas ça arriver sur une table physique.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(48, 3, 2, 6, 2, '2014-03-25 21:00:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(49, 1, 2, 8, 1, '2014-03-25 20:15:00', 0, 1, 0, 0, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(50, 6, 1, 1, 2, '2014-03-25 23:45:00', 0, 1, 0, 1, '');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(51, 6, 1, 11, 1, '2014-03-30 14:00:00', 0, 1, 1, 0, 'Modified win for Mu0n.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(52, 6, 1, 8, 1, '2014-03-30 15:30:00', 0, 1, 0, 0, 'Full win pour Mu0n.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(53, 6, 1, 3, 2, '2014-03-30 16:30:00', 0, 1, 1, 0, 'Modified win pour Mu0n.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(54, 6, 1, 7, 2, '2014-03-30 17:30:00', 0, 1, 1, 0, 'Modified win pour Mu0n.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(55, 1, 2, 6, 1, '2014-03-30 18:45:00', 0, 1, 0, 0, 'Full win pour Klutz. À 40s de la fin!');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(57, 3, 2, 8, 1, '2014-03-30 14:00:00', 0, 1, 0, 0, 'Full win for Slimjim.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(58, 3, 2, 7, 2, '2014-03-30 15:30:00', 0, 1, 0, 0, 'Full win pour Slimjim.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(59, 3, 2, 1, 2, '2014-03-30 17:30:00', 0, 1, 0, 0, 'Full win pour Slimjim.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(60, 3, 2, 11, 1, '2014-03-30 18:45:00', 0, 1, 0, 0, 'Full win pour Steve.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(61, 7, 2, 1, 2, '2014-03-30 14:00:00', 0, 1, 1, 0, 'Modified win pour Hugo.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(62, 1, 2, 11, 1, '2014-03-30 15:30:00', 0, 1, 0, 0, 'Full win pour Klutz.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(63, 1, 2, 8, 1, '2014-03-30 16:30:00', 0, 1, 0, 0, 'Full win pour Klutz.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(64, 11, 1, 7, 2, '2014-03-30 16:30:00', 0, 1, 0, 0, 'Full win pour Simon!');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(65, 8, 1, 11, 1, '2014-03-30 17:30:00', 0, 1, 0, 0, 'Full win pour Khei.\n\nFin incroyable:\n2 Rookie Pilots face à face, Khei avec 3 hull + 1 shield, Simon avec 3 hull.\nKhei shoots first : 4 hits. Simon rolls no evades.\nSimultaneous fire, Simon shoots back. He rolls: 3 hits + 1 crit. Key rolls 1 focus on defense, focuses for an evade. Down to 1 hull - with a crit.\nCrit is nothing. Khei''s Rookie survives - just barely.');
INSERT INTO games (game_id, player1_id, player1_faction_id, player2_id, player2_faction_id, date, is_draw, is_ranked, is_time_runout, is_online, notes) VALUES(66, 8, 1, 7, 2, '2014-03-30 18:45:28', 0, 1, 0, 0, 'Full win pour Khei.');