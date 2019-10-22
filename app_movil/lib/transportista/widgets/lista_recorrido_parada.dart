import 'package:app_movil/main.dart';
import 'package:app_movil/transportista/pantalla_paradas.dart';
import 'package:flutter/material.dart';

import '../../provider.dart';

String idRuta = "";

class ListaRecorridoParada extends StatelessWidget {
  final String aux;
  final String id_usuario;
  ListaRecorridoParada(this.aux,this.id_usuario);
  //Creacion de Lista de rutas
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listaRecorridoSentido.cargarData3(aux),
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
        title: Text(opt['nombresen']),
        subtitle: Text(opt['idrec'].toString()),
        leading: Icon(Icons.art_track),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext contexto) => PantallaParadas(
                  opt['nombresen'].toString(), opt['idrec'].toString(),opt['nombreruta'].toString(),id_usuario)));
        },
      );
      opciones..add(widgetTemp);
    },
  );
  return opciones;
}
