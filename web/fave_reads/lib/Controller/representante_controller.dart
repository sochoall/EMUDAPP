import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/representante.dart';

class RepresentanteController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerLista(@Bind.query('campo') String campo,@Bind.query('valor') String valor,@Bind.query('estado') String estado) async
  {
    final servicio = Representante();
    return Response.ok(await servicio.obtenerDatos(campo,valor,estado));
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = Representante();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearRepresentante(@Bind.body() Representante body )async
  {
     final servicio = Representante();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarRepresentante(@Bind.path('id') int id,@Bind.body() Representante body) async
  {
    final servicio = Representante();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarRepresentante(@Bind.path('id') int id) async
  {
    final servicio = Representante();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
}