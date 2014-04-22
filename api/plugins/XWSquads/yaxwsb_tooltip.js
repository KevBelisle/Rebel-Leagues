(function() {

  var exportObj;
  exportObj = typeof exports !== "undefined" && exports !== null ? exports : this;
  
  exportObj.ttTemplate = "TEMPLATE";
  
  exportObj.parse = function (selector) {
  
	var urlRegex = /http:\/\/geordanr.github.io\/xwing\/\?f=(\S+?)&d=(\S+)/g;
  
	$(selector).find("a[href^='http://geordanr.github.io/xwing/']").each( function (index) {
		var url = $(this).attr('href');
		var urlRegex = /http:\/\/geordanr.github.io\/xwing\/\?f=(\S+?)&d=v[0-9]\!(\S+)+/g;
		var urlComponents = urlRegex.exec( url );
		
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
			var ship = exports.pilotsById[urlData[0][0]];
			var addons = [];
			
			urlData[1].forEach( function (upgrade) {
				if (upgrade > -1) {
					addons.push(exports.upgradesById[upgrade]);
				}
			});
			
			urlData[2].forEach( function (title) {
				if (title > -1) {
					addons.push(exports.titlesById[title]);
				}
			});
			
			urlData[3].forEach( function (modification) {
				if (modification > -1) {
					addons.push(exports.modificationsById[modification]);
				}
			});
			
			squadData.members.push({ship: ship, addons: addons});
		});
		
		console.log(squadData);
		
	});
  };

}).call(this);