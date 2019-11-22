import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/contadores.dart';

class ContadoresController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerElementos(@Bind.query('opcion') int opcion) async
  {
    final servicio = Contadores();
    return Response.ok(await servicio.numeroElementos(opcion));
  }


}