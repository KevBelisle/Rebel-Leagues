
var rebelLeaguesApp = angular.module('rebelLeaguesApp', [
	'ngRoute',
	'rebelLeaguesControllers'
]);

rebelLeaguesApp.config([
	'$routeProvider',
	function ($routeProvider) {
		$routeProvider.
			when('/gamesHistory', {
				templateUrl: 'partials/gamesHistory.html',
				controller: 'gamesHistoryCtrl'
			}).
			otherwise({
				redirectTo: '/gamesHistory'
			});
	}
]);

