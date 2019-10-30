import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class RecorridoSentido extends Serializable
{
  
  int idrec;
  int idsen;
  String nombresen;
  int    estadorec;
  int idruta;
  String nombreruta;
 
  Future<List> obtenerDatoId(int idrec) async {
    final conexion = Conexion();

    final String sql = "select r.rec_id,s.sen_id,s.sen_nombre,r.rec_estado,r.rut_id,ru.rut_nombre from public.te_sentido s,public.te_recorrido r,public.te_ruta ru where r.sen_Id=s.sen_id and r.rec_estado=1 and r.rut_id=$idrec and ru.rut_id=r.rut_id";

    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = RecorridoSentido();
        
        reg.idrec=int.parse(query[i][0].toString());
        reg.idsen=int.parse(query[i][1].toString());
        reg.nombresen=query[i][2].toString(); 
        reg.estadorec=int.parse(query[i][3].toString());
        reg.idruta=int.parse(query[i][4].toString());
        reg.nombreruta=query[i][5].toString(); 
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
    'idrec': idrec,
    'idsen': idsen,
    'nombresen': nombresen,
    'estadorec': estadorec,
    'idruta':idruta,
    'nombreruta': nombreruta,
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    idrec= int.parse(object['idrec'].toString()); 
    nombresen= object['nombresen'].toString();
    idsen= int.parse(object['idsen'].toString());
    estadorec= int.parse(object['estadorec'].toString());
    idruta= int.parse(object['idruta'].toString());
    nombreruta= object['nombreruta'].toString();
  }

}