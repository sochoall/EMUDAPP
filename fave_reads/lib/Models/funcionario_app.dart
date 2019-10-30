import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class FuncionarioApp extends Serializable
{
  int id;
  String cedula;
  String nombre;
  String apellido;
  String direccion;
  String telefono;
  String celular;
  String correo;
  int estado;
  int institutoId;

  Future<List> obtenerDatoId(int id) async 
  {
   final conexion = Conexion();
    final String sql = "select f.fun_id,f.fun_cedula,f.fun_nombre,f.fun_apellido,f.fun_direccion,f.fun_telefono,f.fun_celular,f.fun_correo,f.fun_estado,f.ins_id from public.te_usuario u,public.te_funcionario f where u.usu_id=$id and f.fun_id=u.fun_id";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = FuncionarioApp();
        
        reg.id=int.parse(query[i][0].toString());
        reg.cedula=query[i][1].toString();
        reg.nombre=query[i][2].toString();
        reg.apellido=query[i][3].toString();
        reg.direccion=query[i][4].toString();
        reg.telefono=query[i][5].toString();
        reg.celular=query[i][6].toString();
        reg.correo=query[i][7].toString();
        reg.estado=int.parse(query[i][8].toString());
        reg.institutoId=int.parse(query[i][9].toString());
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
  Map<String, dynamic> asMap() => 
  {
    'id': id,
    'cedula': cedula,
    'nombre': nombre,
    'apellido': apellido,
    'direccion': direccion,
    'telefono': telefono,
    'celular': celular,
    'correo': correo,
    'estado': estado,
    'institutoId' : institutoId
  };

  @override
  void readFromMap(Map<String, dynamic> object) 
  {
    id= int.parse(object['id'].toString());
    cedula= object['cedula'].toString();
    nombre= object['nombre'].toString();
    apellido= object['apellido'].toString();
    direccion= object['direccion'].toString();
    telefono= object['telefono'].toString();
    celular= object['celular'].toString();
    correo= object['correo'].toString();
    estado=int.parse(object['estado'].toString());
    institutoId=int.parse(object['institutoId'].toString());
  }
}