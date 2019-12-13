import 'package:fave_reads/Models/conexion.dart';
import 'package:fave_reads/fave_reads.dart';


class Representante extends Serializable
{
  
  int id;
  String cedula;
  String nombre;
  String apellido;
  String direccion;
  String telefono;
  String celular;
  String correo;
  int estado;
 
  Future<List> obtenerDatos(String camp, String valor ,String est) async {
    final conexion = Conexion();
    String estado="";

    if(est == "2")
    {
      estado="1 and est_estado=0";
    }
    else{
      estado=est;
    }
    
    final String sql = "select * from public.te_representante  where $camp::text LIKE '%$valor%' and rep_estado=$estado order by rep_id ASC";
 
    final List datos=[];
    final List<dynamic> query = await conexion.obtenerTabla(sql);

    if(query != null && query.isNotEmpty)
    {
      for(int i=0; i<query.length;i++)
      {
        final reg = Representante();
        
        reg.id=int.parse(query[i][0].toString());
        reg.cedula=query[i][1].toString();
        reg.nombre=query[i][2].toString();
        reg.apellido=query[i][3].toString();
        reg.direccion=query[i][4].toString();
        reg.telefono=query[i][5].toString();
        reg.celular=query[i][6].toString();
        reg.correo=query[i][7].toString().replaceAll('*','@');
        reg.estado=int.parse(query[i][8].toString());
        datos.add(reg.asMap()); 
      }
      return datos;
    }
    else
    {
      return null;
    }
    
  }

  Future<Representante> obtenerDatoId(int id) async {
    final conexion = Conexion();
    final String sql = "select * from public.te_representante where rep_id=$id";

    final List<dynamic> query = await conexion.obtenerTabla(sql);
    if(query != null && query.isNotEmpty)
    { 
        final reg = Representante();
        reg.id=int.parse(query[0][0].toString());
        reg.cedula=query[0][1].toString();
        reg.nombre=query[0][2].toString();
        reg.apellido=query[0][3].toString();
        reg.direccion=query[0][4].toString();
        reg.telefono=query[0][5].toString();
        reg.celular=query[0][6].toString();
        reg.correo=query[0][7].toString().replaceAll('*','@');
        reg.estado=int.parse(query[0][8].toString());
        
        return reg;
    }
    else
    {
      return null;
    }
    
  }

  Future<void> ingresar(Representante dato) async{
    final conexion = Conexion();
    final String sql = "INSERT INTO public.te_representante(rep_id, rep_cedula, rep_nombre, rep_apellido, rep_direccion,rep_telefono, rep_celular,rep_correo,rep_estado)"
   " VALUES (${dato.id},'${dato.cedula}', '${dato.nombre}','${dato.apellido}','${dato.direccion}','${dato.telefono}', '${dato.celular}','${dato.correo.replaceAll('@','*')}',${dato.estado})";
    print(sql);
    await conexion.operaciones(sql);
  }

   Future<void> modificar(int id,Representante dato) async{
    final conexion = Conexion();
    final String sql = 
    "UPDATE public.te_representante SET rep_direccion='${dato.direccion}',rep_telefono='${dato.telefono}',rep_celular='${dato.celular}',rep_correo='${dato.correo}' "
	  "WHERE usu_id=$id";
    await conexion.operaciones(sql);
  }

   Future<void> eliminar(int id) async{
    final conexion = Conexion();
    final String sql = "UPDATE public.te_representante SET rep_estado=1 WHERE rep_id=$id";
    await conexion.operaciones(sql.toString());
  }

  @override
  Map<String, dynamic> asMap() => {
    'id': id,
    'cedula': cedula,
    'nombre': nombre,
    'apellido': apellido,
    'direccion': direccion,
    'telefono': telefono,
    'celular': celular,
    'correo' : correo,
    'estado' : estado  
  };

  @override
  void readFromMap(Map<String, dynamic> object) {
    id= int.parse(object['id'].toString());
    cedula= object['cedula'].toString();
    nombre= object['nombre'].toString();
    apellido= object['apellido'].toString();
    direccion= object['direccion'].toString();
    telefono= object['telefono'].toString();
    celular=object['celular'].toString();
    correo=object['correo'].toString();
    estado=int.parse(object['estado'].toString());
  }
  }


