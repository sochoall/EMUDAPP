<?php 
    include 'header.php';
?>

<script src="https://unpkg.com/leaflet@1.0.2/dist/leaflet.js"></script>
<script src="leaflet-routing-machine-3.2.12/dist/leaflet-routing-machine.js"></script>
<script src="leaflet-routing-machine-3.2.12/src/Control.Geocoder.js"></script>


<?php
    include 'vehiculo_modal_select_funcionario.php';
    include 'funcionario_modal_selec_institucion.php';
?>

<div class="container mt-2">
    <div class="row justify-content-center ">
        <div class="col-md-10 ">
            <form action="">
                <h3 class="card-header cyan white-text font-weight-bold text-center p-0 m-0" >Solicitud de servicio</h3>
                <div class="row">
                    <label class="col-md-3 col-form-label  align-self-center">Fecha Registro:</label>
                    <div class="col-md-3 align-self-center">
                        <input type="date" id= "fregistro" class="form-control text-uppercase form-control-sm" readonly disabled/>
                    </div>

                    <label class="col-md-3 col-form-label  align-self-center">Fecha Finalizaci&oacute;n:</label>
                    <div class="col-md-3 align-self-center">
                        <input type="date" id= "ffin" class="form-control text-uppercase form-control-sm"/>
                    </div>
                </div>

                <div class="row">
                    <label class="col-md-3 col-form-label  align-self-center">Observaci&oacute;n:</label>
                    <textarea class="form-control col-md-8 ml-3" id="observacion" rows="2"></textarea>
                </div>

                <div class="row mt-2 mb-1">
                    <label class="col-md-3 col-form-label  align-self-center">Tipo de Servicio:</label>
                    <div class="col-md-3 align-self-center" id="tservicio">
                    </div>
                    <label class="col-md-3 col-form-label  align-self-center">Periodo Lectivo:</label>
                    <div class="col-md-3 align-self-center" id="plectivo">
                    </div>	
				</div>


                <div class="row mt-2 mb-1">
                    <label class="col-md-3 col-form-label  align-self-center">Seleccione Estudiante:</label>
                    <div class="col-md-5 align-self-center" id="estudiante">
                    </div>
				</div>

                <!-- SELECCIONAR CONDUCTOR -->
                <h5 class="text-center"><strong>Datos del Conductor </strong></h5>
				<div class=" row">
                    <label class="col-md-3  col-form-label align-self-center">Código: <span class="text-danger">* </span></label>
                    <div class="col-md-3 align-self-center">
                        <input type='text' id= "idfun" class="form-control form-control-sm " />
                    </div>
                            
                    <div class="col-sm-0 align-self-center" id="buscar">
                            <a class="btn grey" href="#" role="button" data-toggle="modal" data-target="#centralModalSmC"><i class="fas fa fa-search "></i></a>
                        </div>	
                </div>

                <div class="row ">
                    <label class="col-md-3 col-form-label  align-self-center">Nombres:</label>
                    <div class="col-md-7 align-self-center">
                        <input type="text" id= "chofer" class="form-control text-uppercase form-control-sm" readonly disabled />
                    </div>	
				</div>
                <!-- FIN SELECCIONAR CONDUCTOR-->

                <!-- SELECCIONAR INSTITUCION-->
                <h5 class="container text-center mt-3 "><strong >Datos de la Institución </strong></h5>
                <div class=" row">
                    <label class="col-md-3  col-form-label align-self-center">Código:<span style="color:red" >*</span></label>
                    <div class="col-md-3 align-self-center">
                        <input type='text' id= "idInst" class="form-control form-control-sm " />
                    </div>
                                      
                    <div class="col-sm-0 align-self-center" id="buscar">
                        <a class="btn grey" href="#" role="button" data-toggle="modal" data-target="#centralModalSm"><i class="fas fa fa-search "></i></a>
                    </div>	
                </div>
                    
                <div class="row ">
                    <label class="col-md-3 col-form-label  align-self-center">Nombre:</label>
                    <div class="col-md-7 align-self-center">
                        <input type="text" id= "nomInst" class="form-control text-uppercase form-control-sm" readonly disabled />
                    </div>
                            
                </div>
                 <!-- FIN SELECCIONAR INSTITUCION-->
                <div class="row ">
                    <label class="col-md-3 col-form-label  align-self-center">Estado:</label>
                    <div class="col-md-4 align-self-center">
                        <SELECT id="estado"  class="browser-default custom-select"> 
                            <OPTION VALUE="1" selected >ACTIVO</OPTION>
                            <OPTION VALUE="0">INACTIVO</OPTION>
                        </SELECT> 
                    </div>	
				</div>


                <div class="row ">
                    <label class="col-md-3 col-form-label  align-self-center" id="textoElegirServicio"></label>
				</div>


                <div class="row ">
                    <div id="map" style="width: 100%; height: 250px;"></div>
				</div>

            </form>
        </div>
    </div>
</div>


<script>

var servicioEntrada=true;
var cooperativa=0;
CargarFechaActual();

function CargarFechaActual()
{
    n =  new Date();
    y = n.getFullYear();
    m = n.getMonth() + 1;
    d = n.getDate();
    document.getElementById("fregistro").value = `${y}-${m}-${d}`;
    document.getElementById("ffin").value = `${y}-${m}-${d}`;


    var divContenedor=document.querySelector('#tservicio');
	var urlservicio=`${raizServidor}/tipoServicio?campo=tse_nombre&bus=&est=1`;			
    cargarCombo(urlservicio,"tipoServicio",divContenedor,"");
    

    var contenedor=document.querySelector('#plectivo');
	var urlperiodo=`${raizServidor}/periodo?campo=ple_nombre&bus=&est=1`;			
    cargarCombo(urlperiodo,"tipoPeriodo",contenedor,"");
    
    document.getElementById("estado").disabled=true;


    let parametro = new URLSearchParams(location.search);
    var idRepresentante = parametro.get('id');	
    
    var contenedor1=document.querySelector('#estudiante');
	var urlperiodo1=`${raizServidor}/estudianteRepresentante?id=${idRepresentante}`;			
    cargarComboEstudiante(urlperiodo1,"tipoEstudiante",contenedor1,"");
    
    document.getElementById("estado").disabled=true;	
}


async function cargarComboEstudiante(
  url,
  nombreCombo,
  divContenedor,
  SeleccionarElemento
) {
  divContenedor.innerHTML = `<div class='text-center'><div class='spinner-border text-info' role='status'><span class='sr-only'>Loading...</span></div></div>`;
  var result = `<select id='${nombreCombo}' class='browser-default custom-select'>`;
  try {
    let response = await fetch(url);
    let data = await response.json();
    for (let pro of data) {
      if (SeleccionarElemento == pro.id)
        result +=
          "<OPTION VALUE=" + pro.id + " selected>" + pro.nombre + "</OPTION>";
      else result += "<OPTION VALUE=" + pro.id + ">" + pro.nombre + " "+ pro.apellido + "</OPTION>";
    }
    result += "</SELECT>";
    divContenedor.innerHTML = result;
  } catch (e) {
    result +=
      '<option value="-1" selected>No existe elementos</option> </SELECT>';
    divContenedor.innerHTML = result;
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
			


			function agregarMarcadorAzul(lat,lng,num,grupo)
			{
				L.marker([lat, lng]).addTo(grupo)
				.bindPopup(`${num}`)
				.openPopup();
			}
			
			function createButton(label, container) 
			{
				var btn = L.DomUtil.create('button', '', container);
				btn.setAttribute('type', 'button');
				btn.innerHTML = label;
				return btn;
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
