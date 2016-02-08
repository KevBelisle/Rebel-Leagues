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
			notes: "",
			attributes: ""
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
					notes: "",
					attributes: ""
				};
				$scope.game_attributes = [];
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
		$scope.partial = "partials/editGame.html";
		
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
		$scope.attribute_groups = {};
		$scope.attributes = [];
		
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
		$http.get('../api/attributes/')
			.then(
				function success(response) {
					response.data.data.attributes.forEach(function (attribute, index) {
						if (attribute.attribute_group == null) {
							$scope.attributes.push(attribute);
						} else {
							if (attribute.attribute_group in $scope.attribute_groups) {
								$scope.attribute_groups[attribute.attribute_group]["group_attributes"].push(attribute);
							} else {
								$scope.attribute_groups[attribute.attribute_group] = {
									"attribute_group": attribute.attribute_group,
									"selected_attribute_id": null,
									"group_attributes": [attribute]
								};
							}
						}
					});
					console.log("attributes:");
					console.log($scope.attribute_groups);
					console.log($scope.attributes);
				},
				function error(reason)     { return false; }
			);
		
		$scope.submit = function (selectedGame) {
			
			selectedGame.date = selectedGame.datetime.toYMDHMS();
			
			console.log("Editing...");
			console.log(selectedGame);
			
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
		$scope.partial = "partials/editLeague.html";
	
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


rebelLeaguesAdminControllers.controller('addAttributeCtrl', ['$scope', '$http',
	function ($scope, $http) {
	
		$scope.title = "Ajouter un attribut";
		$scope.partial = "partials/addAttribute.html";
	
		$scope.expanded = false;
		$scope.toggle = function () { $scope.expanded = !$scope.expanded };
		
		$scope.attribute_groups = [];
		
		$http.get('../api/attributes/groups')
			.then(
				function success(response) { $scope.attribute_groups = response.data.data.attribute_groups; },
				function error(reason)     { return false; }
			);
			
		$scope.attribute = {
			name: null,
			attribute_group: null,
		};

		$scope.submit = function (i_attribute) {
			
			$http.post('../api/attributes', i_attribute).success( function (data) {
				alert("Attribut ajouté.");
				$scope.attribute = {
					name: null,
					attribute_group: null
				};
				console.log(data);
			}).error( function(data) {
				alert("Une erreur est survenue.");
				console.log(data);
			});
		};
	}
]);


rebelLeaguesAdminControllers.controller('editAttributeCtrl', ['$scope', '$http',
	function ($scope, $http) {
	
		$scope.title = "Modifier ou supprimer un attribut";
		$scope.partial = "partials/editAttribute.html";
	
		$scope.expanded = false;
		$scope.toggle = function () { $scope.expanded = !$scope.expanded };
		
		$scope.attributes = [];
		
		$http.get('../api/attributes')
			.then(
				function success(response) { $scope.attributes = response.data.data.attributes; },
				function error(reason)     { return false; }
			);

		$scope.save = function (attribute) {
			
			$http.put('../api/attributes', attribute).success( function (data) {
				alert("Attribut modifié.");
				console.log(data);
			}).error( function(data) {
				alert("Une erreur est survenue.");
				console.log(data);
			});
		};

		$scope.delete = function (attribute) {
			
			$http.delete('../api/attributes', attribute).success( function (data) {
				alert("Attribut supprimé.");
				console.log(data);
			}).error( function(data) {
				alert("Une erreur est survenue.");
				console.log(data);
			});
		};
	}
]);





rebelLeaguesAdminControllers.directive('attributeEditor', function($http) {
    return {
        restrict: 'AE',
        // we don't need anymore to bind the value to the external ngModel
        // as we require its controller and thus can access it directly
        scope: {},
        // the 'require' property says we need a ngModel attribute in the declaration.
        // this require makes a 4th argument available in the link function below
        require: 'ngModel',
		
        templateUrl: 'partials/attributeEditor.html',
		
        // the ngModelController attribute is an instance of an ngModelController
        // for our current ngModel.
        // if we had required multiple directives in the require attribute, this 4th
        // argument would give us an array of controllers.
        link: function(scope, iElement, iAttrs, ngModelController) {
		
			scope.all_attributes = [];
			scope.attribute_groups = {};
			scope.attributes = [];
			
			scope.game_attributes = [];
			scope.selected_attribute = null;
			
			scope.loading = $http.get('../api/attributes/')
				.then(
					function success(response) {
						scope.all_attributes = response.data.data.attributes;
						response.data.data.attributes.forEach(function (attribute, index) {
							if (attribute.attribute_group == null) {
								scope.attributes.push(attribute);
							} else {
								if (attribute.attribute_group in scope.attribute_groups) {
									scope.attribute_groups[attribute.attribute_group]["group_attributes"].push(attribute);
								} else {
									scope.attribute_groups[attribute.attribute_group] = {
										"attribute_group": attribute.attribute_group,
										"selected_attribute_id": null,
										"group_attributes": [attribute]
									};
								}
							}
						});
					},
					function error(reason)     { return false; }
				);
				
			function updateInternalsFromString (attrString) {
				scope.loading.then(function () {
					if (attrString == "" || attrString == undefined) {
						scope.game_attributes = [];
						scope.selected_attribute = null;
						for (var key in scope.attribute_groups) {
							// skip loop if the property is from prototype
							if (!scope.attribute_groups.hasOwnProperty(key)) continue;
							var attribute_group = scope.attribute_groups[key];
							attribute_group.selected_attribute_id = null;
						}
					}
					else
					{
						if( typeof attrString === 'string' ) {
							attrString = attrString.split(",");
						}
						
						scope.game_attributes = [];
							
						attrString.forEach(function (attribute_id, index) {
							var attr = scope.all_attributes.filter(function( obj ) {
								return obj.attribute_id == attribute_id;
							})[0];
							
							if (scope.all_attributes.indexOf(attr) == -1) {
								// Shouldn't happen...
								alert("An error occured.");
							}
							
							
							if (attr.attribute_group == null) {
								scope.game_attributes.push(attr);
							} else {
								scope.attribute_groups[attr.attribute_group].selected_attribute_id = attr.attribute_id;
							}
						});
					}
				});
			}
			
			function arrayFromInternals () {
				var attribute_ids = scope.game_attributes.map(function(obj){ return obj.attribute_id; });
			
				for (var attribute_group in scope.attribute_groups) {
					var selected_attribute_id = scope.attribute_groups[attribute_group].selected_attribute_id;
					if (selected_attribute_id != undefined) {
						attribute_ids.push(selected_attribute_id);
					}
				}
				
				return attribute_ids;
			}
			
			scope.addAttribute = function (attribute_id) {
				
				var attr = scope.attributes.filter(function( obj ) {
					return obj.attribute_id == attribute_id;
				})[0];
				
				if (scope.game_attributes.indexOf(attr) == -1) {
					scope.game_attributes.push(attr);
				}
				
                ngModelController.$setViewValue( arrayFromInternals() );
			};
			
			scope.removeAttribute = function (attribute) {
				var index = scope.game_attributes.indexOf(attribute);
				if (index > -1) {
					scope.game_attributes.splice(index, 1);
				}
				
                ngModelController.$setViewValue( arrayFromInternals() );
			}
			
			scope.attributeGroupChange = function () {
				ngModelController.$setViewValue( arrayFromInternals() );
			}
			
            // we can now use our ngModelController builtin methods
            // that do the heavy-lifting for us

            // when model changes, update our view (just update the div content)
            ngModelController.$render = function() {
				
				updateInternalsFromString( ngModelController.$viewValue );
				
            };
        }
    };
});















