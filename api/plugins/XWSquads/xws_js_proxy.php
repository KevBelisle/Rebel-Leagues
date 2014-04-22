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
	
	this.template = Handlebars.compile("<div class='xwst-tooltip'><ul>\
		{{#members}}<li>\
			<span class='wxst-pilot-name'>{{ship.name}}</span>\
			<span class='wxst-ship-name'>{{ship.ship}}</span>\
			<span class='wxst-ship-cost'>{{ship.points}}</span>\
			<ul class='xwst-addons'>\
				{{#addons}}<li>\
					<span class='wxst-addon-name'>{{name}}</span>\
					<span class='wxst-addon-cost'>{{points}}</span></li>\
				{{/addons}}</ul> <br>\
		</li>{{/members}}\
		</ul></div>");
	
	var urlRegex = /http:\/\/geordanr.github.io\/xwing\/\?f=(\S+?)&d=(\S+)/g;
  
	jQuery("a[href^='http://geordanr.github.io/xwing/']").each( function (index) {
		
		if (jQuery(this).data("XWingSquad")) { return; }
	
		var url = jQuery(this).attr('href');
		var urlRegex = /http:\/\/geordanr.github.io\/xwing\/\?f=(\S+?)&d=v[0-9]\!(\S+)+/g;
		var urlComponents = urlRegex.exec( url );
	
		console.log(urlComponents);
		
		if (urlComponents == null) { return; }
		
		var squadData = {};
		
		squadData.faction = urlComponents[1];
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
			var addons = [];
			
			urlData[1].forEach( function (upgrade) {
				if (upgrade > -1) {
					addons.push(window.XWS.upgradesById[upgrade]);
				}
			});
			
			urlData[2].forEach( function (title) {
				if (title > -1) {
					addons.push(window.XWS.titlesById[title]);
				}
			});
			
			urlData[3].forEach( function (modification) {
				if (modification > -1) {
					addons.push(window.XWS.modificationsById[modification]);
				}
			});
			
			squadData.members.push({ship: ship, addons: addons});
		});
		jQuery(this).data("XWingSquad", "true");
	
		console.log( squadData );
		jQuery(this).addClass("xwst");
		jQuery(this).append( window.XWS.template(squadData) );
	});
		
	console.log(this);
	
}).call(window.XWS);