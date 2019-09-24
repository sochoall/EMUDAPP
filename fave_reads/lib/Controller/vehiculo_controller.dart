import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/Vehiculo.dart';

class VehiculoController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerLista() async
  {
    final servicio = Vehiculo();
    return Response.ok(await servicio.obtenerDatos());
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = Vehiculo();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearVehiculo(@Bind.body() Vehiculo body )async
  {
     final servicio = Vehiculo();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarVehiculo(@Bind.path('id') int id,@Bind.body() Vehiculo body) async
  {
    final servicio = Vehiculo();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarInstitucion(@Bind.path('id') int id) async
  {
    final servicio = Vehiculo();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
 
}