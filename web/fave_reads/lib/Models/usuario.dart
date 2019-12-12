import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class Usuario extends Serializable {
  int id;
  String correo;
  String password;
  int estado;
  String repId;
  String funId;
  String estId;

  Future<List> obtenerDatos(String campo, String bus, String est) async {
    final conexion = Conexion();
    final String sql =
        "select * from public.te_usuario where $campo::text LIKE '%$bus%' and usu_estado::text LIKE '%$est%' order by usu_id DESC";

    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = Usuario();

        reg.id = int.parse(query[i][0].toString());
        reg.correo = query[i][1].toString();
        reg.password = query[i][2].toString();
        reg.estado = int.parse(query[i][3].toString());
        reg.repId = query[i][4].toString();
        reg.funId = query[i][5].toString();
        reg.estId = query[i][6].toString();

        datos.add(reg.asMap());
      }
      return datos;
    } else {
      return null;
    }
  }

  Future<Usuario> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_usuario where usu_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if (query != null && query.isNotEmpty) {
      final reg = Usuario();
      reg.id = int.parse(query[0][0].toString());
      reg.correo = query[0][1].toString();
      reg.password = query[0][2].toString();
      reg.estado = int.parse(query[0][3].toString());
      reg.repId = query[0][4].toString();
      reg.funId = query[0][5].toString();
      reg.estId = query[0][6].toString();
      return reg;
    } else {
      return null;
    }
  }

  Future<void> ingresar(Usuario dato) async {
    final conexion = Conexion();   
    final String sql =
        "INSERT INTO public.te_usuario(usu_correo, usu_password, usu_estado, rep_id, fun_id, est_id)"
        " VALUES ('${dato.correo.replaceAll('@', '*')}', '${dato.password}',${dato.estado},${dato.repId},${dato.funId}, ${dato.estId})";
    print(sql);
    await conexion.operaciones(sql);
  }

  Future<void> modificar(int id, Usuario dato) async {
    final conexion = Conexion();
    String sql = '';
    if (dato.password == "null") {
      sql =
          "UPDATE public.te_usuario SET usu_correo='${dato.correo}' , usu_estado=${dato.estado}"
          "WHERE usu_id=$id";
    } else {
      sql =
          "UPDATE public.te_usuario SET usu_password='${dato.password}' , usu_correo='${dato.correo}' , usu_estado=${dato.estado}"
          "WHERE usu_id=$id";
    }

    await conexion.operaciones(sql);
  }

  Future<void> eliminar(int id) async {
    final conexion = Conexion();
    final String sql =
        "UPDATE public.te_usuario SET usu_estado=1 WHERE usu_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {
        'id': id,
        'correo': correo,
        'password': password,
        'estado': estado,
        'repId': repId,
        'funId': funId,
        'estId': estId
      };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = int.parse(object['id'].toString());
    correo = object['correo'].toString();
    password = object['password'].toString();
    estado = int.parse(object['estado'].toString());
    repId = object['repId'].toString();
    funId = object['funId'].toString();
    estId = object['estId'].toString();
  }
}
