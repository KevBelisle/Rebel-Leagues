(function() {

  var exportObj;
  exportObj = typeof exports !== "undefined" && exports !== null ? exports : this;
  
  exportObj.parse = function (selector) {
  
	var urlRegex = /http:\/\/geordanr.github.io\/xwing\/\?f=(\S+?)&d=(\S+)/g;
  
	$(selector).find("a[href^='http://geordanr.github.io/xwing/']").each( function (index) {
		var url = $(this).attr('href');
		var urlRegex = /http:\/\/geordanr.github.io\/xwing\/\?f=(\S+?)&d=v[0-9]\!(\S+)+/g;
		var urlComponents = urlRegex.exec( url );
		
		var faction = urlComponents[1];
		var ships = urlComponents[2].split(";");
		
		for (var i = 0; i < ships.length; i++) {
			ships[i] = ships[i].split(":");
			for (var j = 0; j < ships[i].length; j++) {
				ships[i][j] = ships[i][j].split(",");
			}
		}
		
		
		console.log(url);
		console.log(faction);
		
		ships.forEach( function (ship) {
			console.log( exports.pilotsById[ship[0][0]] );
			
			ship[1].forEach( function (upgrade) {
				if (upgrade > -1) {
					console.log(exports.upgradesById[upgrade]);
				}
			});
			
			ship[2].forEach( function (title) {
				if (title > -1) {
					console.log(exports.titlesById[title]);
				}
			});
			
			ship[3].forEach( function (modification) {
				if (modification > -1) {
					console.log(exports.modificationsById[modification]);
				}
			});
		});
		
	});
	
	
	
	
  
  };
  
  exportObj.ttTemplate = "TEMPLATE";

}).call(this);