import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class Recorrido extends Serializable
{
  
  int id;
  String horaInicio;
  String horaFin;
  int    estado;
  int    senId;
  int    rutId;

  Future<int> obtenerNumeroElementos() async {
    final conexion = Conexion();
    const String sql = "select count(*) from public.te_recorrido";
    int datos= -1;
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      datos=int.parse(query[0][0].toString());
    }
     return datos;
  }
 
  Future<List> obtenerDatos() async {
    final conexion = Conexion();
    const String sql = "select * from public.te_recorrido where rec_estado=0";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Recorrido();
        
        reg.id=int.parse(query[i][0].toString());
        reg.horaInicio=query[i][1].toString();
        reg.horaFin=query[i][2].toString();        
        reg.estado=int.parse(query[i][3].toString());
        reg.senId=int.parse(query[i][4].toString());
        reg.rutId=int.parse(query[i][5].toString());
        datos.add(reg.asMap()); 
      }
      return datos;
    }
    else
    {
      return null;
    }
    
  }

  Future<Recorrido> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_recorrido where rec_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = Recorrido();
        reg.id=int.parse(query[0][0].toString());
        reg.horaInicio=query[0][1].toString();
        reg.horaFin=query[0][2].toString();        
        reg.estado=int.parse(query[0][3].toString());
        reg.senId=int.parse(query[0][4].toString());
        reg.rutId=int.parse(query[0][5].toString());
        return reg;
    }
    else
    {
      return null;
    }
    
  }

  Future<void> ingresar(Recorrido dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_recorrido(rec_id,rec_hora_inicio,rec_hora_fin,rec_estado,sen_id,rut_id)"
   " VALUES (${dato.id}, '${dato.horaInicio}','${dato.horaFin}',${dato.estado},${dato.senId}, ${dato.rutId})";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,Recorrido dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_recorrido SET rec_hora_inicio='${dato.horaInicio}',rec_hora_fin='${dato.horaFin}' "
	  "WHERE rec_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_recorrido SET rec_estado=1 WHERE rec_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {
    'id': id,
    'horaInicio': horaInicio,
    'horaFin': horaFin,
    'estado': estado,
    'senId': senId,
    'rutId': rutId,
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id= int.parse(object['id'].toString());
    horaInicio= object['horaInicio'].toString();
    horaFin= object['horaFin'].toString();
    estado= int.parse(object['estado'].toString());
    senId= int.parse(object['senId'].toString());
    rutId=int.parse(object['rutId'].toString());
  }

}