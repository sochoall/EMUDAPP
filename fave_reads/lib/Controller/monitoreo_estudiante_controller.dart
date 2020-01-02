import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/monitoreo_estudiante.dart';

class Monitoreo_Estudiante_Controller extends ResourceController
{
  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = Monitoreo_Estudiante();
    return Response.ok(await servicio.obtenerDatoId(id));
  }
}