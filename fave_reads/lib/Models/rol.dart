import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class Rol extends Serializable
{
  
  int id;
  String nombre;
  int    estado;
 
  Future<List> obtenerDatos() async {
    final conexion = Conexion();
    const String sql = "select * from public.te_rol where rol_estado=1";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Rol();
        
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

  Future<Rol> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_rol where rol_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = Rol();
      reg.id=int.parse(query[0][0].toString());
        reg.nombre=query[0][1].toString();
        reg.estado=int.parse(query[0][3].toString());
        return reg;
    }
    else
    {
      return null;
    }
    
  }

  Future<void> ingresar(Rol dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_rol(rol_nombre, rol_estado)"
   " VALUES ('${dato.nombre}', ${dato.estado })";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,Rol dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_rol SET rol_nombre='${dato.nombre}', rol_estado=${dato.estado} "
	  "WHERE rol_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_rol SET rol_estado=1 WHERE rol_id=$id";
    await conexion.operaciones(sql.toString());
  }



  Future<List> obtenerRolesId(String id) async {
    final conexion = Conexion();
    //const String sql = "select * from public.te_rol where rol_estado=0";
    final String sql = "SELECT r.rol_id,r.rol_nombre FROM public.te_usuario_rol t, public.te_rol r WHERE t.rol_id=r.rol_id and t.usu_id=$id and r.rol_estado=1;";
    final List datos=[];
    print(sql);
    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Rol();
        
        reg.id=int.parse(query[i][0].toString());
        reg.nombre=query[i][1].toString();

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
    'estado': estado 
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id= int.parse(object['id'].toString());
    nombre= object['nombre'].toString();
    estado=int.parse( object['estado'].toString());
    
  }


}