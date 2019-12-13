import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/opcion.dart';


class OpcionController extends ResourceController{

  @Operation.get()
  Future<Response> obtenerLista() async
  {
    final servicio = Opcion();
    return Response.ok(await servicio.obtenerDatos());
  }
  
}