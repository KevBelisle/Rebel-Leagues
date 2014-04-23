<!DOCTYPE HTML>
<!--[if lt IE 9]><html class="ie" ng-app="rebelLeaguesApp"><![endif]-->
<!--[if gte IE 9]><!--><html ng-app="rebelLeaguesApp"><!--<![endif]-->

<head>
	<meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	
	<title>RebelLeagues</title>
	
	<link rel="stylesheet" media="all" href="styles.php" />
	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
	<link rel="icon" href="favicon.ico" type="image/x-icon">
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type='text/javascript'>$.noConflict(); delete $;</script>
	
	<link href='http://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700' rel='stylesheet' type='text/css'>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-route.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-animate.js"></script>
	<script src="scripts/lib/ui-bootstrap-tpls-0.10.0.js"></script>
	
	<script src="//cdnjs.cloudflare.com/ajax/libs/handlebars.js/1.3.0/handlebars.min.js"></script>
	
    <script src="api/plugins/XWSquads/xws.js.php" type="text/javascript"></script>
	
	<!--[if lt IE 9]>
		<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
</head>

<body>

<div id="topBar">
	<div>
		<a href="//rebelleagues.com">Rebel<strong>Leagues</strong></a>
	</div>
</div>

<div id="wrapper" class="clear">

	<div id="right" class="clear">
		<header ng-controller="leagueInfoCtrl">
			<img id="logo" src="api/leagues/logo" />
			
			<h1>{{ title }}</h1>
			<h2>{{ subtitle }}</h2>
		</header>
		
		<aside>
			<div id="stats" ng-controller="leagueStatsCtrl">
				<ul>
					<li class="clear">
						<span class="left">Parties jouées</span>
						<span class="right">{{ games_played }}</span>
					</li>
					<li class="clear">
						<span class="left">Joueurs actifs</span>
						<span class="right">{{ active_players }}</span>
					</li>
					<li class="clear">
						<span class="left">Joueurs inscrits</span>
						<span class="right">{{ total_players }}</span>
					</li>
				</ul>
			</div>
		</aside>
	</div>
	
	<div id="left" class="clear">
		<section>
			<nav class="clear">
				<a active-link="active" href="#/gamesHistory">Historique des parties</a>
				<a active-link="active" href="#/playersRanking">Classement des joueurs</a>
			</nav>
			
			<div id="main" ng-view ng-animate class="anim-appear">
			</div>
		</section>

		<footer class="clear">
			<div class="left">
				Cette ligue utilise le système <strong>Rebel<strong>Leagues</strong></strong>,<br />
				développé par <strong>Kevin Bélisle</strong> et <strong>Michaël Juneau</strong>.
			</div>
			<div class="right">
				<a href="admin">Accéder à l'administration</a><br />
				RebelLeagues v0.1
			</div>
		</footer>
	</div>

</div>

<script src="scripts/controllers.js"></script>
<script src="scripts/main.js"></script>

</body>
</html>