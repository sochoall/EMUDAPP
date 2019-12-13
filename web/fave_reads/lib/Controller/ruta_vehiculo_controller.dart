import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/Models/vehiculo.dart';
import 'package:fave_reads/Models/vehiculoRuta.dart';

class RutaVehiculoController extends ResourceController{



  @Operation.get()
  Future<Response> obtenerElementos(@Bind.query('id') int id) async
  {
    final servicio = Vehiculo();
    return Response.ok(await servicio.obtenerVehiculosRuta(id));
  }

   @Operation.post()
  Future<Response> crearRol(@Bind.body() VehiculoRuta body )async
  {
     final servicio = VehiculoRuta();
     await servicio.ingresar(body);
    return Response.ok('se ha ingresado');
  }

}