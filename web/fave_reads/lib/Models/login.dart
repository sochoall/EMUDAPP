import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class Login extends Serializable
{
  
  String usuario;
  String pss;
 

  Future<int>busquedaUsuario(Login dato) async
  {
    final conexion = Conexion();
        
    final String sql ="SELECT COUNT(*) FROM public.te_usuario WHERE usu_correo='${dato.usuario}'";
    final String sql2 ="SELECT COUNT(*) FROM public.te_usuario WHERE usu_correo='${dato.usuario}' and usu_password='${dato.pss}'";
    await conexion.conectar();
    final int cont=await conexion.busqueda(sql);
    final int cont2=await conexion.busqueda(sql2);

    if(cont > 0)
    {
      if(cont2 > 0)
      {
        final String sql ="SELECT usu_id FROM public.te_usuario WHERE usu_correo='${dato.usuario}' and usu_password='${dato.pss}'";
        final int d=await conexion.busqueda(sql).then((value){return value;});
        print(d);
        print('anterior es el id de si existe');
        return d;
        
      }
      else
      {
        return 0;
      }
    }
    else
    {
      return 0;
    }
  }

   

  @override
  Map<String, dynamic> asMap() => {
    'usuario': usuario,
    'pss': pss,
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    usuario= object['usuario'].toString();
    pss= object['pss'].toString();
  }


}