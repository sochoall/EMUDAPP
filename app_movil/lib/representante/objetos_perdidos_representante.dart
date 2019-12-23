import 'package:app_movil/transportista/models/objetos_perdidos_model.dart';
import 'package:app_movil/transportista/tabs/add_objeto_perdido_page.dart';
import 'package:app_movil/transportista/tabs/edit_objeto_perdido_page.dart';
import 'package:app_movil/transportista/widgets/estado_objeto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

class objetosPerdidosRep extends StatefulWidget {
  @override
  final String idRecorrido;
  objetosPerdidosRep(this.idRecorrido);
  _objetosPerdidosPageStateR createState() => _objetosPerdidosPageStateR(idRecorrido);
}

class _objetosPerdidosPageStateR extends State<objetosPerdidosRep> {
  final formKey = GlobalKey<FormState>();
    final String idRecorrido;
    _objetosPerdidosPageStateR(this.idRecorrido);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<estadoObjeto> estadoDeObjetos = List<estadoObjeto>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("Objetos Perdidos."),
        ),
      key: scaffoldKey,
      body: _crearListado(context),
    );
  }

  Future<void> _getEstadoObjeto() async {
    final response = await http.get("http://192.168.137.1:8888/estadoObjetos");

    var jsonData = json.decode(response.body);

    for (var object in jsonData) {
      estadoObjeto estadoObjetos = estadoObjeto();

      estadoObjetos.id = int.parse(object['id'].toString());
      estadoObjetos.nombre = object['nombre'].toString();

      print(object['nombre'].toString() + "---------------------------");
      estadoDeObjetos.add(estadoObjetos);
    }

    //print("ESTUDIANTES:---------->" + estudiantes.length.toString());
  }

  @override
  void initState() {
    _getEstadoObjeto().then((result) {
      setState(() {});
    });

    super.initState();
  }

  Future<List<objetosPerdidoss>> _getObjetosPerdidos() async {
    final response = await http.get("http://192.168.137.1:8888/objetosPerdidos/$idRecorrido");
    var jsonData = json.decode(response.body);
    //final List<objetosPerdidoss> objetos = List();
    List<objetosPerdidoss> objetos = List<objetosPerdidoss>();

    for (var ob in jsonData) {
      objetosPerdidoss object = objetosPerdidoss();
      object.id = int.parse(ob['id'].toString());
      object.fechaHora = ob['fechaHora'].toString();
      object.descripcion = ob['descripcion'].toString();
      if (ob['fechaDevolucion'] != null) {
        object.fechaDevolucion = ob['fechaDevolucion'].toString();
      }
      object.recId = int.parse(ob['recId'].toString());
      object.eobId = int.parse(ob['eobId'].toString());
      // print(ob['descripcion'].toString());
      objetos.add(object);
    }

    //print("ESTUDIANTES:---------->" + objects.length.toString());
    return objetos;
  }

  String _getNombreEstadObjeto(int idEstado) {
    for (estadoObjeto item in estadoDeObjetos) {
      if (idEstado == item.id) {
        return item.nombre;
      }
    }
    return "No encontrado";
  }

  Widget _crearListado(BuildContext context) {
    return FutureBuilder(
      future: _getObjetosPerdidos(),
      builder: (BuildContext context,
          AsyncSnapshot<List<objetosPerdidoss>> snapshot) {
        if (snapshot.hasData) {
          final objetos = snapshot.data;
          //print(objetos);
          return ListView.builder(
            itemCount: objetos.length,
            itemBuilder: (context, i) => _crearItem(context, objetos[i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  
  Widget _crearItem(BuildContext context, objetosPerdidoss objeto) {
    var fechaEncontrado = objeto.fechaHora.split(" ");

    if (objeto.fechaDevolucion.toString().compareTo("") == 0) {
      //print("-------------ES NULO------------");
    }
    var fechaDevuelto = objeto.fechaDevolucion.split(" ");

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                "${objeto.descripcion}",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              subtitle: Text(
                "Encontrado:  " +
                    fechaEncontrado[0] +
                    "\n" +
                    "Estado:          " +
                    _getNombreEstadObjeto(objeto.eobId) +
                    "\n" +
                    "Devuelto:       " +
                    (fechaDevuelto[0].compareTo("") == 0
                        ? ""
                        : fechaDevuelto[0]),
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
             
            ),
            //SizedBox(height: 1.0,)
          ],
        ),
      ),
    );
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 3500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
