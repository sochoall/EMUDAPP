import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class RepresentanteApp extends Serializable
{
  
  int id;
  String cedula;
  String nombre;
  String apellido;
  String direccion;
  String correo;

 
  Future<List> obtenerDatoId(int id) async {
   final conexion = Conexion();
    final String sql = "select re.rep_id,re.rep_cedula,re.rep_nombre,re.rep_apellido,re.rep_direccion,re.rep_correo from public.te_usuario u,public.te_representante re where u.usu_id=$id and re.rep_id=u.rep_id  and rep_estado=1";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = RepresentanteApp();
        
        reg.id=int.parse(query[i][0].toString());
        reg.cedula=query[i][1].toString();
        reg.nombre=query[i][2].toString();
        reg.apellido=query[i][3].toString();
        reg.direccion=query[i][4].toString();     
        reg.correo=query[i][5].toString();
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
    'cedula': cedula,
    'nombre': nombre,
    'apellido': apellido,
    'direccion': direccion,
    'correo' : correo,

  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id= int.parse(object['id'].toString());
    cedula= object['cedula'].toString();
    nombre= object['nombre'].toString();
    apellido= object['apellido'].toString();
    direccion= object['direccion'].toString();
    correo=object['correo'].toString();
  }
  }


