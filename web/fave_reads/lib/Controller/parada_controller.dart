import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/Parada.dart';

class ParadaController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerLista(@Bind.query('opcion') int opcion,@Bind.query('dato') int dato ) async
  {
    final servicio = Parada();

    switch(opcion)
    {
      case 1://caso opcion del query 1, Recuperar los datos de la parada por id de ruta
                return Response.ok(await servicio.obtenerParadaRuta(dato));
        break;
      default:
                return Response.ok(await servicio.obtenerDatos());
        break;
    }
    
  }

  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = Parada();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearParada(@Bind.body() Parada body )async
  {

     final servicio = Parada();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarParada(@Bind.path('id') int id,@Bind.body() Parada body) async
  {
    final servicio = Parada();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarParada(@Bind.path('id') int id) async
  {
    final servicio = Parada();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }
  
}