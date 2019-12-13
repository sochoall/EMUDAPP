<?php
    function login()
    {
        session_start();
        if (isset($_POST['txtuser']) and isset($_POST['txtpass']))
        {
            $user=$_POST['txtuser'];
            $pass=$_POST['txtpass'];

            $url = 'http://localhost:8888/login/' . $user . '*' . $pass;

            $data=json_encode(@file_get_contents($url,true));

            if($data == "false")
            {
            echo "<script type='text/javascript'>
            toastr['warning']('Servico no disponible por el momento');
            </script>";
            }
            else{
                if($data != '"0"')
                {
                    $urlRol='http://localhost:8888/rol?op='.str_replace('"','',$data);
                    $data2=json_decode(file_get_contents($urlRol),true);

                    if(count($data2) == 1)
                    {
                        $userId='http://localhost:8888/usuario/'.str_replace('"','',$data);
                        $dataUser=json_decode(file_get_contents($userId),true);
                        
                        $idLogueado=0;

                        if($dataUser["repId"] != "null")
                        {
                            $idLogueado=$dataUser["repId"];
                        }
                        else if($dataUser["funId"] != "null")
                        {
                            $idLogueado=$dataUser["funId"];
                        }
                                //Aqui voy a traer los datos del funcionario
                        $funcionarioId='http://localhost:8888/funcionario/'.$idLogueado;
                        $dataFuncionario=json_decode(file_get_contents($funcionarioId),true);
                        
                        
                        $_SESSION['institutoId']=$dataFuncionario["institutoId"];
                        $_SESSION['nombreUser']=''.$dataFuncionario["nombre"].' '.$dataFuncionario["apellido"];
                        $_SESSION['id']=$data2[0]["id"];
                        $_SESSION['rol']=$data2[0]["nombre"];
                        $_SESSION['menu']=cargarMenu($data2[0]["id"]);
                        header('location: menu.php');
                    }
                    else
                    {
                        if(isset($_SESSION['id']) && isset($_SESSION['rol']))
                        {
                            header('Location: ./menu');
                        } 
                        else
                        {
                            $userId='http://localhost:8888/usuario/'.str_replace('"','',$data);
                            $dataUser=json_decode(file_get_contents($userId),true);
                            
                            $idLogueado=0;
    
                            if($dataUser["repId"] != "null")
                            {
                                $idLogueado=$dataUser["repId"];
                            }
                            else if($dataUser["funId"] != "null")
                            {
                                $idLogueado=$dataUser["funId"];
                            }
                                    //Aqui voy a traer los datos del funcionario
                            $funcionarioId='http://localhost:8888/funcionario/'.$idLogueado;
                            $dataFuncionario=json_decode(file_get_contents($funcionarioId),true);
                            
                            
                            $_SESSION['institutoId']=$dataFuncionario["institutoId"];
                            $_SESSION['nombreUser']=''.$dataFuncionario["nombre"].' '.$dataFuncionario["apellido"];
                            $_SESSION['roles']=$data2;
                            header('location: elegirRol.php');
                        }
                        
                    }
                }
                else{
                    echo "<script type='text/javascript'>
                    toastr.error('Usuario y/o Contraseña Incorrectos!.');
                    document.getElementById('errorSesion').style.display = 'block';
                    </script>";
                }
            }
            
        }
        else{
        /*echo "<script type='text/javascript'>
        toastr.error('Necesario Llenar Todos Los Campos!.');
        </script>";*/
        }
    }

    /*function cargarMenu1($id) 
    {
        $lista="";
        $url= "http://localhost:8888/opcion/" . $id;
        $datos=json_decode(@file_get_contents($url),true);
        if($datos != "false")
        {
            $lista='<nav class="navbar navbar-expand-lg navbar-dark grey">
        
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-333"
              aria-controls="navbarSupportedContent-333" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
      
            <div class="collapse navbar-collapse" id="navbarSupportedContent-333">
              <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="menu">Inicio
                        <span class="sr-only">(current)</span>
                    </a>
                </li>';

            for($i=0;$i<count($datos);$i++)
            {
                if($datos[$i]['url'] == "null")
                {   
                    $lista.=' <li class="nav-item dropdown ">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown"
                      aria-haspopup="true" aria-expanded="false">'.$datos[$i]['nombre'].'</a>
                    <div class="dropdown-menu dropdown-primary bg-light bg-transparent" aria-labelledby="navbarDropdownMenuLink-333">';
                }
                else
                {
                    $lista.=' <li class="nav-item "><a class="nav-link" href="'.$datos[$i]['url'].'">'.$datos[$i]['nombre'].'</a>';
                }
                

                if($datos[$i]['hijo'] != null)
                {
                    $dat=json_decode($datos[$i]['hijo'],true);
                    for($j=0;$j<count($dat);$j++)
                    {
                        $lista.='<a class="dropdown-item p-1" href="'.$dat[$j]['url'].'">'.$dat[$j]['nombre'].'</a>';
                        
                    }
                    $lista.='</div>
                    </li>';
                }
                else{
                    $lista.='</li>';
                }
            }
            $lista.='</ul> </div>
            </nav>';
        }
        else
        {
            echo "Servicio no disponible por el momento";
        }
        return $lista;
    }*/

    function cargarMenu($id) 
    {
        $lista="";
        $url= "http://localhost:8888/opcion/" . $id;
        $datos=json_decode(@file_get_contents($url),true);
        if($datos != "false")
        {
            $lista='<nav class="navbar navbar-expand-lg navbar-dark grey">
        
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-333"
              aria-controls="navbarSupportedContent-333" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
      
            <div class="collapse navbar-collapse" id="navbarSupportedContent-333">
              <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="menu">Inicio
                        <span class="sr-only">(current)</span>
                    </a>
                </li>';

            for($i=0;$i<count($datos);$i++)
            {
                if($datos[$i]["idpadre"]== "null")
                {
                    if($datos[$i]['url'] == "null")
                    {   
                        $lista.=' <li class="nav-item dropdown ">
                        <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">'.$datos[$i]['nombre'].'</a>
                        <div class="dropdown-menu dropdown-primary bg-light bg-transparent" aria-labelledby="navbarDropdownMenuLink-333">';
                    }
                    else
                    {
                        $lista.=' <li class="nav-item "><a class="nav-link" href="'.$datos[$i]['url'].'">'.$datos[$i]['nombre'].'</a>';
                    }

                    $cont =0;
                    for($j=0;$j<count($datos);$j++)
                    {
                        if($datos[$i]['id'] == $datos[$j]['idpadre'])
                        {
                            $lista.='<a class="dropdown-item p-1" href="'.$datos[$j]['url'].'">'.$datos[$j]['nombre'].'</a>';
                            $cont++;
                        }
                    }

                    if($cont != 0)
                    {
                        $lista.='</div>
                        </li>';
                    }
                    else{
                        $lista.='</li>';
                    }
                }
                
                
            }
            $lista.='</ul> </div>
            </nav>';

        }
        else
        {
            echo "Servicio no disponible por el momento";
        }
        return $lista;
    }

    
   function cargarRol()
   {
        $lista="";
        $url= "http://localhost:8888/rol?op=0";
        $datos=json_decode(@file_get_contents($url),true);
        if($datos != "false")
        {
            
            $lista.="";
            for($i=0;$i<count($datos);$i++)
            {
                $lista.= "<tr>
                          <td scope='row' class='boton'>" . $datos[$i]['id'] . "</td>
                          <td class='boton'>" . $datos[$i]['nombre']. "</td>";

                if($datos[$i]['estado']===1){
                    $lista.="<td class='boton'>ACTIVO</td>";
                }else{
                    $lista.="<td class='boton'>INACTIVO</td>";
                }

                $lista.="
                <td><a href='#' class='text-dark fas fa-edit activarModal'>Editar</a></td>
                </tr>";
                

                
            }
            
            $lista.='</tbody></table>';
        }
        
        else
        {
            echo "Servicio no disponible por el momento";
        }
        return $lista;
   }


?>