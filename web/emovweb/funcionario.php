<?php include 'header.php'; 
	 include 'codigophp/sesion.php';
	 $menu=Sesiones("EMOV");
//    $menu=Sesiones("EMPRESA DE TRANSPORTE"); 
?>



<div class="container-fluid grey">
		<?php 
		echo $menu 
		?>
</div>


<div class="container pt-3">
	<div class="row">
		<div class="h3 text-left font-weight-bold">FUNCIONARIO</div>
	</div>
	

	<div class="form-group row mt-3 align-middle">
		<div class="col-md-3">
			<label>Campo:</label>
			<SELECT id="campo"  class="browser-default custom-select"> 	
				<option value="fun_cedula">CÉDULA</option>
				<option value="fun_nombre">NOMBRE</option>
				<option value="fun_apellido">APELLIDO</option>
				<option value="fun_direccion">DERECCIÓN</option>
			</SELECT> 
		</div>

		<div class="col-md-3">
            <label>Buscar:</label>
            <input type="text" id="textBuscar" name="textBuscar" class="form-control text-uppercase">     
        </div>

		<div class="col-sm-2">
			<label>Estado:</label>	
			<SELECT id="estado"  class="browser-default custom-select"> 	
				<OPTION VALUE="" selected >TODOS</OPTION>
                <OPTION VALUE="1">ACTIVO</OPTION>
                <OPTION VALUE="0">INACTIVO</OPTION>  				
			</SELECT> 
		</div>


		<div class="col-sm-2 align-self-center" id="buscar">
			<a href="" class="btn grey"><i class="fas fa fa-search "></i></a>
		</div>	
	</div>
	<div class="row mt-2">
        <div class="container">
            <div class="row">
                <div class="col-md-12">                    
                    <div class='table-responsive-sm my-custom-scrollbar'>
                        <table id='dt-select' class='table-sm table table-hover text-center' cellspacing='0' width='100%'>
                            <thead class='cyan white-text'>
                            <tr>
								<th scope='col'>ID</th>
								<th scope='col'>CÉDULA</th>
								<th scope='col'>NOMBRE</th>
								<th scope='col'>APELLIDO</th>
								<th scope='col'>DIRECCIÓN</th>
								<th scope='col'>TELÉFONO</th>
								<th scope='col'>CELULAR</th>
								<th scope='col'>CORREO</th>
								<th scope='col'>ESTADO</th>
								<th></th>
							</tr>
                        </thead>
                        <tbody  id="lista" class='dt-select' >
                            <!-- AQUI SE CARGA LA TABLA CON LOS REGISTROS -->
                        </tbody>
                        </table>
                    </div>
                </div>
            </div>                
        </div>
    </div>

	<!--codigo de tabs      -->
	<div class="container mt-3 p-0">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item">
				<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home"
				aria-selected="true">Rol</a>
			</li>
		</ul>
		<div class="row">
		<div class="col-md-6">
			<div class="tab-content" id="myTabContent">
				<div class='table-responsive-md'>
					<table id='dt-select' class='table-sm table table-hover text-center' cellspacing='0' width='100%' style="height:100px">
						<thead class='cyan white-text text-uppercase'>
							<tr>
								<th>Id</th>
								<th>Nombre</th>										
							</tr>
						</thead>
						<tbody id="tablar"></tbody>
					</table>
				</div>
			</div>
		</div>
		</div>
	</div>
	<div class="cyan circulo">
		<a href="funcionarioEditar.php?metodo=Agregar" class="circulo-mas"><i class="fa fa-plus" ></i></a>
	</div>
</div>

	<script type="text/javascript">		
	
		const boton=document.querySelector('#buscar');		
		const lista=document.querySelector('#lista');		
	
		function Buscar(){	
			event.preventDefault();
			
			var campo = document.getElementById('campo').value;			
			var textBuscar=document.getElementById('textBuscar').value;
			textBuscar=textBuscar.toUpperCase();			
			var estado=document.getElementById("estado").value;

			var idIns="";
			let url=`http://localhost:8888/funcionario?campo=${campo}&bus=${textBuscar}&est=${estado}&idIns=${idIns}`;
						
			fetch(url)
		 	.then((res) => {return res.json(); })
			.then(produ => {
				lista.innerHTML='';				
				let result = ``;			
				for(let prod of produ){						
					result +=
					`<tr> 
						<td class ="boton"> ${prod.id}</td>
						<td class ="boton"> ${prod.cedula}</td>
						<td class ="boton"> ${prod.nombre} </td>
						<td class ="boton"> ${prod.apellido}</td>
						<td class ="boton"> ${prod.direccion}</td>
						<td class ="boton"> ${prod.telefono} </td>
						<td class ="boton"> ${prod.celular} </td>
						<td class ="boton"> ${prod.correo} </td>
						<td class ="boton"> ${prod.estado==1?"ACTIVO":"INACTIVO"} </td>
						<td>
							<?php echo "<a href="?>funcionarioEditar.php?id=${prod.id}&inst=${prod.institutoId}&metodo=Modificar
							<?php echo "class='fas fa-edit'>Editar</a>" ?>
						</td>
					</tr>`;						
										
				}
				lista.innerHTML=result;	
				let elementos=document.getElementsByClassName('boton');
						for(let i=0;i<elementos.length;i++)
						{
				
							// cada vez que se haga clic sobre cualquier de los elementos,
							// ejecutamos la funciÃ³n obtenerValores()
							elementos[i].addEventListener('click',obtenerValores);
						}
						
						$(".dt-select tr ").click(function(){
							$(this).addClass('filaSeleccionada').siblings().removeClass('filaSeleccionada');   
						});
					return produ;				
				})		
				.catch(error => { lista.innerHTML =`<div>No se encuentras coincidencias</div>`;	 console.log("error",error); return error; })					
		}		
			
		boton.addEventListener('click',Buscar);
		
 
	// funcion que se ejecuta cada vez que se hace clic
	function obtenerValores(e) {
		var valores="";
 
		// vamos al elemento padre (<tr>) y buscamos todos los elementos <td>
		// que contenga el elemento padre
		var elementosTD=e.srcElement.parentElement.getElementsByTagName("td");
 
        document.getElementById('tablar').innerHTML=valores;

        cargarOpciones(elementosTD[0].innerHTML);
        function cargarOpciones(id)
		{
			var result=``;
			let url= `http://localhost:8888/rol?op=`+id;

			const api = new XMLHttpRequest();
			api.open('GET',url,true);
			api.send();
			
			api.onreadystatechange = function()
			{				
				if(this.status == 200 && this.readyState == 4 )
				{
					let datos= JSON.parse(this.responseText);
					if(datos.length > 0)
					{
						
						result=``;
						for(i=0;i<datos.length;i++)
						{
							result += `<tr> 
									<td> ${datos[i].id}</td>
									<td> ${datos[i].nombre}</td>
								`;
							
							result+=`</tr>`;							
						}
						console.log(result);
						document.getElementById("tablar").innerHTML=result;
					}
					else{
						console.log("el funcionario no tiene roles ");
					}					
				}				
			}
		}	
	}
	</script>
	
	
 <?php include 'footer.php'; ?>
