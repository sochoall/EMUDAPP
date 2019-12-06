import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class VehiculoRuta extends Serializable {
  int vehiculoId;
  int rutaId;

  

  Future<void> ingresar(VehiculoRuta dato) async {
    final conexion = Conexion();
    final String sql = "insert into public.te_ruta_vehiculo(veh_id, rut_id) values (${dato.vehiculoId},${dato.rutaId})";
    await conexion.operaciones(sql);
  }

  @override
  Map<String, dynamic> asMap() => {
        'vehiculoId': vehiculoId,
        'rutaId': rutaId
      };

  @override
  void readFromMap(Map<String, dynamic> object) {
    vehiculoId =  int.parse(object['vehiculoId'].toString());
    rutaId =  int.parse(object['rutaId'].toString());
  }
}
