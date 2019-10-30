import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/representante_app.dart';

class RepresentanteAppController extends ResourceController{


  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = RepresentanteApp();
    return Response.ok(await servicio.obtenerDatoId(id));
  }
  
}