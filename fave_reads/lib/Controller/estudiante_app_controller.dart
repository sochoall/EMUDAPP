import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/estudiante_app.dart';

class EstudianteAppController extends ResourceController{

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = EstudianteApp();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

}