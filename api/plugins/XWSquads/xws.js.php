window.XWS = {};
(function () {
	<?php
	echo file_get_contents("http://geordanr.github.io/xwing/javascripts/cards-common.js");
	echo "\n";
	echo file_get_contents("http://geordanr.github.io/xwing/javascripts/cards-en.js");
	echo "\n";
	echo file_get_contents("http://geordanr.github.io/xwing/javascripts/translate.js");
	?>
	
	this.loadCards("English");
	
	this.template = Handlebars.compile("<div class='xws-tooltip {{id}}'><div class='xws-tooltip-arrow'></div>\
		<span class='xws-squad-title'>\
			<span class='xws-squad-faction'>{{faction}}</span>\
			<span class='xws-squad-points'>{{points}}</span>\
		</span>\
		<ul>\
		{{#members}}<li>\
			<span class='xws-pilot-name'>{{ship.name}}</span>\
			<span class='xws-ship-name'>{{ship.ship}}</span>\
			<span class='xws-ship-cost'>{{ship.points}}</span>\
			<ul class='xws-addons'>\
				{{#addons}}<li>\
					<span class='xws-addon-name'>{{name}}</span>\
					<span class='xws-addon-cost'>{{points}}</span></li>\
				{{/addons}}</ul>\
		</li>{{/members}}\
		</ul>\
		</div>");
	
	var urlRegex = /http:\/\/geordanr.github.io\/xwing\/\?f=(\S+?)&d=(\S+)/g;
  
	jQuery("a[href^='http://geordanr.github.io/xwing/']").each( function (index) {
		
		if (jQuery(this).data("XWingSquad")) { return; }
	
		var url = jQuery(this).attr('href');
		var urlRegex = /http:\/\/geordanr.github.io\/xwing\/\?f=(\S+?)&d=v[0-9]\!(\S+)+/g;
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
			var ship = window.XWS.pilotsById[urlData[0][0]];
			squadData.points += ship.points;
			var addons = [];
			
			urlData[1].forEach( function (upgrade) {
				if (upgrade > -1) {
					addons.push(window.XWS.upgradesById[upgrade]);
					squadData.points += window.XWS.upgradesById[upgrade].points;
				}
			});
			
			urlData[2].forEach( function (title) {
				if (title > -1) {
					addons.push(window.XWS.titlesById[title]);
					squadData.points += window.XWS.titlesById[title].points;
				}
			});
			
			urlData[3].forEach( function (modification) {
				if (modification > -1) {
					addons.push(window.XWS.modificationsById[modification]);
					squadData.points += window.XWS.modificationsById[modification].points;
				}
			});
			
			squadData.members.push({ship: ship, addons: addons});
		});
		jQuery(this).data("XWingSquad", "true");
	
		console.log( squadData );
		jQuery(this).addClass("xws").addClass(squadData.id);
		jQuery(this).append( window.XWS.template(squadData) );
	});
	
}).call(window.XWS);