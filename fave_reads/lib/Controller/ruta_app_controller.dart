import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/ruta_app.dart';

class RutaAppController extends ResourceController{

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = RutaApp();
    return Response.ok(await servicio.obtenerDatoId(id));
  }
}