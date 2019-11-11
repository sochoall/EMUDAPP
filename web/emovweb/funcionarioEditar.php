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
<?php
		include 'modalFuncionario.php';
?>	

<div class="container text-left mt-2 text-uppercase">
	<div class="row">
    	<div class="col-md-6 offset-md-3">
			<div class="card">
      			<h3 class="card-header cyan white-text text-uppercase font-weight-bold text-center" id="titulo"></h3>
      			<div class="card-body">
						<div class="container">
	<div class="row mt-1">
    <div class="col">
	<form>	
		<div class="row">
		<label class="col-sm-4 col-form-label" >cedula:<span style="color:red" >*</span></label>
			<div class="col-sm-5">
				<input type='text' onblur="jj()" id= "ced" class="form-control text-upperCase form-control-sm"  maxlength="10"/>
			</div>
		</div>
		<div class=" row">
			<label class="col-sm-4 col-form-label">nombre:<span style="color:red" >*</span></label>
			<div class="col-sm-8">
				<input type='text' onkeyup="this.value = this.value.toUpperCase();" id= "nom" class="form-control form-control-sm"  maxlength="100"/>
			</div>
		</div>
		<div class="row">
			<label class="col-sm-4 col-form-label">apellido:<span style="color:red" >*</span></label>
			<div class="col-sm-8">
				<input type='text' onkeyup="this.value = this.value.toUpperCase();" id= "ape" class="form-control text-upperCase form-control-sm"  maxlength="50" />
			</div>
		</div>
		<div class="row">
			<label class="col-sm-4 col-form-label" >direccion:<span style="color:red" >*</span></label>
			<div class="col-sm-8">
				<input type='text' onkeyup="this.value = this.value.toUpperCase();" id="dir"  class="form-control form-control-sm" maxlength="100" />
			</div>
		</div>
		<div class="row">
			<label class="col-sm-4 col-form-label">telefono:</label>
			<div class="col-sm-5">
				<input type='text'id= "telf" class="form-control form-control-sm" maxlength="10"/>
			</div>
		</div>	
		<div class="row">
			<label class="col-sm-4 col-form-label">celular:<span style="color:red" >*</span></label>
			<div class="col-sm-5">
				<input type='text' pattern="\d*" id= "cel" class="form-control form-control-sm" maxlength="10"/>
			</div>
		</div>	
		<div class="row">
			<label class="col-sm-4 col-form-label">correo:<span style="color:red" >*</span></label>
			<div class="col-sm-5">
				<input type='text'id= "email" class="form-control form-control-sm" maxlength="100"/>
			</div>
		</div>	
		<div class="row">
			<label class="col-sm-4 col-form-label">Estado:</label>
			<div class="col-sm-4">
				<SELECT id="est" class="browser-default custom-select"> 
					<OPTION VALUE="1" >Activo</OPTION>
					<OPTION VALUE="0">Inactivo</OPTION>
				</SELECT> 
			</div>
		</div>
		<h5 class="container text-center mt-3 text-uppercase"><strong >Datos de la Instituci&oacute;n </strong></h5>
				<div class=" row">
						<label class="col-md-4  col-form-label align-self-center">C&oacute;digo:<span style="color:red" >*</span></label>
						<div class="col-md-3 align-self-center">
							<input type='text' id= "idfun" class="form-control form-control-sm " />
						</div>
	<!-- BOTON MODAL.... en la cabecera importo el modal -->
						<div class="col-sm-0 align-self-center" id="buscar">
								<a class="btn grey" href="#" role="button" data-toggle="modal" data-target="#centralModalSm"><i class="fas fa fa-search "></i></a>
							</div>	
					</div>
					
						<div class="row ">
					<label class="col-md-4 col-form-label  align-self-center">Nombre:</label>
					<div class="col-md-8 align-self-center">
						<input type="text" id= "chofer" class="form-control text-uppercase form-control-sm" readonly disabled />
					</div>
							
				</div>
				<div class=" row justify-content-center">
						<input class="btn cyan" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>		
					<input type="button" value="Cancelar" class="btn cyan" onclick="location.href = 'funcionario.php';"/>
				</div>
		
				<div class="row justify-content-center">
				<span style="color:red" >* campos obligatorios</span>
				</div>
			
	</form>
	
	</div></div></div>

					
					
				</div>
			</div>
      	</div>
	</div>
</div>
<div class="mt-5" id="alerta"></div>	
	<?php
	$id=0;
	if (isset($_GET['metodo'])) {
		$metodo = $_GET['metodo'];
		if($metodo=='Ingresar'){
				
			
	
			 echo "<script language='javascript'> 
				document.getElementById('metodo').value ='$metodo';
				document.getElementById('titulo').innerHTML = ' Funcionario';	
				
			 </script>";
		}else{			
			$id = $_GET['id'];	
					
			echo "<script language='javascript'> 
			document.getElementById('metodo').value ='$metodo';
			document.getElementById('titulo').innerHTML = '$metodo funcionario';
			fetch('http://localhost:8888/funcionario/$id')
			  .then(response => response.json())
			  .then(data => {		  	
				    document.getElementById('ced').value = (data['cedula']);
				  document.getElementById('nom').value = (data['nombre']);
				  document.getElementById('ape').value = (data['apellido']);
				  document.getElementById('dir').value = (data['direccion']);
				  document.getElementById('telf').value = (data['telefono']);
				  document.getElementById('cel').value = (data['celular']);
				  document.getElementById('email').value = (data['correo']);
				  document.getElementById('idfun').value = (data['institutoId']);	
				  BusInstituion(data['institutoId']);
			  	})
			  .catch(error => console.log('error al cargar datos'))
			  
			</script>";
		}			
		
	}
	
	

?>


	<script type="text/javascript">

	function IngMod(v) {	
			var ced = document.getElementById('ced');
			var nom = document.getElementById('nom');
			var ape = document.getElementById('ape');
			var dir = document.getElementById('dir');
			var telf = document.getElementById('telf');
			var cel = document.getElementById('cel');
			var correo = document.getElementById('email');
			var estado = document.getElementById('est');
			var inst = document.getElementById('idfun');	
		event.preventDefault();			

		if(validarRUC(ced.value)==false){
			toastr.error('cedula incorrecta');
			document.getElementById("ced").style.borderColor="red";
		}else{
			document.getElementById("ced").style.borderColor='#ced4da';
			if(valSololetras(nom.value)==false){
				toastr.error('nombre contiene caracteres incorrectos');
				document.getElementById("nom").style.borderColor="red";
			}else{ 
				document.getElementById("nom").style.borderColor='#ced4da';
				if(valSololetras(ape.value)==false){
				toastr.error('apellido contiene caracteres incorrectos');
				document.getElementById("ape").style.borderColor="red";
			}else{ 
				document.getElementById("ape").style.borderColor='#ced4da';
			if(valTelefono(telf.value)==false){
				toastr.error('Teléfono incorrecto');
				document.getElementById("telf").style.borderColor="red";
				}else{ 
					document.getElementById("telf").style.borderColor='#ced4da';
					if(valCelular(cel.value)==false){
						toastr.error('celular incorrecto');
						document.getElementById("cel").style.borderColor="red";
					}else{ 
					document.getElementById("cel").style.borderColor='#ced4da';
												if(valCorreo(correo.value)==false){					
										toastr.error('Correo incorrecto');
										document.getElementById("email").style.borderColor="red";
									}else{
											document.getElementById("email").style.borderColor="#ced4da";
											
											
											var parametros={"id":5,"cedula":ced.value,"nombre":nom.value.toUpperCase(),"apellido":ape.value.toUpperCase(),"direccion":dir.value,"telefono":telf.value,"celular":cel.value,"correo":correo.value,"estado":estado.value,"institutoId":inst.value};		
									
													if(v.value=="Ingresar"){	
														Ingresar(parametros);
													}	
													if(v.value=="Modificar"){
														Modificar(parametros);
													}
								         }
					    }	
				}
				
			
			}
				
			
		  }
	   }
	}
		
	function Ingresar(parametros) {	
		fetch('http://localhost:8888/funcionario', {
				method: 'POST',
				body:JSON.stringify(parametros),
				headers:{
					'Content-Type': 'application/json'
				}		
			}).then(res => res.json())
			.catch(error => {				
				toastr.error('Error al Guardar');
			})
			.then(respuesta => {
				toastr.success('Guardado correctamente');	
				setTimeout("location.href='funcionario.php?metodo=Ingresar'",1000);
			})
	}
	function Modificar(parametros) {
		var id= '<?php echo $id;?>'						
		var url='http://localhost:8888/funcionario/'+id
		fetch(url, {
			method: 'PUT',
			body:JSON.stringify(parametros),
			headers:{
				'Content-Type': 'application/json'
			}				
		}).then(res => res.json())
		.catch(error => {
			toastr.error('Error al Guardar');
		})
		.then(respuesta => {
			toastr.success('Guardado correctamente');	
			setTimeout("location.href='funcionario.php'",1000);		
		});
	}

	function BusInstituion(insid){		
		fetch(`http://localhost:8888/institucion/${insid}`)
			.then(response => response.json())
			.then(data => {		  	
				var dato=`${data.nombre}`;
				document.getElementById('chofer').value = dato;										
		})  
		.catch(error => { 
			toastr.error('No  existe la institucion'); console.log(error);
			document.getElementById('chofer').value = "";	
		})	
	}
	$('#idfun').keypress(function (e) {	
		if (e.which == 13) {
			event.preventDefault();	
			var valor=e.target.value;
			BusInstituion(valor);
		}
	});	
	
	</script>

<?php include 'footer.php'; ?>