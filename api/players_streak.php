<?php

class players_streak {

	/***
	* Gets a list of players who won their last 'streak_threshold' games (or more) in a row.
	***/

	const streak_threshold = 5; 

	static function cmp($a, $b) {
		if ($a['elo_rating'] == $b['elo_rating'])
		return 0;
		return ($b['elo_rating'] < $a['elo_rating']) ? -1 : 1;
	}

	public static function getPlayersStreaks($games, $players) {
		
		$nbPlayers = count($players);
		
		//set all players to a streak count of 0
		foreach($players as $player)
		{
			$streak_count[$player['player_id']] = 0; // helper array to keep track of game count
		}
		
		foreach($games as $game)
		{
			//fetch winner
			$pl1 = $game['player1_id'];

			//fetch ELO ratings and k factors
			foreach($players as $player)
			{
				if($player['player_id'] == $pl1) $elo1 = $player['elo_rating'];
				if($player['player_id'] == $pl2) $elo2 = $player['elo_rating'];
			}
			
			$k1 = ELO::getKFactor($streak_count[$pl1], $elo1);
			$k2 = ELO::getKFactor($streak_count[$pl2], $elo2);

			//compute expected probability of winning
			$exp1 = 1.0/(1.0+pow(10.0,($elo2-$elo1)/400.0));
			$exp2 = 1.0/(1.0+pow(10.0,($elo1-$elo2)/400.0));

			//gotta make a branch for draws, last term becomes 0.5-exp
			if($game['is_draw']==1)
			{
				//adjust elo scores
				foreach($players as $player)
				{
					if($player['player_id'] == $pl1) $elo1 = $elo1 + $k1*(0.5-$exp1);
					if($player['player_id'] == $pl2) $elo2 = $elo2 + $k2*(0.5-$exp2);
				}
			}
			else
			{
				//adjust elo scores
				foreach($players as $player)
				{
					if($player['player_id'] == $pl1) $elo1 = $elo1 + $k1*(1-$exp1);
					if($player['player_id'] == $pl2) $elo2 = $elo2 + $k2*(0-$exp2);
				}
			}

			for($i=0; $i<$nbPlayers; $i++)
			{
				if($players[$i]['player_id'] == $pl1) $players[$i]['elo_rating'] = $elo1;
				if($players[$i]['player_id'] == $pl2) $players[$i]['elo_rating'] = $elo2;
			}
			//adjust number of games to influence k factor maybe
			$streak_count[$pl1]++; 
			$streak_count[$pl2]++; 
			
		}	
		
		//sort high to low
		usort($players, "players_streak::cmp");
		return $players;
	}
}

?>