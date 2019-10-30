import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class CheckEstudiante extends Serializable {
  int ces_id;
  int ces_verificado;
  int mon_id;
  int est_id;

  Future<List> obtenerDatos() async {

    print("-------------------------------------------------------");
    print("---------------ENTRA-- consulta--------------------------");
    print("-------------------------------------------------------");

    final conexion = Conexion();
    const String sql = "select * from public.te_check_estudiante ";
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = CheckEstudiante();

        if (query[i][0] != null) {
          reg.ces_id = int.parse(query[i][0].toString());
        } else {
          reg.ces_id = 0;
        }

        if (query[i][1] != null) {
          reg.ces_verificado = int.parse(query[i][1].toString());
        } else {
          reg.ces_verificado = 0;
        }
          
        if (query[i][2] != null) {
          reg.mon_id = int.parse(query[i][2].toString());
        } else {
          reg.mon_id = 0;
        }

        if (query[i][3] != null) {
          reg.est_id = int.parse(query[i][3].toString());
        } else {
          reg.est_id  = 0;
        }
        
        datos.add(reg.asMap());
      }
      return datos;
    } else {
      return null;
    }
  }

  Future<CheckEstudiante> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql =
        "select * from public.te_check_estudiante where ces_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if (query != null && query.isNotEmpty) {
      final reg = CheckEstudiante();
      reg.ces_id = int.parse(query[0][0].toString());
      reg.ces_verificado = int.parse(query[0][1].toString());
      reg.mon_id = int.parse(query[0][2].toString());
      reg.est_id = int.parse(query[0][3].toString());
      return reg;
    } else {
      return null;
    }
  }

  Future<void> ingresar(CheckEstudiante dato) async {

    final conexion = Conexion();
    print("---------------ENTRA----- ingreso-----------------------");
    final String sql =
        "INSERT INTO public.te_check_estudiante (est_id,ces_verificado)" 
        " VALUES (${dato.est_id},${dato.ces_verificado})";
    print(sql);
    await conexion.operaciones(sql);
  }
  

/*  Future<void> ingresar(ObjetosPerdidos dato) async {
    final conexion = Conexion();
    final String sql =
        "INSERT INTO public.te_objetos_perdidos(ope_id, ope_fecha_hora, ope_descripcion, ope_fecha_devolucion, rec_id, eob_id,est_id)"
        " VALUES (${dato.id},'${dato.fechaHora}', '${dato.descripcion}','${dato.fechaDevolucion}',0,0,0)";
    print(sql);
    await conexion.operaciones(sql);
  }*/
  /* Future<void> modificar(int id, CheckEstudiante dato) async {
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
  }*/

  @override
  Map<String, dynamic> asMap() => {
        'ces_id': ces_id,
        'ces_verificado': ces_verificado,
        'mon_id': mon_id,
        'est_id': est_id
      };

  @override
  void readFromMap(Map<String, dynamic> object) {
    ces_id = 0;//int.parse(object['ces_id'].toString());
    ces_verificado = int.parse(object['ces_verificado'].toString());
    mon_id = int.parse(object['mon_id'].toString());
    est_id = int.parse(object['est_id'].toString());
  }
}
