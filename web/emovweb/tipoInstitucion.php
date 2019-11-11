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

<div class="container-fluid grey">
		<?php 
        echo $menu 
        ?>
</div>

<div class="container">
    <div class="row mt-3 ">
        <div class="h3 text-left font-weight-bold">TIPO DE INSTITUCIÓN</div>
    </div>
    <div class="form-group row mt-3">
        <div class="col-md-3">
            <label class="align-self-center">Campo:</label>
            <select id="campo" class="browser-default custom-select">
                <option VALUE="0" selected>NOMBRE</option>	
            </select>
        </div>

        <div class="col-md-3">
            <label for="txtuser">Buscar:</label>
            <input type="text" id="textBuscar" name="textBuscar" class="form-control text-uppercase">     
        </div>

       <div class="col-sm-2 align-self-center">
            <label>Estado:</label>
            <SELECT id="estBusqueda"  class="browser-default custom-select"> 
                <OPTION VALUE="2" selected >TODOS</OPTION>
                <OPTION VALUE="1">ACTIVO</OPTION>
                <OPTION VALUE="0">INACTIVO</OPTION>        
            </SELECT> 
        </div>

        <div class="col-md-4 mt-3" id="buscar">
                <a href="" class="btn grey"><i class="fas fa fa-search "></i></a>
        </div>
    </div>

     <div class="row mt-2">
         <div class="container">
            <div class="row">
                <div class="col-md-6">
                    
                    <div class='table-responsive-sm my-custom-scrollbar'>
                        <table id='dt-select' class='table-sm table table-hover text-center' cellspacing='0' width='100%'>
                            <thead class='cyan white-text'>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">NOMBRE</th>
                                <th scope="col">ESTADO</th>     
                                <th></th>
                            </tr>
                        </thead>
                        <tbody  id="lista" >
                            <!-- AQUI SE CARGA LA TABLA CON LOS REGISTROS -->
                        </tbody>
                        </table>
                    </div>
                </div>
            </div>                
        </div>
    </div>
</div>

     <div class="position-fixed btn-group-lg" style="bottom:20px; right:80px; width:120px; height:80px;">
			<a href="tipoInstitucionEditar.php?metodo=Ingresar" class="cyan btn "  
			style="  -webkit-border-radius: 50px;
  					-moz-border-radius: 50px;
					  border-radius: 50px;
					  color:#fff;
					  padding-top: 20px;
					  width:70px; height:70px;
					  ">
			
			<i class="fa fa-plus" ></i></a>
		</div>

<script type="text/javascript">		
	
    const boton=document.querySelector('#buscar');		
    const lista=document.querySelector('#lista');		

    function Buscar(){	
        event.preventDefault();

        var campo = "tin_nombre";			
        var textBuscar=document.getElementById('textBuscar').value;
        textBuscar=textBuscar.toUpperCase();			
        var estado=document.getElementById("estBusqueda").value;
                
        if(estado==2){
                estado="";
            }
        if(textBuscar==""){
            // textBuscar="*****";
        }
        let url=`http://localhost:8888/tipoInstitucion?campo=${campo}&bus=${textBuscar}&est=${estado}`;

        lista.innerHTML=`
        <div class="text-center">
        <div class="spinner-border text-info" role="status">
            <span class="sr-only">Loading...</span>
        </div>
        </div>				
            `;	
        fetch(url)
         .then((res) => {return res.json(); })
        .then(produ => {
            let result = "";					
            est="";
            for(let prod of produ){						
                result +=
                `<tr> 
                    <td> ${prod.id}</td>
                    <td> ${prod.nombre}</td>
                `;
                if(prod.estado===0){
                    est="INACTIVO";
                }else{
                    est="ACTIVO";
                }
                result +=
                `<td> ${est}</td>
                <td>
                    <?php echo "<a href="?>tipoInstitucionEditar.php?metodo=Modificar&id=${prod.id}
                    <?php echo "class='fas fa-edit'>Editar</a>" ?>
                </td>
                </tr>`;								
            }
            result += `</table> `;
            lista.innerHTML=result;							
                return produ;				
            })		
            .catch(error => { lista.innerHTML =`<div>No se encuentras coincidencias</div>`;	 console.log("error",error); return error; })		
    }		
        
    boton.addEventListener('click',Buscar);
</script>	

<?php include 'footer.php'; ?>