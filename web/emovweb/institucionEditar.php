<?php include 'header.php'; 
	include 'codigophp/sesion.php';
	$menu=Sesiones("EMOV");
?>
<div class="container text-align-left mt-2 ">
	<div class="row">
    	<div class="col-md-6 offset-md-2">
			<div class="card">
				<h3 class="card-header cyan white-text text-uppercase font-weight-bold text-center" id="titulo">Institución</h3>
      			<div class="card-body">
						<!--AQUI VA EL FORMULARIO DE INGRESO Y EDICION -->
					<form>	
							<div class=" row">
								<label class="col-md-3 col-form-label">RUC: <span class="text-danger">* </span></label>
								<div class="col-md-5">
									<input type='text' id= "ruc" class="form-control form-control-sm"  maxlength="13"/>
								</div>
							</div>

							<div class="row">
								<label class="col-md-3 col-form-label">Nombre: <span class="text-danger">*</span></label>
								<div class="col-md-9">
									<input type='text' id="nombre" class="form-control text-uppercase form-control-sm"  maxlength="50"/>
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
						
				</div>
			</div>
      	</div>
	</div>
</div>
	
<script type="text/javascript">

	let parametro = new URLSearchParams(location.search);
	var metodo = parametro.get('metodo');	
	document.getElementById('metodo').value =metodo;
	var id;
	var divContenedor=document.querySelector('#lista');
	var urlCombo=`${raizServidor}/tipoInstitucion?campo=tin_nombre&bus=&est`;		
	if(metodo=='Guardar'){			
		cargarCombo(urlCombo,"tipoIns",divContenedor,"");	
		document.getElementById("estado").disabled=true;	
	}if(metodo=='Modificar'){
		id= parametro.get('id');	
		(async () => {
			try{
				let response = await fetch(`${raizServidor}/institucion/${id}`)
			    let data = await response.json();			  		  	
				document.getElementById('nombre').value = (data['nombre']);
				document.getElementById('ruc').value = (data['ruc']);
				document.getElementById('direccion').value = (data['direccion']);
				document.getElementById('telefono').value = (data['telefono']);
				document.getElementById('correo').value = (data['correo']); 		  
				let Tins= (data['tipoInstitucionId']); 	
				cargarCombo(urlCombo,"tipoIns",divContenedor,Tins);			
			}catch(e){
				toastr.error('Error al Cargar algunos datos'); 	
			}
		})();			
	}	

	function IngMod(v) {
		event.preventDefault();			

		if(validarRUC(ruc.value)==false){
			toastr["error"]("RUC incorrecto!")
			ruc.style.borderColor="red";
		}else{
			ruc.style.borderColor='green';
			if(valSololetras(nombre.value)==false){
				toastr["error"]("Ingrese solo letras", "Caracteres incorrectos!")
				nombre.style.borderColor="red";
			}else{
				nombre.style.borderColor='green';				
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
						if(tipoIns.value==-1){
							tipoIns.style.borderColor="red";
							toastr["error"]("Seleccione una institución")	
						}else{
							tipoIns.style.borderColor="green";
							var parametros={'id':0,'nombre':nombre.value.toUpperCase(),'ruc':ruc.value,'direccion':direccion.value.toUpperCase(),'telefono':telefono.value,'correo':correo.value,'estado':estado.value,'tipoInstitucionId':tipoIns.value};		
							var url=`${raizServidor}/institucion`;
							if(v.value=="Guardar"){	
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
	}
	
	
	</script>


<?php include 'footer.php'; ?>