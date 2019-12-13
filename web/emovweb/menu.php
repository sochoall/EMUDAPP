<?php include 'header.php'; include './codigophp/funcionesphp.php';?>

 <?php
 session_start();
 if (isset($_SESSION['id']) && isset($_SESSION['rol'])) {
	$id = $_SESSION['id'];
	$rol = $_SESSION['rol'];               
	$menu=$_SESSION['menu'];   
	$institutoId=$_SESSION['institutoId'];
	$nombreUser=$_SESSION['nombreUser'];


	echo " <script> 
	var IntitucionPrincipal=0;
			window.onload = function()
			{ 
				IntitucionPrincipal=$institutoId;
				document.getElementById('name').innerHTML='$nombreUser';
				document.getElementById('rol').innerHTML ='ROL: $rol';
				document.getElementById('btncerrar').style.display = 'block';
			};                      
			</script>" ;
 }
 else if(isset($_SESSION['roles']))  // ENTRA SOLO LA PRIMERA VEZ QUE SE ELIGE EL ROL
 {
	unset($_SESSION['roles']); // ELIMINA LA VARIABLE DE ROLES
	if (isset($_GET['id']) && isset($_GET['rol'])) 
	{
		$_SESSION['id']=$_GET['id'];
		$_SESSION['rol']=$_GET['rol']; //ASIGNA NUEVAS VARIABLES DE SESSION PARA LA SIGUIENTE ACTUALIZADA
		$_SESSION['menu']=cargarMenu($_SESSION['id']); //CARGA EL MENU PARA LA SIGUIENTE ACTUALIZADA

		$id = $_SESSION['id'];
		$rol = $_SESSION['rol'];               
		$menu=$_SESSION['menu'];   
		$institutoId=$_SESSION['institutoId'];
		$nombreUser=$_SESSION['nombreUser'];


		echo " <script> 
		var IntitucionPrincipal=0;
				window.onload = function()
				{ 
					IntitucionPrincipal=$institutoId;
					document.getElementById('name').innerHTML='$nombreUser';
					document.getElementById('rol').innerHTML ='ROL: $rol';
					document.getElementById('btncerrar').style.display = 'block';
				};                      
				</script>" ;
	  }
	  else{
		header('Location: ./');
	  }
 } 
 else {
	 header('Location: ./');
 } 
?>

<div class="container-fluid grey">
		<?php echo $menu ?>
</div>
	

 <?php include 'footer.php'; ?>
