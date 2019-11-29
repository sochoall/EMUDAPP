<?php include 'header.php'; ?>
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
						cargarComboSentido();
                    };
                   
                       
                </script>
        ";
    } else {
        header('Location: ./');
    }   

?>


<div class="container-fluid grey pr-0 pl-0">
		<?php 
		echo $menu 
		?>
</div>


<div class="container-fluid m-1">
	<div class="row ">
		<div class="col-md-5 m-0  card">
			<div class="container-fluid m-0 p-0">
				<div class="row">
					<div class="col-md-12">
						<form class="needs-validation text-left">
							<h3 class="card-header cyan white-text font-weight-bold text-center p-1" >Ruta</h3>
							<div class="form-group row mt-1">
								<label class="col-md-3 col-form-label">Nombre:<span style="color:red" >*</span></label>
								<div class="col-md-8">
									<input type="text" id="nombreRuta" name="nombreRuta" class="form-control text-uppercase">
								</div>
							</div>

							<div class="form-group row">
								<label class="col-md-3 col-form-label">Descripción:<span style="color:red" >*</span></label>
								<div class="col-md-8">
									<input type="text" id="dRuta" name="dRuta" class="form-control text-uppercase">
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
						<h3 class="card-header cyan white-text font-weight-bold text-center  p-1" >Recorrido</h3>
						<div class="form-group row mt-1">
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
									<SELECT id="estado2"  class="browser-default custom-select"> 
										<OPTION VALUE="1" selected >ACTIVO</OPTION>
										<OPTION VALUE="0">INACTIVO</OPTION>
									</SELECT> 
								</div>
							</div>

							
						</form>

						<div class='table-responsive-md my-custom-scrollbar'>
								<table id='dt-select' class='table-sm table table-hover text-center  cellspacing='0' width='100%'>
									<thead class='cyan white-text'>
										<tr>
										<th scope='col'>NRO</th>
										<th scope='col'>NOMBRE</th>
										<th scope='col'>POSICIÓN</th>
										<!-- <th><input type="checkbox" class="checkAll mr-2" name="checkAll"/>TODOS</th> -->
										</tr>
									</thead>
									<tbody id="listaParadas">
									</tbody>
								</table>
						</div>

					</div>
					
				</div>
				<div class="row justify-content-end mt-3 mr-5">
		<input value="Guardar" class="btn cyan text-white" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>
	</div>
			</div>
			
		</div>
		<div class="col-md-7 p-3">
			<div id="map" style="width: 100%; height: 500px;"></div>
			<div class="grey-text text-center">*Para guardar la información debe primero seleccionar las paradas correspondientes a las rutas</div>
		</div>
	</div>

	
		
</div>

<div class="modal fade" id="nombreParada" tabindex="-1" role="dialog" aria-labelledby="tittle"
  aria-hidden="true">

  <!-- Change class .modal-sm to change the size of the modal -->
  <div class="modal-dialog modal-md" role="document">

    <div class="modal-content">
        <div class="modal-header text-center m-0 p-0 cyan">
            <h4 class="modal-title w-100 text-white text-center" id="title">Parada</h4>
            </button>
        </div>
        <div class="modal-body" id="cuerpoModal">
			<div class="row">
				<label class="col-sm-4 col-form-label">Nombre:</label>
				<div class="col-sm-8">
					<input type="text" id= "nomParada" class="form-control text-uppercase form-control-sm"/>
				</div>
			</div>
            
            <div class="row justify-content-center mt-3">
                <div class=""><input type="button" value="Guardar" class="btn cyan" onclick="agregarNombreVector();"  /></div>
                <div class=""><input type="button" value="Cancelar" class="btn cyan" data-dismiss="modal"/><br/></div>
            </div> 
      </div>
    </div>
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
	var vecnombres=[];

	function agregarNombreVector()
	{
		vecnombres.push(document.getElementById('nomParada').value);
		$("#nombreParada").modal('hide');
		actualizarListaParadas();
	}

	function actualizarListaParadas()
	{	
		document.getElementById("listaParadas").innerHTML="";
		var result="";
		for(var i=0; i<vec.length;i++)
		{
			result+=`<tr>
						<td>${i+1}</td>
						<td>${vecnombres[i]}</td>
						<td>${vec[i]}</td>
					</tr>`;
		}
		document.getElementById("listaParadas").innerHTML=result;
	}

	function ingresarRutaRecorrido(nombreRuta,descRuta,cupoRuta,colorRuta,idfun,inicioRuta,finRuta,listaSentido,estado){ 
		var ruta ={ 'id': idRuta, 'nombre': nombreRuta, 'descripcion': descRuta,'estado': estado,'cupoMaximo': cupoRuta,'color': colorRuta,'insId': idfun };
		var recorrido ={'id': idRecorrido,'horaInicio': inicioRuta,'horaFin': finRuta,'estado': estado,'senId': listaSentido,'rutId': idRuta};

	
		IngresarDatos(ruta,"http://localhost:8888/rutas");
		console.log(ruta);
		IngresarDatos(recorrido,"http://localhost:8888/recorrido");

		for (i=0; i<vec.length ; i++)
		{
			var div1 = vec[i].split("(");
			var div2=div1[1].split(")");
			var div3=div2[0].split(",");
			var par="Parada " + i;

			var parada ={'id':0,'nombre': vecnombres[i],'orden': i,'latitud': div3[0],'longuitud': div3[1],'tiempoPromedio': "00:00:00",'estado':1,'recId':idRecorrido };
			setTimeout(IngresarDatos(parada,"http://localhost:8888/parada"),(i+1)*1000);
		}

		setTimeout("window.location.reload()",1000);  
	}


	
	async function IngresarDatos(parametros,url) {	 
		try{	
			let response = await fetch(url, {
					method: 'POST',
					body:JSON.stringify(parametros),
					headers:{'Content-Type': 'application/json'}
				});           	
			let data = await response.json();	
			toastr.success('Guardado correctamente');        
		}catch(e){
			toastr.error('Error al Guardar la información');			
		}
	}

	function IngMod(v) {	
			var nombreRuta = document.getElementById('nombreRuta');
			var descRuta = document.getElementById('dRuta');
			var cupoRuta = document.getElementById('cupoRuta');
			var colorRuta = document.getElementById('colorRuta');
			var idfun = document.getElementById('idfun');
			var inicioRuta = document.getElementById('inicioRuta');
			var finRuta = document.getElementById('finRuta');
			var listaSentido = document.getElementById('listaSentido').value;
			var estado = document.getElementById('estado2').value;
			
		event.preventDefault();			
		if(valSololetras(nombreRuta.value)==false){
			toastr.error('Ingrese solo letras');
			document.getElementById("nombreRuta").style.borderColor="red";
		}else{
			document.getElementById("nombreRuta").style.borderColor='#ced4da';
			if(descRuta.value == ""){
				toastr.error('Debe llenar el campo');
				document.getElementById("dRuta").style.borderColor="red";
			}else{ 
				document.getElementById("dRuta").style.borderColor='#ced4da';
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
							ingresarRutaRecorrido(nombreRuta.value,document.getElementById('dRuta').value,cupoRuta.value,colorRuta.value,idfun.value,inicioRuta.value,finRuta.value,listaSentido,estado);
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
					delBtn = createButton('Eliminar ultima parada', container)

			

		

				L.popup()
					.setContent(container)
					.setLatLng(e.latlng)
					.openOn(map);


				L.DomEvent.on(startBtn, 'click', function() 
				{
					document.getElementById('nomParada').value="";
					control.spliceWaypoints(0, 1, e.latlng);
					map.closePopup();
					$('#nombreParada').modal('show');
					

					vec=[];
					vecnombres=[];
					vec.push(e.latlng.toString());
				});
				
				L.DomEvent.on(interBtn, 'click', function() 
				{
					document.getElementById('nomParada').value="";
					control.spliceWaypoints(cont, 0, e.latlng);
					map.closePopup();
					$('#nombreParada').modal('show');
					cont++;
					vec.push(e.latlng.toString());
				});
				
				L.DomEvent.on(destBtn, 'click', function() 
				{
					document.getElementById('nomParada').value="";
					control.spliceWaypoints(control.getWaypoints().length - 1, 1, e.latlng);
					map.closePopup();
					$('#nombreParada').modal('show');
					vec.push(e.latlng.toString());
				});
				
				L.DomEvent.on(delBtn, 'click', function() 
				{
					control.spliceWaypoints(control.getWaypoints().length - 1, 1);
					map.closePopup();
					vec.pop();
					vecnombres.pop();
					actualizarListaParadas();
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
