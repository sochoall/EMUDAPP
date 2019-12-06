import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/usuario.dart';

class UsuarioController extends ResourceController {
  @Operation.get()
  Future<Response> obtenerLista(@Bind.query('campo') String campo,
      @Bind.query('bus') String bus, @Bind.query('est') String est) async {
    final servicio = Usuario();
    return Response.ok(await servicio.obtenerDatos(campo, bus, est));
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async {
    final servicio = Usuario();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearUsuario(@Bind.body() Usuario body) async {
    final servicio = Usuario();
    await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarUsuario(
      @Bind.path('id') int id, @Bind.body() Usuario body) async {
    final servicio = Usuario();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarInstitucion(@Bind.path('id') int id) async {
    final servicio = Usuario();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }

  /* @Operation.get('correo','password')
  Future<Response> busqueda(@Bind.path('correo') String correo,@Bind.path('password') String pss) async
  {
    final servicio = Usuario();
    String aux=await servicio.busquedaUsuario(correo,pss);
    return Response.ok(aux);

  }*/

}
