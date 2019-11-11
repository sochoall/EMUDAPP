import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/Estudiante.dart';

class EstudianteController extends ResourceController{


  @Operation.get()
  Future<Response> obtenerLista(@Bind.query('campo') String id,@Bind.query('valor') String valor,@Bind.query('estado') String estado) async
  {
    final servicio = Estudiante();
    return Response.ok(await servicio.obtenerDatos(id,valor,estado));
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = Estudiante();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearEstudiante(@Bind.body() Estudiante body )async
  {
     final servicio = Estudiante();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarEstudiante(@Bind.path('id') int id,@Bind.body() Estudiante body) async
  {
    final servicio = Estudiante();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarInstitucion(@Bind.path('id') int id) async
  {
    final servicio = Estudiante();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
  
}