import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/objetos_perdidos.dart';

class ObjetosPerdidosController extends ResourceController{


  @Operation.get('id')
  Future<Response> obtenerListaId(@Bind.path('id') int id) async
  {
    final servicio = ObjetosPerdidos();
    return Response.ok(await servicio.obtenerDatoId(id));
  }

  @Operation.post()
  Future<Response> crearObjetosPerdidos(@Bind.body() ObjetosPerdidos body )async
  {
     final servicio = ObjetosPerdidos();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

  @Operation.put('id')
  Future<Response> modificarObjetosPerdidos(@Bind.path('id') int id,@Bind.body() ObjetosPerdidos body) async
  {
    final servicio = ObjetosPerdidos();
    await servicio.modificar(id, body);
    return Response.ok('se ha modificado');
  }

  @Operation.delete('id')
  Future<Response> eliminarObjetosPerdidos(@Bind.path('id') int id) async
  {
    final servicio = ObjetosPerdidos();
    await servicio.eliminar(id);
    return Response.ok('se ha eliminado');
  }

  @Operation.get()
  Future<Response> busqueda (@Bind.query('f1') String f1, @Bind.query('f2') String f2,@Bind.query('f3') String f3) async
  {
    print(f1);
    print(f2);
        print(f3);
    final servicio = ObjetosPerdidos();
     return Response.ok(await servicio.busquedaO(f1,f2,f3));
  }
  //@Operation.get('correo','password')
  //Future<Response> busqueda(@Bind.path('correo') String correo,@Bind.path('password') String pss) async
  //{
    //final servicio = Usuario();
    //String aux=await servicio.busquedaUsuario(correo,pss);
    //return Response.ok(aux);
  //}
}