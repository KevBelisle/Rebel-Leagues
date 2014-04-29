
<header>
	
	<div class="name">
		<h1>{{ player.nickname }}</h1>
		<h2>{{ player.firstname }} {{ player.lastname }}</h2>
	</div>
	
	<i class="fa fa-times close" ng-click="$close($event)"></i>
</header>

<section>

	<ul>
		<li ng-repeat="player in players_stats">
			<div class="player">
				<div>
					<div class="name">
						<h1>{{ player.rival_nickname }}</h1>
						<h2>{{ player.rival_firstname }} {{ player.rival_lastname }}</h2>
					</div>
				</div>
			</div>
			
			<div class="stats">
				{{ player.games_played }} parties jouées
				<div ng-show="player.games_played" class="stats_bar" ng-attr-style="width: {{ 100 * player.games_played / max | number:0 }}%">
					<div class="darker" ng-attr-style="width: {{ 99.99 * player.games_won / player.games_played | number:2 }}%" tooltip="{{ player.games_won }} parties gagnées"></div>
					<div ng-attr-style="width: {{ 99.99 * player.games_tied / player.games_played | number:2 }}%" tooltip="{{ player.games_tied }} parties annulées"></div>
					<div class="lighter" ng-attr-style="width: {{ 99.99 * player.games_lost / player.games_played | number:2 }}%" tooltip="{{ player.games_lost }} parties perdues"></div>
				</div>
			</div>
		</li>
	</ul>

</section>
