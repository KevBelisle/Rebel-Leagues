
<form id="addPlayer" class="clear">

	<div class="left">
		<input type="text" class="fullWidth" ng-model="player.nickname" placeholder="Nickname" required></input>
	</div>
	<div class="right">
		<input type="text" class="fullWidth" ng-model="player.firstname" placeholder="Prénom" required></input>
		<input type="text" class="fullWidth" ng-model="player.lastname" placeholder="Nom" required></input>
		<button ng-click="submit(player)" class="fullWidth">Submit</button>
	</div>
	
</form>