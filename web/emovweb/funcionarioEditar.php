<?php include 'header.php';
	 include 'codigophp/sesion.php';
	 $menu=Sesiones("EMOV");
	 include 'funcionario_modal_selec_institucion.php';
?>

<div class="container text-left mt-2">
	<div class="row">
    	<div class="col-md-6 offset-md-3">
			<div class="card">
      			<h3 class="card-header cyan white-text font-weight-bold text-center" id="titulo">FUNCIONARIO</h3>
      			<div class="card-body">

					<form>	
						<div class="row">
						<label class="col-sm-3 col-form-label" >Cédula:<span style="color:red" >*</span></label>
							<div class="col-sm-5">
								<input type='text' id= "ced" class="form-control text-upperCase form-control-sm"  maxlength="10"/>
							</div>
						</div>
						<div class=" row">
							<label class="col-sm-3 col-form-label">Nombre:<span style="color:red" >*</span></label>
							<div class="col-sm-8">
								<input type='text' onkeyup="this.value = this.value.toUpperCase();" id= "nom" class="form-control form-control-sm"  maxlength="100"/>
							</div>
						</div>
						<div class="row">
							<label class="col-sm-3 col-form-label">Apellido:<span style="color:red" >*</span></label>
							<div class="col-sm-8">
								<input type='text' onkeyup="this.value = this.value.toUpperCase();" id= "ape" class="form-control text-upperCase form-control-sm"  maxlength="50" />
							</div>
						</div>
						<div class="row">
							<label class="col-sm-3 col-form-label" >Dirección:<span style="color:red" >*</span></label>
							<div class="col-sm-8">
								<input type='text' onkeyup="this.value = this.value.toUpperCase();" id="dir"  class="form-control form-control-sm" maxlength="100" />
							</div>
						</div>
						<div class="row">
							<label class="col-sm-3 col-form-label">Teléfono:</label>
							<div class="col-sm-5">
								<input type='text'id= "telf" class="form-control form-control-sm" maxlength="10"/>
							</div>
						</div>	
						<div class="row">
							<label class="col-sm-3 col-form-label">Celular:<span style="color:red" >*</span></label>
							<div class="col-sm-5">
								<input type='text' pattern="\d*" id= "cel" class="form-control form-control-sm" maxlength="10"/>
							</div>
						</div>	
						<div class="row">
							<label class="col-sm-3 col-form-label">Correo:<span style="color:red" >*</span></label>
							<div class="col-sm-8">
								<input type='text'id= "email" class="form-control form-control-sm" maxlength="100"/>
							</div>
						</div>	
						<div class="row">
							<label class="col-sm-3 col-form-label">Estado:</label>
							<div class="col-sm-5">
								<SELECT id="est" class="browser-default custom-select"> 
									<OPTION VALUE="1">ACTIVO</OPTION>
									<OPTION VALUE="0">INACTIVO</OPTION>
								</SELECT> 
							</div>
						</div>
						<h5 class="container text-center mt-3 text-uppercase"><strong >Datos de la Institución </strong></h5>
						<div class=" row">
								<label class="col-md-3  col-form-label align-self-center">Código:<span style="color:red" >*</span></label>
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
						<div class="text-white row justify-content-center mt-3">
							<input class="btn cyan" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>		
							<input type="button" value="Cancelar" class="btn cyan" onclick="location.href = 'funcionario.php';"/><br/>
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
	if(metodo=='Guardar'){				
		document.getElementById("est").disabled=true;	
	}if(metodo=='Modificar'){
		id= parametro.get('id');	
		(async () => {
			try{
				let response = await fetch(`${raizServidor}/funcionario/${id}`)
				let data = await response.json();				
				document.getElementById('ced').value = (data['cedula']);
				document.getElementById('nom').value = (data['nombre']);
				document.getElementById('ape').value = (data['apellido']);
				document.getElementById('dir').value = (data['direccion']);
				document.getElementById('telf').value = (data['telefono']);
				document.getElementById('cel').value = (data['celular']);
				document.getElementById('email').value = (data['correo']);
				document.getElementById('idInst').value = (data['institutoId']);	
				BusInstituion(data['institutoId']);
			}catch(e){
				toastr.error('Error al Cargar algunos datos'); 	
			}
		})();			
	}	


	function IngMod(v) {	
						
		event.preventDefault();	

		if(valCedula(ced.value)==false){
			toastr.error('Cédula incorrecta');
			document.getElementById("ced").style.borderColor="red";
		}else{
			document.getElementById("ced").style.borderColor='green';
			if(valSololetras(nom.value)==false){
				toastr.error('El nombre contiene caracteres incorrectos');
				document.getElementById("nom").style.borderColor="red";
			}else{ 
				document.getElementById("nom").style.borderColor='green';
				if(valSololetras(ape.value)==false){
					toastr.error('EL Apellido contiene caracteres incorrectos');
					document.getElementById("ape").style.borderColor="red";
				}else{ 
					document.getElementById("ape").style.borderColor='green';
					if(valTelefono(telf.value)==false){
						toastr.error('Teléfono incorrecto');
						document.getElementById("telf").style.borderColor="red";
					}else{ 
						document.getElementById("telf").style.borderColor='green';
						if(valCelular(cel.value)==false){
							toastr.error('celular incorrecto');
							document.getElementById("cel").style.borderColor="red";
						}else{ 
							document.getElementById("cel").style.borderColor='green';
							if(valCorreo(email.value)==false){					
								toastr.error('Correo incorrecto');
								document.getElementById("email").style.borderColor="red";
							}else{
								document.getElementById("email").style.borderColor="green";	
								if((idInst.value=="")||(nomInst.value=="") ){
									toastr["error"]("Seleccione una Institución", "Dato Incorrecto!");
									idInst.style.borderColor="red";
									nomInst.style.borderColor="red";
								}else{
									idInst.style.borderColor='green';
									nomInst.style.borderColor="green";								

									var parametros={"id":0,"cedula":ced.value,"nombre":nom.value.toUpperCase(),"apellido":ape.value.toUpperCase(),"direccion":dir.value,"telefono":telf.value,"celular":cel.value,"correo":email.value,"estado":est.value,"institutoId":idInst.value};							
									var url=`${raizServidor}/funcionario`;	
									
									if(v.value=="Guardar"){
										Ingresar(parametros,url);
										 (async () => {
											try{												
												let response = await fetch(`${raizServidor}/contadores?opcion=3`)
												let data = await response.json();	
												var urlUsuario=`${raizServidor}/usuario`;
												var ParametrosUsuario={"id":0,"correo":ced.value,"password":"1234","estado":1,"funId":data.numero};																										
												//console.log(ParametrosUsuario);
												Ingresar(ParametrosUsuario,urlUsuario);												
											}catch(e){
												toastr.error('Error al Cargar algunos datos'); 	
											}
										})();								
									}	
									if(v.value=="Modificar"){
										let redirigir="funcionario.php";
										Modificar(parametros,`${url}/${id}`,redirigir);
									}
								}
							}
					    }	
					}			
				}			
		  	}
	  	}
	}	

	function BusInstituion(insid){		
		fetch(`http://localhost:8888/institucion/${insid}`)
			.then(response => response.json())
			.then(data => {		  	
				var dato=`${data.nombre}`;
				document.getElementById('nomInst').value = dato;										
		})  
		.catch(error => { 
			toastr.error('No  existe la institucion'); console.log(error);
			document.getElementById('nomInst').value = "";	
		})	
	}
	$('#idInst').keypress(function (e) {	
		if (e.which == 13) {
			event.preventDefault();	
			var valor=e.target.value;
			BusInstituion(valor);
		}
	});
	</script>

<?php include 'footer.php'; ?>