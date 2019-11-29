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

  include 'funcionario_modal_selec_institucion.php';
  
  ?>


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
						<input type='text' id= "idInst" class="form-control form-control-sm " />
					</div>
					<!-- BOTON MODAL.... en la cabecera importo el modal -->
					<div class="col-sm-0 align-self-center" id="buscar">
							<a class="btn grey" href="#" role="button" data-toggle="modal" data-target="#centralModalSm"><i class="fas fa fa-search "></i></a>
					</div>
					
			</div>
			<div class="row ">
				<label class="col-md-3 col-form-label  align-self-center">Nombre:</label>
				<div class="col-md-8 align-self-center">
					<input type="text" id= "nomInst" class="form-control text-uppercase form-control-sm" readonly disabled />
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
								<th><input type="checkbox" class="checkAll mr-2" name="checkAll"/>TODOS</th>
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
								<!-- <th><input type="checkbox" class="checkAll mr-2" name="checkAll"/>TODOS</th> -->
								</tr>
							</thead>
							<tbody id="listaVehículos">
							</tbody>
						</table>
					</div>

				</div>
			</div>

		</div>


		<div class="col-md-8 p-3">
			<div id="map" style="width: 100%; height: 600px;"></div>
		</div>
	</div>
</div>

<script>

var institutoMonitoreo=true;
 

function cargarRutas(id)
{
	var result=`<td></td>
			<td class=" text-center"><div class="spinner-border text-center" role="status">
			<span class="sr-only">Loading...</span>
			</div></td>`;
	document.getElementById('listaRutas').innerHTML =result;
	var url=`http://localhost:8888/rutas?opcion=2&id=`+id;
	fetch(url)
	.then((res) => {return res.json(); })
	.then(produ => {
		result=``;
		if(produ.length > 0)
		{
			for(let prod of produ){						
			result += `<tr> 
						<td class="boton">${prod.id}</td>
						<td class="boton">${prod.nombre}</td> 
						<td><input type="checkbox" class="case" name="case[]" value="${prod.id}"/></td>
						</tr>`;								
								
			}
			
		}
		else{
			result= `<tr> 
						<td></td>
						<td>No se encuentran coincidencias</td> 
						</tr>`;	
		}
		document.getElementById('listaRutas').innerHTML =result;
		
		let elementos=document.getElementsByClassName('boton');

		for(let i=0;i<elementos.length;i++)
		{
			elementos[i].addEventListener('click',obtenerValores);
		} 
		$(".dt-select tr ").click(function(){
						$(this).addClass('filaSeleccionada').siblings().removeClass('filaSeleccionada'); 
		});
		
		$('.checkAll').on('click', function () {
			$(this).closest('table').find('tbody :checkbox')
			.prop('checked', this.checked)
			.closest('tr').toggleClass('selected', this.checked);
		});

		$('tbody :checkbox').on('click', function () {
			$(this).closest('tr').toggleClass('selected', this.checked); 
			$(this).closest('table').find('.checkAll').prop('checked', ($(this).closest('table').find('tbody :checkbox:checked').length == $(this).closest('table').find('tbody :checkbox').length)); //Tira / coloca a seleção no .checkAll
		});

		$("input.case").click(myfunc);
		return produ;				
		})		
		.catch(error => { console.log("error",error); return error; });
}

function mostarRuta(e) {
var elementosTD=e.srcElement.parentElement.getElementsByTagName("td");


cargarVehiculos(elementosTD[0].innerHTML);

		 
function cargarVehiculos(id)
{
	var result=``;
	let url= `http://localhost:8888/rutaVehiculo?id=${id}`;

	fetch(url)
	.then((res) => {return res.json(); })
	.then(produ => {
		
		if(produ.length > 0)
		{
			for(let prod of produ){						
			result += `<tr> 
						<td class="boton">${prod.id}</td>
						<td class="boton">${prod.placa}</td> 
						</tr>`;								
								
			}
			
		}
		else{
			result= `<tr> 
						<td></td>
						<td>No se encuentran coincidencias</td> 
						</tr>`;	
		}
		document.getElementById('listaVehículos').innerHTML =result;


		return produ;				
		})		
		.catch(error => { console.log("error",error); return error; });
}	


}

function obtenerValores(e) {
var elementosTD=e.srcElement.parentElement.getElementsByTagName("td");
let valores=`<td></td>
			<td class=" text-center"><div class="spinner-border text-center" role="status">
			<span class="sr-only">Loading...</span>
			</div></td>
			<td></td>`;
document.getElementById('listaVehículos').innerHTML=valores;

cargarVehiculos(elementosTD[0].innerHTML);

		 
function cargarVehiculos(id)
{
	var result=``;
	let url= `http://localhost:8888/rutaVehiculo?id=${id}`;

	fetch(url)
	.then((res) => {return res.json(); })
	.then(produ => {
		
		if(produ.length > 0)
		{
			for(let prod of produ){						
			result += `<tr> 
						<td class="boton">${prod.id}</td>
						<td class="boton">${prod.placa}</td> 
						</tr>`;								
								
			}
			
		}
		else{
			result= `<tr> 
						<td></td>
						<td>No se encuentran coincidencias</td> 
						</tr>`;	
		}
		document.getElementById('listaVehículos').innerHTML =result;


		return produ;				
		})		
		.catch(error => { console.log("error",error); return error; });
}	


}

var values = new Array();
function myfunc(ele) {

	$.each($("input[name='case[]']:checked").closest("td").siblings("td"),
			function () {
				values.push($(this).text());
			
			});

	setInterval(cargarUbicaciones(), 3000);

}


var posiciones;

function cargarUbicaciones(values)
{
	alert("hola");
	var inst =document.getElementById('idInst').value;
	var result="";
	for(var i = 0 ; i<values.length;i+=2)
	{
		var url=`http://localhost:8888/monitoreo?institucion=${inst}&ruta=`+values[i];
		fetch(url)
		.then((res) => {return res.json(); })
		.then(produ => {
			if(produ.length>0)
			{
				for(let prod of produ)
				{						
					result += ` ${prod.latitud} , ${prod.longuitud},`;					
				}	
			}
			else
			{
				result="";
			}
			

			if(result != "")
			{
				posiciones=result;
				
			}
			return produ;				
			})		
			.catch(error => { console.log("error",error); return error; });
			dibujarPosicion();
	}
	

}

</script>

<!-- <script>

var institutoMonitoreo=true;
 

function cargarRutas(id)
{
	var result=`<td></td>
			<td class=" text-center"><div class="spinner-border text-center" role="status">
			<span class="sr-only">Loading...</span>
			</div></td>`;
	document.getElementById('listaRutas').innerHTML =result;
	var url=`http://localhost:8888/rutas?opcion=2&id=`+id;
	fetch(url)
	.then((res) => {return res.json(); })
	.then(produ => {
		result=``;
		if(produ.length > 0)
		{
			for(let prod of produ){						
			result += `<tr> 
						<td class="boton">${prod.id}</td>
						<td class="boton">${prod.nombre}</td> 
						</tr>`;								
								
			}
			
		}
		else{
			result= `<tr> 
						<td></td>
						<td>No se encuentran coincidencias</td> 
						</tr>`;	
		}
		document.getElementById('listaRutas').innerHTML =result;
		let elementos=document.getElementsByClassName('boton');

		for(let i=0;i<elementos.length;i++)
		{
			elementos[i].addEventListener('click',obtenerValores);
		} 
		$(".dt-select tr ").click(function(){
						$(this).addClass('filaSeleccionada').siblings().removeClass('filaSeleccionada'); 
					});
		return produ;				
		})		
		.catch(error => { console.log("error",error); return error; });
}


function obtenerValores(e) {
var elementosTD=e.srcElement.parentElement.getElementsByTagName("td");
let valores=`<td></td>
			<td class=" text-center"><div class="spinner-border text-center" role="status">
			<span class="sr-only">Loading...</span>
			</div></td>
			<td></td>`;
document.getElementById('listaVehículos').innerHTML=valores;

cargarVehiculos(elementosTD[0].innerHTML);

		 
function cargarVehiculos(id)
{
	var result=``;
	let url= `http://localhost:8888/rutaVehiculo?id=${id}`;

	fetch(url)
	.then((res) => {return res.json(); })
	.then(produ => {
		
		if(produ.length > 0)
		{
			for(let prod of produ){						
			result += `<tr> 
						<td class="boton">${prod.id}</td>
						<td class="boton">${prod.placa}</td> 
						<td><input type="checkbox" name="check" /></td>
						</tr>`;								
								
			}
			
		}
		else{
			result= `<tr> 
						<td></td>
						<td>No se encuentran coincidencias</td> 
						</tr>`;	
		}
		document.getElementById('listaVehículos').innerHTML =result;


		$('.checkAll').on('click', function () {
			$(this).closest('table').find('tbody :checkbox')
			.prop('checked', this.checked)
			.closest('tr').toggleClass('selected', this.checked);
		});

		$('tbody :checkbox').on('click', function () {
			$(this).closest('tr').toggleClass('selected', this.checked); 
		
			$(this).closest('table').find('.checkAll').prop('checked', ($(this).closest('table').find('tbody :checkbox:checked').length == $(this).closest('table').find('tbody :checkbox').length)); //Tira / coloca a seleção no .checkAll
		});
		return produ;				
		})		
		.catch(error => { console.log("error",error); return error; });
}	


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


</script> -->



<script>

			function dibujarPosicion()
			{
				var lista=posiciones.split(",");
				for(var i =0;i<lista.length;i+=2)
				{
					
					L.marker([lista[i],lista[i+1]]).addTo(map)
					.bindPopup(`Posicion ${i}`)
					.openPopup();

					console.log(`${lista[i]},${lista[i+1]}`);
				}
			}

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
			
	

			

			
		</script>

<?php include 'footer.php'; ?>
