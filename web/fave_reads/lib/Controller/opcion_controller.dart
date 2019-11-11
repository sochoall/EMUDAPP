import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/opcion.dart';


class OpcionController extends ResourceController{

  @Operation.get('id')
  Future<Response> obtenerLista(@Bind.path('id') int id) async
  {
    final servicio = Opcion();
    return Response.ok(await servicio.obtenerPadres(id));
  }

  
}