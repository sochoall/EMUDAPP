import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class Monitoreo extends Serializable
{
  
  int id;
  String fechaHora;
  int    completo;
  String latitud;
  String longuitud;
  int    tmoId;
  int    tpaId;
  int    parId;
  int    recId;  
 
 
  Future<List> obtenerDatos() async {
    final conexion = Conexion();
    const String sql = "select * from public.te_monitoreo where mon_estado=0";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Monitoreo();
        
        reg.id=int.parse(query[i][0].toString());
        reg.fechaHora=query[i][1].toString();
        reg.completo=int.parse(query[i][2].toString());        
        reg.latitud=query[i][3].toString();
        reg.longuitud=query[i][4].toString();    
        reg.tmoId=int.parse(query[i][5].toString());
        reg.tpaId=int.parse(query[i][6].toString());
        reg.parId=int.parse(query[i][7].toString());
        reg.recId=int.parse(query[i][8].toString());
        datos.add(reg.asMap()); 
      }
    
    }
    return datos;
    
  }

  Future<Monitoreo> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_monitoreo where mon_id=$id";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = Monitoreo();
        reg.id=int.parse(query[0][0].toString());
        reg.fechaHora=query[0][1].toString();
        reg.completo=int.parse(query[0][2].toString());        
        reg.latitud=query[0][3].toString();
        reg.longuitud=query[0][4].toString();    
        reg.tmoId=int.parse(query[0][5].toString());
        reg.tpaId=int.parse(query[0][6].toString());
        reg.parId=int.parse(query[0][7].toString());
        reg.recId=int.parse(query[0][8].toString());
        datos.add(reg.asMap());
        return reg;
    }
    else
    {
      return null;
    }
    
  }

  Future<void> ingresar(Monitoreo dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_monitoreo(mon_id,mon_fecha_hora,mon_completo,mon_latitud,mon_longuiud,tmo_id,tpa_id,par_id,rec_id)"
   " VALUES (${dato.id}, '${dato.fechaHora}',${dato.completo},'${dato.latitud}','${dato.longuitud}', ${dato.tmoId}, ${dato.tpaId},${dato.parId},${dato.recId})";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,Monitoreo dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_monitoreo SET mon_fecha_hora='${dato.fechaHora}',mon_completo=${dato.completo},mon_latitud='${dato.latitud}',mon_longuiud='${dato.longuitud}' "
	  "WHERE mon_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_monitoreo SET mon_estado=1 WHERE mon_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {
    'id': id,
    'fechaHora': fechaHora,
    'completo': completo,
    'latitud': latitud,
    'longuitud': longuitud,
    'tmoId': tmoId,
    'tpaId': tpaId,
    'parId' : parId,
    'recId':recId 
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id= int.parse(object['id'].toString());
    fechaHora= object['cedula'].toString();
    completo= int.parse(object['nombre'].toString());
    latitud= object['apellido'].toString();
    longuitud= object['direccion'].toString();
    tmoId=int.parse(object['telefono'].toString());
    tpaId=int.parse(object['correo'].toString());
    parId=int.parse(object['estado'].toString());
    recId=int.parse(object['insId'].toString());
  }

}