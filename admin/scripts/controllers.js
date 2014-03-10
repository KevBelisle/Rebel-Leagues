var monthNames = [ "janvier", "février", "mars", "avril", "mai", "juin",
	"juillet", "août", "septembre", "octobre", "novembre", "décembre" ];

var rebelLeaguesControllers = angular.module('rebelLeaguesAdminControllers', ['ui.bootstrap']);

rebelLeaguesControllers.controller('addGameCtrl', ['$scope', '$http', 'factions', 'players',
	function ($scope, $http, factions, players) {
	
		$scope.factions = factions;
		$scope.players = players;
		$scope.date = new Date();
		
		console.log($scope);
		
	}
]);






