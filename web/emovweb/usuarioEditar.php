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


<div class="container text-left mt-5 my-5 text-uppercase">
   <div class="row">
       <div class="col-md-6 offset-md-3">
           <div class="card">
                 <h3 class="card-header cyan white-text text-uppercase font-weight-bold text-center " id="titulo">USUARIO</h3>
                 <div class="card-body">
                    <form>	
                    <div class="row">
                        <label class="col-md-4 col-form-label">C&eacute;dula: <span class="text-warning">*</span></label>
                        <div class="col-md-8">
                            <input type="text" size=10 id= "cedula" class="form-control text-upperCase form-control-sm"  maxlength="50"/>
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-md-4 col-form-label">Contrase&ntilde;a:</label>
                        <div class="col-md-8">
                            <input type='password' id= "contra" class="form-control text-upperCase form-control-sm"  maxlength="50"/>
                        </div>
                    </div>
                        
                    <div class="row">
                        <label class="col-md-4 col-form-label">Estado:</label>
                        <div class="col-md-6">
                            <SELECT id="estado"  class="browser-default custom-select"> 
                                <OPTION VALUE="1" selected >Activo</OPTION>
                                <OPTION VALUE="0">Inactivo</OPTION>
                            </SELECT> 
                        </div>
                    </div>


                    <div class="row justify-content-center text-white mt-4 mb-2">
                        <input value="Modificar" class="btn cyan" onclick="IngMod(this);" type="submit" value="" id="metodo" name="metodo"/>		
                        <input type="button" value="Cancelar" class="btn cyan" onclick="location.href = 'usuario.php';"/>
                    </div>
                        
                    </form>	
               </div>
           </div>
         </div>
   </div>
   <div class="mt-5" id="alerta"></div>
</div>

<?php
	$id=0;
    if (isset($_GET['id'])) 
    {
        $id = $_GET['id'];			
        echo "<script language='javascript'> 
        fetch('http://localhost:8888/usuario/$id')
          .then(response => response.json())
          .then(data => {		  	
              document.getElementById('cedula').value = (data['correo']);
              document.getElementById('estado').value= data['estado'];
              })
          .catch(error => toastr.error('Error al Cargar'))
        </script>";
    }
    else{
        header('Location: usuario.php');
    }
?>


<script type="text/javascript">

function IngMod(v) 
{	
    var cedula = document.getElementById('cedula');
    var contra = document.getElementById('contra');
    var estado = document.getElementById('estado').value;
    
    event.preventDefault();			

    if(validarRUC(cedula.value)==false){
            toastr.error('Cédula con caracteres incorrectos');
            cedula.style.borderColor="red";
    }
    else{
        
        var id= '<?php echo $id;?>'	;
        var parametros={'id':0,'correo':cedula.value,'password':contra.value, 'estado':estado};	
        
        var url='http://localhost:8888/usuario/'+id;
        Modificar(parametros,url,"usuario.php");
           
    }	
}
        

    
</script>


<?php include 'footer.php'; ?>