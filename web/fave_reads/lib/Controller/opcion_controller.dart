import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/opcion.dart';


class OpcionController extends ResourceController{

  @Operation.get()
  Future<Response> obtenerDatos(@Bind.query('id') String id,@Bind.query('opcion') int op ) async
  {
    final servicio = Opcion();
    switch(op)
    {
      case 1:
         return Response.ok(await servicio.obtenerPadresHijos(id)); 
      break;
      case 2:
        	 return Response.ok(await servicio.obtenerHijosRolId(id));
      break;
      default:
           return Response.ok("no ha seleccionado ninguna opcion"); 
      break; 

    }
      
     
  }

  @Operation.get('id')
  Future<Response> obtenerLista(@Bind.path('id') int id) async
  {
    final servicio = Opcion();
    return Response.ok(await servicio.obtenerPadres(id));
  }

  
}