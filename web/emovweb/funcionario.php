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
                    };
                   
                       
                </script>
        ";
    } else {
        header('Location: ./');
    }   

?>

<div class="container-fluid grey">
		<?php echo $menu ?>
</div>


<div class="container">
	<div class="row mt-3 pt-3">
    <div class="col">
		<h1>Funcionario</h1>
		<div class="form-group row">
			<label class="col-sm-0 col-form-label align-self-center">Campo:</label>
			<div class="col-sm-2 align-self-center">
				<SELECT id="campo"  class="browser-default custom-select"> 	
					  <option value="fun_cedula">Cedula</option>
					  <option value="fun_nombre">Nombre</option>
					  <option value="fun_apellido">Apellido</option>
					  <option value="fun_direccion">Direccion</option>
				</SELECT> 
			</div>
			<label class="col-sm-0 col-form-label align-self-center">Buscar:</label>
			<div class="col-sm-4 align-self-center">
				<input type="text" id="textBuscar" class="form-control ">
			</div>	

			<div class="col-sm-2 align-self-center">
				<SELECT id="estado"  class="browser-default custom-select"> 	
					  <option value="1">Activo</option>
					  <option value="0">Inactivo</option>
					  <option value="">Todos</option>
					  
				</SELECT> 
			</div>


			<div class="col-sm-0 align-self-center" id="buscar">
				<a href="" class="btn grey"><i class="fas fa fa-search "></i></a>
			</div>	

			
		</div>
		<ul id="resBusqueda"></ul>

		<div class='table-responsive-md my-custom-scrollbar'>
			<table id='dt-select' class='table-sm table table-hover text-center' cellspacing='0' width='100%'>
				<thead class='cyan white-text text-uppercase'>
					<tr>
					<th scope='col'>Id</th>
					<th scope='col'>Cedula</th>
					<th scope='col'>Nombre</th>
					<th scope='col'>Apellido</th>
					<th scope='col'>Direccion</th>
					<th scope='col'>Telefono</th>
					<th scope='col'>Celular</th>
					<th scope='col'>Correo</th>
					<th scope='col'>Estado</th>
					<th></th>
					</tr>
				</thead>
				<tbody id="lista" class='dt-select'>
				</tbody>
			</table>
		</div>

		
	</div>
	</div>

	
		<!--codigo de tabs      -->
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
								<tbody id="tablar">
							
								</tbody>
							</table>
						</div>

						</div>
				</div>
			</div>
		

		

</div>
		<div class="position-fixed btn-group-lg" style="bottom:20px; right:80px; width:120px; height:80px;">
			<a href="funcionarioEditar.php?metodo=Ingresar" class="cyan btn "  
			style="  -webkit-border-radius: 50px;
  					-moz-border-radius: 50px;
					  border-radius: 50px;
					  color:#fff;
					  padding-top: 20px;
					  width:70px; height:70px;
					  ">
			
			<i class="fa fa-plus" ></i></a>
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
			
			
					
			
			
			if(textBuscar==""){
				//textBuscar="*****";
			}
			
			let url=`http://localhost:8888/funcionario?campo=${campo}&bus=${textBuscar}&est=${estado}`;
			
			
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
					<td class ="boton"> ${prod.estado==1?"Activo":"Inactivo"} </td>
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
		
	</script>	
	<script>
   
 
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
