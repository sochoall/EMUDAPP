import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/login.dart';

class LoginController extends ResourceController{



  @Operation.get('datos')
  Future<Response> verificar(@Bind.path('datos') String datos) async
  {
    final results=datos.split("*");
    print(results);
    final servicio = Login();
    servicio.usuario=results[0].toString();
    servicio.pss=results[1].toString().trim();
    return Response.ok(await servicio.busquedaUsuario(servicio));
  }

}