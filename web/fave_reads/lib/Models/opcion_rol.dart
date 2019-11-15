import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class OpcionRol extends Serializable {
  String id;
  String nombre;
  String idhijo;
  String nombrehijo;

  Future<List> obtenerHijos(String sql) async {
    final conexion = Conexion();
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql.toString());
    
    
    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = OpcionRol();
        reg.id = query[i][0].toString();
        reg.nombre = query[i][1].toString();
        reg.idhijo = query[i][2].toString();
        reg.nombrehijo=query[i][3].toString();
        datos.add(reg.asMap());
      }
      
    } 
  print(datos);
    return datos;
  }

   /*Future<List> obtenerOpcionesHijo(String sql) async {
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
  }*/
 
  @override
  Map<String, dynamic> asMap() =>
      {'id': id, 'nombre': nombre,  'idhijo': idhijo, 'nombrehijo': nombrehijo};

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'].toString();
    nombre = object['idpadre'].toString();
    idhijo = object['estado'].toString();
    nombrehijo = object['url'].toString();
  }
}
