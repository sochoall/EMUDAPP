<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>Material Design Bootstrap</title>
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.0.2/dist/leaflet.css" />
  <link rel="stylesheet" href="leaflet-routing-machine-3.2.12/dist/leaflet-routing-machine.css" /> 
  <link href="https://fonts.googleapis.com/css?family=Roboto+Slab&display=swap" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <!-- Bootstrap core CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <!-- Material Design Bootstrap -->
  <link href="css/mdb.min.css" rel="stylesheet">
  <!-- Your custom styles (optional) -->
  <link href="css/style.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
  <link href="css/addons/datatables.min.css" rel="stylesheet">
  <!-- DataTables JS -->
  <script href="js/addons/datatables.min.js" rel="stylesheet"></script>

  <!-- DataTables Select CSS -->
  <link href="css/addons/datatables-select.min.css" rel="stylesheet">
  <!-- DataTables Select JS -->
  <script href="js/addons/datatables-select.min.js" rel="stylesheet"></script>
  <script type="text/javascript" src="js/validaciones.js"></script>
  <script type="text/javascript" src="js/FuncionIM.js"></script>

</head>
<body >

<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<header class="sticky-top container-fluid cyan">
  <div class="row text-center text-white ">
    <div class="col-md-3">
      <img src="img/emovlogo.png" style="width:50%;" class="" alt="Logo EMOV EP">
    </div>

    <div class="col-md-6 h4-responsive mt-3 tittle font-weight-bold">SISTEMA DE MONITOREO DE TRANSPORTE ESCOLAR
    </div>
    
    <div class="col-sm-3 h6 mt-3">

      <div class="font-weight-bold "> 
          <div id="name"></div>
          <div id="rol"></div>
      </div>

      <div class="" id="btncerrar">
        <a class="col-md-12 text-white font-weight-bold text-center " href="./codigophp/cerrarSesion.php"><i class="fas fa-sign-out-alt pr-2" aria-hidden="true"></i> SALIR</a>
      </div>
    </div>

  </div>
</header>
<!--Navbar -->

<!--/.Navbar -->