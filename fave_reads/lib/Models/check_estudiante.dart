import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class CheckEstudiante extends Serializable 
{
  int est_id;
  int ces_verificado;
  int ces_id;
  int mon_id;

  Future<void> modificar(CheckEstudiante dato) async 
  {
    final conexion = Conexion();
    final String sql =
        "UPDATE public.te_check_estudiante SET ces_verificado='${dato.ces_verificado}'"
        "WHERE est_id=${dato.est_id}";
    await conexion.operaciones(sql);
  }

  @override
  Map<String, dynamic> asMap() => 
  {
    'ces_id': ces_id,
    'ces_verificado': ces_verificado,
    'mon_id': mon_id,
    'est_id': est_id
  };

  @override
  void readFromMap(Map<String, dynamic> object) 
  {
    ces_id = int.parse(object['ces_id'].toString());
    ces_verificado = int.parse(object['ces_verificado'].toString());
    mon_id = int.parse(object['mon_id'].toString());
    est_id = int.parse(object['est_id'].toString());
  }
}