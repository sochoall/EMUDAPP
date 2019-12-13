import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

class ListarCheckEstudiante extends Serializable 
{
  int id;
  String nombre;
  String apellido;
  int verificado;
  int monitoreo;

  Future<List> obtenerDatoId(int id) async 
  {
    final conexion = Conexion();
    final String sql = "select cest.ces_id, est.est_nombre, est.est_apellido, cest.ces_verificado, cest.mon_id from public.te_estudiante as est, public.te_monitoreo as moni, public.te_check_estudiante as cest, public.te_parada as par where est.est_id = cest.est_id and cest.mon_id = moni.mon_id and moni.par_id = par.par_id and par.par_id=$id";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if (query != null && query.isNotEmpty) 
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = ListarCheckEstudiante();
        
        reg.id = int.parse(query[i][0].toString());
        reg.nombre = query[i][1].toString();
        reg.apellido =query[i][2].toString();
        reg.verificado =int.parse(query[i][3].toString());
        reg.monitoreo =int.parse(query[i][4].toString());
        
        datos.add(reg.asMap());
      }
      return datos;
    } 
    else
      return null;
  }

  @override
  Map<String, dynamic> asMap() => 
  {
    'id': id,
    'nombre': nombre,
    'apellido': apellido,
    'verificado': verificado,
    'monitoreo': monitoreo,
  };

  @override
  void readFromMap(Map<String, dynamic> object) 
  {
    id = int.parse(object['id'].toString());
    nombre = object['nombre'].toString();
    apellido =object['apellido'].toString();
    verificado =int.parse(object['verificado'].toString());
    monitoreo =int.parse(object['monitoreo'].toString());
  }
}