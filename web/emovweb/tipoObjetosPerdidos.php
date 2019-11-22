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

<div class="container-fluid grey pr-0 pl-0">
		<?php 
		echo $menu 
		?>
</div>



<div class="container">
	<div class="row mt-3 pt-3">
    <div class="col">
		<div class="row">
			<div class="h3 text-left font-weight-bold">TIPO OBJETOS PERDIDOS</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-0 col-form-label align-self-center">Campo:</label>
			<div class="col-sm-2 align-self-center">
				<SELECT id="campo"  class="browser-default custom-select"> 
					<OPTION VALUE="eob_nombre" selected >Nombre</OPTION>				
				</SELECT> 
			</div>
			<label class="col-sm-0 col-form-label align-self-center">Buscar:</label>
			<div class="col-sm-4 align-self-center">
				<input type="text" id="textBuscar" class="form-control ">
			</div>	
				

		

			<div class="col-sm-0 align-self-center" id="buscar">
				<a href="" class="btn grey"><i class="fas fa fa-search "></i></a>
			</div>		
		</div>
		<ul id="resBusqueda"></ul>
		<div style="text-align:center;"id="lista"></div>
		
		
	</div>
	</div>
		
</div>
		<div class="position-fixed btn-group-lg" style="bottom:20px; right:80px; width:120px; height:80px;">
			<a href="tipoObjetosPerdidosEditar.php?metodo=Ingresar" class="cyan btn "  
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

			var campo = document.getElementById('campo').value;			
			var textBuscar=document.getElementById('textBuscar').value;
			textBuscar=textBuscar.toUpperCase();			
			//var estado=document.getElementById("defaultUnchecked").checked;
		
			if(textBuscar==""){
				//textBuscar="*****";
			}
			let url=`http://localhost:8888/estadoObjetos?campo=${campo}&bus=${textBuscar}`;

			fetch(url)
		 	.then((res) => {return res.json(); })
			.then(produ => {				
				
				lista.innerHTML='';				
				let result = `
				<table class="table table-sm table-striped w-auto">	
				<thead class=" cyan">				
					<tr>
						<th>#</th>
						<th>Nombre</th>			
						  
						<th></th>                  
					</tr>
				<thead>`;					
				est="";
				for(let prod of produ){						
					result +=
					`<tr> 
						<td> ${prod.id}</td>
						<td> ${prod.nombre}</td>
						<td>
							<?php echo "<a href="?>tipoObjetosPerdidosEditar.php?metodo=Modificar&id=${prod.id}
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