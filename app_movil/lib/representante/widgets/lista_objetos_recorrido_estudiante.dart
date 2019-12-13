import 'package:app_movil/main.dart';
import 'package:app_movil/representante/pantalla_estudiante.dart';
import 'package:app_movil/transportista/pantalla_paradas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../provider.dart';
import '../objetos_perdidos_representante.dart';

String idRuta = "";

class ListaRecorridoEstudianteObjetos extends StatelessWidget {
  final String aux;
  final String id_usuario;
  ListaRecorridoEstudianteObjetos(this.aux, this.id_usuario);
  //Creacion de Lista de rutas

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listaRecorridoSentidoEstudiante.cargarData6(aux),
        initialData: [],
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return Column(
            children: _listItems(snapshot.data, context),
          );
        });
  }
}

List<Widget> _listItems(List<dynamic> data, BuildContext context) {
  final List<Widget> opciones = [];
  //widgetTemp=Widget;

  if (data == null) {
    return [];
  }


  data.forEach(
    (opt) {

        final widgetTemp = ListTile(
        title: Text(opt['sen_nombre']),
        leading: Icon(Icons.art_track),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
         Navigator.of(context).push(MaterialPageRoute(

              builder: (BuildContext contexto) => objetosPerdidosRep(opt['rec_id'].toString())));
        },
      );
      opciones..add(widgetTemp);
    },
  );
  return opciones;
}
