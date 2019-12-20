import 'dart:convert';
import 'package:app_movil/bloc/login_bloc.dart';
import 'package:app_movil/main.dart';
import 'package:app_movil/transportista/tabs/rutas.dart';
import 'package:http/http.dart' as http;

final String ip = "192.168.137.1";

class _MenuProvider {
  //Provider que obtiene los datos Del jSon con opciones para el menu
  List<dynamic> opciones = [];
  _MenuProvider() {
    //cargarData();
  }

  Future<List<dynamic>> cargarData(aux) async {
    int aux1 = int.parse(aux);
    final response = await http.get("http://$ip:8888/funcionarioApp/$aux1");
    print(json.decode(response.body));

    return json.decode(response.body);
  }
}

final menuProvider = new _MenuProvider();

class _ListaProvider {
  //Provider que obtiene las rutas del aqueduct

  final String aux;
  _ListaProvider(this.aux);
  List<dynamic> opciones = [];
  Future<List<dynamic>> cargarData1(aux) async {
    int aux1 = int.parse(aux);
    final response = await http.get("http://$ip:8888/rutaApp/$aux1");
    print(json.decode(response.body));

    return json.decode(response.body);
  }
}

final listaProvider = new _ListaProvider("");

//class _ListaParadasProvider {               //Provider que obtiene las paradas del aqueduct segun el id del recorrido
//final String aux;
//_ListaParadasProvider(this.aux);
//List<dynamic> opciones = [];

//Future<List<dynamic>> cargarData2(aux) async {

//final response = await http.get("http://$ip:8888/parada/$aux");
//print(json.decode(response.body));
//return json.decode(response.body);
//}
//}
//final listaParadasProvider = new _ListaParadasProvider("");

class _ListaRecorridoSentidoProvider {
  //Provider que obtiene los recorridos que posee una ruta (Ejemplo: 1 ruta tiene 2 recorrido ida y vuelta)
  final String aux;
  _ListaRecorridoSentidoProvider(this.aux);
  List<dynamic> opciones = [];

  Future<List<dynamic>> cargarData3(aux) async {
    int aux1 = int.parse(aux);
    final response = await http.get("http://$ip:8888/recorridosentido/$aux");
    print(json.decode(response.body));
    return json.decode(response.body);
  }
}

final listaRecorridoSentido = new _ListaRecorridoSentidoProvider("");

class _ListaEstudianteProvider {
  //Provider que obtiene los recorridos que posee una ruta (Ejemplo: 1 ruta tiene 2 recorrido ida y vuelta)
  final String aux;
  _ListaEstudianteProvider(this.aux);
  List<dynamic> opciones = [];

  Future<List<dynamic>> cargarData4(aux) async {
    int aux1 = int.parse(aux);
    final response = await http.get("http://$ip:8888/estudianteApp/$aux");
    print(json.decode(response.body));
    return json.decode(response.body);
  }
}

final listaEstudiante = new _ListaEstudianteProvider("");

//-----------------------------------------------------------------------------------------------------------------

class _MenuProviderRep {
  //Provider que obtiene los datos Del jSon con opciones para el menu
  List<dynamic> opciones = [];
  _MenuProvider() {
    //cargarData();
  }
  Future<List<dynamic>> cargarData5(aux) async {
    int aux1 = int.parse(aux);
    final response = await http.get("http://$ip:8888/representanteApp/$aux1");
    print(json.decode(response.body));

    return json.decode(response.body);
  }
}

final menuProviderRep = new _MenuProviderRep();

//-----------------------------------------------------------------------------------------------------------------

class _ListaRecorridoSentidoEstudianteProvider {
  //Provider que obtiene los recorridos que posee una ruta (Ejemplo: 1 ruta tiene 2 recorrido ida y vuelta)
  final String aux;
  _ListaRecorridoSentidoEstudianteProvider(this.aux);
  List<dynamic> opciones = [];

  Future<List<dynamic>> cargarData6(aux) async {
    final response =
        await http.get("http://$ip:8888/recorridosentidoestudiante/$aux");
    print(json.decode(response.body));
    return json.decode(response.body);
  }
}

final listaRecorridoSentidoEstudiante =
    new _ListaRecorridoSentidoEstudianteProvider("");

//-----------------------------------------------------------------------------------------------------------------
class _ListaParadasProvider {
  final String aux;
  _ListaParadasProvider(this.aux);

  Future<List<Post>> cargarData7(idR) async {
    var response = await http.get("http://$ip:8888/parada/$idR");

    if (response.statusCode == 200) {
      final jsonresponse =
          json.decode(response.body).cast<Map<String, dynamic>>();
      List<Post> listOfRoutes = jsonresponse.map<Post>((json) {
        return Post.fromJson(json);
      }).toList();

      return listOfRoutes;
    } else
      throw Exception('Failed to get items');
  }
}

final listaParadasProvider = new _ListaParadasProvider("");

//--------------------------------------------------------------------------------------------------------
//Servicios Usados para Deteccion del Usuario 

class _serviciosLogin {
  final String id;
  LoginBloc bloc;
  _serviciosLogin(this.bloc, this.id);

  Future<String> consultar(LoginBloc bloc) async {
    final response = await http.get("http://$ip:8888/login/${bloc.cedula}*${bloc.password}");
    return Future.value(response.body);
  }

  Future<List> consultarRoles(id) async {
    final response = await http.get("http://$ip:8888/rol?op=$id");
    return json.decode(response.body);
  }
}
LoginBloc b;
final serviciosLogin = new _serviciosLogin(b, "");
