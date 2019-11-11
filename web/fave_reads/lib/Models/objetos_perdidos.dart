import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class ObjetosPerdidos extends Serializable
{
  
  int id;
  String fechaHora;
  String descripcion;
  String fechaDevolucion;
  int    recId;
  int    eobId;
  int    estId;

 
  Future<List> obtenerDatos() async {
    final conexion = Conexion();
    const String sql = "select * from public.te_objetos_perdidos where ope_estado=0";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = ObjetosPerdidos();
        
        reg.id=int.parse(query[i][0].toString());
        reg.fechaHora=query[i][1].toString();
        reg.descripcion=query[i][2].toString();
        reg.fechaDevolucion=query[i][3].toString();
        reg.recId=int.parse(query[i][4].toString());
        reg.eobId=int.parse(query[i][5].toString());       
        reg.estId=int.parse(query[i][6].toString());
  
        datos.add(reg.asMap()); 
      }
      return datos;
    }
    else
    {
      return null;
    }
    
  }

  Future<ObjetosPerdidos> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_objetos_perdidos where rut_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = ObjetosPerdidos();
        reg.id=int.parse(query[0][0].toString());
        reg.fechaHora=query[0][1].toString();
        reg.descripcion=query[0][2].toString();
        reg.fechaDevolucion=query[0][3].toString();
        reg.recId=int.parse(query[0][4].toString());
        reg.eobId=int.parse(query[0][5].toString());       
        reg.estId=int.parse(query[0][6].toString());
  
       return reg;
    }
    else
    {
      return null;
    }
    
  }

  Future<void> ingresar(ObjetosPerdidos dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_objetos_perdidos(ope_id, ope_fecha_hora, ope_descripcion, ope_fecha_devolucion, rec_id, eob_id,est_id,)"
   " VALUES (${dato.id},'${dato.fechaHora}', '${dato.descripcion}',${dato.fechaDevolucion},${dato.recId},${dato.eobId},${dato.estId})";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,ObjetosPerdidos dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_objetos_perdidos SET ope_fecha_hora='${dato.fechaHora}',ope_descripcion='${dato.descripcion}',ope_fecha_devolucion=${dato.fechaDevolucion}"
	  "WHERE ope_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_objetos_perdidos SET ope_estado=1 WHERE ope_id=$id";
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
    id= int.parse(object['id'].toString());
    fechaHora= object['fechaHora'].toString();
    descripcion= object['desccripcion'].toString();
    fechaDevolucion= object['fechaDevolucion'].toString();
    recId=int.parse( object['recId'].toString());
    eobId= int.parse(object['eobId'].toString());
    estId=int.parse(object['estId'].toString());
  }
}