import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class Vehiculo extends Serializable
{
  
  int id;
  String placa;
  int    capacidad;
  int    estado;
  int    tveId;
  int    funId;
 
  Future<List> obtenerDatos(String campo, String bus, int est) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_vehiculo where $campo::text LIKE '%$bus%' and veh_estado=$est";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Vehiculo();
        
        reg.id=int.parse(query[i][0].toString());
        reg.placa=query[i][1].toString();
        reg.capacidad=int.parse(query[i][2].toString());
        reg.estado=int.parse(query[i][3].toString());
        reg.tveId=int.parse(query[i][4].toString());
        reg.funId=int.parse(query[i][5].toString());
        datos.add(reg.asMap()); 
      }
      return datos;
    }
    else
    {
      return null;
    }
    
  }

  Future<Vehiculo> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_vehiculo where veh_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = Vehiculo();
        reg.id=int.parse(query[0][0].toString());
        reg.placa=query[0][1].toString();
        reg.capacidad=int.parse(query[0][2].toString());
        reg.estado=int.parse(query[0][3].toString());
        reg.tveId=int.parse(query[0][4].toString());
        reg.funId=int.parse(query[0][5].toString());
        return reg;
    }
    else
    {
      return null;
    }
    
  }

  Future<void> ingresar(Vehiculo dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_vehiculo(veh_placa, veh_capacidad, veh_estado, tveId, funId)"
   " VALUES ('${dato.placa}',${dato.capacidad},${dato.estado},${dato.tveId}, ${dato.funId})";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,Vehiculo dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_vehiculo SET veh_placa='${dato.placa}',veh_capacidad='${dato.capacidad}', veh_estado='${dato.estado}', funId='${dato.funId}' "
	  "WHERE veh_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_vehiculo SET veh_estado=1 WHERE vehi_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {
    'id': id,
    'placa': placa,
    'capacidad': capacidad,
    'estado': estado,
    'tveId': tveId,
    'funId': funId
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id= int.parse(object['id'].toString());
    placa= object['placa'].toString();
    capacidad= int.parse(object['capacida'].toString());
    estado=int.parse( object['estado'].toString());
    tveId=int.parse( object['tveId'].toString());
    funId=int.parse( object['funId'].toString());
  
  }

}