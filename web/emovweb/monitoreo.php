<?php include 'header.php';?>
<script src="https://unpkg.com/leaflet@1.0.2/dist/leaflet.js"></script>
<script src="leaflet-routing-machine-3.2.12/dist/leaflet-routing-machine.js"></script>
<script src="leaflet-routing-machine-3.2.12/src/Control.Geocoder.js"></script>

 <?php
    session_start();
    if (isset($_SESSION['id']) && isset($_SESSION['rol'])) {
        $id = $_SESSION['id'];
        $rol = $_SESSION['rol'];
        $menu=$_SESSION['menu'];
        echo " <script>
                    
                    window.onload = function() 
                    {
                      
                        document.getElementById('rol').innerHTML ='ROL: $rol';
						document.getElementById('btncerrar').style.display = 'block';
                    };
                   
                </script>
        ";
    } else {
        header('Location: ./');
    }   

?>
<script>var institutoMonitoreo=true;</script>
<?php  include 'funcionario_modal_selec_institucion.php';?>


<div class="container-fluid grey pr-0 pl-0">
		<?php 
		echo $menu 
		?>
</div>


<div class="container-fluid my-5">
	<div class="row ml-2">
		<div class="col-md-4 m-0  card">
      	
			<div class="h3 text-left font-weight-bold">Filtros</div>

			<div class=" row">
					<label class="col-md-3  col-form-label align-self-center">Instituci&oacute;n:<span style="color:red" >*</span></label>
					<div class="col-md-3 align-self-center">
						<input type='text' id= "idfun" class="form-control form-control-sm " />
					</div>
					<!-- BOTON MODAL.... en la cabecera importo el modal -->
					<div class="col-sm-0 align-self-center" id="buscar">
							<a class="btn grey" href="#" role="button" data-toggle="modal" data-target="#centralModalSm"><i class="fas fa fa-search "></i></a>
					</div>
					
			</div>
			<div class="row ">
				<label class="col-md-3 col-form-label  align-self-center">Nombre:</label>
				<div class="col-md-8 align-self-center">
					<input type="text" id= "chofer" class="form-control text-uppercase form-control-sm" readonly disabled />
				</div>
			</div>
			
			<div class="row mt-3">
				<div class="h4 text-left font-weight-bold col-md-6">Rutas</div>
			</div>
			<div class="row">
				<div class="col-md-12">
				<div class='table-responsive-sm my-custom-scrollbar'>
                        <table class='table-sm table table-hover text-center' cellspacing='0' width='100%'>
                            <thead class='cyan white-text'>
                            <tr>
								<th scope='col'>ID</th>
								<th scope='col'>RUTA</th>
							</tr>
                        </thead>
                        <tbody  id="listaRutas" class='dt-select' >
                            <!-- AQUI SE CARGA LA TABLA CON LOS REGISTROS -->
                        </tbody>
                        </table>
                    </div>

				</div>
			</div>

			<div class="row mt-3">
				<div class="h4 text-left font-weight-bold col-md-6">Vehículos</div>
			</div>
			<div class="row">
				<div class="col-md-12">

					<div class='table-responsive-md my-custom-scrollbar'>
						<table id='dt-select' class='table-sm table table-hover text-center  cellspacing='0' width='100%'>
							<thead class='cyan white-text'>
								<tr>
								<th scope='col'>ID</th>
								<th scope='col'>RUTA</th>
								<th>
									<!-- Default unchecked -->
									<div class="custom-control custom-checkbox">
									<input type="checkbox" class="custom-control-input" id="tableDefaultCheck1">
									<label class="custom-control-label" for="tableDefaultCheck1">TODOS</label>
									</div>
								</th>
								</tr>
							</thead>
							<tbody id="listaVehículos">
							</tbody>
						</table>
					</div>

				</div>
			</div>

			<input type="button" value="Obtener" class="btn cyan " onclick="cargarUbicaciones();"  />
		</div>


		<div class="col-md-8 p-3">
			<div id="map" style="width: 100%; height: 600px;"></div>
		</div>
	</div>
</div>


<script>

    var result="";

	function cargarRutas(id)
	{
		var url=`http://localhost:8888/rutas?opcion=2&id=`+id;
		fetch(url)
		.then((res) => {return res.json(); })
		.then(produ => {
			
			for(let prod of produ){						
				result += `<tr> 
							<td class="boton">${prod.id}</td>
							<td class="boton">${prod.nombre}</td> 
							</tr>`;								
									
			}
			$(".dt-select tr").click(function(){
				$(this).addClass('filaSeleccionada').siblings().removeClass('filaSeleccionada');
			});

			document.getElementById('listaRutas').innerHTML =result;
			return produ;				
			})		
			.catch(error => { console.log("error",error); return error; });
	}

    function cargarUbicaciones(id)
	{
		var url=`http://localhost:8888/monitoreo?id=`+id;
		fetch(url)
		.then((res) => {return res.json(); })
		.then(produ => {
			
			for(let prod of produ){						
				result += ` ${prod.latitud} , ${prod.longuitud};`;								
									
			}	
				alert(result);
				return produ;				
			})		
			.catch(error => { console.log("error",error); return error; });

	}


</script>



<script>


			var osmUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
				osmAttrib = '&copy; <a href="http://openstreetmap.org/copyright">OpenStreetMap</a> contributors',
				osm = L.tileLayer(osmUrl, {maxZoom: 16, attribution: osmAttrib});

			var cont=1;
			var map = L.map('map').setView([-2.901866, -79.006055], 14).addLayer(osm);
			map.doubleClickZoom.disable();
			var control = L.Routing.control({

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
					vec=[];
					vec.push(e.latlng.toString());
				});
				
				L.DomEvent.on(interBtn, 'click', function() 
				{
					control.spliceWaypoints(cont, 0, e.latlng);
					map.closePopup();
					cont++;
					vec.push(e.latlng.toString());
				});
				
				L.DomEvent.on(destBtn, 'click', function() 
				{
					control.spliceWaypoints(control.getWaypoints().length - 1, 1, e.latlng);
					map.closePopup();
					vec.push(e.latlng.toString());
					console.log(vec);
				});
				
				L.DomEvent.on(delBtn, 'click', function() 
				{
					control.spliceWaypoints(control.getWaypoints().length - 1, 1);
					map.closePopup();
					vec.pop();
				});
			});
			
			
			// function onLocationFound(e) 
			// {
			// 	var radius = e.accuracy / 2;

			// 	L.marker(e.latlng).addTo(map)
			// 		.bindPopup("You are within " + radius + " meters from this point").openPopup();

			// 	L.circle(e.latlng, radius).addTo(map);
			// }

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

<?php include 'footer.php'; ?>
