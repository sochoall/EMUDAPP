<?php include 'header.php'; ?>

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
						cargarComboSentido();
                    };
                   
                       
                </script>
        ";
    } else {
        header('Location: ./');
    }   

?>
<?php
		include 'modalFuncionario.php';
?>	

<div class="container-fluid grey pr-0 pl-0">
		<?php 
		echo $menu 
		?>
</div>


<div class="container-fluid my-5">
	<div class="row">
		<div class="h3 text-left font-weight-bold ml-5 mb-5">Rutas y Recorridos</div>
	</div>
	<div class="row text-uppercase">
		<div class="col-md-5 p-4  card">
			<div class="container-fluid m-0 p-0">
				<div class="row">
					<div class="col-md-12">
						<form class="needs-validation text-left">	
							<div class="form-group row">
								<label class="col-md-3 col-form-label">Nombre:<span style="color:red" >*</span></label>
								<div class="col-md-8">
									<input type="text" id="nombreRuta" name="nombreRuta" class="form-control text-uppercase">
								</div>
							</div>

							<div class="form-group row">
								<label class="col-md-3 col-form-label">Descripción:<span style="color:red" >*</span></label>
								<div class="col-md-8">
									<input type="text" id="descRuta" name="descRuta" class="form-control text-uppercase">
								</div>
							</div>


							<div class="form-group row">
								<label class="col-md-3 col-form-label">Cupo M&aacute;ximo:<span style="color:red" >*</span></label>
								<div class="col-md-3">
									<input type='number'id= "cupoRuta" name="cupoRuta"  class="form-control" required/>
								</div>
								<label class="col-md-2 col-form-label text-right">Color:<span style="color:red" >*</span></label>
								<div class="col-md-1">
									<input type="color" id="colorRuta" name="colorRuta" value="#ff0000">
								</div>
							</div>

							<div class=" row">
									<label class="col-md-3 col-form-label align-self-center">Instituci&oacute;n:<span style="color:red" >*</span></label>
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
							
						</form>

						<form class="needs-validation text-left mt-1">	
						<div class="form-group row">
								<label class="col-md-3 col-form-label">Hora inicio:<span style="color:red" >*</span></label>
								<div class="col-md-3">
									<input type='time' id= "inicioRuta" name="inicioRuta" class="form-control" required/>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-md-3 col-form-label">Hora fin: <span style="color:red" >*</span></label>
								<div class="col-md-3">
									<input type='time' id= "finRuta" name="finRuta"  class="form-control" required/>
								</div>
							</div>
							
							<div class="form-group row">
								<label class="col-md-3 col-form-label">Sentido<span style="color:red" >*</span></label>
								<div class="col-md-4">
									<SELECT id="listaSentido"  class="browser-default custom-select"> 
									</SELECT> 
								</div>
							</div>


							<div class="form-group row">
								<label class="col-md-3 col-form-label">Estado:<span style="color:red" >*</span></label>
								<div class="col-md-4">
									<SELECT id="estado"  class="browser-default custom-select"> 
										<OPTION VALUE="0" selected >Activo</OPTION>
										<OPTION VALUE="1">Inactivo</OPTION>
									</SELECT> 
								</div>
							</div>

							
						</form>
					</div>
				</div>
			</div>

		</div>
		<div class="col-md-7 p-3">
			<div id="map" style="width: 100%; height: 500px;"></div>
		</div>
	</div>

	<div class="row justify-content-end mt-3 mr-5">
		<input value="Guardar" class="btn cyan text-white" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>
	</div>
		
</div>

	
<script type="text/javascript">

	var timeControl1 = document.getElementById('inicioRuta');
	timeControl1.value = '06:00';
	var timeControl2 = document.getElementById('finRuta');
	timeControl2.value = '06:00';

	async function cargarComboSentido(){
		const listaSentido=document.querySelector('#listaSentido');
		listaSentido.innerHTML=``;
		try {
			var url=`http://localhost:8888/sentido?campo=sen_nombre&bus=&est=1`;			
			let response = await fetch(url)
			let data = await response.json();					
			var result = ``;						
			for(let pro of data){
				result +='<OPTION VALUE=' + pro.id + '>' + pro.nombre + '</OPTION>';		
			}			
			listaSentido.innerHTML = result;	
		}catch(e)
		{
			listaSentido.innerHTML =`<div>No se encuentran resultados</div>`; 	
		}
	}
	

	function BusInstituion(insid){		
		fetch(`http://localhost:8888/institucion/${insid}`)
			.then(response => response.json())
			.then(data => {		  	
				var dato=`${data.nombre}`;
				document.getElementById('chofer').value = dato;										
		})  
		.catch(error => { 
			toastr.error('No  existe la institucion'); console.log(error);
			document.getElementById('chofer').value = "";	
		})	
	}


	$('#idfun').keypress(function (e) {	
		if (e.which == 13) {
			event.preventDefault();	
			var valor=e.target.value;
			BusInstituion(valor);
		}
	});	

	var idRuta = -1;
	var idRecorrido = -1;
	var vec=[];


	function ingresarRutaRecorrido(nombreRuta,descRuta,cupoRuta,colorRuta,idfun,inicioRuta,finRuta,listaSentido,estado){
		var ruta ={ 'id': idRuta, 'nombre': nombreRuta, 'descripcion': descRuta,'estado': estado,'cupoMaximo': cupoRuta,'color': colorRuta,'insId': idfun };
		var recorrido ={'id': idRecorrido,'horaInicio': inicioRuta,'horaFin': finRuta,'estado': estado,'senId': listaSentido,'rutId': idRuta};

		Ingresar(ruta,"http://localhost:8888/rutas");
		Ingresar(recorrido,"http://localhost:8888/recorrido");

		for (i=0; i<vec.length ; i++)
		{
			var div1 = vec[i].split("(");
			var div2=div1[1].split(")");
			var div3=div2[0].split(";");
			var par="Parada " + i;

			var parada ={'nombre': par,'orden': i,'latitud': div3[0],'longuitud': div3[1],'tiempoPromedio': 0,'estado':1,'recId':idRecorrido };

			Ingresar(parada,"http://localhost:8888/parada"),1000
		}
	}
	function IngMod(v) {	
			var nombreRuta = document.getElementById('nombreRuta');
			var descRuta = document.getElementById('descRuta');
			var cupoRuta = document.getElementById('cupoRuta');
			var colorRuta = document.getElementById('colorRuta');
			var idfun = document.getElementById('idfun');
			var inicioRuta = document.getElementById('inicioRuta');
			var finRuta = document.getElementById('finRuta');
			var listaSentido = document.getElementById('listaSentido').value;
			var estado = document.getElementById('estado').value;
			
		
		event.preventDefault();			



		if(valSololetras(nombreRuta.value)==false){
			toastr.error('Ingrese solo letras');
			document.getElementById("nombreRuta").style.borderColor="red";
		}else{
			document.getElementById("nombreRuta").style.borderColor='#ced4da';
			if(descRuta.value.is_null){
				toastr.error('Debe llenar el campo');
				document.getElementById("descRuta").style.borderColor="red";
			}else{ 
				document.getElementById("descRuta").style.borderColor='#ced4da';
				if(cupoRuta.value < 1){
				toastr.error('Ingrese datos válidos');
				document.getElementById("cupoRuta").style.borderColor="red";
			}else{ 
				document.getElementById("cupoRuta").style.borderColor='#ced4da';
				if(valNumeros(idfun.value)==false){
					toastr.error('Institución incorrecta');
					document.getElementById("idfun").style.borderColor="red";
					}else{ 
						document.getElementById("idfun").style.borderColor='#ced4da';
						
						if(vec.length == 0 )
						{
							toastr.error('No ha ingresado paradas para la ruta ingresada');
						}
						else{
							(async() =>{
							
							let response = await fetch(`http://localhost:8888/contadores?opcion=1`);		
							let data = await response.json();
							idRuta=data.numero+1;

							let response2 = await fetch(`http://localhost:8888/contadores?opcion=2`);		
							let data2 = await response2.json();
							idRecorrido =data2.numero + 1; 
							ingresarRutaRecorrido(nombreRuta.value,descRuta.value,cupoRuta.value,colorRuta.value,idfun.value,inicioRuta.value,finRuta.value,listaSentido,estado);
						})();
						}
						
					}	
				}
			}
		}
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
<?php include 'footer.php'; ?>
