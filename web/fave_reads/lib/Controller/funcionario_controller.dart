import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/funcionario.dart';

class FuncionarioController extends ResourceController{



 @Operation.get()
  Future<Response> obtenerLista(@Bind.query('campo') String campo,@Bind.query('bus') String bus,@Bind.query('est') String est,@Bind.query('idIns') String idIns) async
  {
    final servicio = Funcionario();
    return Response.ok(await servicio.obtenerDatos(campo,bus,est,idIns));
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = Funcionario();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearFuncionario(@Bind.body() Funcionario body )async
  {
     final servicio = Funcionario();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarFuncionario(@Bind.path('id') int id,@Bind.body() Funcionario body) async
  {
    final servicio = Funcionario();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarFuncionario(@Bind.path('id') int id) async
  {
    final servicio = Funcionario();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
}