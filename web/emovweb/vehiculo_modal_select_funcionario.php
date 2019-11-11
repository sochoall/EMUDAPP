<!-- Central Modal Small -->
<div class="modal fade" id="centralModalSm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">

  <!-- Change class .modal-sm to change the size of the modal -->
  <div class="modal-dialog modal-lg" role="document">

    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title w-100" id="myModalLabel">Seleccionar Funcionario</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body"> 	


				<div class="container">
					<div class="row mt-3 pt-3">
				    <div class="col">		
						<div class="form-group row">
							<label class="col-sm-0 col-form-label align-self-center">Campo:</label>
							<div class="col-sm-2 align-self-center">
								<SELECT id="campo"  class="browser-default custom-select"> 
				                    <OPTION VALUE="0" selected >Nombre</OPTION>
				                    <OPTION VALUE="1">Apellido</OPTION>	
									<OPTION VALUE="2">Cédula</OPTION>					
								</SELECT> 
							</div>
							<label class="col-sm-0 col-form-label align-self-center">Buscar:</label>
							<div class="col-sm-4 align-self-center">
								<input type="text" id="textBuscar" class="form-control ">
							</div>	

							<div class="custom-control custom-checkbox align-self-center">
								<input type="checkbox" class="custom-control-input" id="defaultUnchecked" checked >
								<label class="custom-control-label" for="defaultUnchecked">Activo</label>				
							</div>

							<div class="col-sm-0 align-self-center" id="buscar">
								<a href="" class="btn grey"><i class="fas fa fa-search "></i></a>
							</div>		
						</div>		
						<div id="lista"></div>		
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
			var estado=document.getElementById("defaultUnchecked").checked;
						
			if(campo==0){ 
				campo="fun_nombre";				
			}if(campo==1){ 
				campo="fun_apellido";				
            }if(campo==2){ 
				campo="fun_cedula";
			}			
			if(estado==true){
				estado=1;
			}else{
				estado=0;
			}
			if(textBuscar==""){
				// textBuscar="*****";
			}
			let url=`http://localhost:8888/funcionario?campo=${campo}&bus=${textBuscar}&est=${estado}`;

			lista.innerHTML=`
			<div class="text-center">
			<div class="spinner-border text-info" role="status">
				<span class="sr-only">Loading...</span>
			</div>
			</div>				
				`;	
			fetch(url)
		 	.then((res) => {return res.json(); })
			.then(produ => {
				let result = `
				<table id="tab" class="table table-sm table-striped w-auto">	
				<thead class=" cyan">				
					<tr>
						<th>#</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
						<th>CEDULA</th>  					
						<th>Estado</th>  
						<th></th>                  
					</tr>
				<thead>`;					
				est="";
				for(let prod of produ){						
					result +=
					`<tr> 
						<td> ${prod.id}</td>
                        <td> ${prod.nombre}</td>
                        <td> ${prod.apellido}</td>
						<td> ${prod.cedula}</td>	
					`
					if(prod.estado===0){
						est="inactivo";
					}else{
						est="activo";
					}
			// data-dismiss='modal'  EVENTO PARA QUE SE CIERRE EL MODAL 
					result +=
					`<td> ${est}</td>													
					<td><a class='bot fas fa-check-circle' data-dismiss='modal'>Seleccionar</a>
					</td> 
					</tr>`;											
				}
				result += `</tabla> `;
				lista.innerHTML=result;
				return produ;				
			})		
				.catch(error => { lista.innerHTML =`<div>No se encuentras coincidencias</div>`;	 console.log("error",error); return error; })					
		}		
			
		boton.addEventListener('click',Buscar);
		
		// la clase bot es del boton de seleccionar. 
		//  la lista es el div contenedor del resultado de la busqueda
		$("#lista").on('click', '.bot', function(e) {
			// CAPTURA LOS DATOS DE LAS POSICIONES DE LA TABLA DE BUSQUEDA.
			var cod = $(this).parents("tr").find("td")[0].innerHTML;
			var nom = $(this).parents("tr").find("td")[1].innerHTML;
			var ape = $(this).parents("tr").find("td")[2].innerHTML;
			// ENVIO EL RESULTADO A LOS INPUT DE LA VENTANA PRINCIPAL
			document.getElementById('chofer').value = (`${nom} ${ape}`);
			document.getElementById('idfun').value = cod;
		});		 
	</script>	
 
