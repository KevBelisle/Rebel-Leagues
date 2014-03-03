var monthNames = [ "janvier", "février", "mars", "avril", "mai", "juin",
	"juillet", "août", "septembre", "octobre", "novembre", "decembre" ];

var rebelLeaguesControllers = angular.module('rebelLeaguesControllers', []);

rebelLeaguesControllers.controller('gamesHistoryCtrl', ['$scope', '$http',
	function($scope, $http) {
		$http.get('api/games').success(function(data) {
		
			$scope.games = [];
			var prev_date_string = "";
		
			for (var i = 0; i < data.data.games.length; i++) {
			
				var game = data.data.games[i];
				
				game.is_draw = game.is_draw == "1" ? true : false;
				game.is_online = game.isOnline == "1" ? true : false;
				game.is_time_runout = game.isTimeRunout == "1" ? true : false;
				game.is_group_title = false;
				
				var date = new Date( game.date.substring(0,4), parseInt(game.date.substring(5,7))-1, game.date.substring(8,10) );
				
				game.date_string = date.getDate() + " " + monthNames[date.getMonth()] + " " + date.getFullYear();
				
				if ( game.date_string != prev_date_string) {
					prev_date_string = game.date_string
					$scope.games.push( { is_group_title: true, date_string: game.date_string } );
				}
				
				$scope.games.push( game );
				
			}
			
			console.log($scope.games);
			
		});
	}
]);


rebelLeaguesControllers.controller('playersRankingCtrl', ['$scope', '$http',
	function($scope, $http) {
		$http.get('api/ranking').success(function(data) {
		
			$scope.players = data.data.players;
			$scope.ranking = data.data.ranking;
			
		});
	}
]);
