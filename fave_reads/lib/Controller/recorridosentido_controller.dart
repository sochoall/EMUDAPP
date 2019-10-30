import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/recorrido_sentido.dart';



class RecorridoSentidoController extends ResourceController{

  @Operation.get('idrec')
  Future<Response> obtenerListaId(@Bind.path('idrec') int idrec) async
  {
    final servicio = RecorridoSentido();
    return Response.ok(await servicio.obtenerDatoId(idrec));
  } 
  
}