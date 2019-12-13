import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class Vehiculo extends Serializable {
  String id;
  String placa;
  String capacidad;
  String estado;
  String tve_id;
  String fun_id;

  

  Future<List> obtenerDatos(String campo, String bus, String est, String intitucionId) async {
    final conexion = Conexion();
    String sql; 
    if(intitucionId != "")
      sql = "select v.veh_id, v.veh_placa, v.veh_capacidad, v.veh_estado, v.tve_id, f.fun_id from public.te_vehiculo v, public.te_funcionario f where f.ins_id=$intitucionId and f.fun_id = v.fun_id and v.$campo::text LIKE '%$bus%' and veh_estado::text LIKE '%$est%' order by veh_id DESC";
    else
      sql = "select * from public.te_vehiculo where $campo::text LIKE '%$bus%' and veh_estado::text LIKE '%$est%' order by veh_id DESC";
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = Vehiculo();
        reg.id = query[i][0].toString();
        reg.placa = query[i][1].toString();
        reg.capacidad = query[i][2].toString();
        reg.estado = query[i][3].toString();
        reg.tve_id = query[i][4].toString();
        reg.fun_id = query[i][5].toString();

        datos.add(reg.asMap());
      }      
    } 
    return datos;
  }

 Future<List> obtenerVehiculosRuta(int id) async {
    final conexion = Conexion();
    final String sql= "select v.veh_id,v.veh_placa,v.veh_capacidad,v.veh_estado,v.tve_id,v.fun_id from te_ruta_vehiculo r, te_vehiculo v where r.veh_id=v.veh_id and rut_id=$id order by 1";
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = Vehiculo();
        reg.id = query[i][0].toString();
        reg.placa = query[i][1].toString();
        reg.capacidad = query[i][2].toString();
        reg.estado = query[i][3].toString();
        reg.tve_id = query[i][4].toString();
        reg.fun_id = query[i][5].toString();

        datos.add(reg.asMap());
      }      
    } 
    return datos;
  }





  Future<Vehiculo> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_vehiculo where veh_id=$id";
    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if (query != null && query.isNotEmpty) {
      final reg = Vehiculo();
      reg.id = query[0][0].toString();
      reg.placa = query[0][1].toString();
      reg.capacidad = query[0][2].toString();
      reg.estado = query[0][3].toString();
      reg.tve_id = query[0][4].toString();
      reg.fun_id = query[0][5].toString();
      return reg;
    } else {
      return null;
    }
  }



  Future<void> ingresar(Vehiculo dato) async {
    final conexion = Conexion();
    final String sql =
        "insert into public.te_vehiculo (veh_placa,veh_capacidad, veh_estado, tve_id, fun_id) values ('${dato.placa}','${dato.capacidad}','${dato.estado}','${dato.tve_id}', '${dato.fun_id}')";
    await conexion.operaciones(sql);
  }

  Future<void> modificar(int id, Vehiculo dato) async {
    final conexion = Conexion();
    final String sql =
        "UPDATE public.te_vehiculo SET veh_placa='${dato.placa}', veh_capacidad='${dato.capacidad}', veh_estado='${dato.estado}',tve_id='${dato.tve_id}', fun_id='${dato.fun_id}' WHERE veh_id=$id";
    await conexion.operaciones(sql);
  }

  @override
  Map<String, dynamic> asMap() => {
        'id': id,
        'placa': placa,
        'capacidad': capacidad,
        'estado': estado,
        'tve_id': tve_id,
        'fun_id': fun_id
      };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'].toString();
    placa = object['placa'].toString();
    capacidad = object['capacidad'].toString();
    estado = object['estado'].toString();
    tve_id = object['tve_id'].toString();
    fun_id = object['fun_id'].toString();
  }
}
