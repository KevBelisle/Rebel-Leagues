var monthNames = [ "janvier", "février", "mars", "avril", "mai", "juin",
	"juillet", "août", "septembre", "octobre", "novembre", "décembre" ];

var rebelLeaguesControllers = angular.module('rebelLeaguesControllers', ['ui.bootstrap']);

rebelLeaguesControllers.controller('gamesHistoryCtrl', ['$scope', '$http', '$modal',
	function ($scope, $http, $modal) {
	
		$scope.games = [];
		$scope.lastIndex = 0;
		$scope.prev_date_string = "";
		$scope.loadInProgress = false;
		$scope.noMoreData = false;
	
		$scope.loadMore = function (skip) {
		
			if ($scope.loadInProgress || $scope.noMoreData) {
				return;
			}
			
			$scope.loadInProgress = true;
			
			$http.get('api/games/'+skip+'/20/').success(function(data) {
			
				for (var i = 0; i < data.data.games.length; i++) {
				
					var game = data.data.games[i];
					
					game.is_draw = game.is_draw == "1" ? true : false;
					game.is_online = game.is_online == "1" ? true : false;
					game.is_time_runout = game.is_time_runout == "1" ? true : false;
					game.is_group_title = false;
					
					var date = new Date( game.date.substring(0,4), parseInt(game.date.substring(5,7))-1, game.date.substring(8,10) );
					
					game.date_string = date.getDate() + " " + monthNames[date.getMonth()] + " " + date.getFullYear();
					
					if ( game.date_string != $scope.prev_date_string) {
						$scope.prev_date_string = game.date_string
						$scope.games.push( { is_group_title: true, date_string: game.date_string } );
					}
					
					game.showNotes = false;
					
					$scope.games.push( game );
					
				}
				
				$scope.lastIndex += data.data.games.length;
				if (data.data.games.length < 20) {
					$scope.noMoreData = true;
				}
				
				$scope.loadInProgress = false;
				
			}).error(function(data){
				console.log(data);
				$scope.loadInProgress = false;
			});
		
		};
		
		

		$scope.showFactionModal = function ($factionId) {
			console.log("Faction ID : " + $factionId);
			
			$modal.open({
				'templateUrl' : 'partials/factionModal.html',
				'controller' : 'factionModalCtrl',
				'windowClass' : 'faction',
				"resolve": {
					"faction": [
						'$http',
						function($http) {
							return $http.get('api/factions/' + $factionId)
								.then(
									function success(response) { return response.data.data; },
									function error(reason)     { return false; }
								);
						}
					],
					"faction_stats": [
						'$http',
						function($http) {
							return $http.get('api/factions/' + $factionId + "/stats")
								.then(
									function success(response) { return response.data.data; },
									function error(reason)     { return false; }
								);
						}
					]
				}
			});
		};
		
		$scope.loadMore(0);
		
	}
]);

rebelLeaguesControllers.controller('playersReviewCtrl', ['$scope', '$http', '$modal',
	function($scope, $http, $modal) {
		
		$scope.playerSelected = false;
		$scope.playerid;
		$scope.players = [];
		
		$http.get('api/players/')
			.then(
				function success(response) {
                    //$scope.activePlayers = $.grep(response.data.data.players, function(a){return a.active > 0;});
                    //$scope.inactivePlayers = $.grep(response.data.data.players, function(a){return a.active > 0;}, true);
                    $scope.players = response.data.data.players;
                },
				function error(reason)     { return false; }
			);
		
		$scope.getPlayerStats = function () {
			$http.get('api/players/' + $scope.playerid)
				.then(
					function success(response) {
						$scope.playerInfo = response.data.data;
					},
					function error(reason) {return false; }
				);
				
			$http.get('api/players/' + $scope.playerid + '/stats')
				.then(
					function success(response) {
						$scope.playerStats = response.data.data;
                        
                        $scope.playerStats.allOpponentsVisible = false;
                        
                        if ($scope.playerStats.opponents.length <= 5) {
                            $scope.playerStats.allOpponentsVisible = true;
                        }
						
						var lastGameDate = new Date(
							$scope.playerStats.lastgame.date.substring(0,4),
							parseInt($scope.playerStats.lastgame.date.substring(5,7))-1,
							$scope.playerStats.lastgame.date.substring(8,10)
						);
						
						$scope.playerStats.lastgame.date = lastGameDate.getDate() + " " +
															monthNames[lastGameDate.getMonth()] + " " +
															lastGameDate.getFullYear();

                        $scope.playerStats.maxGamesWithFaction      = Math.max.apply(null, $scope.playerStats.factionEfficiencyRatiosWith.map(function(a){return a.games_played_with;}));
                        $scope.playerStats.maxGamesAgainstFaction   = Math.max.apply(null, $scope.playerStats.factionEfficiencyRatiosAgainst.map(function(a){return a.games_played_against;}));
                        
                        $scope.playerStats.maxGamesAgainstPlayer    = Math.max.apply(null, $scope.playerStats.opponents.map(function(a){return a.games_played;}));
                        
                        if ($scope.playerStats.performanceHistory) {
                            $scope.playerStats.performanceGraph = {};
                            $scope.playerStats.performanceGraph.data = [$scope.playerStats.performanceHistory.map(function(a){return parseFloat(a.tenGameAverage)})];
                            $scope.playerStats.performanceGraph.labels = $scope.playerStats.performanceHistory.map(function(a){return ""});
                            $scope.playerStats.performanceGraph.options = {
                                                                            animation: false,
                                                                            pointDot : false,
                                                                            scaleShowVerticalLines: false,
                                                                            pointHitDetectionRadius : 0,
                                                                            bezierCurveTension : 0.1,
                                                                            scaleOverride: true,
                                                                            scaleSteps: 4,
                                                                            scaleStepWidth: 0.25,
                                                                            scaleStartValue: 0,
                                                                            scaleLabel: "<%=value*100%>%",
                                                                            showTooltips: false,
                                                                            maintainAspectRatio: false
                            }
                            $scope.playerStats.performanceGraph.colours = [{
                                                                            "fillColor": 'rgba(102, 82, 200, 0.2)',
                                                                            "strokeColor": 'rgba(102, 82, 200, 0.8)'
                            }];
                        }
                        
                        console.log($scope);
					},
					function error(reason) {return false; }
				);
				
			$scope.playerSelected = true;
        }
        
		$scope.showEfficiencyWithInfo = function () {
			$modal.open({
				'templateUrl' : 'partials/showEfficiencyWithInfo.html',
				'controller' : 'playersReviewCtrl',
				'windowClass' : 'something',
				"resolve": {
				}
			});
		};
		
		$scope.showEfficiencyAgainstInfo = function () {
            console.log("!!!");
			$modal.open({
				'templateUrl' : 'partials/showEfficiencyAgainstInfo.html',
				'controller' : 'playersReviewCtrl',
				'windowClass' : 'something',
				"resolve": {
				}
			});
		};
		
	}
]);

rebelLeaguesControllers.controller('factionsReviewCtrl', ['$scope', '$http', '$modal',
	function($scope, $http, $modal) {
		
		$scope.factionSelected = false;
		$scope.factionid;
		
		$http.get('api/factions/')
			.then(
				function success(response) {
                    $scope.factions = response.data.data.factions;
                },
				function error(reason)     { return false; }
			);
            
		$http.get('api/factions/stats/')
			.then(
				function success(response) {
                
                    //$scope.factionsStats.rawUsageData = response.data.data;
                    
                    var data = response.data.data;
                    
                    $scope.factionsStats = {};
                    $scope.factionsStats.usageGraph = {};
                    $scope.factionsStats.usageGraph.data = [];
                    $scope.factionsStats.usageGraph.series = [];
                    $scope.factionsStats.usageGraph.colours = [];
                    
                    $scope.factions.forEach( function(faction) {
                        var id = faction.faction_id;
                        $scope.factionsStats.usageGraph.data.push( data[id] );
                        $scope.factionsStats.usageGraph.series.push(faction.name);
                        $scope.factionsStats.usageGraph.colours.push({
                            "fillColor": '#' + faction.color,
                            "strokeColor": '#' + faction.color
                        });
                    });
                    
                    for ( var i = $scope.factionsStats.usageGraph.data.length-2; i >= 0; i-- ) {
                        var dataset = $scope.factionsStats.usageGraph.data[i];
                        dataset.forEach( function (data, index, dataset) {
                            dataset[index] = dataset[index] + $scope.factionsStats.usageGraph.data[i+1][index];
                        });
                    }
                    
                    $scope.factionsStats.usageGraph.labels = $scope.factionsStats.usageGraph.data[0].map(function(a){return ""});
                    $scope.factionsStats.usageGraph.options = {
                                                                    animation: false,
                                                                    pointDot : false,
                                                                    scaleShowVerticalLines: false,
                                                                    pointHitDetectionRadius : 0,
                                                                    bezierCurveTension : 0.1,
                                                                    datasetStroke : false,
                                                                    datasetStrokeWidth : 0,
                                                                    scaleOverride: true,
                                                                    scaleSteps: 4,
                                                                    scaleStepWidth: 0.25,
                                                                    scaleStartValue: 0,
                                                                    scaleLabel: "<%=100*value%>%",
                                                                    showTooltips: false,
                                                                    maintainAspectRatio: false
                    };
                },
				function error(reason)     { return false; }
			);
		
		$scope.getFactionStats = function () {
		
			$http.get('api/factions/' + $scope.factionid)
				.then(
					function success(response) {
						$scope.factionInfo = response.data.data;
					},
					function error(reason) {return false; }
				);
				
			$http.get('api/factions/' + $scope.factionid + '/ranking')
				.then(
					function success(response) {
						$scope.factionRanking = response.data.data;
					},
					function error(reason) {return false; }
				);
			
			$http.get('api/factions/' + $scope.factionid  + '/stats')
				.then(
					function success(response) {
						$scope.factionStats = response.data.data;
						$scope.factionStats.maxGamesAgainstFaction   = Math.max.apply(null, $scope.factionStats.efficiencyRatiosAgainst.map(function(a){return a.games_played;}));
						
					},
					function error(reason) {return false; }
					
				);
				
			
						
		
		$scope.factionSelected = true;
		
		}
		
		
	
		console.log($scope);
	}
]);

rebelLeaguesControllers.controller('playersRankingCtrl', ['$scope', '$http', '$modal',
	function ($scope, $http, $modal) {
		$http.get('api/ranking').success(function(data) {
		
			if (data.data.ranking == 3) { // ELO rating
				$scope.min = Math.min.apply(null, data.data.players.map(function(a){return a.elo_rating;}));
				$scope.max = Math.max.apply(null, data.data.players.map(function(a){return a.elo_rating;}));
				
			} else if (data.data.ranking == 1) { // Games played
				$scope.min = Math.min.apply(null, data.data.players.map(function(a){return a.games_played;}));
				$scope.max = Math.max.apply(null, data.data.players.map(function(a){return a.games_played;}));
				
			} else if (data.data.ranking == 2) { // Points
				$scope.min = Math.min.apply(null, data.data.players.map(function(a){return a.points;}));
				$scope.max = Math.max.apply(null, data.data.players.map(function(a){return a.points;}));
			}


			$scope.showPlayerModal = function ($playerId) {
				console.log("Player ID : " + $playerId);			
						
				$modal.open({
					'templateUrl' : 'partials/playerModal.html',
					'controller' : 'playerModalCtrl',
					'windowClass' : 'player',
					"resolve": {
						"player": [
							'$http',
							function($http) {
								return $http.get('api/players/' + $playerId)
									.then(
										function success(response) { return response.data.data; },
										function error(reason)     { return false; }
									);
							}
						],
						"players_stats": [
							'$http',
							function($http) {
								return $http.get('api/players/' + $playerId + "/stats")
									.then(
										function success(response) { return response.data.data; },
										function error(reason)     { return false; }
									);
							}
						]						
					}
				});	
			};
		
			$scope.players = data.data.players;
			$scope.ranking = data.data.ranking;
			
			console.log($scope);
		});
	}
]);



rebelLeaguesControllers.controller('factionModalCtrl', ['$scope', '$http', 'faction', 'faction_stats',
	function ($scope, $http, faction, faction_stats) {
		$scope.faction = faction;
		$scope.faction_stats = faction_stats.factions;
		
		$scope.min = Math.min.apply(null, $scope.faction_stats.map(function(a){return a.games_played;}));
		$scope.max = Math.max.apply(null, $scope.faction_stats.map(function(a){return a.games_played;}));
	}
]);


rebelLeaguesControllers.controller('playerModalCtrl', ['$scope', '$http', 'player', 'players_stats',
	function ($scope, $http, player, players_stats) {
		$scope.player = player;
		$scope.players_stats = players_stats.players;
		
		$scope.min = Math.min.apply(null, $scope.players_stats.map(function(a){return a.games_played;}));
		$scope.max = Math.max.apply(null, $scope.players_stats.map(function(a){return a.games_played;}));
	}
]);


rebelLeaguesControllers.controller('leagueStatsCtrl', ['$scope', '$http',
	function ($scope, $http) {
		$http.get('api/stats').success(function(data) {
			$scope.games_played = data.data.stats.games_played;
			$scope.total_players = data.data.stats.total_players;
			$scope.active_players = data.data.stats.active_players;
		});
				
	}
]);


rebelLeaguesControllers.controller('leagueInfoCtrl', ['$scope', '$http',
	function ($scope, $http) {
		$http.get('api/leagues').success(function(data) {
			console.log(data);
			$scope.title = data.data.league.title;
			$scope.subtitle = data.data.league.subtitle;
		});
				
	}
]);








