import 'dart:async';
import 'package:fave_reads/fave_reads.dart';
import 'package:fave_reads/Models/conexion.dart';

class Monitoreo extends Serializable
{
  int mon_id;
  String mon_fecha_hora;
  int    mon_completo;
  String mon_latitud;
  String mon_longitud;
  int    tmo_id;
  int    tpa_id;
  int    par_id;
  int    rec_id;  
 
  Future<List> obtenerDatos() async 
  {
    final conexion = Conexion();
    const String sql = "select * from public.te_monitoreo";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Monitoreo();
        
        reg.mon_id=int.parse(query[i][0].toString());
        reg.mon_fecha_hora=query[i][1].toString();
        reg.mon_completo=int.parse(query[i][2].toString());        
        reg.mon_latitud=query[i][3].toString();
        reg.mon_longitud=query[i][4].toString();    
        reg.tmo_id=int.parse(query[i][5].toString());
        reg.tpa_id=int.parse(query[i][6].toString());
        reg.par_id=int.parse(query[i][7].toString());
        reg.rec_id=int.parse(query[i][8].toString());
        datos.add(reg.asMap()); 
      }
      return datos;
    }
    else
      return null;
  }

  Future<Monitoreo> obtenerDatoId(int id) async 
  {
    final conexion = Conexion();
    final String sql = "select * from public.te_monitoreo where mon_id=$id";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
      final reg = Monitoreo();
      reg.mon_id=int.parse(query[0][0].toString());
      reg.mon_fecha_hora=query[0][1].toString();
      reg.mon_completo=int.parse(query[0][2].toString());        
      reg.mon_latitud=query[0][3].toString();
      reg.mon_longitud=query[0][4].toString();    
      reg.tmo_id=int.parse(query[0][5].toString());
      reg.tpa_id=int.parse(query[0][6].toString());
      reg.par_id=int.parse(query[0][7].toString());
      reg.rec_id=int.parse(query[0][8].toString());
      datos.add(reg.asMap());
      return reg;
    }
    else
      return null;
  }

  Future<void> ingresar(Monitoreo dato) async
  {
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_monitoreo(mon_fecha_hora,mon_completo,mon_latitud,mon_longitud,tmo_id,tpa_id,par_id,rec_id)"
    "VALUES ('${dato.mon_fecha_hora}',${dato.mon_completo},'${dato.mon_latitud}','${dato.mon_longitud}',${dato.tmo_id},${dato.tpa_id},${dato.par_id},${dato.rec_id})";
    print(sql);
    await conexion.operaciones(sql);
  }

  Future<void> modificar(int id,Monitoreo dato) async
  {
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_monitoreo SET mon_fecha_hora='${dato.mon_fecha_hora}',mon_completo=${dato.mon_completo},mon_latitud='${dato.mon_latitud}',mon_longitud='${dato.mon_longitud}'"
	  "WHERE mon_id=$id";
    await conexion.operaciones(sql);
  }

  Future<void> eliminar(int id) async
  {
    final conexion = Conexion();
    final String sql = "UPDATE public.te_monitoreo SET mon_estado=1 WHERE mon_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {
    'mon_id': mon_id,
    'mon_fecha_hora': mon_fecha_hora,
    'mon_completo': mon_completo,
    'mon_latitud': mon_latitud,
    'mon_longitud': mon_longitud,
    'tmo_id': tmo_id,
    'tpa_id': tpa_id,
    'par_id' : par_id,
    'rec_id': rec_id 
  };

  @override
  void readFromMap(Map<String, dynamic> object) 
  {
    mon_id = int.parse(object['mon_id'].toString());
    mon_fecha_hora = object['mon_fecha_hora'].toString();
    mon_completo = int.parse(object['mon_completo'].toString());
    mon_latitud = object['mon_latitud'].toString();
    mon_longitud = object['mon_longitud'].toString();
    tmo_id = int.parse(object['tmo_id'].toString());
    tpa_id = int.parse(object['tpa_id'].toString());
    par_id = int.parse(object['par_id'].toString());
    rec_id = int.parse(object['rec_id'].toString());
  }
}