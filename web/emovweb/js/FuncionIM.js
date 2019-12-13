var raizServidor = "http://localhost:8888";

async function cargarCombo(
  url,
  nombreCombo,
  divContenedor,
  SeleccionarElemento
) {
  divContenedor.innerHTML = `<div class='text-center'><div class='spinner-border text-info' role='status'><span class='sr-only'>Loading...</span></div></div>`;
  var result = `<select id='${nombreCombo}' class='browser-default custom-select'>`;
  try {
    let response = await fetch(url);
    let data = await response.json();
    result += '<option value="-1" selected>ELIJA UNA OPCIÓN</option>';
    for (let pro of data) {
      if (SeleccionarElemento == pro.id)
        result +=
          "<OPTION VALUE=" + pro.id + " selected>" + pro.nombre + "</OPTION>";
      else result += "<OPTION VALUE=" + pro.id + ">" + pro.nombre + "</OPTION>";
    }
    result += "</SELECT>";
    divContenedor.innerHTML = result;
  } catch (e) {
    result +=
      '<option value="-1" selected>No existe elementos</option> </SELECT>';
    divContenedor.innerHTML = result;
  }
}

async function Ingresar(parametros, url) {
  try {
    let response = await fetch(url, {
      method: "POST",
      body: JSON.stringify(parametros),
      headers: { "Content-Type": "application/json" }
    });
    let data = await response.json();
    toastr.success("Guardado correctamente");
    // setTimeout("window.location.reload()", 1000);
  } catch (e) {
    toastr.error("Error al Guardar la información");
  }
}

async function Modificar(parametros, url, redirigir) {
  try {
    let response = await fetch(url, {
      method: "PUT",
      body: JSON.stringify(parametros),
      headers: { "Content-Type": "application/json" }
    });
    let data = await response.json();
    toastr.success("Guardado correctamente");
    // setTimeout(function() {
    //   location.href = redirigir;
    // }, 1000);
  } catch (e) {
    toastr.error(`Error al modificar la información`);
  }
}
