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
    const String sql = "select * from public.te_parada where par_estado=0";
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
      return datos;
    }
    else
    {
      return null;
    }
    
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
    final String sql = "INSERT INTO public.te_parada(par_id,par_nombre,par_orden,par_latitud,par_longuitud,par_tiempo_promedio,par_estado,rec_id)"
   " VALUES (${dato.id},'${dato.nombre}',${dato.orden},'${dato.latitud}', '${dato.longuitud}', '${dato.tiempoPromedio}',${dato.estado},${dato.recId})";
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