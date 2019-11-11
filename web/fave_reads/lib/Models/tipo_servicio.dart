import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class TipoServicio extends Serializable
{
  
  int id;
  String nombre;
  int estado;
 
 Future<List> obtenerDatos(String campo, String bus, String est) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_tipo_servicio where $campo::text LIKE '%$bus%' and tse_estado::text LIKE '%$est%' order by tse_id DESC";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = TipoServicio();
        
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

  Future<TipoServicio> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_tipo_servicio where tse_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = TipoServicio();
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

  Future<void> ingresar(TipoServicio dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_tipo_servicio(tse_nombre,tse_estado)"
                        "VALUES('${dato.nombre}',${dato.estado})";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,TipoServicio dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_tipo_servicio SET tse_nombre='${dato.nombre}', tse_estado='${dato.estado}' "
	  "WHERE tse_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_tipo_servicio SET tse_estado=1 WHERE usu_id=$id";
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