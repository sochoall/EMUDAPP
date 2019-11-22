import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

import 'opcion.dart';

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


  Future<void> ingresar(OpcionRol dato) async{
    final conexion = Conexion();
    final String sql = "Insert into te_opcion_rol values(${dato.id},${dato.idhijo})";
    await conexion.operaciones(sql);
  }

  Future<void> eliminar(int id,OpcionRol dato) async{
    final conexion = Conexion();
    final String sql = 
    "Delete from public.te_opcion_rol where rol_id=${dato.id} and opc_id=${dato.idhijo} ";

    print(sql);
    await conexion.operaciones(sql);
  }
 
  @override
  Map<String, dynamic> asMap() =>
      {'id': id, 'nombre': nombre,  'idhijo': idhijo, 'nombrehijo': nombrehijo};

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'].toString();
    nombre = object['nombre'].toString();
    idhijo = object['idhijo'].toString();
    nombrehijo = object['nombrehijo'].toString();
  }
}
