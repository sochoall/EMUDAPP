function validar()
{
	var id = document.getElementById("txtuser").value;
	var con= document.getElementById("txtpass").value;
	let url= `http://localhost:8888/login/`+id+`*`+con;

	const api = new XMLHttpRequest();
	api.open('GET',url,true);
	api.send();

	api.onreadystatechange = function()
	{
		if(this.status == 200 && this.readyState == 4 )
		{
			if(this.responseText != '0')
			{
				//alert(this.responseText);
				let urls= `http://localhost:8888/rol?op=`+this.responseText;
				const rol = new XMLHttpRequest();
				rol.open('GET',urls,true);
				rol.send();
				rol.onreadystatechange = function()
				{
					if(this.status == 200 && this.readyState == 4 )
					{
						let datos= JSON.parse(this.responseText);
						if(datos.length == 1)
						{
							location.href='menu?id='+datos[0].id+'&rol='+datos[0].nombre;//envia a la pantalla principal luego del ingreso
							console.log(datos[0].nombre);
						}
						else{
							console.log("usuario con mas roles");
						}
						
					}
				}
			}
		}
	}
}



function cargarOpciones(id)
{
	var lista=``;
	let url= `http://localhost:8888/opcion/`+id;

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
				
				lista=`
				<div class="contenedor-menu">
					<div class="btn-menu text-white" href="">Menu<i class="icono fas fa-bars"></i></div>
					<ul class="menuprincipal">`;
				for(i=0;i<datos.length;i++)
				{
					if(datos[i].url == "null")
					{
						lista+="<li><a href='' >"+datos[i].nombre+"<i class='icono derecha fas fa-angle-down'></i></a>";
					}
					else
					{
						lista+="<li><a href='"+datos[i].url+"'>"+datos[i].nombre+"</a>";
					}
					

					if(datos[i].hijo != null)
					{
						let dat=JSON.parse(datos[i].hijo);
						lista+=`<ul>`;
						for(j=0;j<dat.length;j++)
						{
							
							lista+="<li><a href='"+dat[j].url+"'>"+dat[j].nombre+"</a></li>";
							
						}
						lista+=`</ul></li>`;
					}
					else{
						lista+=`</li>`;
					}
				}
				lista+=`</ul>
				</div>
				`;

				console.log(lista);
				document.getElementById("resultado").innerHTML=lista;
			}
			else{
				console.log("usuario con mas roles");
			}
			
		}
		
	}
}


function cargarRoles(){
	var lista=``;
	let url= `http://localhost:8888/rol?op=0`;

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
				
				lista=`<div class='table-responsive-md'>
							<table class='table text-center table-hover'>
								<thead class='grey white-text'>
									<tr>
									<th scope='col'>#</th>
									<th scope='col'>DESCRIPCION</th>
									<th scope='col'>ESTADO</th>
									<th></th>
									</tr>
								</thead>
								<tbody>`;
								
				for(i=0;i<datos.length;i++)
				{
					result += `<tr> 
							<td> ${datos[i].id}</td>
							<td> ${datos[i].nombre}</td>
						`;
					if(datos[i].estado===1){
						result+=`<td>INACTIVO</td>`;
					}else{
						result+=`<td>INACTIVO</td>`;
					}
				  result+=`	<td>
								<div class='col-md-4 mt-3' id='ver'>
									<a href='' class='btn grey'><i class='fas fa-eye '></i> Ver</a>
								</div>
							</td>
						</tr>`;
					

					
				}
				lista+=`</tbody>
				</table>
				`;

				console.log(lista);
				document.getElementById('resultado').innerHTML=lista;
			}
			else{
				console.log('no existen roles');
			}
			
		}
		
	}
}

