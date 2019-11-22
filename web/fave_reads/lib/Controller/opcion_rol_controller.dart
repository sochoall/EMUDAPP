import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/opcion_rol.dart';


class OpcionRolController extends ResourceController{


  
 @Operation.post()
  Future<Response> crearMonitoreo(@Bind.body() OpcionRol body )async
  {
     final servicio = OpcionRol();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }



  @Operation.put('id')
  Future<Response> modificarTipoVehiculo(@Bind.path('id') int id,@Bind.body() OpcionRol body) async
  {
    final servicio = OpcionRol();
    await servicio.eliminar(id, body);
    return Response.ok('se ha modificado');
  }
}