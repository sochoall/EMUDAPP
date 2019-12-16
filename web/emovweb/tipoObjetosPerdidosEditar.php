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
					
					<div class="container">
	<div class="row mt-3 pt-3">
    <div class="col">

	<form>	
		<div class="row">
			<label class="col-sm-3 col-form-label">Nombre:</label>
			<div class="col-sm-9">
				<input type='text' id= "nombre" class="form-control text-upperCase form-control-sm"  maxlength="50"/>
			</div>
		</div>
	
		
		<input value="Guardar" class="btn btn-primary" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>		
		<input type="button" value="Cancelar" class="btn btn-primary" onclick="location.href = 'tipoObjetosPerdidos.php';"/><br/>
			
	</form>
	<div class="mt-9" id="alerta"></div>	
	</div></div>
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
				document.getElementById('titulo').innerHTML = '$metodo estado objetos';
			 </script>";
		}else{			
			$id = $_GET['id'];			
			echo "<script language='javascript'> 
			document.getElementById('metodo').value ='$metodo';
			document.getElementById('titulo').innerHTML = '$metodo estado objetos';
			fetch('http://localhost:8888/estadoObjetos/$id')
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
			

						var parametros={'id':0,'nombre':nombre.value.toUpperCase()};		
	
						if(v.value=="Ingresar"){	
							Ingresar(parametros);
						}	
						if(v.value=="Modificar"){
							Modificar(parametros);
						}
					}	
				}
			
	
	
		
	function Ingresar(parametros) {	
		fetch('http://localhost:8888/estadoObjetos', {
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
				setTimeout("location.href='tipoObjetosPerdidos.php?metodo=Ingresar'",1000);
			})
	}
	function Modificar(parametros) {
		var id= '<?php echo $id;?>'						
		var url='http://localhost:8888/estadoObjetos/'+id
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
			setTimeout("location.href='tipoObjetosPerdidos.php'",1000);		
		});
	}

		
	</script>

<?php include 'footer.php'; ?>