import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class RutaApp extends Serializable
{
  
  int id;
  String nombre;
  String descripcion;
  int    estado;
  int    cupoMaximo;
  String color;
  int    insId;
  


  Future<List> obtenerDatoId(int id) async {
    final conexion = Conexion();
    //final String sql = "select * from public.te_ruta where rut_id=$id";

    final String sql = "select r.rut_id,r.rut_nombre,r.rut_descripcion,r.rut_estado,r.rut_cupo_maximo,r.rut_color,r.ins_id,u.usu_id from public.te_usuario u,public.te_vehiculo v,public.te_ruta_vehiculo rv,public.te_ruta r where u.usu_id=$id and v.fun_id=u.fun_id and rv.veh_id=v.veh_id and r.rut_id=rv.rut_id and r.rut_estado=1";

    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);
print(query);
    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = RutaApp();
        
        reg.id=int.parse(query[i][0].toString());
        reg.nombre=query[i][1].toString();
        reg.descripcion=query[i][2].toString();
        reg.estado=int.parse(query[i][3].toString());
        reg.cupoMaximo=int.parse(query[i][4].toString());
        reg.color=query[i][5].toString();       
        reg.insId=int.parse(query[i][6].toString());
        datos.add(reg.asMap()); 
      }
      return datos;
    }
    else
    {
      return null;
    }
    
  }

  @override
  Map<String, dynamic> asMap() => {
    'id': id,
    'nombre': nombre,
    'descripcion': descripcion,
    'estado': estado,
    'cupoMaximo': cupoMaximo,
    'color': color,
    'insId': insId 
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id= int.parse(object['id'].toString());
    nombre= object['nombre'].toString();
    descripcion= object['descripcion'].toString();
    estado=int.parse( object['estado'].toString());
    cupoMaximo=int.parse( object['cupoMaximo'].toString());
    color= object['color'].toString();
    insId=int.parse(object['insId'].toString());
  }
}