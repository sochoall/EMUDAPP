import 'dart:async';
import 'package:fave_reads/fave_reads.dart';
import 'package:fave_reads/Models/conexion.dart';

class Monitoreo_Estudiante extends Serializable
{
  String ser_latitud;
  String ser_longitud;
  int mon_id;
  String mon_latitud;
  String mon_longitud;

  Future<List> obtenerDatoId(int id) async 
  {
    final conexion = Conexion();
    final String sql = "select s.ser_latitud, s.ser_longitud, m.mon_id, m.mon_latitud, m.mon_longitud from public.te_servicio s, public.te_recorrido_servicio rs, public.te_recorrido r, public.te_monitoreo m, (select max(mon_id) maximo from public.te_monitoreo) as t where s.ser_id=rs.ser_id and rs.rec_id=r.rec_id and r.rec_id=m.rec_id and s.est_id=$id and m.mon_id=t.maximo";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
      final reg = Monitoreo_Estudiante();

      reg.ser_latitud=query[0][0].toString();
      reg.ser_longitud=query[0][1].toString();
      reg.mon_id=int.parse(query[0][2].toString());
      reg.mon_latitud=query[0][3].toString();
      reg.mon_longitud=query[0][4].toString(); 
        
      datos.add(reg.asMap());
      return datos;
    }
    else
      return null;
  }

  @override
  Map<String, dynamic> asMap() => 
  {
    'ser_latitud': ser_latitud,
    'ser_longitud': ser_longitud,
    'mon_id': mon_id,
    'mon_latitud': mon_latitud,
    'mon_longitud': mon_longitud,
  };

  @override
  void readFromMap(Map<String, dynamic> object) 
  {
    ser_latitud = object['ser_latitud'].toString();
    ser_longitud = object['ser_longitud'].toString();
    mon_id = int.parse(object['mon_id'].toString());
    mon_latitud = object['mon_latitud'].toString();
    mon_longitud = object['mon_longitud'].toString();
  }
}