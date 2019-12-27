import 'package:app_movil/transportista/models/fechas_consulta_model.dart';
import 'package:app_movil/transportista/tabs/add_objeto_perdido_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'consulta_objetos_perdidos_page.dart';

class objetosPerdidosSeleccionarFechaPage extends StatefulWidget {
  @override
  final idRecorrido;
  objetosPerdidosSeleccionarFechaPage(this.idRecorrido);
  _objetosPerdidosSeleccionarFechaPageState createState() =>
      _objetosPerdidosSeleccionarFechaPageState(idRecorrido);
}

class _objetosPerdidosSeleccionarFechaPageState
    extends State<objetosPerdidosSeleccionarFechaPage> {
  final idRecorrido;
  _objetosPerdidosSeleccionarFechaPageState(this.idRecorrido);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  fechaConsulta objetoFechasConsulta = fechaConsulta();
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Objetos Perdidos"),
      ),
      body: _crearEncabezado(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.cyan,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext contexto) =>
                    addObjetosPerdidosPage(idRecorrido)));
          }),
    );
  }

  Widget _crearEncabezado(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height * 0.10,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  "Seleccione el rango de fechas",
                ),
                SizedBox(
                  height: 20.0,
                ),
                Icon(
                  Icons.calendar_today,
                  color: Colors.cyan,
                  size: 25.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                _crearFechaInicio(),
                _crearFechaFin(),
                SizedBox(
                  height: 30.0,
                ),
                _crearBoton(context)
              ],
            ),
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearFechaInicio() {
    List<String> arrayFecha;
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
      child: Row(children: <Widget>[
        Expanded(
            child: new TextFormField(
          decoration: new InputDecoration(
            icon: const Icon(Icons.calendar_today),
            labelText: 'Desde *',
            hintText: "Ejemplo:  mm/dd/aaaa",
          ),
          controller: _controller,
          keyboardType: TextInputType.datetime,
          validator: (val) => isValidDob(val) ? null : 'Fecha no válida',
          onSaved: (val) {
            arrayFecha = val.split("/");
            objetoFechasConsulta.fechaInicio =
                arrayFecha[1] + "-" + arrayFecha[0] + "-" + arrayFecha[2];
          },
        )),
        IconButton(
          icon: new Icon(Icons.more_horiz),
          tooltip: 'Choose date',
          onPressed: (() {
            _chooseDate(context, _controller.text);
          }),
        )
      ]),
    );
  }

  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now());
  }

  Widget _crearFechaFin() {
    List<String> arrayFecha;
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              //initialValue: FechaDevolucion[0],
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  labelText: 'Hasta',
                  hintText: "Ejemplo: mm/dd/aaaa"),
              controller: _controller2,
              keyboardType: TextInputType.datetime,
              onSaved: (value) {
                if (!value.isEmpty) {
                  arrayFecha = value.split("/");
                  objetoFechasConsulta.fechaFin =
                      arrayFecha[1] + "-" + arrayFecha[0] + "-" + arrayFecha[2];
                } else {}
              },
            ),
          ),
          IconButton(
            icon: new Icon(Icons.more_horiz),
            tooltip: 'Choose date',
            onPressed: (() {
              _chooseDate2(context, _controller2.text);
            }),
          )
        ],
      ),
    );
  }

  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;
    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  Future _chooseDate2(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);
    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());
    if (result == null) return;
    setState(() {
      _controller2.text = new DateFormat.yMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
          child: Text("Buscar"),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 0.0,
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            objetoFechasConsulta.fechaInicio =
                _controller.text.replaceAll("/", "-");
            objetoFechasConsulta.fechaFin =
                _controller2.text.replaceAll("/", "-");

            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext contexto) => consultaObjetosPerdidosPage(
                    objetoFechasConsulta, idRecorrido)));
          } else {
            mostrarSnackbar("Es necesario una fecha de inicio");
          }
        });
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 3500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
