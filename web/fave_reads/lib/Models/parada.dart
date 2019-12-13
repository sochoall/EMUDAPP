import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class Parada extends Serializable
{
  
  int id;
  String nombre;
  int orden;
  String latitud;
  String longuitud;
  String tiempoPromedio;
  int    estado;
  int    recId;
 
  Future<List> obtenerDatos() async {
    final conexion = Conexion();
    const String sql = "select * from public.te_parada where par_estado=1";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Parada();
        
        reg.id=int.parse(query[i][0].toString());
        reg.nombre=query[i][1].toString();
        reg.orden=int.parse(query[i][2].toString());        
        reg.latitud=query[i][3].toString();
        reg.longuitud=query[i][4].toString();    
        reg.tiempoPromedio=query[i][5].toString();
        reg.estado=int.parse(query[i][6].toString());
        reg.recId=int.parse(query[i][7].toString());
        datos.add(reg.asMap()); 
      }
    }
      return datos;
    
  }


   Future<List> obtenerParadaRuta(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_parada p, public.te_ruta u,public.te_recorrido r where r.rut_id=u.rut_id and r.rec_id=p.rec_id and r.rut_id=$id";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Parada();
        
        reg.id=int.parse(query[i][0].toString());
        reg.nombre=query[i][1].toString();
        reg.orden=int.parse(query[i][2].toString());        
        reg.latitud=query[i][3].toString();
        reg.longuitud=query[i][4].toString();    
        reg.tiempoPromedio=query[i][5].toString();
        reg.estado=int.parse(query[i][6].toString());
        reg.recId=int.parse(query[i][7].toString());
        datos.add(reg.asMap()); 
      }
    }
      return datos;
    
  }

  Future<List> obtenerParadaMonitoreo(int id, String fecha) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_parada a ,"
    "(select p.par_id as parada FROM public.te_monitoreo m, public.te_recorrido e,"
    "public.te_ruta r, public.te_parada p where m.rec_id=e.rec_id and r.rut_id=e.rut_id and m.par_id=p.par_id and r.rut_id=$id and m.mon_fecha_hora>='2019-11-27 00:00:00'"
    "and m.mon_fecha_hora<='2019-11-27 23:59:59') as h "
    "where a.par_id=h.parada";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Parada();
        
        reg.id=int.parse(query[i][0].toString());
        reg.nombre=query[i][1].toString();
        reg.orden=int.parse(query[i][2].toString());        
        reg.latitud=query[i][3].toString();
        reg.longuitud=query[i][4].toString();    
        reg.tiempoPromedio=query[i][5].toString();
        reg.estado=int.parse(query[i][6].toString());
        reg.recId=int.parse(query[i][7].toString());
        datos.add(reg.asMap()); 
      }
    }
      return datos;
    
  }

  Future<Parada> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_parada where par_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = Parada();
       reg.id=int.parse(query[0][0].toString());
        reg.nombre=query[0][1].toString();
        reg.orden=int.parse(query[0][2].toString());        
        reg.latitud=query[0][3].toString();
        reg.longuitud=query[0][4].toString();    
        reg.tiempoPromedio=query[0][5].toString();
        reg.estado=int.parse(query[0][6].toString());
        reg.recId=int.parse(query[0][7].toString());
        return reg;
    }
    else
    {
      return null;
    }
    
  }


  Future<void> ingresar(Parada dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_parada(par_nombre,par_orden,par_latitud,par_longitud,par_tiempo_promedio,par_estado,rec_id)"
   " VALUES ('${dato.nombre}',${dato.orden},'${dato.latitud}', '${dato.longuitud}', '${dato.tiempoPromedio}',${dato.estado},${dato.recId})";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,Parada dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_parada SET par_nombre='${dato.nombre}',par_correo=${dato.orden} "
	  "WHERE par_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_parada SET par_estado=1 WHERE par_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {
    'id': id,
    'nombre': nombre,
    'orden': orden,
    'latitud': latitud,
    'longuitud': longuitud,
    'tiempoPromedio': tiempoPromedio,
    'estado': estado,
    'recId':recId 
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id= int.parse(object['id'].toString());
    nombre= object['nombre'].toString();
    orden= int.parse(object['orden'].toString());
    latitud= object['latitud'].toString();
    longuitud=object['longuitud'].toString();
    tiempoPromedio=object['tiempoPromedio'].toString();
    estado=int.parse(object['estado'].toString());
    recId=int.parse(object['recId'].toString());
  }

}