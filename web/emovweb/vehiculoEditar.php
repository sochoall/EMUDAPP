<?php 
	include 'header.php'; 
	include 'codigophp/sesion.php';
	$menu=Sesiones("EMOV");	
	// $menu=Sesiones("EMPRESA DE TRANSPORTE"); 
    include 'vehiculo_modal_select_funcionario.php';  
?>	
	<div class="container text-align-left mt-2 ">
   	<div class="row">
       <div class="col-md-6 offset-md-2">
           <div class="card">
                 <h3 class="card-header cyan white-text text-uppercase font-weight-bold text-center" id="titulo">Vehículo</h3>
                 <div class="card-body">	

		<form>	
			<div class="row">
				<label class="col-md-3 col-form-label">Placa: <span class="text-danger">* </span></label>
				<div class="col-md-3">
					<input type='text' id= "placa" class="form-control text-uppercase form-control-sm"  maxlength="7"/>
				</div>
			</div>
			<div class=" row">
				<label class="col-md-3  col-form-label">Capacidad: <span class="text-danger">* </span></label>
				<div class="col-md-3">
					<input type='number' id= "capacidad" class="form-control form-control-sm"  maxlength="2"/>
				</div>
			</div>		
			<div class="row">
				<label class="col-md-3 col-form-label">Estado: <span class="text-danger">* </span></label>
				<div class="col-md-6">
					<SELECT id="estado" class="browser-default custom-select"> 
						<OPTION VALUE="1" selected >ACTIVO</OPTION>
						<OPTION VALUE="0">INACTIVO</OPTION>
					</SELECT> 
				</div>
			</div>	
			<div class="row align-self-center">
				<label class="col-md-3 col-form-label">Tipo de Vehículo: <span class="text-danger">* </span></label>
				<div  id="vehiculo" class="col-md-6 align-self-center "></div>
			</div><br/>						

				<h5><strong>Datos del Conductor </strong></h5>
				<div class=" row">
						<label class="col-md-3  col-form-label align-self-center">Código: <span class="text-danger">* </span></label>
						<div class="col-md-3 align-self-center">
							<input type='text' id= "idfun" class="form-control form-control-sm " />
						</div>
	<!-- BOTON MODAL.... en la cabecera importo el modal -->
						<div class="col-sm-0 align-self-center" id="buscar">
								<a class="btn grey" href="#" role="button" data-toggle="modal" data-target="#centralModalSmC"><i class="fas fa fa-search "></i></a>
							</div>	
					</div>
				<div class="row ">
					<label class="col-md-3 col-form-label  align-self-center">Nombres:</label>
					<div class="col-md-9 align-self-center">
						<input type="text" id= "chofer" class="form-control text-uppercase form-control-sm" readonly disabled />
					</div>
							
				</div>
				<div class="text-white row justify-content-center mt-3">
					<input class="btn cyan" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>		
					<input type="button" value="Cancelar" class="btn cyan" onclick="location.href = 'vehiculo.php';"/><br/>
				</div>
		</form>

	
	</div>
	</div></div></div></div>

	<script type="text/javascript">

	// CAPTURA DE PARAMETRO DE LA URL tooooodo CON JAVASCRIPT 
	let parametro = new URLSearchParams(location.search);
	var metodo = parametro.get('metodo');
	var id,tveh;
	var urlCombo=`${raizServidor}/tipoVehiculo?campo=tve_nombre&bus=&est`;	
	var divContenedor=document.querySelector('#vehiculo');
	document.getElementById('metodo').value =metodo;
	if(metodo=='Guardar'){			
		cargarCombo(urlCombo,"tipoVehiculo",divContenedor,"");	
		document.getElementById("estado").disabled=true;
	}if(metodo=='Modificar'){		
		id= parametro.get('id');
		(async () => {
			try{
				let response = await fetch(`${raizServidor}/vehiculo/${id}`);
				let data = await response.json();					
				document.getElementById('placa').value = (data.placa);
				document.getElementById('capacidad').value = (data.capacidad);				   
				tveh= (data.tve_id); 	 	
				document.getElementById('idfun').value = (data.fun_id);				
				BusFuncionario(data.fun_id);
				cargarCombo(urlCombo,"tipoVehiculo",divContenedor,tveh);		
			}catch(e){
				toastr.error('Error al Cargar algunos datos'); 	
			}
		})();
	}
	
	async function BusFuncionario(funid){	
		try{	
			let response = await fetch(`${raizServidor}/funcionario/${funid}`)
			let data = await response.json();					  	
			var nomApe=`${data.nombre} ${data.apellido}`;
			document.getElementById('chofer').value = nomApe;	
		}catch(e){
			toastr.error('No se existe funcionario'); 
			document.getElementById('chofer').value = "";	
		}
	}
	
	// $('#idfun').on('blur', function(e) { 
	// 	event.preventDefault();				
	// 	var valor=e.target.value;
	// 	BusFuncionario(valor);
	// });
	
	$('#idfun').keypress(function (e) {	
		if (e.which == 13) {
			event.preventDefault();	
			var valor=e.target.value;
			BusFuncionario(valor);
		}
	});

	function IngMod(v) {
		event.preventDefault();				
		
		if(valPlaca(placa.value)==false){
			toastr["error"]("Ingrese solo letras y números", "Caracteres incorrectos!");
				placa.style.borderColor="red";
		}else{
			placa.style.borderColor='green';				
			if(valNumeros(capacidad.value)==false){
				toastr["error"]("Ingrese solo números", "Capacidad incorrecta!");
				capacidad.style.borderColor="red";				
			}else{				 
				capacidad.style.borderColor='green';	
				if(tipoVehiculo.value==-1){
					toastr["error"]("Ingrese un tipo de Vehiculo");
					tipoVehiculo.style.borderColor="red";		
				}else{
					tipoVehiculo.style.borderColor="green";
					if((idfun.value=="")||(chofer.value=="") ){
						toastr["error"]("Seleccione un Conductor", "Dato Incorrecto!");
						idfun.style.borderColor="red";
						chofer.style.borderColor="red";
					}else{
						idfun.style.borderColor='green';
						chofer.style.borderColor="green";	
						var parametros={'id':0,'placa':placa.value.toUpperCase(),'capacidad':capacidad.value,'estado':estado.value,'tve_id':tipoVehiculo.value,'fun_id':idfun.value};	
						var urlVe=`${raizServidor}/vehiculo`;					
						if(v.value=="Guardar")	
							Ingresar(parametros,urlVe);
						if(v.value=="Modificar"){
							let redirigir="vehiculo.php";
							Modificar(parametros,`${urlVe}/${id}`,redirigir);
						}
					}
				}
		 	}
		}		
	}
		
	</script>
  
	<?php include "footer.php" ?>

