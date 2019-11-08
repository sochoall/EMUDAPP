import 'dart:convert';
import 'dart:ffi';

import 'package:app_movil/transportista/models/registro_estudiantes_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class listado extends StatefulWidget {
  @override
  _listadoState createState() => _listadoState();
}

class _listadoState extends State<listado> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  List<Estudiante> estudiantes = List<Estudiante>();

  Future<void> _getEstudiantes() async {
    final response = await http.get("http://192.169.4.10:8888/estudiante");
    print(response);
    var jsonData = json.decode(response.body);

    for (var object in jsonData) {
      Estudiante estudiante = Estudiante();

      estudiante.id = int.parse(object['id'].toString());
      estudiante.cedula = object['cedula'].toString();
      estudiante.nombre = object['nombre'].toString();
      estudiante.apellido = object['apellido'].toString();
      estudiante.direccion = object['direccion'].toString();
      estudiante.telefono = object['telefono'].toString();
      estudiante.correo = object['correo'].toString();
      estudiante.estado = int.parse(object['estado'].toString());
      estudiante.insId = int.parse(object['insId'].toString());
      estudiante.verificado = false;

      //print(object['nombre'].toString());
      estudiantes.add(estudiante);
    }

    //print("ESTUDIANTES:---------->" + estudiantes.length.toString());
  }

  _makePostRequest() async {
    var url = "http://192.169.4.10:8888/check_estudiante";

    Map<String, String> headers = {"Content-type": "application/json"};
    String json = "";
    for (Estudiante estudiante in estudiantes) {
      if (estudiante.verificado == false) {
        json =
            '{"ces_id": "0", "ces_verificado": "0", "mon_id": "0", "est_id": "${estudiante.id}"}';
      } else {
        json =
            '{"ces_id": "0", "ces_verificado": "1", "mon_id": "0", "est_id": "${estudiante.id}"}';
      }

      print(json);

      Response response = await http.post(url, headers: headers, body: json);
      int statusCode = response.statusCode;
      String body = response.body;
      print(body);
    }
    mostrarSnackbar("Guardado con éxito.");
  }

  @override
  void initState() {
    super.initState();
    _getEstudiantes().then((result) {
      print("Todo BIEN");
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
              value: estudiantes[i].verificado,
              controlAffinity: ListTileControlAffinity.platform,
              title: Text(estudiantes[i].nombre),
              subtitle: Text(estudiantes[i].direccion),
              activeColor: Colors.cyan,
              onChanged: (bool value) {
                setState(() {
                  estudiantes[i].verificado = value;
                });
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            var url = "http://192.169.4.10s:8888/check_estudiante";

            Map<String, String> headers = {"Content-type": "application/json"};
            String json = "";
            for (Estudiante estudiante in estudiantes) {
              if (estudiante.verificado == false) {
                json =
                    '{"ces_id": "0", "ces_verificado": "0", "mon_id": "0", "est_id": "${estudiante.id}"}';
              } else {
                json =
                    '{"ces_id": "0", "ces_verificado": "1", "mon_id": "0", "est_id": "${estudiante.id}"}';
              }

              print(json);

              Response response =
                  await http.post(url, headers: headers, body: json);
              int statusCode = response.statusCode;
              String body = response.body;
              print(body);
            }
            mostrarSnackbar("Guardado con éxito.");

            Navigator.pop(context);
          } catch (e) {
            mostrarSnackbar(e.toString());
          }
        },
        label: Text('Guardar'),
        icon: Icon(Icons.save),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 9000),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
