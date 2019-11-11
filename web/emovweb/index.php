
<?php include 'header.php';  include './codigophp/funcionesphp.php'; ?>


<section class="container pt-5">
  <div class="row justify-content-center ">
    <div class="col-md-6">
      <form method="POST">
            <div class="card rounded-bottom">
              <div class="card-body">
                <p class="h4 mb-4 text-center">Iniciar Sesi&oacute;n</p>
                <div class="md-form">
                  <i class="far fa-address-card prefix grey-text pr-2" aria-hidden="true"></i>
                  <input type="text" id="txtuser" name="txtuser" class="form-control" required>
                  <label for="txtuser">Nro. Identificaci&oacute;n</label>
                </div>
                <div class="md-form">
                  <i class="fas fa-key prefix grey-text pr-2"></i>
                  <input type="password" name="txtpass" id="txtpass" class="form-control" required>
                  <label for="fas txtpass">Contrase&ntilde;a</label>
                </div>
                <div class="text-center">
                  <button type="submit" class="btn cyan text-white"><i class="fas fa-sign-in-alt pr-2" aria-hidden="true"></i>Iniciar Sesi&oacute;n</button>
                </div>
              </div>
            </div> 
      </form>
    </div>
    
  </div>

</section>


<script>
  document.getElementById('btncerrar').style.display = 'none';
</script>


<?php login();?>

<?php include 'footer.php'; ?>