import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_movil/transportista/models/registro_estudiantes_model.dart';

class listado extends StatefulWidget {
  @override
  final idParada;
  listado(this.idParada);
  _listadoState createState() => _listadoState(idParada);
}

class _listadoState extends State<listado> {
  final idParada;
  _listadoState(this.idParada);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Estudiante> estudiantes = List<Estudiante>();
  Future<void> _getEstudiantes() async {
    final response =
        await http.get("http://192.168.137.1:8888/listarCEstudiante/$idParada");
    var jsonData = json.decode(response.body);
    for (var object in jsonData) {
      Estudiante estudiante = Estudiante();
      estudiante.id = int.parse(object['id'].toString());
      estudiante.nombre = object['nombre'].toString();
      estudiante.apellido = object['apellido'].toString();
      estudiante.verificado = int.parse(object['verificado'].toString());
      estudiante.monitoreo = int.parse(object['monitoreo'].toString());
      estudiantes.add(estudiante);
    }
  }
  @override
  void initState() {
    super.initState();
    _getEstudiantes().then((result) {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: ListView.builder(
          itemCount: estudiantes.length,
          itemBuilder: (BuildContext context, int i) {
            return CheckboxListTile(
              value: estudiantes[i].verificado == 1 ? true : false,
              controlAffinity: ListTileControlAffinity.platform,
              title:
                  Text(estudiantes[i].nombre + " " + estudiantes[i].apellido),
              activeColor: Colors.cyan,
              onChanged: (bool value) {
                setState(() {
                  estudiantes[i].verificado = value ? 1 : 0;
                });
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            var url = "http://192.168.137.1:8888/check_estudiante";
            Map<String, String> headers = {"Content-Type": "application/json"};
            String json = "";
            for (Estudiante estudiante in estudiantes) {
              json =
                  '{"ces_id": "0", "ces_verificado": "${estudiante.verificado}", "mon_id": "${estudiante.monitoreo}", "est_id": "${estudiante.id}"}';
              Response response =
                  await http.put(url, headers: headers, body: json);
              int statusCode = response.statusCode;
            }
          } catch (e) {
            print(e.toString());
          }
        },
        label: Text('Guardar'),
        icon: Icon(Icons.save),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
