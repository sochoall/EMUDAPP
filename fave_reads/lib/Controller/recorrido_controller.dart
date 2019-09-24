import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/Recorrido.dart';

class RecorridoController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerLista() async
  {
    final servicio = Recorrido();
    return Response.ok(await servicio.obtenerDatos());
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = Recorrido();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearRecorrido(@Bind.body() Recorrido body )async
  {
     final servicio = Recorrido();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarRecorrido(@Bind.path('id') int id,@Bind.body() Recorrido body) async
  {
    final servicio = Recorrido();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarInstitucion(@Bind.path('id') int id) async
  {
    final servicio = Recorrido();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
  
}