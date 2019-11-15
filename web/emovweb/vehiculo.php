<?php include 'header.php'; 
   include 'codigophp/sesion.php';
   $menu=Sesiones("EMOV");
?>

<div class="container-fluid grey">
		<?php 
		 echo $menu; 	
		?>
</div>


<div class="container">
    <div class="row mt-3 ">
        <div class="h3 text-left font-weight-bold">VEHÍCULO</div>
    </div>
	<div class="form-group row mt-3 align-middle">
		<div class="col-md-3">
			<label>Campo:</label>
			<select id="campo" name="campo" class="browser-default custom-select" onchange="veroferta(this.value)">
				<option value="0" selected >PLACA</option>	
			</select>
		</div>

		<div class="col-md-3">
            <label>Buscar:</label>
            <input type="text" id="textBuscar" name="textBuscar" class="form-control text-uppercase">     
        </div>	

		<div class="col-sm-2">
            <label>Estado:</label>
            <SELECT id="estBusqueda"  class="browser-default custom-select"> 
                <OPTION VALUE="2" selected >TODOS</OPTION>
                <OPTION VALUE="1">ACTIVO</OPTION>
                <OPTION VALUE="0">INACTIVO</OPTION>             
            </SELECT> 
        </div>

		<div class="col-sm-2 align-middle" id="buscar">
				<a href="" class="btn grey"><i class="fas fa fa-search "></i></a>
		</div>
	</div>

	<div class="row mt-2">
        <div class="container">
            <div class="row">
                <div class="col-md-8">                    
                    <div class='table-responsive-sm my-custom-scrollbar'>
                        <table id='dt-select' class='table-sm table table-hover text-center' cellspacing='0' width='100%'>
                            <thead class='cyan white-text'>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">PLACA</th>
                                <th scope="col">CAPACIDAD</th> 
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

<div class="cyan circulo">
        <a href="vehiculoEditar.php?metodo=Agregar" class="circulo-mas"><i class="fa fa-plus" ></i></a>
</div>	

<script type="text/javascript">		
	
		const boton=document.querySelector('#buscar');		
		const lista=document.querySelector('#lista');		
	
		function Buscar(){	
			event.preventDefault();

			var campo = document.getElementById('campo').value;			
			var textBuscar=document.getElementById('textBuscar').value;
			textBuscar=textBuscar.toUpperCase();			
			var estado=document.getElementById("estBusqueda").value;
						
			campo="veh_placa";									
			if(estado==2){
                estado="";
            }
			if(textBuscar==""){
				// textBuscar="*****";
			}
			let url=`${raizServidor}/vehiculo?campo=${campo}&bus=${textBuscar}&est=${estado}`;

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
				let result="";					
				est="";
				for(let prod of produ){						
					result +=
					`<tr> 
						<td> ${prod.id}</td>
						<td> ${prod.placa}</td>
						<td class="text-center"> ${prod.capacidad}</td>	
					`
					if(prod.estado===0){
						est="INACTIVO";
					}else{
						est="ACTIVO";
					}
					result +=
					`<td> ${est}</td>
						<td>
							<?php echo "<a href="?>vehiculoEditar.php?metodo=Modificar&id=${prod.id}
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
