import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/Recorrido.dart';
import 'package:fave_reads/Models/servicio.dart';

class ServicioController extends ResourceController{



  @Operation.get('id')
  Future<Response> obtenerLista(@Bind.path('id') int id) async
  {
    final servicio = Servicio();
    return Response.ok(await servicio.obtenerDatos(id));
  }


  @Operation.post()
  Future<Response> crearRecorrido(@Bind.body() Recorrido body )async
  {
     final servicio = Recorrido();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

 
  
}