import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/estudiante.dart';

class EstudianteRepresentanteController extends ResourceController{


  @Operation.get()
  Future<Response> obtenerLista(@Bind.query('id') String id) async
  {
    final servicio = Estudiante();
    return Response.ok(await servicio.obtenerDatosRepresentante(id));
  }

 
}