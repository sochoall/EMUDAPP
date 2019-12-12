import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/Monitoreo.dart';
import 'package:fave_reads/Models/parada.dart';

class MonitoreoController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerLista(@Bind.query('id') int id) async
  {
    final servicio = Parada();
    return Response.ok(await servicio.obtenerParadaMonitoreo(id,""));
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = Monitoreo();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearMonitoreo(@Bind.body() Monitoreo body )async
  {
     final servicio = Monitoreo();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarMonitoreo(@Bind.path('id') int id,@Bind.body() Monitoreo body) async
  {
    final servicio = Monitoreo();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarInstitucion(@Bind.path('id') int id) async
  {
    final servicio = Monitoreo();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
  
}