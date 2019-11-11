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
		<?php echo $menu ?>
</div>


<div class="container ">
    <div class="row mt-3 ">
        <div class="h3 text-left font-weight-bold">ESTUDIANTE</div>
    </div>
    <div class="form-group row mt-3">
        <div class="col-md-3">
            <label class="align-self-center">Campo:</label>
            <select id="campo" name="campo" class="browser-default custom-select" onchange="veroferta(this.value)">
                <option value="1" selected>C&Eacute;DULA</option>
                <option value="2">NOMBRE</option>
                <option value="3">APELLIDO</option>
                <option value="4">DIRECCI&Oacute;N</option>
            </select>
        </div>

        <div class="col-md-3">
            <label for="txtuser">Buscar:</label>
            <input type="text" id="textBuscar" name="textBuscar" class="form-control">     
        </div>

        <div class="col-md-2 ">
            <label class="align-self-center">Estado:</label>
            <select id="comboactivo" name="comboactivo" class="browser-default custom-select">
                <option value="2" selected>TODOS</option>
                <option value="1">ACTIVOS</option>
                <option value="0">INACTIVOS</option>
            </select>
        </div>

        <div class="col-md-4 mt-3" id="buscar">
                <a href="" class="btn grey"><i class="fas fa fa-search "></i></a>
        </div>
    </div>

    <div class="row mt-2">
        <div class="container">
            <div class='table-responsive-md my-custom-scrollbar'>
                <table id='dt-select' class='table-sm table table-hover text-center' cellspacing='0' width='100%'>
                    <thead class='cyan white-text text-uppercase'>
                    <tr>
                    <th scope="col">Id</th>
                    <th scope="col">C&eacute;dula</th>
                    <th scope="col">Nombres y Apellidos</th>
                    <th scope="col">Direcci&oacute;n</th>
                    <th scope="col">Estado</th>
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

<script type="text/javascript">

    const boton=document.querySelector('#buscar');		
    const lista=document.querySelector('#lista');		

    
    function Buscar(){	
        event.preventDefault();

        var campo = document.getElementById('campo').value;			
        var textBuscar=document.getElementById('textBuscar').value;
        textBuscar=textBuscar.toUpperCase();			
        var estado=document.getElementById("comboactivo").value;
                    
        
        if(textBuscar=="")
        {
            textBuscar="*";
        }
        
        let url=`http://localhost:8888/estudiante?campo=${campo}&valor=${textBuscar}&estado=${estado}`;
        fetch(url)
        .then((res) => {return res.json(); })
        .then(produ => {
            if(produ.length > 0){
                lista.innerHTML='';						
                let result = ``;
                        
                for(let prod of produ){						
                    result +=
                    `<tr> 
                        <td class='boton'> ${prod.id}</td>
                        <td class='boton'> ${prod.cedula}</td>
                        <td class='boton'> ${prod.nombre}  ${prod.apellido}</td>
                        <td class='boton'> ${prod.direccion}</td>
                    `;
                    
                    if(prod.estado===1){
                        estado="INACTIVO";
                    }else{
                        estado="ACTIVO";
                    }

                    result +=`
                    <td class='boton'>${estado}</td>
                    <td><a href='estudiante?id=${prod.id}' class='fas fa-edit'>Editar</a></td></tr> `;
                            
                }

                lista.innerHTML=result;	
                
            }
            else{
                lista.innerHTML =`<div>No se encuentras coincidencias.</div>`				
            }
                return produ;				
            })		
            .catch(error => { console.log("error",error); return error; })					
    }		
        
    boton.addEventListener('click',Buscar);
</script>	

 <?php include 'footer.php'; ?>
