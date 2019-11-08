import 'dart:convert';

import 'package:app_movil/transportista/models/objetos_perdidos_model.dart';
import 'package:app_movil/transportista/widgets/estado_objeto_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:intl/intl.dart' as prefix1;

class editObjetosPerdidosPage extends StatefulWidget {
  @override
  _editObjetosPerdidosPageState createState() =>
      _editObjetosPerdidosPageState();
}

class _editObjetosPerdidosPageState extends State<editObjetosPerdidosPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  objetosPerdidoss objeto = objetosPerdidoss();
  bool _guardando = false;

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedEstadoObjetoPerdido;

  List<estadoObjeto> estadoDeObjetos = List<estadoObjeto>();

  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();

  Future<void> _getEstadoObjeto() async {
    final response = await http.get("http://192.169.4.10:8888/estadoObjetos");
    var jsonData = json.decode(response.body);
    for (var object in jsonData) {
      estadoObjeto estadoObjetos = estadoObjeto();

      estadoObjetos.id = int.parse(object['id'].toString());
      estadoObjetos.nombre = object['nombre'].toString();
      estadoDeObjetos.add(estadoObjetos);
    }
    //print("ESTUDIANTES:---------->" + estudiantes.length.toString());
  }

  @override
  void initState() {
    _getEstadoObjeto().then((result) {
      _dropDownMenuItems = buildAndGetDropDownMenuItems(estadoDeObjetos);
      setState(() {});
    });
    super.initState();
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(
      List estadoDeObjetos) {
    List<DropdownMenuItem<String>> items = List();
    for (estadoObjeto estado in estadoDeObjetos) {
      items.add(DropdownMenuItem(
          value: estado.id.toString(), child: Text(estado.nombre)));
    }
    return items;
  }

  void changedDropDownItem(String selectedEstadoObjetoPerdido) {
    setState(() {
      _selectedEstadoObjetoPerdido = selectedEstadoObjetoPerdido;
      objeto.eobId = int.parse(selectedEstadoObjetoPerdido);
    });
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

  String _getNombreEstadObjeto(int idEstado) {
    for (estadoObjeto item in estadoDeObjetos) {
      print(item.nombre);
      if (idEstado == item.id) {
        return item.nombre;
      }
    }
    return "No encontrado";
  }

  @override
  Widget build(BuildContext context) {
    final objetosPerdidoss objetoData =
        ModalRoute.of(context).settings.arguments;

    if (objetoData != null) {
      objeto = objetoData;

      List<String> extraerFecha = objeto.fechaHora.split(" ");
      List<String> extraerDatosFecha = extraerFecha[0].split("-");

      _controller.text = extraerDatosFecha[1] +
          "/" +
          extraerDatosFecha[2] +
          "/" +
          extraerDatosFecha[0];

      if ((objeto.fechaDevolucion.compareTo("") == 0)) {
        _controller2.text = null;
      } else {
        extraerFecha = objeto.fechaDevolucion.split(" ");
        extraerDatosFecha = extraerFecha[0].split("-");

        _controller2.text = extraerDatosFecha[1] +
            "/" +
            extraerDatosFecha[2] +
            "/" +
            extraerDatosFecha[0];
      }

      print("---------------------------------");
      print("---------------------------------");
      print("---------------------------------");
      print(objeto.eobId);
      print("---------------------------------");
      print("---------------------------------");

      _selectedEstadoObjetoPerdido = objeto.eobId.toString();
    }

    return Scaffold(
      key: scaffoldKey,
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
                _crearCombo(),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
      child: Column(
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
      ),
    );
  }

  Widget _crearFechaHora() {
    //List<String> FechaHora = objeto.fechaHora.split(" ");
    List<String> arrayFecha;
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
      child: Row(children: <Widget>[
        Expanded(
            child: new TextFormField(
          decoration: new InputDecoration(
            icon: const Icon(Icons.calendar_today),
            labelText: 'Fecha en la que se encontro el objeto',
            hintText: "Ejemplo:  mm/dd/aaaa",
          ),
          controller: _controller,
          keyboardType: TextInputType.datetime,
          validator: (val) => isValidDob(val)
              ? null
              : 'No puede ingresar una fecha mayor a la actual',
          onSaved: (val) {
            arrayFecha = val.split("/");
            objeto.fechaHora =
                arrayFecha[2] + "-" + arrayFecha[0] + "-" + arrayFecha[1];
          },
        )),
      ]),
    );
  }

  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now());
  }

  /*bool isValidDob2(String dob, int eob) {
    print("****************                  "+eob.toString()+"+********************");
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now() ) && eob!=1;
  }*/

  Widget _crearFechaDevolucion() {
    List<String> arrayFecha;
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  labelText: 'Fecha en la que se devolvio el objeto',
                  hintText: "Ejemplo: mm/dd/aaaa"),
              controller: _controller2,
              keyboardType: TextInputType.datetime,
              validator: (val) => isValidDob(val) ? null : 'Fecha no válida',
              onSaved: (val) {
                if (val.isNotEmpty) {
                  arrayFecha = val.split("/");
                  objeto.fechaDevolucion =
                      arrayFecha[2] + "-" + arrayFecha[0] + "-" + arrayFecha[1];
                } else {}
              },
            ),
          ),
          /*IconButton(
            icon: new Icon(Icons.more_horiz),
            tooltip: 'Choose date',
            onPressed: (() {
              _chooseDate2(context, _controller2.text);
            }),
          )*/
        ],
      ),
    );
  }

  _crearCombo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 25.0, 0.0),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {},
            iconSize: 30.0,
            icon: new Icon(Icons.open_in_browser),
            tooltip: 'Choose date',
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                value: _selectedEstadoObjetoPerdido,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              )
            ],
          ),
        ],
      ),
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

    try {
      if (_controller2.text.compareTo("") != 0 && objeto.eobId == 1) {
        mostrarSnackbar(
            "No puede ingresar un estado PENDIENTE y una Fecha de devolución.");
      }
      if (_controller2.text.isEmpty &&
          (objeto.eobId == 2 || objeto.eobId == 3)) {
        mostrarSnackbar("Debe ingresar una fecha de devolución.");
      }
      if ((_controller2.text.isEmpty && (objeto.eobId == 1)) ||
          (_controller2.text.isNotEmpty &&
              (objeto.eobId == 2 || objeto.eobId == 3))) {
                
        var url = "http://192.168.137.1:8888/objetosPerdidos/${objeto.id}";
        Map<String, String> headers = {"Content-type": "application/json"};
        String json =
            '{"id": "${objeto.id}","descripcion": "${objeto.descripcion.toUpperCase()}", "fechaHora": "${objeto.fechaHora}", "fechaDevolucion": "${objeto.fechaDevolucion}", "recId": "","eobId": "${objeto.eobId}","stId": "" }';
        print(json);
        Response response = await http.put(url, headers: headers, body: json);
        int statusCode = response.statusCode;
        String body = response.body;
        print(body);
        mostrarSnackbar("Guardado con éxito.");
        Navigator.pop(context);
      }
      /*  if (_controller2.text.compareTo("")!=0 ) {
        var url = "http://192.168.1.5:8888/objetosPerdidos/${objeto.id}";
        Map<String, String> headers = {"Content-type": "application/json"};
        String json =
            '{"id": "${objeto.id}","descripcion": "${objeto.descripcion.toUpperCase()}", "fechaHora": "${objeto.fechaHora}", "fechaDevolucion": "${objeto.fechaDevolucion}", "recId": "","eobId": "${objeto.eobId}","stId": "" }';
        print(json);
        Response response = await http.put(url, headers: headers, body: json);
        int statusCode = response.statusCode;
        String body = response.body;
        print(body);
        mostrarSnackbar("Guardado con éxito.");
        Navigator.pop(context);
      }*/
    } catch (e) {
      mostrarSnackbar(e.toString());
    }

    setState(() {
      _guardando = false;
    });
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 5000),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
