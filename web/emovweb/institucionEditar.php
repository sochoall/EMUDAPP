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

<div class="container text-align-left mt-2 text-uppercase">
	<div class="row">
    	<div class="col-md-7 offset-md-2">
			<div class="card">
				<h3 class="card-header cyan white-text text-uppercase font-weight-bold text-center" id="titulo">Institución</h3>
      			<div class="card-body">
						<!--AQUI VA EL FORMULARIO DE INGRESO Y EDICION -->
					<form>	
							<div class="row">
								<label class="col-md-3 col-form-label">Nombre: <span class="text-danger">*</span></label>
								<div class="col-md-9">
									<input type='text' id="nombre" class="form-control text-uppercase form-control-sm"  maxlength="50"/>
								</div>
							</div>
							<div class=" row">
								<label class="col-md-3 col-form-label">RUC: <span class="text-danger">* </span></label>
								<div class="col-md-5">
									<input type='text' id= "ruc" class="form-control form-control-sm"  maxlength="13"/>
								</div>
							</div>
							<div class="row">
								<label class="col-md-3 col-form-label">Dirección: <span class="text-danger">* </span></label>
								<div class="col-md-9">
									<input type='text'id= "direccion" class="form-control text-uppercase form-control-sm"  maxlength="100" />
								</div>
							</div>
							<div class="row">
								<label class="col-md-3 col-form-label" >Teléfono: <span class="text-danger">* </span></label>
								<div class="col-md-9">
									<input type='text' id="telefono"  class="form-control form-control-sm" maxlength="10" />
								</div>
							</div>
							<div class="row">
								<label class="col-md-3 col-form-label">Correo: <span class="text-danger">* </span></label>
								<div class="col-md-9">
									<input type='text'id= "correo" class="form-control form-control-sm" maxlength="100"/>
								</div>
							</div>	
							<div class="row">
								<label class="col-md-3 col-form-label">Estado: <span class="text-danger">* </span></label>
								<div class="col-md-5">
									<SELECT id="estado"  class="browser-default custom-select"> 
										<OPTION VALUE="1" selected >ACTIVO</OPTION>
										<OPTION VALUE="0">INACTIVO</OPTION>
									</SELECT> 
								</div>
							</div>	
							<div class="row align-self-center">
								<label class="col-md-3 col-form-label">Tipo de Institución: <span class="text-danger">* </span></label>
								<div  id="lista" class="col-md-8 align-self-center"></div>
							</div>							
							<div class="text-white row justify-content-center mt-3">
								<input class="btn cyan" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>		
								<input type="button" value="Cancelar" class="btn cyan" onclick="location.href = 'institucion.php';"/><br/>
							</div>
						</form>
						<div class="row justify-content-center">
							<span class=" text-danger">* campos obligatorios</span>
						</div>
				</div>
			</div>
      	</div>
	</div>
</div>
	
<script type="text/javascript">

	let parametro = new URLSearchParams(location.search);
	var metodo = parametro.get('metodo');	
	var id;
	document.getElementById('metodo').value =metodo;	
	if(metodo=='Agregar'){			
		cargarCombo();		
	}if(metodo=='Modificar'){
		id= parametro.get('id');	
		(async () => {
			try{
				let response = await fetch(`http://localhost:8888/institucion/${id}`)
			    let data = await response.json();			  		  	
				document.getElementById('nombre').value = (data['nombre']);
				document.getElementById('ruc').value = (data['ruc']);
				document.getElementById('direccion').value = (data['direccion']);
				document.getElementById('telefono').value = (data['telefono']);
				document.getElementById('correo').value = (data['correo']); 		  
				let Tins= (data['tipoInstitucionId']); 	
				cargarCombo(Tins);			
			}catch(e){
				toastr.error('Error al Cargar algunos datos'); 	
			}
		})();			
	}

	async function cargarCombo(Tins){
		const lista=document.querySelector('#lista');
		lista.innerHTML=`<div class='text-center'><div class='spinner-border text-info' role='status'><span class='sr-only'>Loading...</span></div></div>`;
		try {
			var url=`http://localhost:8888/tipoInstitucion?campo=tin_nombre&bus=&est=1`;			
			let response = await fetch(url)
			let data = await response.json();					
			var result = `<select id='tipoIns' class='browser-default custom-select'>`;						
			for(let pro of data){	
				if(pro.id==Tins)						
					result +='<OPTION selected VALUE=' + pro.id + '>' + pro.nombre + '</OPTION>';	
				else
					result +='<OPTION VALUE=' + pro.id + '>' + pro.nombre + '</OPTION>';		
			}	
			result += '</SELECT>';				
			lista.innerHTML = result;	
		}catch(e){
				lista.innerHTML =`<div>No se encuentras</div>`; 	
			}
	}

	function IngMod(v) {
		event.preventDefault();			

		if(valSololetras(nombre.value)==false){
			toastr["error"]("Ingrese solo letras", "Caracteres incorrectos!")
				nombre.style.borderColor="red";
		}else{
			nombre.style.borderColor='green';
			if(validarRUC(ruc.value)==false){
				toastr["error"]("RUC incorrecto!")
				ruc.style.borderColor="red";
			}else{ 
				ruc.style.borderColor='green';
				if(valTelefono(telefono.value)==false){				
				toastr["error"]("Ingrese solo números", "Teléfono incorrecto!")
				telefono.style.borderColor="red";
				}else{ 
					telefono.style.borderColor='green';
					if(valCorreo(correo.value)==false){					
						toastr["error"]("Ingrese caracteres válidos", "Correo incorrecto!")						
						correo.style.borderColor="red";
					}else{
						correo.style.borderColor="green";
						var parametros={'id':0,'nombre':nombre.value.toUpperCase(),'ruc':ruc.value,'direccion':direccion.value.toUpperCase(),'telefono':telefono.value,'correo':correo.value,'estado':estado.value,'tipoInstitucionId':tipoIns.value};		
						var url="http://localhost:8888/institucion";

						// console.log(parametros);
						if(v.value=="Agregar"){	
							Ingresar(parametros,url);
						}	
						if(v.value=="Modificar"){
							let redirigir="institucion.php";
							Modificar(parametros,`${url}/${id}`,redirigir);
						}
					}	
				}			
			}
		}
	}
	
	
	</script>


<?php include 'footer.php'; ?>