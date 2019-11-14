import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/recorrido_sentido_estudiante.dart';



class RecorridoSentidoEstudianteController extends ResourceController{

  @Operation.get('idrec')
  Future<Response> obtenerListaId(@Bind.path('idrec') int idrec) async
  {
    final servicio = RecorridoSentidoEstudiante();
    return Response.ok(await servicio.obtenerDatoId(idrec));
  } 
  
}