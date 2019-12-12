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

<script>
function obtenerValores(e) {
    var elementosTD=e.srcElement.parentElement.getElementsByTagName("td");
    let valores=`<td></td>
                <td class=" text-center"><div class="spinner-border text-center" role="status">
                <span class="sr-only">Loading...</span>
                </div></td>
                <td></td>`;
    document.getElementById('opciones').innerHTML=valores;

    cargarOpciones(elementosTD[0].innerHTML);

             
    function cargarOpciones(id)
    {
        var result=``;
        let url= `http://localhost:8888/rol?op=`+id;
    
        const api = new XMLHttpRequest();
        api.open('GET',url,true);
        api.send();
        
        api.onreadystatechange = function()
        {
            
            if(this.status == 200 && this.readyState == 4 )
            {
                let datos= JSON.parse(this.responseText);
                if(datos.length > 0)
                {
                    
                    result=``;
                    for(i=0;i<datos.length;i++)
                    {
                        result += `<tr> 
                                <td> ${datos[i].id}</td>
                                <td> ${datos[i].nombre}</td>
                            `;
                        if(datos[i].estado == 0)
                            result+=`<td>INACTIVO</td>`;
                        else
                        result+=`<td>ACTIVO</td>`;
                        
                        result+=`</tr>`;
                    }
                    
                }
                else{
                    result=`<td></td>
                    <td>No se encontraron resultados.</td>
                    <td></td>`;
                }
            
                document.getElementById("opciones").innerHTML=result;
            }
            
        }
    }	


}

</script>


<div class="container-fluid grey pr-0 pl-0">
		<?php 
		echo $menu 
		?>
</div>


<div class="container">
    <div class="row mt-3 ">
        <div class="h3 text-left font-weight-bold">USUARIO</div>
    </div>
    <div class="form-group row mt-3">
        <div class="col-md-3">
            <label class="align-self-center">Campo:</label>
            <select id="campo" name="campo" class="browser-default custom-select" onchange="veroferta(this.value)">
                <option value="1" selected>Nro. Identicaci&oacute;n</option>
                <option value="2">Funcionario</option>
                <option value="3">Representante</option>
                <option value="4">Estudiante</option>
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
                <option value="1">ACTIVO</option>
                <option value="0">INACTIVO</option>
            </select>
        </div>

        <div class="col-md-4 mt-3" id="buscar">
                <a href="" class="btn grey"><i class="fas fa fa-search "></i></a>
        </div>
    </div>

    <div class="row mt-2">
        <div class="container">
            <div class='table-responsive-md my-custom-scrollbar'>
                <table id='dt-select' class='table-sm table table-hover text-center' cellspacing='0' width='100%' style="height:100px">
                    <thead class='cyan white-text'>
                    <tr>
                    <th scope="col">ID</th>
                    <th scope="col">NRO. IDENTIFICACIÓN</th>
                    <th scope="col">FUNCIONARIO</th>
                    <th scope="col">REPRESENTANTE</th>
                    <th scope="col">ESTUDIANTE</th>
                    <th scope="col">ESTADO</th>
                    <th></th>
                    </tr>
                </thead>
                <tbody  id="lista" class="td-select" >
                    <!-- AQUI SE CARGA LA TABLA CON LOS REGISTROS -->
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="container mt-3 p-0">
	<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item">
			<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home"
			aria-selected="true">Roles</a>
		</li>
	</ul>

	<div class="tab-content" id="myTabContent">
		<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
			<div class="container-fluid p-0 mt-1">
                <div class="row">
                    <div class="col-md-6">
                        <div class='table-responsive-md'>
                            <table id='dt-select' class='table-sm table table-hover text-center' cellspacing='0' width='100%' style="height:100px;">
                                <thead class='cyan white-text'>
                                    <tr>
                                        <th scope='col'>ID</th>
                                        <th scope='col'>DESCRIPCIÓN</th>
                                        <th scope='col'>ESTADO</th>
                                    </tr>
                                </thead>
                                <tbody id="opciones" class='dt-select'>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
			</div>
			
		</div>
	</div>
</div>

    <script type="text/javascript">

        function veroferta(sel)
        {
            if(sel==2 ||sel==3 ||sel==4 )
            {
                document.getElementById('textBuscar').value="";
                document.getElementById('textBuscar').disabled=true;
                document.getElementById("buscar").focus();
            }
            else{
                document.getElementById('textBuscar').disabled=false;
                document.getElementById("textBuscar").focus();
            }
        }
	
        const boton=document.querySelector('#buscar');		
		const lista=document.querySelector('#lista');		
    
        
		function Buscar(){	
			event.preventDefault();

			var campo = document.getElementById('campo').value;			
			var textBuscar=document.getElementById('textBuscar').value;
			textBuscar=textBuscar.toUpperCase();			
			var estado=document.getElementById("comboactivo").value;
			
			let url=`http://localhost:8888/usuario?campo=${campo}&valor=${textBuscar}&estado=${estado}`;           
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
                            <td class='boton'> ${prod.correo}</td>
                        `;
                        if(prod.funId == "null")
                        {
                            fun='<i class="fas fa-times"></i>';
                        }else{
                            fun='<i class="fas fa-check"></i>';
                        }
                        if(prod.repId == "null")
                        {
                            rep='<i class="fas fa-times"></i>';
                        }else{
                            rep='<i class="fas fa-check"></i>';
                        }
                        if(prod.estId == "null")
                        {
                            est='<i class="fas fa-times"></i>';
                        }else{
                            est='<i class="fas fa-check"></i>';
                        }
                        
                        if(prod.estado==1){
                            estado="ACTIVO";
                        }else{
                            estado="INACTIVO";
                        }

                        result +=
                        `<td class='boton'> ${fun}</td>
                        <td class='boton'>${rep} </td>
                        <td class='boton'> ${est}</td>
                        <td class='boton'> ${estado}</td>
                        <td><a href='usuarioEditar?id=${prod.id} ' class='fas fa-edit'>Editar</a></td></tr> `;
                              
                    }
                    lista.innerHTML=result;	
                    let elementos=document.getElementsByClassName('boton');
                    for(let i=0;i<elementos.length;i++)
                    {
                        elementos[i].addEventListener('click',obtenerValores);
                    } 
                   
                           
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
