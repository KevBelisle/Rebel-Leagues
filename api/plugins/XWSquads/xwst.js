(function () {

	window.XWST = {
		template: "<div class='xwst-tooltip'><ul>\
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
		</ul></div`>",
		setTemplate: function (template) {
			window.XWST.template = template;
		},
		_loaded: jQuery.Deferred(),
		_ready: jQuery.Deferred()
	};
	
	jQuery(function () {
		['http://cdnjs.cloudflare.com/ajax/libs/handlebars.js/1.3.0/handlebars.min.js',
		'api/plugins/xwst_preload.js',
		'http://geordanr.github.io/xwing/javascripts/cards-common.js',
		'http://geordanr.github.io/xwing/javascripts/cards-en.js',
		'http://geordanr.github.io/xwing/javascripts/translate.js',
		'api/plugins/xwst_postload.js'].forEach( function (source) {
			var script = document.createElement('script');
			script.type = "text/javascript";
			script.src = source;
			script.async = false;
			document.body.appendChild(script);
		});
	});
	
	var prepareXWST = function () {
		setTimeout(window.XWST._ready.resolve, 100);
	};
	
	window.XWST._loaded.then( prepareXWST );
	
	window.XWST.run = function (selector) {
		window.XWST._ready.done( function () {
		
			var urlRegex = /http:\/\/geordanr.github.io\/xwing\/\?f=(\S+?)&d=(\S+)/g;
		  
			jQuery(selector).find("a[href^='http://geordanr.github.io/xwing/']").each( function (index) {
				
				if (jQuery(this).data("XWST")) { return; }
			
				var url = jQuery(this).attr('href');
				var urlRegex = /http:\/\/geordanr.github.io\/xwing\/\?f=(\S+?)&d=v[0-9]\!(\S+)+/g;
				var urlComponents = urlRegex.exec( url );
				
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
					var ship = XWST.pilotsById[urlData[0][0]];
					var addons = [];
					
					urlData[1].forEach( function (upgrade) {
						if (upgrade > -1) {
							addons.push(XWST.upgradesById[upgrade]);
						}
					});
					
					urlData[2].forEach( function (title) {
						if (title > -1) {
							addons.push(XWST.titlesById[title]);
						}
					});
					
					urlData[3].forEach( function (modification) {
						if (modification > -1) {
							addons.push(XWST.modificationsById[modification]);
						}
					});
					
					squadData.members.push({ship: ship, addons: addons});
				});
				jQuery(this).data("XWST", "true");
			
				console.log( squadData );
				jQuery(this).addClass("xwst");
				jQuery(this).append( Handlebars.compile(window.XWST.template)(squadData) );
			});
		
		});
	};
	
})();