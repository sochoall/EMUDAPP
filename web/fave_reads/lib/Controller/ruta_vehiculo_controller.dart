import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/vehiculo.dart';

class RutaVehiculoController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerElementos(@Bind.query('id') int id) async
  {
    final servicio = Vehiculo();
    return Response.ok(await servicio.obtenerVehiculosRuta(id));
  }


}