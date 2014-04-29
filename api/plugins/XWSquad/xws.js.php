
window.XWSquad = angular.module('xwsquad', [])
	.directive('xwsquad', function() {
		return {
			link: function (scope, element, attrs) {
			
				if (attrs.xwsquad.substring(0,32) == 'http://geordanr.github.io/xwing/') {
					element.html( window.XWSquad.parseURL(attrs.xwsquad) );
				} else if (attrs.xwsquad.length > 0) {
					element.html( "<a href='"+attrs.xwsquad+"' target='new'>Voir squad</a>" );
				} else {
				}
				
			}
		};
	});


(function () {
	<?php
	echo file_get_contents("http://geordanr.github.io/xwing/javascripts/cards-common.js");
	echo "\n";
	echo file_get_contents("http://geordanr.github.io/xwing/javascripts/cards-en.js");
	echo "\n";
	echo file_get_contents("http://geordanr.github.io/xwing/javascripts/translate.js");
	?>
	
	this.loadCards("English");
	
	this.template = Handlebars.compile("<span class='xws-squad-title weight-heavy color-xxdark'>\
			<span class='xws-squad-faction'>{{faction}}</span>\
			<span class='xws-squad-points'>{{points}}</span>\
		</span>\
		<ul>\
		{{#members}}<li>\
			<span class='xws-pilot-name weight-medium color-xxdark'>{{ship.name}}</span>\
			<span class='xws-ship-name'>{{ship.ship}}</span>\
			<span class='xws-ship-cost'>{{ship.points}}</span>\
			<ul class='xws-addons'>\
				{{#addons}}<li>\
					<span class='xws-addon-name'>{{name}}</span>\
					<span class='xws-addon-cost'>{{points}}</span></li>\
				{{/addons}}</ul>\
		</li>{{/members}}\
		</ul>");
	
	
	this.parseURL = function(url) {
		
		var urlRegex = /http:\/\/geordanr.github.io\/xwing\/\?f=(\S+?)&d=v[0-9](?:\![\S])?\!(\S+)+/g;
		var urlComponents = urlRegex.exec( url );
		
		if (urlComponents == null) { return; }
		
		var squadData = {};
		
		squadData.id = "xws-" + Date.now();
		squadData.faction = decodeURIComponent( urlComponents[1] );
		squadData.points = 0;
		squadData.members = [];
		
		var ships = urlComponents[2].split(";");
		for (var i = 0; i < ships.length; i++) {
			ships[i] = ships[i].split(":");
			for (var j = 0; j < ships[i].length; j++) {
				ships[i][j] = ships[i][j].split(",");
			}
		}
		
		ships.forEach( function (urlData) {
			var ship = window.XWSquad.pilotsById[urlData[0][0]];
			squadData.points += ship.points;
			var addons = [];
			
			urlData[1].forEach( function (upgrade) {
				if (upgrade > -1) {
					addons.push(window.XWSquad.upgradesById[upgrade]);
					squadData.points += window.XWSquad.upgradesById[upgrade].points;
				}
			});
			
			urlData[2].forEach( function (title) {
				if (title > -1) {
					addons.push(window.XWSquad.titlesById[title]);
					squadData.points += window.XWSquad.titlesById[title].points;
				}
			});
			
			urlData[3].forEach( function (modification) {
				if (modification > -1) {
					addons.push(window.XWSquad.modificationsById[modification]);
					squadData.points += window.XWSquad.modificationsById[modification].points;
				}
			});
			
			squadData.members.push({ship: ship, addons: addons});
		});
		
		return window.XWSquad.template(squadData);
	}
	
}).call(window.XWSquad);