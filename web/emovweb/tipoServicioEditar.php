<?php include 'header.php'; 
    include 'codigophp/sesion.php';
    $menu=Sesiones("EMOV");

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
                                    <OPTION VALUE="1" selected >ACTIVO</OPTION>
                                    <OPTION VALUE="0">INAACTIVO</OPTION>
                                </SELECT> 
                            </div>
                        </div>
                        <div class=" mt-3 justify-content-between text-white">
                            <input value="Guardar" class="btn cyan" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>		
                            <input type="button" value="Cancelar" class="btn cyan" onclick="location.href = 'tipoServicio.php';"/>
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
	var id;	
    document.getElementById('metodo').value =metodo;
    if(metodo=='Guardar')
	    document.getElementById("estado").disabled=true;    
    if(metodo=='Modificar'){		
		id= parametro.get('id');
        fetch(`${raizServidor}/tipoServicio/${id}`)
			  .then(response => response.json())
			  .then(data => {		  	
				  document.getElementById('nombre').value = (data.nombre);				  
			  	})
			  .catch(error => toastr.error('Error al Cargar'))
    }

	function IngMod(v) {	
		var nombre = document.getElementById('nombre');		
		event.preventDefault();			

		if(valSololetras(nombre.value)==false){
			toastr["error"]("Ingrese solo letras", "Caracteres incorrectos!")
			nombre.style.borderColor="red";
		}else{
			nombre.style.borderColor='green';
			var parametros={'id':0,'nombre':nombre.value.toUpperCase(),'estado':estado.value};		
			var url=`${raizServidor}/tipoServicio`;
			if(v.value=="Guardar"){
				Ingresar(parametros,url);
			}	
			if(v.value=="Modificar"){			
				let redirigir="tipoServicio.php";
				Modificar(parametros,`${url}/${id}`,redirigir);
			}
		}	
	}		
	</script>

<?php include 'footer.php'; ?>