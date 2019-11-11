<!DOCTYPE html>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<head>
		<link rel="stylesheet" href="https://unpkg.com/leaflet@1.0.2/dist/leaflet.css" />
		<script src="https://unpkg.com/leaflet@1.0.2/dist/leaflet.js"></script>
		<script src="leaflet-routing-machine-3.2.12/dist/leaflet-routing-machine.js"></script>
		<script src="leaflet-routing-machine-3.2.12/src/Control.Geocoder.js"></script>
		<link rel="stylesheet" href="leaflet-routing-machine-3.2.12/dist/leaflet-routing-machine.css" /> 
		
		<style>
			#map { 
			width: 50px;
			height: 700px; }
		</style>
		<title>Mapa simple de OpenStreetMap con Leaflet</title>
		<!--link rel="stylesheet" href="https://unpkg.com/leaflet@1.0.3/dist/leaflet.css"-->
	</head>
	<body>
	<h3>Mapa Calculo de rutas</h3>  
	<!--script src="https://unpkg.com/leaflet@1.0.3/dist/leaflet.js"></script-->	  
	<div id="map"></div>
		<script>

			var osmUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
				osmAttrib = '&copy; <a href="http://openstreetmap.org/copyright">OpenStreetMap</a> contributors',
				osm = L.tileLayer(osmUrl, {maxZoom: 16, attribution: osmAttrib});

			var cont=1;
			var map = L.map('map').setView([-2.901866, -79.006055], 14).addLayer(osm);
			map.doubleClickZoom.disable();
			var control = L.Routing.control({
				//Agrega marcadores estaticos definidos por el programador y traza la ruta
				/*waypoints: [
					L.latLng(-2.901866, -79.006055),//Coordenadas Cuenca
					L.latLng(-2.740386, -78.849135)//Coordenadas Azogues
				],*/
				routeWhileDragging: true,
				reverseWaypoints: true,
				showAlternatives: true,
				altLineOptions: {
					styles: [
						{color: 'black', opacity: 0.15, weight: 9},
						{color: 'white', opacity: 0.8, weight: 6},
						{color: 'blue', opacity: 0.5, weight: 2}
					]
				}
				//geocoder: L.Control.Geocoder.nominatim()
			}).addTo(map);
			
			//Marcador en la Ciudad de Cuenca				
			/*L.marker([-2.901866, -79.006055],{title: '1'})
				.addTo(map)
				.bindPopup('Ciudad de Cuenca.')
				.openPopup();*/
			
			function createButton(label, container) 
			{
				var btn = L.DomUtil.create('button', '', container);
				btn.setAttribute('type', 'button');
				btn.innerHTML = label;
				return btn;
			}

			map.on('dblclick', function(e) 
			{
				var container = L.DomUtil.create('div'),
					startBtn = createButton('Comenzar ruta aqui', container),
					interBtn = createButton('Realizar parada aqui', container),
					destBtn = createButton('Finalizar ruta aqui', container),
					delBtn = createButton('Eliminar ultima parada', container);

				L.popup()
					.setContent(container)
					.setLatLng(e.latlng)
					.openOn(map);
					
				L.DomEvent.on(startBtn, 'click', function() 
				{
					control.spliceWaypoints(0, 1, e.latlng);
					map.closePopup();
				});
				
				L.DomEvent.on(interBtn, 'click', function() 
				{
					control.spliceWaypoints(cont, 0, e.latlng);
					map.closePopup();
					cont++;
				});
				
				L.DomEvent.on(destBtn, 'click', function() 
				{
					control.spliceWaypoints(control.getWaypoints().length - 1, 1, e.latlng);
					map.closePopup();
				});
				
				L.DomEvent.on(delBtn, 'click', function() 
				{
					control.spliceWaypoints(control.getWaypoints().length - 1, 1);
					map.closePopup();
				});
			});
			
			/*var ReversablePlan = L.Routing.Plan.extend({
				createGeocoders: function() 
				{
					var container = L.Routing.Plan.prototype.createGeocoders.call(this),
						reverseButton = createButton('↑↓', container);
					return container;
				}
			}
			
			var plan = new ReversablePlan([
				L.latLng(57.74, 11.94),
				L.latLng(57.6792, 11.949)
			], {
				geocoder: L.Control.Geocoder.nominatim(),
				routeWhileDragging: true
			}),
			control = L.Routing.control({
				routeWhileDragging: true,
				plan: plan
			}).addTo(map);*/
			
			function onLocationFound(e) 
			{
				var radius = e.accuracy / 2;

				L.marker(e.latlng).addTo(map)
					.bindPopup("You are within " + radius + " meters from this point").openPopup();

				L.circle(e.latlng, radius).addTo(map);
			}

			function onLocationError(e)
			{
				alert(e.message);
			}

			map.on('locationfound', onLocationFound);
			map.on('locationerror', onLocationError);

			map.locate({setView: true, maxZoom: 16});
			
			L.Routing.errorControl(control).addTo(map);

			L.Routing.Formatter = L.Class.extend({
				options: {
					language: 'sp'
				}
			});
		</script>
	</body>
</html>