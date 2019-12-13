import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/check_estudiante.dart';

class CheckEstudianteController extends ResourceController
{
  @Operation.put()
  Future<Response> modificarCheckEstudiante(@Bind.body() CheckEstudiante body) async
  {
    final servicio = CheckEstudiante();
    await servicio.modificar(body);
    return Response.ok('se ha modificado');
  }
}
