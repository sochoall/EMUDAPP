import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/funcionario_app.dart';

class FuncionarioAppController extends ResourceController{

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = FuncionarioApp();
    return Response.ok(await servicio.obtenerDatoId(id));
  }
}