var monthNames = [ "janvier", "février", "mars", "avril", "mai", "juin",
	"juillet", "août", "septembre", "octobre", "novembre", "décembre" ];

var rebelLeaguesControllers = angular.module('rebelLeaguesAdminControllers', ['ui.bootstrap']);

rebelLeaguesControllers.controller('addGameCtrl', ['$scope', '$http', 'factions', 'players',
	function ($scope, $http, factions, players) {
	
		(function() {
			Date.prototype.toYMDHMS = Date_toYMDHMS;
			function Date_toYMDHMS() {
				var year, month, day, hours, minute, seconds;
				year = String(this.getFullYear());
				month = String(this.getMonth() + 1);
				if (month.length == 1) {
					month = "0" + month;
				}
				day = String(this.getDate());
				if (day.length == 1) {
					day = "0" + day;
				}
				hours = ("00" + this.getHours()).slice(-2);
				minutes = ("00" + this.getMinutes()).slice(-2);
				seconds = ("00" + this.getSeconds()).slice(-2);
				return year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
			}
		})();
	
		$scope.factions = factions;
		$scope.players = players;
		
		$scope.game = {
			player1_id: null,
			player1_faction_id: null,
			player2_id: null,
			player2_faction_id: null,
			is_draw: false,
			is_ranked: true,
			is_time_runout: false,
			is_online: false,
			datetime: new Date(),
			notes: ""
		};
		
		$scope.game.datetime.setHours( ((($scope.game.datetime.getMinutes()/105 + .5) | 0) + $scope.game.datetime.getHours()) % 24 );
		$scope.game.datetime.setMinutes( ((($scope.game.datetime.getMinutes() + 7.5)/15 | 0) * 15) % 60 );
		$scope.game.datetime.setSeconds(0);
		
		$scope.submit = function (game) {
			
			game.date = game.datetime.toYMDHMS();
			
			//console.log(encodeURIComponent(angular.toJson(game)));
			
			$http.post('../api/games', game).success( function (data) {
				alert(data);
				console.log(data);
			});
		
			console.log(game);
			console.log(game.datetime.toYMDHMS());
		};
		
		console.log($scope);
		
	}
]);

rebelLeaguesControllers.controller('addPlayerCtrl', ['$scope', '$http',
	function ($scope, $http) {
		
		$scope.player = {
			nickname: 'bobo',
			firstname: 'leclown',
			lastname: 'magique'
		};

		$scope.submit = function (player) {
			
			//console.log(encodeURIComponent(angular.toJson(game)));
			
			$http.post('../api/players', player).success( function (data) {
				alert(data);
				console.log(data);
			});
		
			console.log(player);
		};
		
		console.log($scope);
	}
]);




