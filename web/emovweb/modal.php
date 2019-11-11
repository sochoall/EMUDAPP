<div class="modal fade" id="centralModalSm" tabindex="-1" role="dialog" aria-labelledby="tituloModal"
  aria-hidden="true">

  <!-- Change class .modal-sm to change the size of the modal -->
  <div class="modal-dialog modal-md" role="document">

    <div class="modal-content">
        <div class="modal-header text-center m-0 p-0 cyan">
            <h4 class="modal-title w-100 text-white" id="tituloModal"></h4>
            </button>
        </div>
        <div class="modal-body" id="cuerpoModal">
            <div class="row">
                <label class="col-sm-3 col-form-label">Nombre:</label>
                <div class="col-sm-9">
                    <input type='text' id= "nombreModal" class="form-control text-upperCase form-control-sm text-uppercase"  maxlength="50"/>
                </div>
            </div>
            
            <div class="row">
                <label class="col-sm-3 col-form-label">Estado:</label>
                <div class="col-sm-9">
                    <select id="estadoModal"  class="browser-default custom-select"> 
                        <OPTION VALUE="1">ACTIVO</OPTION>
                        <OPTION VALUE="0">INACTIVO</OPTION>
                    </SELECT> 
                </div>

            </div>
            
            <div class="row justify-content-center mt-3">
                <div class=""><input type="button" value="" class="btn cyan" onclick="IngresoEdicion(this)"  id="botonModal"/></div>
                <div class=""><input type="button" value="Cancelar" class="btn cyan" data-dismiss="modal"/><br/></div>
            </div> 
      </div>
    </div>
  </div>
</div>


