import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/check_estudiante.dart';

class CheckEstudianteController extends ResourceController {
  @Operation.get()
  Future<Response> obtenerLista() async {
    final servicio = CheckEstudiante();
    return Response.ok(await servicio.obtenerDatos());
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async {
    final servicio = CheckEstudiante();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearCheckEstudiante(@Bind.body() CheckEstudiante body )async
  {
     final servicio = CheckEstudiante();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

/*
  @Operation.put('id')
  Future<Response> modificarCheckEstudiante(@Bind.path('id') int id,@Bind.body() CheckEstudiante body) async
  {
    final servicio = CheckEstudiante();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarInstitucion(@Bind.path('id') int id) async
  {
    final servicio = CheckEstudiante();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
 */
}
