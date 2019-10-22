import 'package:app_movil/transportista/models/objetos_perdidos_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:intl/intl.dart' as prefix1;

class addObjetosPerdidosPage extends StatefulWidget {
  @override
  _addObjetosPerdidosPageState createState() => _addObjetosPerdidosPageState();
}

class _addObjetosPerdidosPageState extends State<addObjetosPerdidosPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  objetosPerdidoss objeto = objetosPerdidoss();
  bool _guardando = false;

  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final objetosPerdidoss objetoData =
        ModalRoute.of(context).settings.arguments;

    if (objetoData != null) {
      objeto = objetoData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Objeto Perdido",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                _crearDescripcion(),
                SizedBox(
                  height: 10.0,
                ),
                _crearFechaHora(),
                SizedBox(
                  height: 10.0,
                ),
                _crearFechaDevolucion(),
                SizedBox(
                  height: 15.0,
                ),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearDescripcion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          initialValue: objeto.descripcion,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              icon: const Icon(Icons.layers),
              labelText: 'Descripción del Objeto',
              hintText: "Ejemplo: ZAPATOS DEPORTIVOS BLANCOS TALLA 36"),
          keyboardType: TextInputType.multiline,
          validator: (value) {
            if (value.length <= 3) {
              return "Ingrese descripción del objeto.";
            } else {
              return null;
            }
          },
          onSaved: (value) => objeto.descripcion = value,
        ),
      ],
    );
  }

  Widget _crearFechaHora() {
    //List<String> FechaHora = objeto.fechaHora.split(" ");
    List<String> arrayFecha;
    return Row(children: <Widget>[
      Expanded(
          child: new TextFormField(
        decoration: new InputDecoration(
          icon: const Icon(Icons.calendar_today),
          labelText: 'Fecha en la que se encontro el objeto',
          hintText: "Ejemplo:  mm/dd/aaaa",
        ),
        controller: _controller,
        keyboardType: TextInputType.datetime,
        validator: (val) => isValidDob(val) ? null : 'Fecha no válida',
        onSaved: (val) {
          arrayFecha = val.split("/");
          objeto.fechaHora =
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
    ]);
  }

  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now());
  }

  Widget _crearFechaDevolucion() {
    List<String> arrayFecha;
    //List<String> FechaDevolucion = objeto.fechaDevolucion.split(" ");
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            //initialValue: FechaDevolucion[0],
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                icon: const Icon(Icons.calendar_today),
                labelText: 'Fecha en la que se devolvio el objeto',
                hintText: "Ejemplo: mm/dd/aaaa"),
            controller: _controller2,
            keyboardType: TextInputType.datetime,
            //validator: (val) => isValidDob(val) ? null : 'Fecha no válida',
            onSaved: (value) {
              if (!value.isEmpty) {
                arrayFecha = value.split("/");
                objeto.fechaDevolucion =
                    arrayFecha[1] + "-" + arrayFecha[0] + "-" + arrayFecha[2];
              }else{
                
              }
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
    );
  }

  _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      icon: Icon(Icons.save),
      color: Colors.cyan,
      textColor: Colors.white,
      label: Text("Guardar"),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (objeto.id == null) {
      try {
        var url = "http://192.168.1.5:8888/objetosPerdidos";

        Map<String, String> headers = {"Content-type": "application/json"};
        String json =
            '{"id": "17","descripcion": "${objeto.descripcion.toUpperCase()}", "fechaHora": "${objeto.fechaHora}", "fechaDevolucion": "${objeto.fechaDevolucion.toString()}", "recId": "","eobId": "1","stId": "" }';

        print(json);
        Response response = await http.post(url, headers: headers, body: json);
        int statusCode = response.statusCode;
        String body = response.body;
        print(body);
        mostrarSnackbar("Guardado con éxito.");
      } catch (e) {
        mostrarSnackbar(e.toString());
      }
    } else {
      try {
        var url = "http://192.168.1.5:8888/objetosPerdidos/${objeto.id}";
        Map<String, String> headers = {"Content-type": "application/json"};
        String json =
            '{"id": "${objeto.id}","descripcion": "${objeto.descripcion.toUpperCase()}", "fechaHora": "${objeto.fechaHora}", "fechaDevolucion": "${objeto.fechaDevolucion}", "recId": "","eobId": "","stId": "" }';
        print(json);
        Response response = await http.put(url, headers: headers, body: json);
        int statusCode = response.statusCode;
        String body = response.body;
        print(body);
        mostrarSnackbar("Guardado con éxito.");
      } catch (e) {
        mostrarSnackbar(e.toString());
      }
    }
    setState(() {
      _guardando = false;
    });

    mostrarSnackbar("Registro guardado con exito");

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 3500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
