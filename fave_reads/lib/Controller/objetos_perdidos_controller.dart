import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/objetos_perdidos.dart';

class ObjetosPerdidosController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerLista() async
  {
    final servicio = ObjetosPerdidos();
    return Response.ok(await servicio.obtenerDatos());
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = ObjetosPerdidos();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearObjetosPerdidos(@Bind.body() ObjetosPerdidos body )async
  {
     final servicio = ObjetosPerdidos();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarObjetosPerdidos(@Bind.path('id') int id,@Bind.body() ObjetosPerdidos body) async
  {
    final servicio = ObjetosPerdidos();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarObjetosPerdidos(@Bind.path('id') int id) async
  {
    final servicio = ObjetosPerdidos();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
}