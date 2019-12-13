import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/listar_check_estudiante.dart';

class ListarCheckEstudianteController extends ResourceController
{

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async 
  {
    final servicio = ListarCheckEstudiante();
    return Response.ok(await servicio.obtenerDatoId(id));
  }
}
