
<form id="editGame" class="clear">

	<select class="fullWidth" ng-model="selectedGameId" ng-options="game.game_id as (game.date + ' : ' + game.player1_nickname + ' (' + game.player1_faction_name + ') vs ' + game.player2_nickname + ' (' + game.player2_faction_name + ')') for game in games" ng-change="change(selectedGameId)">
		<option value="">Choisir partie existante</option>
	</select>
	
	<div ng-show="selectedGame">
		<h2>Modifier les données :</h2>

		<div class="left">

			<select class="fullWidth" ng-model="selectedGame.player1_id" ng-options="player.player_id as (player.nickname + ' (' + player.firstname + ' ' + player.lastname + ')') for player in players">
				<option value="">Choisir premier joueur (vainqueur)</option>
			</select>
			
			<select class="fullWidth" ng-model="selectedGame.player1_faction_id" ng-options="f.faction_id as f.name group by f.parent_faction_name for f in factions">
				<option value="">Choisir faction du premier joueur</option>
			</select>
			
			<select class="fullWidth" ng-model="selectedGame.player2_id" ng-options="player.player_id as (player.nickname + ' (' + player.firstname + ' ' + player.lastname + ')') for player in players">
				<option value="">Choisir deuxième joueur</option>
			</select>
			
			<select class="fullWidth" ng-model="selectedGame.player2_faction_id" ng-options="f.faction_id as f.name group by f.parent_faction_name for f in factions">
				<option value="">Choisir faction du deuxième joueur</option>
			</select>
			
			<label class="fullWidth"> <input type="checkbox" ng-model="selectedGame.is_draw" /> Finie en nulle</label>
			<label class="fullWidth"> <input type="checkbox" ng-model="selectedGame.is_ranked" /> Comptabilisée au classement</label>
			<label class="fullWidth"> <input type="checkbox" ng-model="selectedGame.is_time_runout" /> Terminée par manque de temps</label>
			<label class="fullWidth"> <input type="checkbox" ng-model="selectedGame.is_online" /> Jouée en ligne (VASSAL)</label>
		
		</div>
		
		<div class="right">
			<div ng-model="selectedGame.datetime" class="datepicker">
				<datepicker show-weeks="false"></datepicker>
			</div>
			
			<div ng-model="selectedGame.datetime" class="timepicker">
				<timepicker hour-step="1" minute-step="15" show-meridian="false"></timepicker>
			</div>
			
			<textarea class="fullWidth" ng-model="selectedGame.notes" placeholder="Notes"></textarea>
			
			<button ng-click="submit(selectedGame)" class="fullWidth">Modifier la partie</button>
			<button class="danger fullWidth" ng-click="delete(selectedGame)" ng-if="user.tier <= 1">Supprimer la partie</button>
		</div>
	</div>
	
	
</form>