<div class="container">
	<div class="row mt-3 pt-3">
    <div class="col">		
		<div class="form-group row">
			<label class="col-sm-0 col-form-label align-self-center">Campo:</label>
			<div class="col-sm-2 align-self-center">
				<SELECT id="campo"  class="browser-default custom-select"> 	
					  <option value="ins_ruc">Ruc</option>
					  <option value="ins_nombre">Nombre</option>
					  <option value="ins_direccion">Direccion</option>
				</SELECT> 
			</div>
			<label class="col-sm-0 col-form-label align-self-center">Buscar:</label>
			<div class="col-sm-4 align-self-center">
				<input type="text" id="textBuscar" class="form-control ">
			</div>	

			<div class="col-sm-2 align-self-center">
				<SELECT id="estado"  class="browser-default custom-select"> 	
					  
					<option value="">TODOS</option>
					<option value="0">ACTIVO</option>
					<option value="1">INACTIVO</option>
					  
				</SELECT> 
			</div>

			<div class="col-sm-0 align-self-center" id="buscar">
				<a href="" class="btn grey"><i class="fas fa fa-search "></i></a>
			</div>		
		</div>		
		<div id="lista"></div>		
	</div>
	</div>		
</div>
		

	<script type="text/javascript">	
		const boton=document.querySelector('#buscar');		
		const lista=document.querySelector('#lista');
		var idFun;		
	
		function Buscar(){	
			event.preventDefault();

			var campo = document.getElementById('campo').value;			
			var textBuscar=document.getElementById('textBuscar').value;
			textBuscar=textBuscar.toUpperCase();			
			var estado=document.getElementById("estado").value;
						
				
		
			if(textBuscar==""){
				// textBuscar="*****";
			}
			let url=`http://localhost:8888/institucion?campo=${campo}&bus=${textBuscar}&est=${estado}`;

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
						<th >Id</th>
									<th >Ruc</th>
									<th >Nombre</th>
									<th >Direccion</th>
									<th >Telefono</th>
									<th >Correo</th>
									<th >Estado</th>
						<th></th>                  
					</tr>
				<thead>`;					
				est="";
				for(let prod of produ){						
					result +=
					`<tr> 
							<td > ${prod.id}</td>
					<td > ${prod.ruc}</td>
					<td > ${prod.nombre} </td>
					<td > ${prod.direccion}</td>
					<td > ${prod.telefono} </td>
					<td > ${prod.correo} </td>
					<td > ${prod.estado==1?"Activo":"Inactivo"} </td>	
					`
					
			// data-dismiss='modal'  EVENTO PARA QUE SE CIERRE EL MODAL 
					result +=
					`													
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
			var nom = $(this).parents("tr").find("td")[2].innerHTML;
				
			// ENVIO EL RESULTADO A LOS INPUT DE LA VENTANA PRINCIPAL
			document.getElementById('chofer').value = (`${nom}`);
			document.getElementById('idfun').value = cod;
		});		 
	</script>