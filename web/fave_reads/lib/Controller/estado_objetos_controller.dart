import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/estado_objetos.dart';

class EstadoObjetosController extends ResourceController {
  @Operation.get()
  Future<Response> obtenerLista(
      @Bind.query('campo') String campo, @Bind.query('bus') String bus) async {
    final servicio = EstadoObjetos();
    return Response.ok(await servicio.obtenerDatos(campo, bus));
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async {
    final servicio = EstadoObjetos();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearEstadoObjetos(@Bind.body() EstadoObjetos body) async {
    final servicio = EstadoObjetos();
    await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarEstadoObjetos(
      @Bind.path('id') int id, @Bind.body() EstadoObjetos body) async {
    final servicio = EstadoObjetos();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarEstadoObjetos(@Bind.path('id') int id) async {
    final servicio = EstadoObjetos();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
}
