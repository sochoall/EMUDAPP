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
  String    tmoId;
  String    tpaId;
  String    parId;
  String    recId;  
 

  Future<List> obtenerDatos(int id) async {
    final conexion = Conexion();
    final String sql = "select * from te_monitoreo w, "
                    "(select max(m.mon_id) as id from public.te_monitoreo m, public.te_recorrido r, public.te_ruta t, public.te_institucion i "
                    " where r.rec_id=m.rec_id and r.rut_id=t.rut_id and t.ins_id=i.ins_id and i.ins_id=$id group by m.rec_id order by 1) as x"
                    " where  x.id=w.mon_id";
    print(sql);       
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
        reg.tmoId=query[i][5].toString();
        reg.tpaId=query[i][6].toString();
        reg.parId=query[i][7].toString();
        reg.recId=query[i][8].toString();
        datos.add(reg.asMap()); 
      }
    
    }
    return datos;
    
  }

   Future<List> obtenerMonitoreoId(int id) async {
    final conexion = Conexion();
    final String sql="select l.idpar, m.b,m.c,l.lat,l.long,m.f,m.g,m.parada,m.h "
"from (select p.par_id as idpar, p.par_latitud as lat,p.par_longitud as long from public.te_ruta r, public.te_recorrido e,public.te_parada p "
"where e.rec_id=p.rec_id and r.rut_id=e.rut_id and r.rut_id=$id) as l "
" LEFT JOIN (select m.mon_id as a,m.mon_fecha_hora as b,m.mon_completo as c,m.mon_latitud as d,m.mon_longitud as e,m.tmo_id as f,m.tpa_id as g,m.par_id as parada,m.rec_id as h  FROM public.te_monitoreo m, public.te_recorrido e, "
"public.te_ruta r, public.te_parada p where m.rec_id=e.rec_id and r.rut_id=e.rut_id and m.par_id=p.par_id and r.rut_id=$id) as m"
 " ON m.parada = l.idpar";
    print(sql);       
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
        reg.tmoId=query[i][5].toString();
        reg.tpaId=query[i][6].toString();
        reg.parId=query[i][7].toString();
        reg.recId=query[i][8].toString();
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
        reg.tmoId=query[0][5].toString();
        reg.tpaId=query[0][6].toString();
        reg.parId=query[0][7].toString();
        reg.recId=query[0][8].toString();
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
    tmoId=object['telefono'].toString();
    tpaId=object['correo'].toString();
    parId=object['estado'].toString();
    recId=object['insId'].toString();
  }

}