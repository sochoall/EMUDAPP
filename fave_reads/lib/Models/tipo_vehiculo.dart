import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class TipoVehiculo extends Serializable
{
  
  int id;
  String nombre;
  int    estado;
 
  Future<List> obtenerDatos() async {
    final conexion = Conexion();
    const String sql = "select * from public.te_tipo_vehiculo where tve_estado=0";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = TipoVehiculo();
        
        reg.id=int.parse(query[i][0].toString());
        reg.nombre=query[i][1].toString();
        reg.estado=int.parse(query[i][2].toString());
        datos.add(reg.asMap()); 
      }
      return datos;
    }
    else
    {
      return null;
    }
    
  }

  Future<TipoVehiculo> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_tipo_vehiculo where tve_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = TipoVehiculo();
      reg.id=int.parse(query[0][0].toString());
        reg.nombre=query[0][1].toString();
        reg.estado=int.parse(query[0][2].toString());
        return reg;
    }
    else
    {
      return null;
    }
    
  }

  Future<void> ingresar(TipoVehiculo dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_tipo_vehiculo(tve_id, tve_nombre,tve_estado)"
   " VALUES (${dato.id},'${dato.nombre}',${dato.estado}";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,TipoVehiculo dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_tipo_vehiculo SET tve_nombre='${dato.nombre}' "
	  "WHERE tve_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_tipo_vehiculo SET tve_estado=1 WHERE usu_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {
    'id': id,
    'nombre': nombre,
    'estado': estado 
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id= int.parse(object['id'].toString());
    nombre= object['nombre'].toString();
    estado=int.parse( object['estado'].toString());
  }
}