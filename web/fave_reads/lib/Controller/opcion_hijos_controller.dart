import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/hijo.dart';
import 'package:fave_reads/Models/opcion.dart';


class OpcionHijoController extends ResourceController{

  @Operation.get()
  Future<Response> obtenerHijos(@Bind.query('id') String id) async
  {
    final servicio = Hijo();
    return Response.ok(await servicio.obtenerSoloHijos(id));
  }
  

  @Operation.get('id')
  Future<Response> obtenerHijosId(@Bind.path('id') String id) async
  {
    final servicio = Hijo();
    return Response.ok(await servicio.obtenerhijos(id));
  }

  @Operation.put('id')
  Future<Response> modificarTipoVehiculo(@Bind.path('id') int id,@Bind.body() Opcion body) async
  {
    final servicio = Hijo();
    await servicio.agregarPadre(id, body);
    return Response.ok('se ha modificado');
  }
}