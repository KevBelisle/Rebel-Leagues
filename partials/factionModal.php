
<header>
	<div class="logo">
		<img src="api/factions/{{ faction.faction_id }}/logo">
	</div>
	<div class="name">
		<h2>{{ faction.parent_faction_name }}</h2>
		<h1>{{ faction.faction_name }}</h1>
	</div>
	
	<i class="fa fa-times close" ng-click="$close($event)"></i>
</header>

<section>

	<ul>
		<li ng-repeat="faction in faction_stats">
			<div class="faction">
				<div>
					<div class="logo">
						<img src="api/factions/{{ faction.rival_faction_id }}/logo">
					</div>
					<div class="name">
						<h2>{{ faction.rival_parent_faction_name }}</h2>
						<h1>{{ faction.rival_faction_name }}</h1>
					</div>
				</div>
			</div>
			
			<div class="stats">
				{{ faction.games_played }} parties jouées
				<div ng-show="faction.games_played" class="stats_bar" ng-attr-style="width: {{ 100 * faction.games_played / max | number:0 }}%">
					<div class="darker" ng-attr-style="width: {{ 99.99 * faction.games_won / faction.games_played | number:2 }}%" tooltip="{{ faction.games_won }} parties gagnées"></div>
					<div ng-attr-style="width: {{ 99.99 * faction.games_tied / faction.games_played | number:2 }}%" tooltip="{{ faction.games_tied }} parties annulées"></div>
					<div class="lighter" ng-attr-style="width: {{ 99.99 * faction.games_lost / faction.games_played | number:2 }}%" tooltip="{{ faction.games_lost }} parties perdues"></div>
				</div>
			</div>
		</li>
	</ul>

</section>
