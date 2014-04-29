<?php

	# -------------------------------
	#	X-Wing Squads Plugin
	# -------------------------------
	
	class XWSquad extends Plugin {
		var $name = "X-Wing Squad Plugin";
		var $current_version = 1;
						
		var $pluginAddons = [
			"js_includes" => ["http://cdnjs.cloudflare.com/ajax/libs/handlebars.js/1.3.0/handlebars.min.js"],
			"js_modules" => ["xwsquad"],
			"css_includes" => [],
			"view_additions" => [
				"games_history" => [
					"game_details" => ['<div class="xwsquads clear" ng-show="game.player1_squad || game.player2_squad">
							<div class="squad">
								<div xwsquad="{{game.player1_squad}}"></div>
							</div>
							<div class="squad">
								<div xwsquad="{{game.player2_squad}}"></div>
							</div>
						</div>']
				]
			],
			"api_additions" => [
				"games_history" => ["games_squads"],
				"add_game" => [
					"check_fields" => ["player1_squad", "player2_squad"],
					"pre_insert" => [],
					"post_insert" => [array( 'XWSquad', 'insert_game_squads' )]
				]
			],
			"admin_additions" => [
				"add_game" => [
					"player1" => ["<input type='text' class='fullWidth' ng-model='game.player1_squad' placeholder='Squad du premier joueur' />"],
					"player2" => ["<input type='text' class='fullWidth' ng-model='game.player2_squad' placeholder='Squad du deuxième joueur' />"]
				]
			]
		];
		
		static public function insert_game_squads($database, $game_id) {
			try {
				print 'TEST TEST TEST TEST TEST';
			
				print_r([
					':game_id' => $game_id,
					':player1_squad' => $_POST["player1_squad"],
					':player2_squad' => $_POST["player2_squad"]
				]);
			
				$database->execute('INSERT INTO games_squads (game_id, player1_squad, player2_squad) VALUES (:game_id, :player1_squad, :player2_squad)',
				[
					':game_id' => $game_id,
					':player1_squad' => $_POST["player1_squad"],
					':player2_squad' => $_POST["player2_squad"]
				]);
				
			} catch (Exception $e) {}
			
			print 'TEST TEST TEST TEST TEST';
		}
		
		function _constructor() {
			array_push($this->pluginAddons["js_includes"], $this->root_dir."xws.js.php");
			array_push($this->pluginAddons["css_includes"], $this->root_dir."xws.css");
		}
		
		public function setup()
		{
			$table_name = getDatabase()->execute('CREATE TABLE IF NOT EXISTS games_squads ( game_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ) ENGINE=InnoDB DEFAULT CHARSET=utf8;');
			
			getDatabase()->execute("ALTER TABLE games_squads ADD player1_squad VARCHAR(256)");
			getDatabase()->execute("ALTER TABLE games_squads ADD player2_squad VARCHAR(256)");

			return true;
		}
	};
?>