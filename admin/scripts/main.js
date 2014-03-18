
angular.module('link', [])
	.directive('activeLink', ['$location', function(location) {
		return {
			restrict: 'A',
			link: function(scope, element, attrs, controller) {
				var clazz = attrs.activeLink;
				var path = attrs.href;
				path = path.substring(1); //hack because path does not return including hashbang
				scope.location = location;
				scope.$watch('location.path()', function(newPath) {
					if (path === newPath) {
						element.addClass(clazz);
					} else {
						element.removeClass(clazz);
					}
				});
			}
		};
	}]);

var rebelLeaguesApp = angular.module('rebelLeaguesAdminApp', [
	'ngRoute',
	'rebelLeaguesAdminControllers',
	'link',
	'ui.bootstrap'
]).run(
	['$templateCache', function($templateCache){
		$templateCache.put('template/datepicker/datepicker.html',
			"<table>\n" +
			"  <thead>\n" +
			"    <tr>\n" +
			"      <th><button type=\"button\" class=\"btn btn-default btn-sm pull-left\" ng-click=\"move(-1)\"><i class=\"fa fa-chevron-left\"></i></button></th>\n" +
			"      <th colspan=\"{{rows[0].length - 2 + showWeekNumbers}}\"><button type=\"button\" class=\"btn btn-default btn-sm btn-block\" ng-click=\"toggleMode()\"><strong>{{title}}</strong></button></th>\n" +
			"      <th><button type=\"button\" class=\"btn btn-default btn-sm pull-right\" ng-click=\"move(1)\"><i class=\"fa fa-chevron-right\"></i></button></th>\n" +
			"    </tr>\n" +
			"    <tr ng-show=\"labels.length > 0\" class=\"h6\">\n" +
			"      <th ng-show=\"showWeekNumbers\" class=\"text-center\">#</th>\n" +
			"      <th ng-repeat=\"label in labels\" class=\"text-center\">{{label}}</th>\n" +
			"    </tr>\n" +
			"  </thead>\n" +
			"  <tbody>\n" +
			"    <tr ng-repeat=\"row in rows\">\n" +
			"      <td ng-show=\"showWeekNumbers\" class=\"text-center\"><em>{{ getWeekNumber(row) }}</em></td>\n" +
			"      <td ng-repeat=\"dt in row\" class=\"text-center\">\n" +
			"        <button type=\"button\" style=\"width:100%;\" class=\"btn btn-default btn-sm\" ng-class=\"{'btn-info': dt.selected}\" ng-click=\"select(dt.date)\" ng-disabled=\"dt.disabled\"><span ng-class=\"{'text-muted': dt.secondary}\">{{dt.label}}</span></button>\n" +
			"      </td>\n" +
			"    </tr>\n" +
			"  </tbody>\n" +
			"</table>\n" +
			"");
			
		$templateCache.put("template/timepicker/timepicker.html",
			"<table>\n" +
			"	<tbody>\n" +
			"		<tr class=\"text-center\">\n" +
			"			<td><button ng-click=\"incrementHours()\" class=\"btn btn-link\"><i class=\"fa fa-chevron-up\"></i></button></td>\n" +
			"			<td>&nbsp;</td>\n" +
			"			<td><button ng-click=\"incrementMinutes()\" class=\"btn btn-link\"><i class=\"fa fa-chevron-up\"></i></button></td>\n" +
			"			<td ng-show=\"showMeridian\"></td>\n" +
			"		</tr>\n" +
			"		<tr>\n" +
			"			<td style=\"width:50px;\" class=\"form-group\" ng-class=\"{'has-error': invalidHours}\">\n" +
			"				<input type=\"text\" ng-model=\"hours\" ng-change=\"updateHours()\" class=\"form-control text-center\" ng-mousewheel=\"incrementHours()\" ng-readonly=\"readonlyInput\" maxlength=\"2\">\n" +
			"			</td>\n" +
			"			<td class='text-center'>:</td>\n" +
			"			<td style=\"width:50px;\" class=\"form-group\" ng-class=\"{'has-error': invalidMinutes}\">\n" +
			"				<input type=\"text\" ng-model=\"minutes\" ng-change=\"updateMinutes()\" class=\"form-control text-center\" ng-readonly=\"readonlyInput\" maxlength=\"2\">\n" +
			"			</td>\n" +
			"			<td ng-show=\"showMeridian\"><button type=\"button\" class=\"btn btn-default text-center\" ng-click=\"toggleMeridian()\">{{meridian}}</button></td>\n" +
			"		</tr>\n" +
			"		<tr class=\"text-center\">\n" +
			"			<td><button ng-click=\"decrementHours()\" class=\"btn btn-link\"><i class=\"fa fa-chevron-down\"></i></button></td>\n" +
			"			<td>&nbsp;</td>\n" +
			"			<td><button ng-click=\"decrementMinutes()\" class=\"btn btn-link\"><i class=\"fa fa-chevron-down\"></i></button></td>\n" +
			"			<td ng-show=\"showMeridian\"></td>\n" +
			"		</tr>\n" +
			"	</tbody>\n" +
			"</table>\n" +
			"");
	}
]);


rebelLeaguesApp.config([
	'$routeProvider',
	function ($routeProvider) {
	
		console.log("routeProvider CHECKING IN!");
		
		$routeProvider
			.when('/addGame', {
				templateUrl: 'partials/addGame.html',
				controller: 'addGameCtrl',
				resolve: {
					"factions": [
						'$http',
						function($http) {
							return $http.get('../api/factions/leafs')
								.then(
									function success(response) { return response.data.data.factions; },
									function error(reason)     { return false; }
								);
						}
					],
					"players": [
						'$http',
						function($http) {
							return $http.get('../api/players/')
								.then(
									function success(response) { return response.data.data.players; },
									function error(reason)     { return false; }
								);
						}
					]
				}
			})
			.when('/addPlayer', {
				templateUrl: 'partials/addPlayer.html',
				controller: 'addPlayerCtrl'
			})			
			.otherwise({
				redirectTo: '/addGame'
			});
	}
]);
