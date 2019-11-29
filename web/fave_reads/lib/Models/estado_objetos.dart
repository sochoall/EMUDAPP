import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class EstadoObjetos extends Serializable {
  int id;
  String nombre;

  Future<List> obtenerDatos(String campo, String bus) async {
    final conexion = Conexion();
    final String sql =
        "select * from public.te_estado_objetos where $campo::text LIKE '%$bus%' order by eob_id DESC";
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = EstadoObjetos();

        reg.id = int.parse(query[i][0].toString());
        reg.nombre = query[i][1].toString();
        datos.add(reg.asMap());
      }
      return datos;
    } else {
      return null;
    }
  }

  Future<EstadoObjetos> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql =
        "select * from public.te_estado_objetos where eob_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if (query != null && query.isNotEmpty) {
      final reg = EstadoObjetos();
      reg.id = int.parse(query[0][0].toString());
      reg.nombre = query[0][1].toString();
      return reg;
    } else {
      return null;
    }
  }

  Future<void> ingresar(EstadoObjetos dato) async {
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_estado_objetos(eob_nombre)"
        " VALUES ( '${dato.nombre}')";
    print(sql);
    await conexion.operaciones(sql);
  }

  Future<void> modificar(int id, EstadoObjetos dato) async {
    final conexion = Conexion();
    final String sql =
        "UPDATE public.te_estado_objetos SET eob_nombre='${dato.nombre}'"
        "WHERE eob_id=$id";
    await conexion.operaciones(sql);
  }

  Future<void> eliminar(int id) async {
    final conexion = Conexion();
    final String sql = "DELETE FROM public.te_estado_objetos WHERE eob_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {'id': id, 'nombre': nombre};

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = int.parse(object['id'].toString());
    nombre = object['nombre'].toString();
  }
}
