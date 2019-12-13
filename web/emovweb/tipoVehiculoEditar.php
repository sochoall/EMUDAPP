<?php include 'header.php'; 
	include 'codigophp/sesion.php';
	$menu=Sesiones("EMOV");
 ?>


<div class="container text-center mt-2">
   <div class="row">
       <div class="col-md-6 offset-md-3">
           <div class="card">
                <h3 class="card-header cyan white-text text-uppercase font-weight-bold text-center" id="titulo">TIPO DE VEHÍCULOS</h3>
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
                                        <OPTION VALUE="0">INACTIVO</OPTION>
                                    </SELECT> 
                                </div>
                            </div>
                            <div class=" mt-3 justify-content-between text-white">
                                <input value="Guardar" class="btn cyan" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>		
                                <input type="button" value="Cancelar" class="btn cyan" onclick="location.href = 'tipoVehiculo.php';"/>
                            </div>
                                
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
		if($metodo=='Guardar'){			
			 echo "<script language='javascript'> 
				document.getElementById('metodo').value ='$metodo';
				document.getElementById('titulo').innerHTML = 'tipo de vehículo';
			 </script>";
		}else{			
			$id = $_GET['id'];			
			echo "<script language='javascript'> 
			document.getElementById('metodo').value ='$metodo';
			document.getElementById('titulo').innerHTML = 'tipo de vehículo';
			fetch('http://localhost:8888/tipoVehiculo/$id')
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
			var url="http://localhost:8888/tipoVehiculo";

			if(v.value=="Guardar"){	
				Ingresar(parametros,url);
			}	
			if(v.value=="Modificar"){
				let para = new URLSearchParams(location.search);				
				var id=para.get('id');
				let redirigir="tipoVehiculo.php";
				Modificar(parametros,`${url}/${id}`,redirigir);
			}
		}	
	}
	</script>

<?php include 'footer.php'; ?>