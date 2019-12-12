 <?php
	session_start();
	if (isset($_SESSION['id']) && isset($_SESSION['rol'])) {
		if($_SESSION['rol'] == "EMOV")
		{
			$id = $_SESSION['id'];
			$rol = $_SESSION['rol'];
			$menu=$_SESSION['menu'];
			echo " <script type='text/javascript'>
						window.onload=function() {

							document.getElementById('rol').innerHTML ='ROL - $rol';
							document.getElementById('btncerrar').style.display = 'block';
							CargarRoles();
						}
					</script>
			";
		}
		else{
			header('Location: ./');
		}
		
	} else {
		header('Location: ./');
	} 
      

?>


<?php 	include 'header.php'; 
		include 'codigophp/funcionesphp.php'; 
		include 'modal.php';
?>

    <script>
   let datosHijos=0;
	
   var idRol=0;
	function obtenerValores(e) {
		var elementosTD=e.srcElement.parentElement.getElementsByTagName("td");
		 let valores=`<td></td>
					<td class=" text-right"><div class="spinner-border text-center" role="status">
					<span class="sr-only">Loading...</span>
					</div></td>
					<td></td>`;
        document.getElementById('opciones').innerHTML=valores;
		idRol=elementosTD[0].innerHTML;
        cargarOpciones(idRol);
        function cargarOpciones(id) 
		{
			var result=``;
			var result2=``;
			let url= `http://localhost:8888/opcion?id=`+id+`&opcion=1`;

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
						result2=`<option value='0'>Elegir</option>`;
						for(i=0;i<datos.length;i++)
						{
							result += `<tr> 
									<td> ${datos[i].id}</td>
									<td> ${datos[i].nombre}</td>
									<td> ${datos[i].idhijo}</td>
									<td> ${datos[i].nombrehijo}</td>
								`;
							result+=`<td><a href='#' class='text-dark fas fa-trash-alt actionmodal2' >  Eliminar</a></td></tr>`;
						}

						document.getElementById("combomodal1").innerHTML=result2;
						
					}
					else{
						result=`<td></td>
						<td>No se encontraron resultados.</td>
						<td></td>`;
					}
				
					document.getElementById("opciones").innerHTML=result;
				}
				
			}


			let url2= `http://localhost:8888/opcion?id=`+id+`&opcion=2`;
			// alert(url2); ==================================================================AQUI SE IMPRIME LA URL PARA CARGAR OOPCIONES

			const api2 = new XMLHttpRequest();
			api2.open('GET',url2,true);
			api2.send();
			api2.onreadystatechange = function()
			{
				if(this.status == 200 && this.readyState == 4 )
				{
					result2=`<option value='0'>Elegir</option>`;
					let datos= JSON.parse(this.responseText);
					if(datos.length > 0)
					{
						
						for(i=0;i<datos.length;i++)
						{
							result2 +=`<option value="${datos[i].id}">${datos[i].nombre}</option>`;	
						}
						
					}
					document.getElementById("combomodal1").innerHTML=result2;
				}
				
			}
		}	


	}

    </script>
 
 <div class="container-fluid grey pr-0 pl-0">
		<?php 
		echo $menu 
		?>
</div>

<div class="container pt-3">
	<div class="row">
		<div class="h3 text-left font-weight-bold">ROLES</div>
	</div>
	<div class="row justify-content-end text-white mr-1">
		<button id="btnRol" type="button" class="btn btn-info p-1" onclick="resetearModal(this)"  role="button" data-toggle="modal" data-target="#centralModalSm" ><i class="far fa-plus-square pr-2" aria-hidden="true"></i>Rol</button>
	</div>

	
	<div class='table-responsive-md my-custom-scrollbar'>
		<table  class='table-sm table table-hover text-center' cellspacing='0' width='100%'>
			<thead class='cyan white-text'>
				<tr>
				<th scope='col'>ID</th>
				<th scope='col'>NOMBRE</th>
				<th scope='col'>ESTADO</th>
				<th></th>
				</tr>
			</thead>
			<tbody class="dt-select" id="listaroles">
				
			</tbody>
		</table>
	</div>

	
</div>


<div class="container mt-3 p-0">
	<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item">
			<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home"
			aria-selected="true">Opciones</a>
		</li>
	</ul>

	<div class="tab-content" id="myTabContent">
		<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
			<div class="container-fluid p-0 m-0">
				<div class="row justify-content-end text-white mr-1">
					<button type="button" class="btn btn-info p-1"  role="button" data-toggle="modal" data-target="#modalOpciones"><i class="far fa-plus-square pr-2" aria-hidden="true"></i>Opci&oacute;n</button>
				</div>

			
				<div class='table-responsive-md my-custom-scrollbar'>
					<table id='dt-select' class='table-sm table table-hover text-center  cellspacing='0' width='100%'>
						<thead class='cyan white-text'>
							<tr>
							<th scope='col'>ID</th>
							<th scope='col'>OPCION</th>
							<th scope='col'>ID SUBOPCION</th>
							<th scope='col'>SUBOPCION</th>
							<th></th>
							</tr>
						</thead>
						<tbody id="opciones">
						</tbody>
					</table>
				</div>
			</div>
			
		</div>
	</div>
</div>


<div class="modal fade" id="modalOpciones" tabindex="-1" role="dialog" aria-labelledby="tittle"
  aria-hidden="true">

  <!-- Change class .modal-sm to change the size of the modal -->
  <div class="modal-dialog modal-md" role="document">

    <div class="modal-content">
        <div class="modal-header text-center m-0 p-0 cyan">
            <h4 class="modal-title w-100 text-white" id="title">Asignar Opciones</h4>
            </button>
        </div>
        <div class="modal-body" id="cuerpoModal">
			<div class="row">
					<label class="col-sm-3 col-form-label">Opciones:</label>
					<div class="col-sm-9">
						<select id="combomodal1"  class="browser-default custom-select">
						</SELECT> 
					</div>
            </div>
            
            <div class="row mt-1">
                <label class="col-sm-3 col-form-label">Subopciones:</label>
                <div class="col-sm-9">
                    <select id="combomodal2"  class="browser-default custom-select">
						<option >Seleccionar</option>
                    </SELECT> 
                </div>

            </div>
            
            <div class="row justify-content-center mt-3">
                <div class=""><input type="button" value="Agregar" class="btn cyan" onclick="AsignarOpcion(this)"  /></div>
                <div class=""><input type="button" value="Cancelar" class="btn cyan" data-dismiss="modal"/><br/></div>
            </div> 
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="modalEliminar" tabindex="-1" role="dialog" aria-labelledby="tittle"
  aria-hidden="true">

  <!-- Change class .modal-sm to change the size of the modal -->
  <div class="modal-dialog modal-md" role="document">

    <div class="modal-content">
        <div class="modal-header text-center m-0 p-0 rgba-red-strong">
            <h4 class="modal-title w-100 text-white text-center" id="title">Eliminar</h4>
            </button>
        </div>
        <div class="modal-body" id="cuerpoModal">
			<label class="col-form-label text-center">Esta seguro de eliminar?</label>
            <div class="row justify-content-center mt-3">
                <div class=""><input type="button" value="Eliminar" class="btn white" onclick="eliminar();"  /></div>
                <div class=""><input type="button" value="Cancelar" class="btn white" data-dismiss="modal"/><br/></div>
            </div> 
      </div>
    </div>
  </div>
</div>

<script>

	$("#combomodal1").change(function() {
	var id = $(this).val();

	let url= `http://localhost:8888/hijo?id=`+id;

	const api = new XMLHttpRequest();
	api.open('GET',url,true);
	api.send();
	
	api.onreadystatechange = function()
	{
		
		if(this.status == 200 && this.readyState == 4 )
		{
			let datos=JSON.parse(this.responseText);
			let result=``;
			if(datos.length > 0)
			{
				
				
				for(i=0;i<datos.length;i++)
				{
					result+=`<option value=' ${datos[i].id}'> ${datos[i].nombre} </option>`;
				}

				
				
			}
			document.getElementById("combomodal2").innerHTML=result;
		}
		
	}
	});



	var idMod=0;
	$('#listaroles').on('click', '.activarModal', function(e) {
		$('#centralModalSm').modal('show');
		// CAPTURA LOS DATOS DE LAS POSICIONES DE LA TABLA DE BUSQUEDA.
		var cod = $(this).parents('tr').find('td')[2].innerHTML;
		var nom = $(this).parents('tr').find('td')[1].innerHTML;
		idMod =$(this).parents('tr').find('td')[0].innerHTML;
		document.getElementById('nombreModal').value = nom;


		if(cod == "ACTIVO")
			$('[id="estadoModal"]').val('1');
		else
			$('[id="estadoModal"]').val('0');;
		
			document.getElementById('botonModal').value = 'MODIFICAR';	
		//
	});

	var id1=0;
	var id2=0;
	
	$('#opciones').on('click', '.actionmodal2', function(e) {
		$('#modalEliminar').modal('show');
		id1=idRol;
		id2 = $(this).parents('tr').find('td')[2].innerHTML;
	});

	async function eliminar(){
    try{

		var parametros={"id": id1, "nombre": "", "idhijo":id2, "nombrehijo": ""};	
		var url='http://localhost:8888/opcionRol/1'; 

        let response = await  fetch(url, {
                method: 'PUT',
                body:JSON.stringify(parametros),
                headers:{'Content-Type': 'application/json'}				
            })
        let data = await response.json();
        toastr.success('Eliminado correctamente');	
		setTimeout("window.location.reload()",1000); 
      
    }catch(e){
        toastr.error(`Error al eliminar la información`);			
    }
}

	function resetearModal()
	{
		document.getElementById('nombreModal').value = ``;
		$('[id="estadoModal"]').val('1');
		document.getElementById('botonModal').value = 'AGREGAR';	
	}

	function IngresoEdicion(v) 
	{	
		var nombre = document.getElementById('nombreModal');
		var estado = document.getElementById('estadoModal');
		
		event.preventDefault();			

		if(valSololetras(nombre.value)==false){
				toastr.error('Nombre con caracteres incorrecto');
				nombre.style.borderColor="red";
		}
		else
		{
			var parametros={'id':0,'nombre':nombre.value.toUpperCase(),'estado':estado.value};		

			
			if(v.value=='AGREGAR'){	
				Ingresar(parametros,"http://localhost:8888/rol");
			}	
			else{
				let redirigir="rolMaster.php";
				var id= idMod;					
				var url='http://localhost:8888/rol/'+id;
				Modificar(parametros,url,redirigir);
			}
		}

		CargarRoles();
	}

	function AsignarOpcion(v)
	{
		var padre = idRol;
		var hijo = document.getElementById('combomodal2');
		
		event.preventDefault();			

		if(padre.value == 0){
				toastr.error('Debe eligir una opción');
				padre.style.borderColor="red";
		}
		else
		{
			var parametros={"id": padre, "nombre": "", "idhijo":hijo.value, "nombrehijo": ""};	

			var url='http://localhost:8888/opcionRol';
			Ingresar(parametros,url);
			
		}	
	}

	</script>

<script type="text/javascript">	

	const lista=document.querySelector('#listaroles');		
	function CargarRoles(){	
			
		let url=`http://localhost:8888/rol?op=0`;

		lista.innerHTML=`<div class="text-center"><div class="spinner-border text-info" role="status"><span class="sr-only">Loading...</span></div></div>`;	
		fetch(url)
		.then((res) => {return res.json(); })
		.then(produ => {
			let result="";					
			est="";
			for(let prod of produ){						
				result +=
				`<tr> 
					<td class='boton'> ${prod.id}</td>
					<td class='boton'> ${prod.nombre}</td>
					
				`
				if(prod.estado===0){
					// est="<span class='badge badge-info'>INACTIVO</span>";
					est="INACTIVO";
				}else{
					// est="<span class='badge badge-success'>ACTIVO</span>";
					est="ACTIVO";
				}					
				result +=
				`	<td class='boton'>${est}</td>
					<td><a href='#' class='text-dark fas fa-edit activarModal'>Editar</a></td>
				</tr>`;									
									
			}
			lista.innerHTML=result;
			$(".dt-select tr ").click(function(){
			$(this).addClass('filaSeleccionada').siblings().removeClass('filaSeleccionada'); 

			
			});

			let elementos=document.getElementsByClassName('boton');
			for(let i=0;i<elementos.length;i++)
			{
				elementos[i].addEventListener('click',obtenerValores);
			} 
			document.getElementById('tituloModal').innerHTML = 'ROL';	

				return produ;				
			})		
			.catch(error => { lista.innerHTML =`<div>No se encuentran coincidencias</div>`;	 console.log("error",error); return error; })		
	}
	
</script>


 <?php include 'footer.php'; ?>
