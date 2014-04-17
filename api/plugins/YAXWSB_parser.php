<?php

	$definition_file = file_get_contents('https://raw.githubusercontent.com/geordanr/xwing/master/javascripts/cards-common.js');
	
	function get_bracket_contents($haystack, $start_key, $brackets) {
		$start_index = stripos($haystack, $start_key) + strlen($start_key);
		
		$length = 1;
		$open_bracket_count = 1;
		
		while ($open_bracket_count > 0 && $start_index + $length < strlen($haystack)) {
			if ( $haystack{$start_index + $length} == $brackets{0} ) {
				$open_bracket_count += 1;
			} else if ( $haystack{$start_index + $length} == $brackets{1} ) {
				$open_bracket_count -= 1;
			}
			$length += 1;
		}
		
		$content_string = substr($haystack, $start_index, $length);
		#$content_string = preg_replace('/\s+/', '', $content_string);
		$content_string = preg_replace('/\\\"/', '', $content_string);
		$content_string = preg_replace('/ \'([\s\S]*?)"([\s\S]*?)"([\s\S]*?)\',/', ' "$1$2$3",', $content_string);
		$content_string = preg_replace('/\'/', '', $content_string);
		$content_string = preg_replace('/(\w+):/', '"$1":', $content_string);
		$content_string = preg_replace('/,[\s]+"restriction_func": function[\s\S]+?},(?! {)/', ',', $content_string);
		
		$content_string = preg_replace('/,[\s]+"restriction_func": function[\s\S]+?},/', '},', $content_string);
		$content_string = preg_replace('/,[\s]+"modifier_func": function[\s\S]+?},/', '},', $content_string);
		$content_string = preg_replace('/exportObj.\w+/', 'null', $content_string);
		
		return json_decode($content_string);
	};

	$pilots = get_bracket_contents($definition_file, "pilotsById: ", "[]");
	$upgrades = get_bracket_contents($definition_file, "upgradesById: ", "[]");
	$modifications = get_bracket_contents($definition_file, "modificationsById: ", "[]");
	$titles = get_bracket_contents($definition_file, "titlesById: ", "[]");

	
	
?>