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
		
		$http.get("../api/login").success(function(data) {
			console.log(data);
			if (data.status == "success") {
				$scope.loggedIn = true;
				$scope.user.username = data.data.username;
				$scope.user.tier = data.data.tier;
			}
		});
		
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
		$scope.partial = "partials/addGame.php";
		
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
		$scope.league = [];
		
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
		$http.get('../api/leagues/')
			.then(
				function success(response) { $scope.league = response.data.data.league; },
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
			
			$http.post('../api/games', game).success( function (data) {
				alert("Partie ajoutée.");
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
				console.log(data);
			}).error( function(data) {
				alert("Une erreur est survenue.");
				console.log(data);
			});
		};
	}
]);


rebelLeaguesAdminControllers.controller('addPlayerCtrl', ['$scope', '$http',
	function ($scope, $http) {
	
		$scope.title = "Ajouter un joueur";
		$scope.partial = "partials/addPlayer.php";
	
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
				alert("Joueur ajouté.");
				$scope.player = {
					nickname: null,
					firstname: null,
					lastname: null
				};
				console.log(data);
			}).error( function(data) {
				alert("Une erreur est survenue.");
				console.log(data);
			});
		};
	}
]);



rebelLeaguesAdminControllers.controller('editGameCtrl', ['$scope', '$http',
	function ($scope, $http) {
	
		$scope.title = "Modifier une partie";
		$scope.partial = "partials/editGame.php";
		
		$scope.expanded = false;
		$scope.toggle = function () { $scope.expanded = !$scope.expanded };
		
		$scope.selectedGame = false;
		$scope.selectedGameId = false;
		
		$scope.change = function (selectedGameId) {
			$scope.selectedGame =  $scope.games.filter(function(obj) { if(obj.game_id == selectedGameId) { return obj } })[0];
			$scope.selectedGame.datetime = new Date( $scope.selectedGame.date );
			
			$scope.selectedGame.is_draw = $scope.selectedGame.is_draw == 1 ? true : false;
			$scope.selectedGame.is_online = $scope.selectedGame.is_online == 1 ? true : false;
			$scope.selectedGame.is_ranked = $scope.selectedGame.is_ranked == 1 ? true : false;
			$scope.selectedGame.is_time_runout = $scope.selectedGame.is_time_runout == 1 ? true : false;
			
			console.log($scope.selectedGame);
		};
	
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
		
		$scope.games = [];
		$scope.factions = [];
		$scope.players = [];
		
		
		$http.get('../api/games/all')
			.then(
				function success(response) { $scope.games = response.data.data.games; },
				function error(reason)     { return false; }
			);
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
		
		$scope.submit = function (selectedGame) {
			
			selectedGame.date = selectedGame.datetime.toYMDHMS();
			
			$http.put('../api/games/'+selectedGame.game_id, selectedGame).success( function (data) {
				alert("Partie modifiée.");
				$scope.selectedGameId = false;
				$scope.selectedGame = false;
				console.log(data);
			}).error( function(data) {
				alert("Une erreur est survenue.");
				console.log(data);
			});
		
			console.log(selectedGame);
			console.log(selectedGame.datetime.toYMDHMS());
		};
		
		$scope.delete = function (selectedGame) {
		
			if (window.confirm("Êtes-vous certain de vouloir supprimer la partie?\nCette action ne peut être annulée.")) {
				$http.delete('../api/games/'+selectedGame.game_id).success( function (data) {
					alert("Partie supprimée.");
					$scope.selectedGameId = false;
					$scope.selectedGame = false;
					console.log(data);
				}).error( function(data) {
					alert("Une erreur est survenue.");
					console.log(data);
				});
			} else {
				return false;
			}
		};
		
		console.log($scope);
		
	}
]);

rebelLeaguesAdminControllers.controller('editLeagueCtrl', ['$scope', '$http',
	function ($scope, $http) {
	
		$scope.title = "Modifier les paramètres de league";
		$scope.partial = "partials/editLeague.php";
	
		$scope.expanded = false;
		$scope.toggle = function () { $scope.expanded = !$scope.expanded };
		
		$scope.league = {};
		$scope.ranking_methods = [];
		
		$http.get('../api/leagues')
			.then(
				function success(response) { $scope.league = response.data.data.league;
											 $scope.ranking_methods = response.data.data.ranking_methods; },
				function error(reason)     { return false; }
			);

		$scope.submit = function (league, ranking_methods) {
			
			//console.log(encodeURIComponent(angular.toJson(game)));
			
			$http.put('../api/leagues', league).success( function (data) {
					console.log(data);
				if (data.status == "success") {
					alert("Paramètres modifiées.");
				} else {
					alert("Une erreur est survenue.");
				}
			}).error( function(data) {
				alert("Une erreur est survenue.");
				console.log(data);
			});
		};
	}
]);



