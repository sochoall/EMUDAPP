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
                                    <OPTION VALUE="1" selected >Activo</OPTION>
                                    <OPTION VALUE="0">Inactivo</OPTION>
                                </SELECT> 
                            </div>
                        </div>
                        <div class=" mt-3 justify-content-between text-white">
                            <input value="Guardar" class="btn cyan" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>		
                            <input type="button" value="Cancelar" class="btn cyan" onclick="location.href = 'tipoServicio.php';"/>
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
	
<?php
	$id=0;
	if (isset($_GET['metodo'])) {
		$metodo = $_GET['metodo'];
		if($metodo=='Ingresar'){			
			 echo "<script language='javascript'> 
				document.getElementById('metodo').value ='$metodo';				
			 </script>";
		}else{			
			$id = $_GET['id'];			
			echo "<script language='javascript'> 
			document.getElementById('metodo').value ='$metodo';
			fetch('http://localhost:8888/tipoServicio/$id')
			  .then(response => response.json())
			  .then(data => {		  	
				  document.getElementById('nombre').value = (data['nombre']);				  
			  	})
			  .catch(error => toastr.error('Error al Cargar'))
			</script>";
		}			
	}
?>

	<script type="text/javascript">

	function IngMod(v) {	
		var nombre = document.getElementById('nombre');		
		event.preventDefault();			

		if(valSololetras(nombre.value)==false){
			toastr["error"]("Ingrese solo letras", "Caracteres incorrectos!")
			nombre.style.borderColor="red";
		}else{
			nombre.style.borderColor='green';
			var parametros={'id':0,'nombre':nombre.value.toUpperCase(),'estado':estado.value};		
			var url="http://localhost:8888/tipoServicio";
			if(v.value=="Ingresar"){
				Ingresar(parametros,url);
			}	
			if(v.value=="Modificar"){
				let parametro = new URLSearchParams(location.search);
				let id= parametro.get('id');
				let redirigir="tipoServicio.php";
				Modificar(parametros,`${url}/${id}`,redirigir);
			}
		}	
	}	
	

		
	</script>

<?php include 'footer.php'; ?>