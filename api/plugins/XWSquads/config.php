<?php

	abstract class Plugin {
		var $name = "";
		var $version = 0;
		var $root_dir = "";
		
		var $js_includes = [];
		var $css_includes = [];
		
		function __construct($root_dir) {
			$this->root_dir = $root_dir;
		}
		
		public function get_css_includes() {
			$output = [];
			foreach ($this->css_includes as $i => $file) {
				$output[] = $this->root_dir . $file;
			}
			return $output;
		}
		
		public function get_js_includes() {
			$output = [];
			foreach ($this->js_includes as $i => $file) {
				$output[] = $this->root_dir . $file;
			}
			return $output;
		}
		
		abstract public function setup();
	}


	# -------------------------------
	#	X-Wing Squads Plugin
	# -------------------------------
	
	class xws_plugin extends Plugin {
		var $name = "X-Wing Squads Plugin";
		var $version = 0;
		
		public function setup()
		{
			return true;
		}
		
		var $js_includes = ["xws.js.php"];
		var $css_includes = ["xws.css"];
	};
	
	$xws_plugin = new xws_plugin("root/dir/");
	
	var_dump( $xws_plugin->js_includes );
	var_dump( $xws_plugin->get_js_includes() );
	var_dump( $xws_plugin->css_includes );
	var_dump( $xws_plugin->get_css_includes() );
	
?>