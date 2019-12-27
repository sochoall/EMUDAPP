import 'package:app_movil/transportista/models/objetos_perdidos_model.dart';
import 'package:app_movil/transportista/tabs/edit_objeto_perdido_page.dart';
import 'package:app_movil/transportista/widgets/estado_objeto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'objetos_perdidos_seleccionar_fecha_page.dart';

class objetosPerdidosPage extends StatefulWidget {
  @override
  final String idRecorrido;
  objetosPerdidosPage(this.idRecorrido);
  _objetosPerdidosPageState createState() =>
      _objetosPerdidosPageState(idRecorrido);
}

class _objetosPerdidosPageState extends State<objetosPerdidosPage> {
  final String idRecorrido;
  _objetosPerdidosPageState(this.idRecorrido);
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<estadoObjeto> estadoDeObjetos = List<estadoObjeto>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Objetos Perdidos"),
      ),
      key: scaffoldKey,
      body: _crearListado(context),
      floatingActionButton: _crearBoton(context),
    );
  }

  Future<void> _getEstadoObjeto() async {
    final response = await http.get("http://192.168.137.1:8888/estadoObjetos");
    var jsonData = json.decode(response.body);
    for (var object in jsonData) {
      estadoObjeto estadoObjetos = estadoObjeto();
      estadoObjetos.id = int.parse(object['id'].toString());
      estadoObjetos.nombre = object['nombre'].toString();
      estadoDeObjetos.add(estadoObjetos);
    }
  }

  @override
  void initState() {
    _getEstadoObjeto().then((result) {
      setState(() {});
    });
    super.initState();
  }

  Future<List<objetosPerdidoss>> _getObjetosPerdidos() async {
    final response = await http
        .get("http://192.168.137.1:8888/objetosPerdidos/$idRecorrido");
    var jsonData = json.decode(response.body);
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
      objetos.add(object);
    }
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

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.calendar_today),
        backgroundColor: Colors.cyan,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext contexto) =>
                  objetosPerdidosSeleccionarFechaPage(idRecorrido)));
        });
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
                    fontSize: 15.0,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext contexto) =>
                          editObjetosPerdidosPage(objeto, idRecorrido)));
                }),
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
