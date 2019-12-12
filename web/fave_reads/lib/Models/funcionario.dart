import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class Funcionario extends Serializable {
  int id;
  String cedula;
  String nombre;
  String apellido;
  String direccion;
  String telefono;
  String celular;
  String correo;
  int estado;
  int institutoId;

  Future<int> obtenerNumeroElementos() async {
    final conexion = Conexion();
    const String sql = "select max (fun_id) from public.te_funcionario";
    int datos = -1;
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      datos = int.parse(query[0][0].toString());
    }
    return datos;
  }

  Future<List> obtenerDatos(
      String campo, String bus, String est, String intitucionId) async {
    final conexion = Conexion();
    String sql;
    if (intitucionId != "")
      sql =
          "select * from public.te_funcionario where ins_id=$intitucionId and $campo::text LIKE '%$bus%' and fun_estado::text LIKE '%$est%' order by fun_id DESC";
    else
      sql =
          "select * from public.te_funcionario where $campo::text LIKE '%$bus%' and fun_estado::text LIKE '%$est%' order by fun_id DESC";
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = Funcionario();

        reg.id = int.parse(query[i][0].toString());
        reg.cedula = query[i][1].toString();
        reg.nombre = query[i][2].toString();
        reg.apellido = query[i][3].toString();
        reg.direccion = query[i][4].toString();
        reg.telefono = query[i][5].toString();
        reg.celular = query[i][6].toString();
        reg.correo = query[i][7].toString().replaceAll('*', '@');
        reg.estado = int.parse(query[i][8].toString());
        reg.institutoId = int.parse(query[i][9].toString());
        datos.add(reg.asMap());
      }
      return datos;
    } else {
      return null;
    }
  }

  Future<Funcionario> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_funcionario where fun_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if (query != null && query.isNotEmpty) {
      final reg = Funcionario();
      reg.id = int.parse(query[0][0].toString());
      reg.cedula = query[0][1].toString();
      reg.nombre = query[0][2].toString();
      reg.apellido = query[0][3].toString();
      reg.direccion = query[0][4].toString();
      reg.telefono = query[0][5].toString();
      reg.celular = query[0][6].toString();
      reg.correo = query[0][7].toString().replaceAll('*', '@');
      reg.estado = int.parse(query[0][8].toString());
      reg.institutoId = int.parse(query[0][9].toString());
      return reg;
    } else {
      return null;
    }
  }

  Future<void> ingresar(Funcionario dato) async {
    final conexion = Conexion();
    final String sql =
        "INSERT INTO public.te_funcionario(fun_cedula, fun_nombre, fun_apellido, fun_direccion, fun_telefono, fun_celular, fun_correo, fun_estado, ins_id)"
        " VALUES ('${dato.cedula}','${dato.nombre}','${dato.apellido}','${dato.direccion}','${dato.telefono}','${dato.celular}','${dato.correo.replaceAll('@', '*')}',${dato.estado},${dato.institutoId});";
    print(sql);
    await conexion.operaciones(sql);
  }

  Future<void> modificar(int id, Funcionario dato) async {
    final conexion = Conexion();

    final String sql =
        "UPDATE public.te_funcionario SET fun_cedula='${dato.cedula}', fun_nombre='${dato.nombre}', fun_apellido='${dato.apellido}', fun_direccion='${dato.direccion}', fun_telefono='${dato.telefono}', fun_celular='${dato.celular}', fun_correo='${dato.correo.replaceAll('@', '*')}',fun_estado='${dato.estado}', ins_id=${dato.institutoId}"
        "WHERE fun_id=$id";
    print(sql);
    await conexion.operaciones(sql);
  }

  Future<void> eliminar(int id) async {
    final conexion = Conexion();
    final String sql =
        "UPDATE public.te_funcionario SET fun_estado=1* WHERE fun_id=$id";
    await conexion.operaciones(sql);
  }

  @override
  Map<String, dynamic> asMap() => {
        'id': id,
        'cedula': cedula,
        'nombre': nombre,
        'apellido': apellido,
        'direccion': direccion,
        'telefono': telefono,
        'celular': celular,
        'correo': correo,
        'estado': estado,
        'institutoId': institutoId
      };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = int.parse(object['id'].toString());
    cedula = object['cedula'].toString();
    nombre = object['nombre'].toString();
    apellido = object['apellido'].toString();
    direccion = object['direccion'].toString();
    telefono = object['telefono'].toString();
    celular = object['celular'].toString();
    correo = object['correo'].toString();
    estado = int.parse(object['estado'].toString());
    institutoId = int.parse(object['institutoId'].toString());
  }
}
