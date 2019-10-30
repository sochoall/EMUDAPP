import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class Usuario extends Serializable
{
  
  int id;
  String correo;
  String password;
  int    estado;
  int    rep_id;
  int    fun_id;
  int    rol_id;
  int    est_id;
 
  Future<List> obtenerDatos() async {
    final conexion = Conexion();
    const String sql = "select * from public.te_usuario where usu_estado=1";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Usuario();
        
        reg.id=int.parse(query[i][0].toString());
        reg.correo=query[i][1].toString();
        reg.password=query[i][2].toString();
        
        
        reg.estado=int.parse(query[i][3].toString());
      
        
        reg.rep_id=int.parse(query[i][4].toString());
        
        
        reg.fun_id=int.parse(query[i][5].toString());
       
        reg.rol_id=int.parse(query[i][6].toString());
      
        reg.est_id=int.parse(query[i][7].toString());
        datos.add(reg.asMap()); 
      }
      return datos;
    }
    else
    {
      return null;
    }
    
  }

  Future<Usuario> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_usuario where usu_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = Usuario();
      reg.id=int.parse(query[0][0].toString());
        reg.correo=query[0][1].toString();
        reg.password=query[0][2].toString();
        reg.estado=int.parse(query[0][3].toString());
        reg.rep_id=int.parse([0][4].toString());
        reg.fun_id=int.parse([0][5].toString().replaceAll('*','@'));
        reg.rol_id=int.parse(query[0][6].toString());
        reg.est_id=int.parse(query[0][7].toString());
        return reg;
    }
    else
    {
      return null;
    }
    
  }

  Future<void> ingresar(Usuario dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_usuario(usu_id, usu_correo, usu_password, usu_estado, rep_id, fun_id, rol_id, est_id)"
   " VALUES (${dato.id},'${dato.correo.replaceAll('@','*')}', '${dato.password}',${dato.estado},${dato.rep_id},${dato.fun_id}, ${dato.rol_id}, ${dato.est_id})";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,Usuario dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_usuario SET usu_password='${dato.password}' "
	  "WHERE usu_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_usuario SET usu_estado=1 WHERE usu_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {
    'id': id,
    'correo': correo,
    'password': password,
    'estado': estado,
    'rep_id': rep_id,
    'fun_id': fun_id,
    'rol_id': rol_id,
    'est_id' : est_id 
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id= int.parse(object['id'].toString());
    correo= object['correo'].toString();
    password= object['password'].toString();
    estado=int.parse( object['estado'].toString());
    rep_id=int.parse( object['rep_id'].toString());
    fun_id=int.parse( object['fun_id'].toString());
    rol_id=int.parse(object['rol_id'].toString());
    est_id=int.parse(object['est_id'].toString());
  }

Future<String>busquedaUsuario(String correo,String cod)async{
final conexion = Conexion();
    
final String sql ="SELECT COUNT(correo) FROM public.te_usuario WHERE usu_correo=$correo";
final String sql2 ="SELECT COUNT(correo) FROM public.te_usuario WHERE usu_correo=$correo and usu_password=$cod";
if (await conexion.busqueda(sql.toString())>0)
{
  if(await conexion.busqueda(sql2.toString())>0)
  return "existe";
  else{
    return "incorrecta ";
  }
}
else{
  return "no existe";
}


}
}