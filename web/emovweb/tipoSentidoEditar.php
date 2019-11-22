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

<div class="container text-center mt-2 text-uppercase">
   <div class="row">
       <div class="col-md-6 offset-md-3">
           <div class="card">
                 <h3 class="card-header cyan white-text text-uppercase font-weight-bold text-center py-5" id="titulo"></h3>
                 <div class="card-body">
                       <!--AQUI VA EL FORMULARIO DE INGRESO Y EDICION -->
                   
                       <form>	
                            <div class="row">
                                <label class="col-md-3 col-form-label">Nombre:</label>
                                <div class="col-md-9">
                                    <input type='text' id= "nombre" class="form-control text-upperCase form-control-sm"  maxlength="50"/>
                                </div>
                            </div>
                        
                            <div class="row">
                                <label class="col-md-3 col-form-label">Estado:</label>
                                <div class="col-md-9">
                                    <SELECT id="estado"  class="browser-default custom-select"> 
                                        <OPTION VALUE="1" selected >Activo</OPTION>
                                        <OPTION VALUE="0">Inactivo</OPTION>
                                    </SELECT> 
                                </div>
                            </div>
                            <input value="Guardar" class="btn info-color" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>		
                            <input type="button" value="Cancelar" class="info-color" onclick="location.href = 'sentido.php';"/><br/>
                                
                        </form>
                        <div class="mt-5" id="alerta"></div>
               </div>
           </div>
         </div>
   </div>
</div>


<?php
	$id=0;
	if (isset($_GET['metodo'])) {
		$metodo = $_GET['metodo'];
		if($metodo=='Ingresar'){			
			 echo "<script language='javascript'> 
				document.getElementById('metodo').value ='$metodo';
				document.getElementById('titulo').innerHTML = '$metodo sentido';
			 </script>";
		}else{			
			$id = $_GET['id'];			
			echo "<script language='javascript'> 
			document.getElementById('metodo').value ='$metodo';
			document.getElementById('titulo').innerHTML = '$metodo sentido';
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

		
	</script>

<?php include 'footer.php'; ?>