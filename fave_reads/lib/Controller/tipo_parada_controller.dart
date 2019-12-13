import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/tipo_parada.dart';

class TipoParadaController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerLista() async
  {
    final servicio = TipoParada();
    return Response.ok(await servicio.obtenerDatos());
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = TipoParada();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearTipoParada(@Bind.body() TipoParada body )async
  {
     final servicio = TipoParada();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarTipoParada(@Bind.path('id') int id,@Bind.body() TipoParada body) async
  {
    final servicio = TipoParada();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarInstitucion(@Bind.path('id') int id) async
  {
    final servicio = TipoParada();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
  
}