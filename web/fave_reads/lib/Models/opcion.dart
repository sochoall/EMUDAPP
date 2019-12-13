import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/Models/opcion_rol.dart';
import 'package:fave_reads/fave_reads.dart';

class Opcion extends Serializable {
  int id;
  String idpadre;
  String nombre;
  int estado;
  String url;

  Future<List> obtenerPadres(int id) async {
    final conexion = Conexion();
    final String sql = "select o.opc_id, o.opc_padre_id, o.opc_nombre, o.opc_estado, o.opc_url from te_opcion_rol r, te_opcion o where r.opc_id=o.opc_id and r.rol_id=$id order by 1";
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

  Future<List> obtenerPadresHijos(String id) async {
    final String sql = "select k.id,k.nom,k.opc_id,k.opc_nombre from (select p.id,p.nom,m.opc_id,m.opc_nombre from (select o.opc_id as id,o.opc_nombre as  nom from te_opcion_rol r, te_opcion o "
                      " where r.opc_id=o.opc_id and r.rol_id=$id and opc_padre_id is null and o.opc_estado = 1) as p,te_opcion m "
                      " where m.opc_padre_id=p.id order by 1) as k, te_opcion_rol a"
                      " where a.opc_id=k.opc_id and rol_id=$id";
    final reg = OpcionRol();
    
    return reg.obtenerHijos(sql);
  }

 


  Future<List> obtenerHijosRolId(String id) async {
    final String sql = "select o.opc_id,o.opc_padre_id,o.opc_nombre,o.opc_estado,o.opc_url from te_opcion_rol r, te_opcion o  where r.opc_id=o.opc_id and r.rol_id=$id and o.opc_padre_id is null and o.opc_url is null";
    final reg = OpcionRol();
    
    return reg.obtenerOpcionesHijo(sql);
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
      {'nombre': nombre, 'id': id, 'idpadre': idpadre, 'estado': estado,'url':url};

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = int.parse(object['id'].toString());
    idpadre = object['idpadre'].toString();
    nombre = object['nombre'].toString();
    estado = int.parse(object['estado'].toString());
    url = object['url'].toString();
  }
}
