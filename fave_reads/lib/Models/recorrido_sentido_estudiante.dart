import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class RecorridoSentidoEstudiante extends Serializable
{
  int rec_id;
  String sen_nombre;
  String rec_hora_inicio;
  String rec_hora_fin;
  String rut_nombre;
  
 
  Future<List> obtenerDatoId(int idest) async {
    final conexion = Conexion();

    final String sql = "SELECT rs.rec_id, se.sen_nombre,to_char(re.rec_hora_inicio, 'HH24:MI'),to_char(re.rec_hora_fin, 'HH24:MI'),ru.rut_nombre FROM public.te_servicio s, public.te_recorrido_servicio rs ,public.te_sentido se,public.te_recorrido re,public.te_ruta ru where s.ser_id=rs.ser_id and rs.rec_id=re.rec_id and re.sen_id=se.sen_id and ru.rut_id=re.rut_id and s.est_id=$idest";

    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = RecorridoSentidoEstudiante();
        
        reg.rec_id=int.parse(query[i][0].toString());
        reg.sen_nombre=query[i][1].toString();
        reg.rec_hora_inicio=query[i][2].toString();
        reg.rec_hora_fin=query[i][3].toString();
        reg.rut_nombre=query[i][4].toString();

        datos.add(reg.asMap()); 
      }
      return datos;
    }
    else
    {
      return null;
    }
    
  }


  @override
  Map<String, dynamic> asMap() => {
    'rec_id': rec_id,
    'sen_nombre': sen_nombre,
    'rec_hora_inicio': rec_hora_inicio,
    'rec_hora_fin': rec_hora_fin,
    'rut_nombre':rut_nombre
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    rec_id= int.parse(object['rec_id'].toString()); 
    sen_nombre= object['sen_nombre'].toString();
    rec_hora_inicio= object['rec_hora_inicio'].toString();
    rec_hora_fin= object['rec_hora_fin'].toString();
    rut_nombre= object['rut_nombre'].toString();
  }

}