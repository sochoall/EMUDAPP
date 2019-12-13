import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class Ruta extends Serializable
{
  
  int id;
  String nombre;
  String descripcion;
  int    estado;
  int    cupoMaximo;
  String color;
  int    insId;

 
  Future<List> obtenerDatos() async {
    final conexion = Conexion();
    const String sql = "select * from public.te_ruta where rut_estado=1";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);
print(query);
    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Ruta();
        
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

  Future<Ruta> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_ruta where rut_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = Ruta();
      reg.id=int.parse(query[0][0].toString());
        reg.nombre=query[0][1].toString();
        reg.descripcion=query[0][2].toString();
        reg.estado=int.parse(query[0][3].toString());
        reg.cupoMaximo=int.parse(query[0][4].toString());
        reg.color=query[0][5].toString();       
        reg.insId=int.parse(query[0][6].toString());  return reg;
    }
    else
    {
      return null;
    }
    
  }

  Future<void> ingresar(Ruta dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_ruta(rut_id, rut_nombre, rut_descripcion, rut_estado, rut_cupo_maximo, rut_color, ins_id,)"
   " VALUES (${dato.id},'${dato.nombre}', '${dato.descripcion}',${dato.estado},${dato.cupoMaximo},'${dato.color}')";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,Ruta dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_ruta SET rut_nombre='${dato.nombre}',rut_descripcion='${dato.descripcion}',rut_cupo_maximo=${dato.cupoMaximo},rut_color='${dato.color}'"
	  "WHERE rut_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_ruta SET rut_estado=1 WHERE rut_id=$id";
    await conexion.operaciones(sql.toString());
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