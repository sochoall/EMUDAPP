<?php include 'header.php'; ?>

 <?php
    session_start();
    if (isset($_SESSION['roles'])) {
        $roles = $_SESSION['roles'];
?>

<div class="container mt-4" id="contenido">

<div class="row ">
    <div class="col-md-4 offset-md-4 justify-content-center card text-center">
        <h3 class="card-header cyan white-text text-uppercase font-weight-bold text-center" >Elegir Rol</h3>
   

<?php

    $result='';
    for($i=0;$i<count($roles);$i++)
    {           
        $result.='<div class="btn-group-lg mt-2 text-center" >
        <a href="menu?id='.$roles[$i]["id"].'&rol='.$roles[$i]["nombre"].'" class="cyan btn "  
        style="  -webkit-border-radius: 75px;
                    -moz-border-radius: 75px;
                    border-radius: 75px;
                    color:#fff;
                    padding-top: 40px;
                    width:150px; height:150px;
                    ">';
        if($roles[$i]["id"] == 1)
            $result .='<i class="fas fa-user-cog fa-3x"></i></a>';
        else if($roles[$i]["id"] == 2)
            $result .='<i class="fas fa-bus fa-3x"></i></a>';
        else
            $result .='<i class="fas fa-user-friends fa-3x"></i></a>';
        
        $result .= '<div class=" rounded-circle text-dark text-uppercase font-weight-bold mb-3">'.$roles[$i]["nombre"].'</div>';
    }
    
    echo $result;

?>


<?php
        
    }
    else if(isset($_SESSION['rol']) && isset($_SESSION['rol']))
    {
        header('Location: ./menu');
    } 
    else 
    {
        header('Location: ./');
    } 
?>

        </div>
    </div>

</div>
       




 <?php include 'footer.php'; ?>