import 'package:app_movil/transportista/models/fechas_consulta_model.dart';
import 'package:app_movil/transportista/models/objetos_perdidos_model.dart';
import 'package:app_movil/transportista/tabs/add_objeto_perdido_page.dart';
import 'package:app_movil/transportista/tabs/edit_objeto_perdido_page.dart';
import 'package:app_movil/transportista/widgets/estado_objeto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';

import 'objetos_perdidos_seleccionar_fecha_page.dart';

class consultaObjetosPerdidosPage extends StatefulWidget {
  @override
  final fechaConsulta objetoData;
  final idRecorrido;

  consultaObjetosPerdidosPage(this.objetoData,this.idRecorrido);

  _consultaObjetosPerdidosPageState createState() =>
      _consultaObjetosPerdidosPageState(objetoData,idRecorrido);
}

class _consultaObjetosPerdidosPageState
    extends State<consultaObjetosPerdidosPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
final fechaConsulta objetoData;
final idRecorrido;

_consultaObjetosPerdidosPageState(this.objetoData,this.idRecorrido);


  List<estadoObjeto> estadoDeObjetos = List<estadoObjeto>();
  fechaConsulta objeto = fechaConsulta();

  @override
  Widget build(BuildContext context) {
    //final fechaConsulta objetoData = ModalRoute.of(context).settings.arguments;

    if (objetoData != null) {
      objeto = objetoData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar( 
        title: Text("Objetos Perdidos"),
        ),
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

      print(object['nombre'].toString() + "---------------------------");
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

  Future<List<objetosPerdidoss>> _getObjetosPerdidos(
      String fechaInicios, String fechaFins) async {
    List<String> fechaConvert = objeto.fechaInicio.split("-");
     String fecha;
    String fechaInicio =
        fechaConvert[2] + "-" + fechaConvert[0] + "-" + fechaConvert[1];

    String fechaFin = "";
    if (objeto.fechaFin.isNotEmpty) {
      fechaConvert = objeto.fechaFin.split("-");
      fechaFin =
          fechaConvert[2] + "-" + fechaConvert[0] + "-" + fechaConvert[1];
    }
    else
    {
      DateTime now = DateTime.now();
      fecha = DateFormat('yyyy-MM-dd').format(now);
      print(fecha);
       fechaFin =fecha;
    }

    try {
      final response = await http.get(
          "http://192.168.137.1:8888/objetosPerdidos?f1=${fechaInicio}&f2=${fechaFin}&f3=$idRecorrido");

      print(
          "http://192.168.137.1:8888/objetosPerdidos?f1=${fechaInicio}&f2=${fechaFin}&f3=$idRecorrido");

      var jsonData = json.decode(response.body);      
      List<objetosPerdidoss> objetos = List<objetosPerdidoss>();

      for (var ob in jsonData) {
        objetosPerdidoss object = objetosPerdidoss();
        print(ob['id'].toString());
        object.id = int.parse(ob['id'].toString());
        object.fechaHora = ob['fechaHora'].toString();
        object.descripcion = ob['descripcion'].toString();
        if (ob['fechaDevolucion'] != null) {
          object.fechaDevolucion = ob['fechaDevolucion'].toString();
        }
        object.recId = int.parse(ob['recId'].toString());
        object.eobId = int.parse(ob['eobId'].toString());

        print(ob['descripcion'].toString());
        objetos.add(object);
      }

      return objetos;
    } catch (e) {
      return List<objetosPerdidoss>();
    }
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
      future: _getObjetosPerdidos(objeto.fechaInicio, objeto.fechaFin),
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
      child: Icon(Icons.add),
      backgroundColor: Colors.cyan,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext contexto) =>  objetosPerdidosSeleccionarFechaPage(idRecorrido)));
      }
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
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext contexto) =>  editObjetosPerdidosPage(objeto,idRecorrido)));
              }
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
