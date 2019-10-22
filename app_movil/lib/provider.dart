import 'dart:convert';
import 'package:http/http.dart' as http;


final String ip = "192.168.137.1";

class _MenuProvider {                           //Provider que obtiene los datos Del jSon con opciones para el menu
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

class _ListaProvider {                        //Provider que obtiene las rutas del aqueduct

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

class _ListaParadasProvider {               //Provider que obtiene las paradas del aqueduct segun el id del recorrido
  final String aux; 
  _ListaParadasProvider(this.aux);
  List<dynamic> opciones = [];

  Future<List<dynamic>> cargarData2(aux) async {
    
    final response = await http.get("http://$ip:8888/parada/$aux");
    print(json.decode(response.body));
    return json.decode(response.body);
  }
}
final listaParadasProvider = new _ListaParadasProvider("");

class _ListaRecorridoSentidoProvider {         //Provider que obtiene los recorridos que posee una ruta (Ejemplo: 1 ruta tiene 2 recorrido ida y vuelta)
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


class _ListaEstudianteProvider {         //Provider que obtiene los recorridos que posee una ruta (Ejemplo: 1 ruta tiene 2 recorrido ida y vuelta)
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


class _MenuProviderRep {                           //Provider que obtiene los datos Del jSon con opciones para el menu
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