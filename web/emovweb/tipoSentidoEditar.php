<?php include 'header.php'; 
	 include 'codigophp/sesion.php';
	 $menu=Sesiones("EMOV");
?>


<div class="container text-center mt-2 ">
   <div class="row">
       <div class="col-md-6 offset-md-3">
           <div class="card">
				<h3 class="card-header cyan white-text text-uppercase font-weight-bold text-center" id="titulo">TIPO DE SERVICIO</h3>
				<div class="card-body">
                       <!--AQUI VA EL FORMULARIO DE INGRESO Y EDICION -->

   					<form>	
                        <div class="row">
                            <label class="col-md-3 col-form-label">Nombre: <span class="text-danger">* </span></label>
                            <div class="col-md-9">
                                <input type='text' id= "nombre" class="form-control text-uppercase form-control-sm"  maxlength="50"/>
                            </div>
                        </div>

						<div class="row">
                            <label class="col-md-3 col-form-label">Estado: <span class="text-danger">* </span></label>
                            <div class="col-md-9">
                                <SELECT id="estado"  class="browser-default custom-select"> 
                                    <OPTION VALUE="1" selected >ACTIVO</OPTION>
                                    <OPTION VALUE="0">INAACTIVO</OPTION>
                                </SELECT> 
                            </div>
                        </div>

						<div class=" mt-3 justify-content-between text-white">
                            <input value="Guardar" class="btn cyan" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>		
                            <input type="button" value="Cancelar" class="btn cyan" onclick="location.href = 'TipoSentido.php';"/>
                        </div>  
                          
					</form>
               </div>
           </div>
         </div>
   </div>
</div>


<?php
	$id=0;
	if (isset($_GET['metodo'])) {
		$metodo = $_GET['metodo'];
		if($metodo=='Agregar'){			
			 echo "<script language='javascript'> 
				document.getElementById('metodo').value ='$metodo';
				document.getElementById('titulo').innerHTML = 'tipos de sentido';
			 </script>";
		}else{			
			$id = $_GET['id'];			
			echo "<script language='javascript'> 
			document.getElementById('metodo').value ='$metodo';
			document.getElementById('titulo').innerHTML = 'tipos de sentido';
			fetch('http://localhost:8888/sentido/$id')
			  .then(response => response.json())
			  .then(data => {		  	
				  document.getElementById('nombre').value = (data['nombre']);
			  	})
			  .catch(error => console.log('error al cargar datos'))
			</script>";
		}			
	}
?>


	<script type="text/javascript">

	function IngMod(v) {	
		var nombre = document.getElementById('nombre');
		var estado = document.getElementById('estado');
		
		event.preventDefault();			

		if(valSololetras(nombre.value)==false){
				toastr.error('Nombre con caracteres incorrecto');
				nombre.style.borderColor="red";
		}else{
<<<<<<< HEAD
			

						var parametros={'id':0,'nombre':nombre.value.toUpperCase(),'estado':estado.value};		
	
						if(v.value=="Ingresar"){	
							Ingresar(parametros);
						}	
						if(v.value=="Modificar"){
                            // alert(parametros.estado);
							Modificar(parametros);
						}
					}	
				}
			
	
	
		
	function Ingresar(parametros) {	
		fetch('http://localhost:8888/sentido', {
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
				setTimeout("location.href='sentido.php?metodo=Ingresar'",1000);
			})
	}
	function Modificar(parametros) {
		var id= '<?php echo $id;?>'						
		var url='http://localhost:8888/sentido/'+id;
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
			setTimeout("location.href='sentido.php'",1000);		
		});
	}

		
=======
			var parametros={'id':0,'nombre':nombre.value.toUpperCase(),'estado':estado.value};		
			var url="http://localhost:8888/sentido";
			if(v.value=="Agregar"){	
				Ingresar(parametros,url);
			}	
			if(v.value=="Modificar"){
				let para = new URLSearchParams(location.search);				
				var id=para.get('id');
				let redirigir="tipoSentido.php";
				Modificar(parametros,`${url}/${id}`,redirigir);
			}
		}	
	}
>>>>>>> a8160bd0c4a95052b225ba06791831f51f1253ec
	</script>

<?php include 'footer.php'; ?>