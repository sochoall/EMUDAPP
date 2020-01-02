import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class EstudianteApp extends Serializable
{
  
  int id;
  String cedula;
  String nombre;
  String apellido;
  String direccion;
  String correo;
  String insNombre;
 
  Future<List> obtenerDatoId(int id) async 
  {
    final conexion = Conexion();
    final String sql = "select e.est_id,e.est_cedula,e.est_nombre,e.est_apellido,e.est_direccion,e.est_correo,i.ins_nombre from public.te_usuario u,public.te_estudiante_representante re,public.te_estudiante e,public.te_institucion i where u.usu_id=$id and re.rep_id=u.rep_id  and e.est_id=re.est_id and i.ins_id=e.est_id and est_estado=1";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = EstudianteApp();
        
        reg.id=int.parse(query[i][0].toString());
        reg.cedula=query[i][1].toString();
        reg.nombre=query[i][2].toString();        
        reg.apellido=query[i][3].toString();
        reg.direccion=query[i][4].toString();    
        reg.correo=query[i][5].toString();
        reg.insNombre=query[i][6].toString();

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
    'correo': correo,
    'insNombre':insNombre 
  };

  @override
  void readFromMap(Map<String, dynamic> object) 
  {
    id= int.parse(object['id'].toString());
    cedula= object['cedula'].toString();
    nombre= object['nombre'].toString();
    apellido= object['apellido'].toString();
    direccion= object['direccion'].toString();
    correo=object['correo'].toString();
    insNombre=object['insNombre'].toString();
  }
}