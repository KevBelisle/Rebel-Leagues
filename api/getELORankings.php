<?php

class ELO {

	/***
	* K-Factor starts at $kFactorStarting between 0 and $seasonedGameReq games played,  
	* then drops down to $kFactorSeasoned. After that point, if the ELO rating is equal or above
	* $masterLevel, then the K-factor drops further down to $kFactorMaster.
	***/

	const kFactorStarting = 25; 
	const kFactorSeasoned = 15;
	const kFactorMaster = 10;
	const masterLevel = 2400;
	const seasonedGameReq = 30;
	const initELO = 1000;

	public static function getKFactor($nbGames, $elo) {
		if($elo >= ELO::masterLevel && $nbGames >= ELO::seasonedGameReq)
		{
			return ELO::kFactorMaster;
		}
		else if($elo < ELO::masterLevel && $nbGames >= ELO::seasonedGameReq)
		{
			return ELO::kFactorSeasoned;
		}
		else return ELO::kFactorStarting;
	}

	static function cmp($a, $b) {
		if ($a['elo_rating'] == $b['elo_rating'])
		return 0;
		return ($b['elo_rating'] < $a['elo_rating']) ? -1 : 1;
	}

	public static function getELORankings($games, $players) {
		
		$nbPlayers = count($players);
		
		//set all players to $initELO initially and their game to 0
		foreach($players as $player)
		{
			$games_played[$player['player_id']] = 0; // helper array to keep track of game count
		}
		
		foreach($games as $game)
		{
			//fetch winner, then loser
			$pl1 = $game['player1_id'];
			$pl2 = $game['player2_id'];

			//fetch ELO ratings and k factors
			foreach($players as $player)
			{
				if($player['player_id'] == $pl1) $elo1 = $player['elo_rating'];
				if($player['player_id'] == $pl2) $elo2 = $player['elo_rating'];
			}
			
			$k1 = ELO::getKFactor($games_played[$pl1], $elo1);
			$k2 = ELO::getKFactor($games_played[$pl2], $elo2);

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
			$games_played[$pl1]++; 
			$games_played[$pl2]++; 
			
		}	
		
		//sort high to low
		usort($players, "ELO::cmp");
		return $players;
	}
}

?>