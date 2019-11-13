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