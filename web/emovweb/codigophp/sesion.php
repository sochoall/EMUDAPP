<?php
    function Sesiones($rolPermitido){
        session_start();
        if (isset($_SESSION['id']) && isset($_SESSION['rol'])) {            
            if($_SESSION['rol']  == $rolPermitido ){
                
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
                return $menu;
            } else 
                header('Location: ./');
        }else 
            header('Location: ./');
    }

?>