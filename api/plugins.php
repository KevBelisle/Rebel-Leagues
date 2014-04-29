<?php

	abstract class Plugin {
		var $name = "";
		var $version = 0;
		var $root_dir = "";
		var $id = 0;
		
		function __construct($id, $version, $root_dir) {
			$this->id = $id;
			$this->version = $version;
			$this->root_dir = $root_dir;
			
			$this->_constructor();
		}
		
		abstract public function setup();
		public function _constructor() {}
	}

	$pluginAddons = [
		"js_includes" => [],
		"js_modules" => [],
		"css_includes" => [],
		"view_additions" => [
			"games_history" => [
				"game_details" => []
			]
		],
		"api_additions" => [
			"games_history" => [],
			"add_game" => [
				"check_fields" => [],
				"pre_insert" => [],
				"post_insert" => []
			]
		],
		"admin_additions" => [
			"add_game" => [
				"player1" => [],
				"player2" => []
			]
		]
	];

	foreach (getDatabase()->all("SELECT * FROM plugins") as $plugin) {
	
		include_once "plugins/" . $plugin["folder"] . "/config.php";
		
		$p = new ReflectionClass($plugin["folder"]);
		$pluginInstance = $p->newInstance($plugin["plugin_id"], $plugin["version"], "api/plugins/" . $plugin["folder"] . "/");
		
		$pluginAddons = array_merge_recursive($pluginAddons, $pluginInstance->pluginAddons);
		
		if ($pluginInstance->version == 0) {
			try {
				$pluginInstance->setup();
				getDatabase()->execute('UPDATE plugins SET version = 1 WHERE plugin_id = :plugin_id',
					array( ':plugin_id' => $pluginInstance->id )
				);
				$pluginInstance->version = 1;
			} catch (Exception $e) {
				echo outputError($e->getMessage());
			}
		}
		
		if ($pluginInstance->version < $pluginInstance->current_version) {
			// Update script...
		}
		
		
	}
	
?>