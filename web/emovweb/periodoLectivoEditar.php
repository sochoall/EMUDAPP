<?php include 'header.php'; 
  include 'codigophp/sesion.php';
	$menu=Sesiones("EMOV");
?>

 <div class="modal fade" id="modalConfirmar" tabindex="-1" role="dialog" aria-labelledby="tittle"
  aria-hidden="true">

  <!-- Change class .modal-sm to change the size of the modal -->
  <div class="modal-dialog modal-md" role="document">

    <div class="modal-content">
        <div class="modal-header text-center m-0 p-0 warning-color">
            <h4 class="modal-title w-100 text-white text-center" id="title">CONFIRMAR</h4>
            </button>
        </div>
        <div class="modal-body" id="cuerpoModal">
		      	<label class="col-form-label text-center">Se modificarán los restantes periodos lectivos a estado INACTIVO.!</label>
            <div class="row justify-content-center mt-3">
                <div class=""><input value="" class="btn grey" onclick="IngMod(this)" type="submit" value="" id="confirmar" name="confirmar"/>	</div>
                <div class=""><input type="button" value="Cancelar" class="btn grey" data-dismiss="modal"/><br/></div>
            </div> 
        </div>
    </div>
  </div>
</div>


<div class="container text-center mt-2">
   <div class="row">
       <div class="col-md-6 offset-md-3">
           <div class="card">
                 <h3 class="card-header cyan white-text text-uppercase font-weight-bold text-center" id="titulo">Periodo Lectivo</h3>
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
                                    <OPTION VALUE="1">ACTIVO</OPTION>
                                    <OPTION VALUE="0">INACTIVO</OPTION>
                                </SELECT> 
                            </div>
                        </div>
                        <div class=" mt-3 justify-content-between text-white">
                          <!-- <input value="Guardar" class="btn cyan" onclick="IngMod(this)" type="submit" value="" id="metodo" name="metodo"/>	 -->
                          
                          <input value="" class="btn cyan" id="metodo"  type="button" data-toggle="modal" data-target="#modalConfirmar"/>	                          
                          <input type="button" value="Cancelar" class="btn cyan" onclick="location.href = 'periodoLectivo.php';"/>
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
  document.getElementById('confirmar').value=metodo;
 
  if(metodo=='Guardar')
	    document.getElementById("estado").disabled=true;
  if(metodo=='Modificar'){   
    id= parametro.get('id');
      (async () => {
      try{
        let response = await fetch(`${raizServidor}/periodo/${id}`);
        let data = await response.json();         
        document.getElementById('nombre').value = (data.nombre);  
        var est = data.estado;           
        $("#estado").val(est);
      }catch(e){
          toastr.error('Error al Cargar algunos datos');  
      }
    })();
  }

	function IngMod(v) {		
		event.preventDefault();			
    
		if((nombre.value)==""){
			toastr["error"]("Ingrese algún valor", "Campo incorrecto!")
			nombre.style.borderColor="red";
		}else{
			nombre.style.borderColor='green';
			var parametros={'id':0,'nombre':nombre.value.toUpperCase(),'estado':estado.value};		
			var url=`${raizServidor}/periodo`;
			if(v.value=="Guardar"){
        modEstado(url);
				Ingresar(parametros,url);
			}	
			if(v.value=="Modificar"){				
        let redirigir="periodoLectivo.php";
        modEstado(url);
				Modificar(parametros,`${url}/${id}`,redirigir);
			}
		}	
  }
 
  async function modEstado(url){      
      try{
        let response = await fetch(`${raizServidor}/periodo?campo=ple_nombre&bus=&est`);
        let data = await response.json();
        for(let pro of data){ 
          if(pro.estado==1){  
                           
               let parametros={'id':0,'nombre':pro.nombre,'estado':0};                      
               let response = await fetch(`${url}/${pro.id}`, {
                  method: 'PUT',
                  body:JSON.stringify(parametros),
                  headers:{'Content-Type': 'application/json'}        
              }) 
           }
        }              
      }catch(e){
          toastr.error('Error al procesar algunos datos');  
      }  
  }
	</script>

<?php include 'footer.php'; ?>