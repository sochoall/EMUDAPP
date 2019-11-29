<script>
function IngresarR(parametros) {	
		fetch('http://localhost:8888/representante', {
				method: 'POST',
				body:JSON.stringify(parametros),
				headers:{
					'Content-Type': 'application/json'
				}		
			}).then(res => res.json())
			.catch(error => {				
			//	toastr.error('Error al Guardar');
			})
			.then(respuesta => {
			//	toastr.success('Guardado correctamente');	
				//setTimeout("location.href='funcionario.php?metodo=Ingresar'",1000);
			})
	}

    function IngresarRE(parametros) {	
		fetch('http://localhost:8888/estudianteRepresentante', {
				method: 'POST',
				body:JSON.stringify(parametros),
				headers:{
					'Content-Type': 'application/json'
				}		
			}).then(res => res.json())
			.catch(error => {				
			//	toastr.error('Error al Guardar');
			})
			.then(respuesta => {
			//	toastr.success('Guardado correctamente');	
				//setTimeout("location.href='funcionario.php?metodo=Ingresar'",1000);
			})
	}
    function IngresarE(parametros) {	
		fetch('http://localhost:8888/estudiante', {
				method: 'POST',
				body:JSON.stringify(parametros),
				headers:{
					'Content-Type': 'application/json'
				}		
			}).then(res => res.json())
			.catch(error => {				
			//	toastr.error('Error al Guardar');
			})
			.then(respuesta => {
			//	toastr.success('Guardado correctamente');	
				//setTimeout("location.href='funcionario.php?metodo=Ingresar'",1000);
			})
	}

    function BusRepresentante(ced){
alert(ced);
		fetch(`http://localhost:8888/representante?campo=rep_cedula&valor=${ced}&estado=1`)
			.then(response => response.json())
			.then(data => {    
				if(data==null || data=="")
                {   
                    
                    document.getElementById('repId').value =0;
                }
                else{
                   
                var dato=`${data[0].id}`;
                
				document.getElementById('repId').value = dato;
                }
		})
		.catch(error => {
			//toastr.error('No  existe el representante'); console.log(error);
			//document.getElementById('repId').value = 0;
		})
	}

    function BusEstudiante(ced){
        
    fetch(`http://localhost:8888/estudiante?campo=est_cedula&valor=${ced}&estado=1`)
    .then(response => response.json())
    .then(data => {
        
        if(data==null)
        {   
            document.getElementById('repId').value =0;
        }
        else{
           
        var dato=`${data[0].id}`;
        document.getElementById('estId').value = dato;
        }
})
.catch(error => {
    //toastr.error('No  existe el representante'); console.log(error);
    //document.getElementById('repId').value = 0;
})
}
    </script>
    <input type='text' name='repId' id='repId' value="0">
    <input type='text' name='estId' id='estId' value="0" >
<?php
    if(isset($_POST['submit']))
    {
        $id= $_GET['id'];
        
        //Aqu� es donde seleccionamos nuestro csv
         $fname = $_FILES['sel_file']['name'];
         echo 'Cargando nombre del archivo: '.$fname.' <br>';
         $chk_ext = explode(".",$fname);

         if(strtolower(end($chk_ext)) == "csv")
         {
             //si es correcto, entonces damos permisos de lectura para subir
             $filename = $_FILES['sel_file']['tmp_name'];
             $handle = fopen($filename, "r");

             while (($data = fgetcsv($handle, 1000, ";")) !== FALSE)
             {
                if ($id=='r') {
                    echo"<script>
                    var parametros={'id':0,'cedula':'$data[0]','nombre':'$data[1]','apellido':'$data[2]','direccion':'$data[3]','telefono':'$data[4]','celular':'$data[5]','correo':'$data[6]','estado':1};		
                    IngresarR(parametros);
                    </script>";
                }
                else//($id=='e')
                {
                   
                    $inst= $_POST['inst'];
                    echo"<script>
                    var ced='$data[6]';		
                    BusRepresentante(ced);
                    setTimeout(function(){ var repId=document.getElementById('repId').value;  
                        if(repId!=0){
                        var parametros={'id':0,'cedula':'$data[0]','nombre':'$data[1]','apellido':'$data[2]','direccion':'$data[3]','telefono':'$data[4]','correo':'$data[5]','estado':1,'insId':$inst};
                        IngresarE(parametros);
                        var cedE='$data[0]';
                        BusEstudiante(cedE);
                        var rI=document.getElementById('repId').value;
                        var eI=document.getElementById('estId').value;
 
                        var parametros2={'estId':eI,repId:rI};      
                        IngresarRE(parametros2);

                       // alert(parametros2.estId);
                        //alert(parametros2.repId);

                    }//fin If
                        else{


                        }//fin else    
                        ; }, 500);
                    </script>";
                    

                   
                    
                }
               //Insertamos los datos con los valores...
               // $sql = "INSERT into TABLA(CAMPOS SEPARADOS POR COMAS) values('$data[0]','$data[1]','$data[2]','$data[3]','$data[4]',...)";
               // mysql_query($sql) or die('Error: '.mysql_error());
             }
             //cerramos la lectura del archivo "abrir archivo" con un "cerrar archivo"
             fclose($handle);
             echo "Importacion exitosa!";
         }
         else
         {
            //si aparece esto es posible que el archivo no tenga el formato adecuado, inclusive cuando es cvs, revisarlo para
//ver si esta separado por " , "
             echo "Archivo invalido!";
         }
    }

?>