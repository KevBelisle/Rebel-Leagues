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

	public static function getELORankings($games, $players) {
		
		//set all players to $initELO initially and their game to 0
		foreach($players as $player)
		{
			$elos[$player['player_id']] = ELO::initELO;
			$games_played[$player['player_id']] = 0;
		}
		
		foreach($games as $game)
		{
			//fetch winner, then loser
			$pl1 = $game['player1_id'];
			$pl2 = $game['player2_id'];

			//fetch k factors
			$k1 = ELO::getKFactor($games_played[$pl1], $elos[$pl1]);
			$k2 = ELO::getKFactor($games_played[$pl2], $elos[$pl2]);


			//fetch elos
			$elo1 = $elos[$pl1];
			$elo2 = $elos[$pl2];

			//compute expected probability of winning
			$exp1 = 1.0/(1.0+pow(10.0,($elo2-$elo1)/400.0));
			$exp2 = 1.0/(1.0+pow(10.0,($elo1-$elo2)/400.0));

			//gotta make a branch for draws, last term becomes 0.5-exp
			if($game['is_draw']==1)
			{
				//adjust elo scores
				$elos[$pl1] = $elo1 + $k1*(0.5-$exp1);
				$elos[$pl2] = $elo2 + $k2*(0.5-$exp2);
			}
			else
			{
				//adjust elo scores
				$elos[$pl1] = $elo1 + $k1*(1-$exp1);
				$elos[$pl2] = $elo2 + $k2*(1-$exp2);
			}

			//adjust number of games to influence k factor maybe
			$games_played[$pl1]++; 
			$games_played[$pl2]++; 
			
		}	
		//repackage to mimick other output produced in admin.html
		foreach($elos as $key=>$value)
		{
		$arr = null;
		$arr[$key] = $value;
		$output[] = $arr;
		}
		return $output;
	}
}

?>