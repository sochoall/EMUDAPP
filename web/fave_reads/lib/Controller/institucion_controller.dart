
import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/institucion.dart';

class InstitucionController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerLista(@Bind.query('campo') String campo,@Bind.query('bus') String bus,@Bind.query('est') String est ) async
  {
    final servicio = Institucion();
    return Response.ok(await servicio.obtenerDatos(campo,bus,est));
  }
  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = Institucion();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearInstitucion(@Bind.body() Institucion body )async
  {
     final servicio = Institucion();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarInstitucion(@Bind.path('id') int id,@Bind.body() Institucion body) async
  {
    final servicio = Institucion();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarInstitucion(@Bind.path('id') int id) async
  {
    final servicio = Institucion();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
}