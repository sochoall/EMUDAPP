import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';

import 'opcion.dart';


class Servicio extends Serializable {
  String id;
  String fechaRegistro;
  String fechaFin;
  String observacion;
  String estado;
  String latitud;
  String longitud;
  String periodo;
  String cooperativa;
  String educativa;
  String estudiante;
  String funcionario;
  String tipoServicio;

   Future<List> obtenerDatos(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_servicio where ser_id=$id";
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Servicio();
        
        reg.id=query[i][0].toString();
        reg.fechaRegistro=query[i][1].toString();
        reg.fechaFin=query[i][2].toString();
        reg.observacion=query[i][3].toString();
        reg.estado=query[i][4].toString();
        reg.latitud=query[i][5].toString();
        reg.longitud=query[i][6].toString();
        reg.periodo=query[i][7].toString();
        reg.cooperativa=query[i][8].toString();
        reg.educativa=query[i][9].toString();
        reg.estudiante=query[i][10].toString();
        reg.funcionario=query[i][11].toString();
        reg.tipoServicio=query[i][12].toString();
        datos.add(reg.asMap()); 
      }
     
    }
     return datos;
    
  }

  

    Future<void> ingresar(Servicio dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_servicio(ser_fecha_registro, ser_fecha_fin, ser_observacion, ser_estado, ser_latitud, ser_longitud, ple_id, ins_coop_id, ins_edu_id, est_id, fun_id, tse_id)"
	                      " VALUES ('${dato.fechaRegistro}','${dato.fechaFin}','${dato.observacion}',${dato.estado},'${dato.latitud}','${dato.longitud}',${dato.periodo},${dato.cooperativa},${dato.educativa},${dato.estudiante},${dato.funcionario},${dato.tipoServicio});";
    await conexion.operaciones(sql);
  }



  @override
  Map<String, dynamic> asMap() =>
      {'id': id,'fechaRegistro':fechaRegistro,'fechaFin':fechaFin,'observacion':observacion,'estado':estado,'latitud':latitud,'longitud':longitud,'periodo':periodo,'cooperativa':cooperativa,'educativa':educativa,'estudiante':estudiante,'funcionario':funcionario,'tipoServicio':tipoServicio};

  @override
  void readFromMap(Map<String, dynamic> object) {


     id=object['id'].toString();
   fechaRegistro=object['fechaRegistro'].toString();
   fechaFin=object['fechaFin'].toString();
   observacion=object['observacion'].toString();
   estado=object['estado'].toString();
   latitud=object['latitud'].toString();
   longitud=object['longitud'].toString();
   periodo=object['periodo'].toString();
   cooperativa=object['cooperativa'].toString();
   educativa=object['educativa'].toString();
   estudiante=object['estudiante'].toString();
   funcionario=object['funcionario'].toString();
   tipoServicio=object['tipoServicio'].toString();
  }
}
