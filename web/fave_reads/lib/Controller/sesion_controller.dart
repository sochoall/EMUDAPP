import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/sesion.dart';


class SesionController extends ResourceController{


  @Operation.post()
  Future<Response> crearTipoServicio(@Bind.body() Sesion body )async
  {
     final servicio = Sesion();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.get('id')
  Future<Response> buscar(@Bind.path('id') int id) async
  {
     final servicio = Sesion();
     int i=await servicio.busqueda(id);
    return Response.ok(i.toString());
  }
  
}