<?php
    function Sesiones($rolPermitido){
        session_start();
        if (isset($_SESSION['id']) && isset($_SESSION['rol'])) {            
            if($_SESSION['rol']  == $rolPermitido ){
                
                $id = $_SESSION['id'];
                $rol = $_SESSION['rol'];
                $menu=$_SESSION['menu'];                
                echo " <script>                    
                        window.onload = function()
                        {                      
                            document.getElementById('rol').innerHTML ='ROL: $rol';
                            document.getElementById('btncerrar').style.display = 'block';
                        };                      
                        </script>";
                return $menu;
            } else 
                header('Location: ./');
        }else 
            header('Location: ./');
    }

?>