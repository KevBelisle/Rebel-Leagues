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
		
		$scope.playerid;
		$scope.players = [];
		
		$http.get('api/players/')
			.then(
				function success(response) { $scope.players = response.data.data.players; },
				function error(reason)     { return false; }
			);
		
		$scope.getPlayerStats = function () {
			
			$http.get('api/players/' + $scope.playerid)
				.then(
					function success(response) {
						$scope.info = response.data.data;
					},
					function error(reason) {return false; }
				);
				
			$http.get('api/players/' + $scope.playerid + '/efficiencyRatiosWith')
				.then(
					function success(response) {
						$scope.efficiencyRatiosWith = response.data.data;
					},
					function error(reason) {return false; }
				);
				
			$http.get('api/players/' + $scope.playerid + '/efficiencyRatiosAgainst')
				.then(
					function success(response) {
						$scope.efficiencyRatiosAgainst = response.data.data;
					},
					function error(reason) {return false; }
				);
				
			$http.get('api/players/' + $scope.playerid + '/lastdate')
				.then(
					function success(response) { 
					    var treatThis = response.data.data.lastdate;
					    var date = new Date(treatThis.substring(0,4), parseInt(treatThis.substring(5,7))-1, treatThis.substring(8,10) );
						
						$scope.lastdate = date.getDate() + " " + monthNames[date.getMonth()] + " " + date.getFullYear();
						},
					function error(reason) {return false; }
				);
		
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
		
		
	}
]);

rebelLeaguesControllers.controller('playerReviewCtrl', ['$scope', '$http',function($scope, $http) {
		
		$http.get('api/players/6/efficiencyRatiosWith')
			.then(
				function success(response) { $scope.efficiencyRatiosWith = response.data.data; },
				function error(reason) {return false; }
				)
		$http.get('api/players/6/efficiencyRatiosAgainst')
			.then(
				function success(response) { $scope.efficiencyRatiosAgainst = response.data.data; },
				function error(reason) {return false; }
				)
		$http.get('api/players/6')
			.then(
				function success(response) { $scope.players = response.data.data; },
				function error(reason) {return false; }
				);
		$http.get('api/players/6/lastdate')
			.then(
				function success(response) { 
				    var treatThis = response.data.data.lastdate;
				    var date = new Date(treatThis.substring(0,4), parseInt(treatThis.substring(5,7))-1, treatThis.substring(8,10) );
					
					$scope.lastdate = date.getDate() + " " + monthNames[date.getMonth()] + " " + date.getFullYear();
					},
				function error(reason) {return false; }
				);
		console.log($scope);
    //just a test for mic centric view	
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








