import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

import 'opcion.dart';


class Hijo extends Serializable {
  String id;
  String idpadre;
  String nombre;
  String estado;
  String url;

  Future<List> obtenerSoloHijos(String id) async {
    final String sql = "select * from (select * from te_opcion p left join te_opcion_rol r on p.opc_id =r.opc_id "
    "where opc_padre_id=$id) l where l.rol_id is null";
    final reg= Opcion();
    return reg.obtenerOpcionesHijo(sql);
  }
  

  Future<String> obtenerhijos(String id) async {
    final conexion = Conexion();
    final String sql = "select * from te_opcion where opc_padre_id=$id";
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = Hijo();
        reg.id ='"' +query[i][0].toString()+'"';
        reg.idpadre ='"' +query[i][1].toString()+'"';
        reg.nombre ='"' + query[i][2].toString()+'"';
        reg.estado = '"' +query[i][3].toString()+'"';
        reg.url = '"' +query[i][4].toString()+'"';
        datos.add(reg.asMap());
      }
      print(datos);
      return datos.toString();
    } else {
      return null;
    }
  }

  Future<void> agregarPadre(int id,Opcion dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_opcion SET opc_padre_id='${dato.idpadre}' "
	  "WHERE opc_id=$id";
    await conexion.operaciones(sql);
  }

  @override
  Map<String, dynamic> asMap() =>
      {'"nombre"': nombre, '"id"': id, '"idpadre"': idpadre, '"estado"': estado,'"url"':url};

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'].toString();
    idpadre = object['idpadre'].toString();
    nombre = object['nombre'].toString();
    estado = object['estado'].toString();
    url= object['url'].toString();
  }
}
