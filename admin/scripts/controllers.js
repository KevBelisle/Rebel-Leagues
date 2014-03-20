var monthNames = [ "janvier", "février", "mars", "avril", "mai", "juin",
	"juillet", "août", "septembre", "octobre", "novembre", "décembre" ];

var rebelLeaguesAdminControllers = angular.module('rebelLeaguesAdminControllers', ['ui.bootstrap']);


rebelLeaguesAdminControllers.controller('mainCtrl', ['$scope', '$http',
	function ($scope, $http) {
		
		$scope.loggedIn = false;
		$scope.anonymousUser = false;
		
		$scope.user = {
			username: "",
			tier: 5
		};
		
		$scope.loginInfo = {
			username: "",
			password: "",
			invalid: false
		};
		
		console.log($scope);
		
		$scope.login = function(loginInfo) {
			$scope.loginInfo.invalid = false;
			$http.post("../api/login", loginInfo)
				.then(
					function success(response) {
						console.log(response);
						
						if (response.data.status == "success") {
							$scope.loggedIn = true;
							$scope.user = {
								username: response.data.data.username,
								tier: response.data.data.tier
							};
						} else {
							$scope.loginInfo.invalid = true;
						}
					},
					function error(reason)     { return false; }
				);
		};
		
		$scope.noLogin = function() {
			$scope.loggedIn = true;
			$scope.anonymousUser = true;
		};
		
		$scope.logout = function() {
			$scope.loggedIn = false;
			$scope.anonymousUser = false;
			
			$scope.user = {
				username: "",
				tier: 5
			};
			
			$scope.loginInfo = {
				username: "",
				password: "",
				invalid: false
			};
			$http.get("../api/logout");
		};
		
		$scope.resetLogin = function() {
			$scope.loggedIn = false;
			$scope.anonymousUser = false;
		};
		
	}
]);


rebelLeaguesAdminControllers.controller('addGameCtrl', ['$scope', '$http',
	function ($scope, $http) {
	
		$scope.title = "Ajouter une partie";
		$scope.partial = "partials/addGame.html";
		
		$scope.expanded = false;
		$scope.toggle = function () { $scope.expanded = !$scope.expanded };
	
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
		
		$scope.factions = [];
		$scope.players = [];
		
		$http.get('../api/factions/leafs')
			.then(
				function success(response) { $scope.factions = response.data.data.factions; },
				function error(reason)     { return false; }
			);
		$http.get('../api/players/')
			.then(
				function success(response) { $scope.players = response.data.data.players; },
				function error(reason)     { return false; }
			);
		
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


rebelLeaguesAdminControllers.controller('addPlayerCtrl', ['$scope', '$http',
	function ($scope, $http) {
	
		$scope.title = "Ajouter un joueur";
		$scope.partial = "partials/addPlayer.html";
	
		$scope.expanded = false;
		$scope.toggle = function () { $scope.expanded = !$scope.expanded };
		
		$scope.player = {
			nickname: null,
			firstname: null,
			lastname: null
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


rebelLeaguesAdminControllers.controller('tier1Ctrl', ['$scope', '$http',
	function ($scope, $http) {
	
		$scope.title = "Tier <= 1 ONLY!";
		$scope.partial = "partials/nothing";
	
		$scope.expanded = false;
		$scope.toggle = function () { $scope.expanded = !$scope.expanded };
	}
]);


rebelLeaguesAdminControllers.controller('tier2Ctrl', ['$scope', '$http',
	function ($scope, $http) {
	
		$scope.title = "Tier <= 2 ONLY!";
		$scope.partial = "partials/nothing";
	
		$scope.expanded = false;
		$scope.toggle = function () { $scope.expanded = !$scope.expanded };
	}
]);



