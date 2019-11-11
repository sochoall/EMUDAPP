import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class Periodo extends Serializable
{
  
  int id;
  String nombre;
  String estado;


  Future<List> obtenerDatos(String campo, String bus, String est) async {
    final conexion = Conexion();
 
    final String sql = "select * from public.te_periodo_lectivo where $campo::text LIKE '%$bus%' and ple_estado::text LIKE '%$est%' order by ple_id DESC";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Periodo();
        
        reg.id=int.parse(query[i][0].toString());
        reg.nombre=query[i][1].toString();
        reg.estado=query[i][2].toString();
      
        datos.add(reg.asMap()); 
      }
      return datos;
    }
    else
    {
      return null;
    }
    
  }

  Future<Periodo> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_periodo_lectivo where ple_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = Periodo();
      reg.id=int.parse(query[0][0].toString());
        reg.nombre=query[0][1].toString();
        reg.estado=query[0][2].toString();
        return reg;
    }
    else
    {
      return null;
    }
    
  }

  Future<void> ingresar(Periodo dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_periodo_lectivo(ple_nombre, ple_estado)"
    " VALUES ('${dato.nombre}',${dato.estado});";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,Periodo dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_periodo_lectivo SET ple_nombre='${dato.nombre}', ple_estado='${dato.estado}'"
	  "WHERE ple_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_periodo_lectivo SET ple_estado=1 WHERE ple_id=$id";
    await conexion.operaciones(sql);
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
    estado=object['estado'].toString();
  }


}