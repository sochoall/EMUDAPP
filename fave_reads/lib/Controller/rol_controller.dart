import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/rol.dart';

class RolController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerLista() async
  {
    final servicio = Rol();
    return Response.ok(await servicio.obtenerDatos());
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = Rol();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearRol(@Bind.body() Rol body )async
  {
     final servicio = Rol();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarRol(@Bind.path('id') int id,@Bind.body() Rol body) async
  {
    final servicio = Rol();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarRol(@Bind.path('id') int id) async
  {
    final servicio = Rol();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
}