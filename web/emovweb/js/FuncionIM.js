async function Ingresar(parametros,url) {	 
     
    try{	
        let response = await fetch(url, {
                method: 'POST',
                body:JSON.stringify(parametros),
                headers:{'Content-Type': 'application/json'}
            });
            alert("hola");  	
        let data = await response.json();	
        console.log(data);
        toastr.success('Guardado correctamente');
        setTimeout("window.location.reload()",1000);
        
    }catch(e){
        toastr.error('Error al Guardar la información');			
    }
}

async function Modificar(parametros,url,redirigir){
    try{      
        let response = await  fetch(url, {
                method: 'PUT',
                body:JSON.stringify(parametros),
                headers:{'Content-Type': 'application/json'}				
            })
        let data = await response.json();
        toastr.success('Guardado correctamente');	
        setTimeout(function(){location.href=redirigir}, 1000);	
      
    }catch(e){
        toastr.error('Error al modificar la información');			
    }
}