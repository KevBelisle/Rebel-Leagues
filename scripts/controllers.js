var monthNames = [ "janvier", "février", "mars", "avril", "mai", "juin",
	"juillet", "août", "septembre", "octobre", "novembre", "décembre" ];

var rebelLeaguesControllers = angular.module('rebelLeaguesControllers', ['ui.bootstrap']);

rebelLeaguesControllers.controller('gamesHistoryCtrl', ['$scope', '$http', '$modal',
	function ($scope, $http, $modal) {
		$http.get('api/games').success(function(data) {
		
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
					/*resolve : {
						'faction' : $http.get('api/factions/' + $factionId),
						'faction_stats' : $http.get('api/factions/' + $factionId + '/stats')
					}*/
				});
			};
		
			$scope.games = [];
			var prev_date_string = "";
		
			for (var i = 0; i < data.data.games.length; i++) {
			
				var game = data.data.games[i];
				
				game.is_draw = game.is_draw == "1" ? true : false;
				game.is_online = game.is_online == "1" ? true : false;
				game.is_time_runout = game.is_time_runout == "1" ? true : false;
				game.is_group_title = false;
				
				var date = new Date( game.date.substring(0,4), parseInt(game.date.substring(5,7))-1, game.date.substring(8,10) );
				
				game.date_string = date.getDate() + " " + monthNames[date.getMonth()] + " " + date.getFullYear();
				
				if ( game.date_string != prev_date_string) {
					prev_date_string = game.date_string
					$scope.games.push( { is_group_title: true, date_string: game.date_string } );
				}
				
				game.showNotes = false;
				
				$scope.games.push( game );
				
			}
			
			console.log($scope.games);
			
		});
	}
]);


rebelLeaguesControllers.controller('playersRankingCtrl', ['$scope', '$http', '$modal',
	function ($scope, $http, $modal) {
		$http.get('api/ranking').success(function(data) {
		
			if (data.data.ranking == "elo_rating") {
				$scope.min = Math.min.apply(null, data.data.players.map(function(a){return a.elo_rating;}));
				$scope.max = Math.max.apply(null, data.data.players.map(function(a){return a.elo_rating;}));
				
			} else if (data.data.ranking == "games_played") {
				$scope.min = Math.min.apply(null, data.data.players.map(function(a){return a.games_played;}));
				$scope.max = Math.max.apply(null, data.data.players.map(function(a){return a.games_played;}));
				
			} else if (data.data.ranking == "points") {
				$scope.min = Math.min.apply(null, data.data.players.map(function(a){return a.points;}));
				$scope.max = Math.max.apply(null, data.data.players.map(function(a){return a.points;}));
			}
		
			$scope.players = data.data.players;
			$scope.ranking = data.data.ranking;
			
		});
	}
]);



rebelLeaguesControllers.controller('factionModalCtrl', ['$scope', '$http', 'faction', 'faction_stats',
	function ($scope, $http, faction, faction_stats) {
		$scope.faction = faction;
		$scope.faction_stats = faction_stats.factions;
		
		$scope.min = Math.min.apply(null, $scope.faction_stats.map(function(a){return a.games_played;}));
		$scope.max = Math.max.apply(null, $scope.faction_stats.map(function(a){return a.games_played;}));
				
		console.log($scope);
	}
]);


rebelLeaguesControllers.controller('leagueStatsCtrl', ['$scope', '$http',
	function ($scope, $http) {
		$http.get('api/stats').success(function(data) {
			$scope.games_played = data.data.stats.games_played;
			$scope.total_players = data.data.stats.total_players;
			$scope.active_players = data.data.stats.active_players;
			console.log($scope);
		});
				
	}
]);






