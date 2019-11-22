
import 'dart:async';
import 'package:aqueduct/aqueduct.dart';


import 'package:fave_reads/Models/tipo_institucion.dart';

class TipoInstitucionController extends ResourceController{

  @Operation.get()
  Future<Response> obtenerLista(@Bind.query('campo') String campo,@Bind.query('bus') String bus,@Bind.query('est') String est ) async
  {
    final servicio = TipoInstitucion();
    return Response.ok(await servicio.obtenerDatos(campo,bus,est));
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = TipoInstitucion();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearTipoServicio(@Bind.body() TipoInstitucion body )async
  {
     final servicio = TipoInstitucion();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarTipoServicio(@Bind.path('id') int id,@Bind.body() TipoInstitucion body) async
  {
    final servicio = TipoInstitucion();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarTipoServicio(@Bind.path('id') int id) async
  {
    final servicio = TipoInstitucion();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
}