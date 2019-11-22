import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/vehiculo.dart';

class VehiculoController extends ResourceController {
  @Operation.get()
  Future<Response> obtenerLista(@Bind.query('campo') String campo,@Bind.query('bus') String bus,@Bind.query('est') String est,@Bind.query('idIns') String idIns) async
  {
    final servicio = Vehiculo();
    return Response.ok(await servicio.obtenerDatos(campo,bus,est,idIns));
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async {
    final servicio = Vehiculo();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearUsuario(@Bind.body() Vehiculo body) async {
    final servicio = Vehiculo();
    await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }
  
  @Operation.put('id')
  Future<Response> modificarTipoServicio(@Bind.path('id') int id,@Bind.body() Vehiculo body) async
  {
    final servicio = Vehiculo();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }




}
