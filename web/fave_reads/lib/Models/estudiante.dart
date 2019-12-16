import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class Estudiante extends Serializable {
  String id;
  String cedula;
  String nombre;
  String apellido;
  String direccion;
  String telefono;
  String correo;
  String estado;
  String insId;

  Future<List> obtenerDatos(String camp, String valor, String est) async {
    final conexion = Conexion();
    final String sql =
        "select * from public.te_estudiante where $camp::text LIKE '%$valor%' and est_estado::text LIKE '%$est%' order by est_id DESC";
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = Estudiante();

        reg.id = query[i][0].toString();
        reg.cedula = query[i][1].toString();
        reg.nombre = query[i][2].toString();
        reg.apellido = query[i][3].toString();
        reg.direccion = query[i][4].toString();
        reg.telefono = query[i][5].toString();
        reg.correo = query[i][6].toString();
        reg.estado = query[i][7].toString();
        reg.insId = query[i][8].toString();
        datos.add(reg.asMap());
      }
    }
    return datos;
  }

  Future<List> obtenerDatosRepresentante(String id) async {
    final conexion = Conexion();
    final String sql =
        "select * from public.te_estudiante e, public.te_Estudiante_representante r where r.est_id=e.est_id and r.rep_id=$id";
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = Estudiante();

        reg.id = query[i][0].toString();
        reg.cedula = query[i][1].toString();
        reg.nombre = query[i][2].toString();
        reg.apellido = query[i][3].toString();
        reg.direccion = query[i][4].toString();
        reg.telefono = query[i][5].toString();
        reg.correo = query[i][6].toString();
        reg.estado = query[i][7].toString();
        reg.insId = query[i][8].toString();
        datos.add(reg.asMap());
      }
    }
    return datos;
  }


  
  Future<Estudiante> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_estudiante where est_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if (query != null && query.isNotEmpty) {
      final reg = Estudiante();
      reg.id = query[0][0].toString();
      reg.cedula = query[0][1].toString();
      reg.nombre = query[0][2].toString();
      reg.apellido = query[0][3].toString();
      reg.direccion = query[0][4].toString();
      reg.telefono = query[0][5].toString();
      reg.correo = query[0][6].toString().replaceAll('*', '@');
      reg.estado = query[0][7].toString();
      reg.insId = query[0][0].toString();
      return reg;
    } else {
      return null;
    }
  }

  Future<void> ingresar(Estudiante dato) async {
    final conexion = Conexion();
    final String sql =
        "INSERT INTO public.te_estudiante(est_cedula,est_nombre,est_apellido,est_direccion,est_telefono,est_correo,est_estado,ins_id)"
        " VALUES ('${dato.cedula}','${dato.nombre}','${dato.apellido}','${dato.direccion}', '${dato.telefono}', '${dato.correo.replaceAll('@', '*')}',${dato.estado},${dato.insId})";
    print(sql);
    await conexion.operaciones(sql);
  }

  Future<void> modificar(int id, Estudiante dato) async {
    final conexion = Conexion();
    final String sql =
        "UPDATE public.te_estudiante SET est_nombre='${dato.nombre}',est_apellido='${dato.apellido}',est_direccion='${dato.direccion}',est_correo='${dato.correo.replaceAll('@', '*')}' "
        "WHERE est_id=$id";
    await conexion.operaciones(sql);
  }

  Future<void> eliminar(int id) async {
    final conexion = Conexion();
    final String sql =
        "UPDATE public.te_estudiante SET est_estado=1 WHERE est_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {
        'id': id,
        'cedula': cedula,
        'nombre': nombre,
        'apellido': apellido,
        'direccion': direccion,
        'telefono': telefono,
        'correo': correo,
        'estado': estado,
        'insId': insId
      };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = object['id'].toString();
    cedula = object['cedula'].toString();
    nombre = object['nombre'].toString();
    apellido = object['apellido'].toString();
    direccion = object['direccion'].toString();
    telefono = object['telefono'].toString();
    correo = object['correo'].toString();
    estado = object['estado'].toString();
    insId = object['insId'].toString();
  }
}
