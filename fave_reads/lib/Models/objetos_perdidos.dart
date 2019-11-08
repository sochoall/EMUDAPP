import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class ObjetosPerdidos extends Serializable {
  int id;
  String fechaHora;
  String descripcion;
  String fechaDevolucion;
  int recId;
  int eobId;
  int estId;

  Future<List> obtenerDatos() async {
    final conexion = Conexion();
    const String sql =
        "select * from public.te_objetos_perdidos where eob_id!=0";
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = ObjetosPerdidos();

        if (query[i][1] != null) {
          reg.id = int.parse(query[i][0].toString());
        } else {
          reg.id = 1;
        }

        if (query[i][1] != null) {
          reg.fechaHora = query[i][1].toString();
        } else {
          reg.fechaHora = "";
        }

        if (query[i][2] != null) {
          reg.descripcion = query[i][2].toString();
        } else {
          reg.descripcion = "";
        }

        if (query[i][3] != null) {
          reg.fechaDevolucion = query[i][3].toString();
        } else {
          reg.fechaDevolucion = "";
        }

        if (query[i][4] != null) {
          reg.recId = int.parse(query[i][4].toString());
        } else {
          reg.recId = 0;
        }

        if (query[i][5] != null) {
          reg.eobId = int.parse(query[i][5].toString());
        } else {
          reg.eobId = 0;
        }

        if (query[i][6] != null) {
          reg.estId = int.parse(query[i][6].toString());
        } else {
          reg.estId = 0;
        }

        datos.add(reg.asMap());
      }
      return datos;
    } else {
      return null;
    }
  }

/*
  Future<ObjetosPerdidos> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql =
        "select * from public.te_objetos_perdidos where rut_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if (query != null && query.isNotEmpty) {
      final reg = ObjetosPerdidos();
      reg.id = int.parse(query[0][0].toString());
      reg.fechaHora = query[0][1].toString();
      reg.descripcion = query[0][2].toString();
      reg.fechaDevolucion = query[0][3].toString();
      reg.recId = int.parse(query[0][4].toString());
      reg.eobId = int.parse(query[0][5].toString());
      reg.estId = int.parse(query[0][6].toString());

      return reg;
    } else {
      return null;
    }
  }
*/
  Future<List> obtenerDatoFechas(String fecha) async {
    final List<String> fechas = fecha.split("*");
    final String fechaInicio = fechas[0];
    final String fechaFin = fechas[1];

    print("ENTRA EN OBJETOS PERDIDOS");
    print(fechas);

    String sql = "";
    if (fechas[1].isNotEmpty) {
      sql =
          "select * from public.te_objetos_perdidos where ope_fecha_hora>='$fechaInicio' and ope_fecha_devolucion<='$fechaFin'";
    } else {
      sql =
          "select * from public.te_objetos_perdidos where ope_fecha_hora>='$fechaInicio' and ope_fecha_devolucion is null";
    }

    print(sql);

    final conexion = Conexion();
    final List datos = [];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) {
      for (int i = 0; i < query.length; i++) {
        final reg = ObjetosPerdidos();

        if (query[i][1] != null) {
          reg.id = int.parse(query[i][0].toString());
        } else {
          reg.id = 1;
        }

        if (query[i][1] != null) {
          reg.fechaHora = query[i][1].toString();
        } else {
          reg.fechaHora = "";
        }

        if (query[i][2] != null) {
          reg.descripcion = query[i][2].toString();
        } else {
          reg.descripcion = "";
        }

        if (query[i][3] != null) {
          reg.fechaDevolucion = query[i][3].toString();
        } else {
          reg.fechaDevolucion = "";
        }

        if (query[i][4] != null) {
          reg.recId = int.parse(query[i][4].toString());
        } else {
          reg.recId = 0;
        }

        if (query[i][5] != null) {
          reg.eobId = int.parse(query[i][5].toString());
        } else {
          reg.eobId = 0;
        }

        if (query[i][6] != null) {
          reg.estId = int.parse(query[i][6].toString());
        } else {
          reg.estId = 0;
        }

        datos.add(reg.asMap());
      }
      return datos;
    } else {
      return null;
    }
  }

  Future<void> ingresar(ObjetosPerdidos dato) async {
    final conexion = Conexion();

    String sql = "";
    if (dato.fechaDevolucion.isEmpty) {
      sql =
          "INSERT INTO public.te_objetos_perdidos(ope_id, ope_fecha_hora, ope_descripcion, rec_id, eob_id,est_id)"
          " VALUES (${dato.id},'${dato.fechaHora}', '${dato.descripcion}',0,${dato.eobId},0)";
    } else {
      sql =
          "INSERT INTO public.te_objetos_perdidos(ope_id, ope_fecha_hora, ope_descripcion, ope_fecha_devolucion, rec_id, eob_id,est_id)"
          " VALUES (${dato.id},'${dato.fechaHora}', '${dato.descripcion}','${dato.fechaDevolucion}',0,${dato.eobId},0)";
    }

    print(sql);
    await conexion.operaciones(sql);
  }

  Future<void> modificar(int id, ObjetosPerdidos dato) async {
    final conexion = Conexion();
    String sql = "";
    if (dato.fechaDevolucion.isEmpty) {
      sql =
          "UPDATE public.te_objetos_perdidos SET ope_fecha_hora='${dato.fechaHora}', ope_descripcion='${dato.descripcion}', eob_id=${dato.eobId}"
          " WHERE ope_id=$id";
    } else {
      sql =
          "UPDATE public.te_objetos_perdidos SET ope_fecha_hora='${dato.fechaHora}', ope_descripcion='${dato.descripcion}', ope_fecha_devolucion='${dato.fechaDevolucion}', eob_id=${dato.eobId}"
          " WHERE ope_id=$id";
    }

    await conexion.operaciones(sql);
  }

  Future<void> eliminar(int id) async {
    final conexion = Conexion();
    final String sql =
        "UPDATE public.te_objetos_perdidos SET eob_id=0 WHERE ope_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {
        'id': id,
        'fechaHora': fechaHora,
        'descripcion': descripcion,
        'fechaDevolucion': fechaDevolucion,
        'recId': recId,
        'eobId': eobId,
        'estId': estId
      };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id = int.parse(object['id'].toString());
    fechaHora = object['fechaHora'].toString();
    descripcion = object['descripcion'].toString();
    fechaDevolucion = object['fechaDevolucion'].toString();
    recId = 0; //int.parse(object['recId'].toString());
    eobId = int.parse(object['eobId'].toString());
    estId = 0; //int.parse(object['estId'].toString());
  }
}
