<!-- Central Modal Small -->
<div class="modal fade" id="centralModalSm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">

  <!-- Change class .modal-sm to change the size of the modal -->
  <div class="modal-dialog modal-lg" role="document">

    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title " id="myModalLabel">Seleccionar Funcionario</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body"> 	


				<div class="container">
					<div class="form-group row">
				    	<div class="col-md-3  align-self-center">		
							<label>Campo:</label>
                            <select id="campo" name="campo" class="browser-default custom-select" onchange="veroferta(this.value)">
                                <option value="veh_placa" selected >PLACA</option>	
                            </select>
						</div>
						<div class="col-md-3">
							<label for="txtuser">Buscar:</label>
							<input type="text" id="textBuscar" name="textBuscar" class="form-control text-uppercase">     
						</div>
						
						<div class="col-md-3">
							<label>Estado:</label>
							<SELECT id="estBusqueda"  class="browser-default custom-select"> 
								<OPTION VALUE="" selected >TODOS</OPTION>
								<OPTION VALUE="1">ACTIVO</OPTION>
								<OPTION VALUE="0">INACTIVO</OPTION>             
							</SELECT> 
						</div>							

						<div class="col-md-2  align-self-center" id="buscar">
							<a href="" class="btn grey"><i class="fas fa fa-search "></i></a>
						</div>
					</div>
					<div class="row">
						<div class="container">
							<div class="row">
								<div class="col">                    
									<div class='table-responsive-sm my-custom-scrollbar'>
										<table id='dt-select' class='table-sm table table-hover text-center' cellspacing='0' width='100%'>
											<thead class='cyan white-text'>
												<tr>
													<th scope="col">ID</th>
                                                    <th scope="col">PLACA</th>
                                                    <th scope="col">CAPACIDAD</th> 
                                                    <th scope="col">ESTADO</th>     
                                                    <th></th>
												</tr>
											</thead>
											<tbody  id="lista" >
												<!-- AQUI SE CARGA LA TABLA CON LOS REGISTROS -->
											</tbody>
										</table>
									</div>
								</div>
							</div>                
						</div>
					</div>
    			</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-sm grey" data-dismiss="modal">Cancelar</button>       
				</div>
			</div>
    </div>
  </div>
</div>
<!-- Central Modal Small -->
		

	<script type="text/javascript">	
		const boton=document.querySelector('#buscar');		
		const lista=document.querySelector('#lista');
		var idFun;		
	
		function Buscar(){	
			event.preventDefault();
		var campo = document.getElementById('campo').value;			
		var textBuscar=document.getElementById('textBuscar').value;
		textBuscar=textBuscar.toUpperCase();			
		var estado=document.getElementById("estBusqueda").value;	
		lista.innerHTML=`<div class="text-center"><div class="spinner-border text-info" role="status"><span class="sr-only">Loading...</span></div></div>`;	
				
		(async () => {
			try{
				var idIns="1";
				var url=`${raizServidor}/vehiculo?campo=${campo}&bus=${textBuscar}&est=${estado}&idIns=${idIns}`;
				
				let response = await fetch(url);
				let data = await response.json();
				let result="";					
				est="";
				for(let prod of data){						
					result +=
					`<tr> 
						<td> ${prod.id}</td>
						<td> ${prod.placa}</td>
						<td class="text-center"> ${prod.capacidad}</td>	
						<td> ${prod.estado==1?"ACTIVO":"INACTIVO"} </td>
						<td><a class='bot fas fa-check-circle' data-dismiss='modal'>Seleccionar</a></td> 
					</tr>`;										
				}
				result += `</table> `;
				lista.innerHTML=result;	
			}catch(e){
				toastr.error('Error al Cargar algunos datos'+ e); 	
			}
		})();
		}		
			
		boton.addEventListener('click',Buscar);
		
		// la clase bot es del boton de seleccionar. 
		//  la lista es el div contenedor del resultado de la busqueda
		$("#lista").on('click', '.bot', function(e) {
			// CAPTURA LOS DATOS DE LAS POSICIONES DE LA TABLA DE BUSQUEDA.			
			var id = $(this).parents("tr").find("td")[0].innerHTML;
			var placa = $(this).parents("tr").find("td")[1].innerHTML;
			// ENVIO EL RESULTADO A LOS INPUT DE LA VENTANA PRINCIPAL
			document.getElementById('placa').value = (`${placa}`);
			document.getElementById('idVehiculo').value = (`${id}`);
		});		 
	</script>	
 
