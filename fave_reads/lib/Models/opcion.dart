import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class Opcion extends Serializable {
  int id;
  int idpadre;
  String nombre;
  int estado;
  String ruta;

  Future<List> obtenerDatos() async {
    final conexion = Conexion();
    const String sql = "select * from public.te_opcion";
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = Opcion();
        reg.id = int.parse(query[i][0].toString());

        reg.idpadre = int.parse(query[i][1].toString());

        reg.nombre = query[i][2].toString();

        reg.estado = int.parse(query[i][3].toString());
        reg.ruta=query[i][4].toString();
        datos.add(reg.asMap());
        //print(datos);
      }
      return datos;
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic> asMap() =>
      {'nombre': nombre, 'id': id, 'idpadre': idpadre, 'estado': estado, 'ruta': ruta};

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = int.parse(object['id'].toString());
    idpadre = int.parse(object['idpadre'].toString());
    nombre = object['nombre'].toString();
    estado = int.parse(object['estado'].toString());
    ruta = object['ruta'].toString();
  }
}
