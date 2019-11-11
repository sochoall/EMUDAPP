import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/Models/hijo.dart';
import 'package:fave_reads/fave_reads.dart';

class Opcion extends Serializable {
  int id;
  String idpadre;
  String nombre;
  int estado;
  String url;
  String hijo;

  Future<List> obtenerPadres(int id) async {
    final conexion = Conexion();
    final String sql = "select o.opc_id, o.opc_padre_id, o.opc_nombre, o.opc_estado, o.opc_url from te_opcion_rol r, te_opcion o where r.opc_id=o.opc_id and r.rol_id=$id ";
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = Opcion();
        
        final reg2 = Hijo();
        reg.id = int.parse(query[i][0].toString());
        reg.idpadre = query[i][1].toString();
        reg.nombre = query[i][2].toString();
        reg.estado = int.parse(query[i][3].toString());
        reg.url=query[i][4].toString();
        reg.hijo= await reg2.obtenerhijos(query[i][0].toString());
        datos.add(reg.asMap());
      }
      
    } 

    return datos;
  }

   Future<List> obtenerOpcionesHijo(String sql) async {
    final conexion = Conexion();
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = Opcion();
        reg.id = int.parse(query[i][0].toString());
        reg.idpadre = query[i][1].toString();
        reg.nombre = query[i][2].toString();
        reg.estado = int.parse(query[i][3].toString());
        reg.url=query[i][4].toString();
        datos.add(reg.asMap());
      }
      
    } 

    return datos;
  }
 
  @override
  Map<String, dynamic> asMap() =>
      {'nombre': nombre, 'id': id, 'idpadre': idpadre, 'estado': estado,'url':url,'hijo':hijo};

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = int.parse(object['id'].toString());
    idpadre = object['idpadre'].toString();
    nombre = object['nombre'].toString();
    estado = int.parse(object['estado'].toString());
    url = object['url'].toString();
    hijo =  object['hijo'].toString();
  }
}
