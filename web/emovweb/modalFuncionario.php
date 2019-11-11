<!-- Central Modal Small -->
<div class="modal fade" id="centralModalSm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">

  <!-- Change class .modal-sm to change the size of the modal -->
  <div class="modal-dialog modal-lg" role="document">

    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title w-100" id="myModalLabel">Seleccionar Institucion</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">     
          <?php 
            include 'selec_fun.php'; 
				
          ?>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-sm grey" data-dismiss="modal">Cancelar</button>
        
      </div>
    </div>
  </div>
</div>
<!-- Central Modal Small -->