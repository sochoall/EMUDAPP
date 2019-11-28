import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/ruta.dart';

class RutaController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerLista(@Bind.query('opcion') int opcion,@Bind.query('id') int id) async
  {
    final servicio = Ruta();
    return Response.ok(await servicio.obtenerDatos(opcion, id));
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = Ruta();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearRutas(@Bind.body() Ruta body )async
  {
     final servicio = Ruta();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarRutas(@Bind.path('id') int id,@Bind.body() Ruta body) async
  {
    final servicio = Ruta();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarRutas(@Bind.path('id') int id) async
  {
    final servicio = Ruta();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
}