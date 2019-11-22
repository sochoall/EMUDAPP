import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/tipo_monitoreo.dart';

class TipoMonitoreoController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerLista(@Bind.query('campo') String campo,@Bind.query('bus') String bus,@Bind.query('est') String est ) async
  {
    final servicio = TipoMonitoreo();
    return Response.ok(await servicio.obtenerDatos(campo,bus,est));
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = TipoMonitoreo();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearTipoMonitoreo(@Bind.body() TipoMonitoreo body )async
  {
     final servicio = TipoMonitoreo();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarTipoMonitoreo(@Bind.path('id') int id,@Bind.body() TipoMonitoreo body) async
  {
    final servicio = TipoMonitoreo();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarInstitucion(@Bind.path('id') int id) async
  {
    final servicio = TipoMonitoreo();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
  
}