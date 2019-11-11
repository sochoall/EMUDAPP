import 'dart:async';
import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class Sesion extends Serializable
{
  
  int id;
  String inicio;
  String hash;
  String fin;
  int  estado;
  int    usuarioId;



  Future<void> ingresar(Sesion dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_sesiones(ses_fecha_hora_inicio, ses_hash, ses_fecha_hora_fin, ses_estado, usu_id)"
	                     "VALUES (${dato.inicio}, ${dato.hash},${dato.fin},${dato.estado},${dato.usuarioId})";
    //print(sql);
    await conexion.operaciones(sql);
  }


   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_sesiones SET ses_estado=1 WHERE ses_id=$id";
    await conexion.operaciones(sql.toString());
  }

  Future<int> busqueda(int id) async{
    final conexion = Conexion();
    final String sql = "SELECT count(*) FROM public.te_sesiones WHERE ses_id='$id'";
    print(sql);
    return await conexion.busqueda(sql);
  }

  @override
  Map<String, dynamic> asMap() => {
    'id': id,
    'inicio': inicio,
    'hash': hash,
    'fin': fin,
    'estado': estado,
    'usuarioId': usuarioId
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id= int.parse(object['id'].toString());
    inicio= object['inicio'].toString();
    hash= object['hash'].toString();
    fin= object['fin'].toString();
    estado=int.parse( object['estado'].toString());
    usuarioId=int.parse(object['usuarioId'].toString());
  }
}