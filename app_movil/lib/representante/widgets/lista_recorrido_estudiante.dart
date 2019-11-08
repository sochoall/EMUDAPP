import 'package:app_movil/main.dart';
import 'package:app_movil/representante/pantalla_estudiante.dart';
import 'package:app_movil/transportista/pantalla_paradas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../provider.dart';

String idRuta = "";

class ListaRecorridoEstudiante extends StatelessWidget {
  final String aux;
  final String id_usuario;
  ListaRecorridoEstudiante(this.aux,this.id_usuario);
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
  DateTime now = DateTime.now();
  String fecha = DateFormat('kk:mm').format(now);
  int hora=int.parse(fecha.substring(0,2)) ;
  int min=int.parse(fecha.substring(3,5)) ;
  
  data.forEach(
    (opt) {
      int horaRecorridoI=int.parse(opt['rec_hora_inicio'].substring(0,2)) ;
      int minRecorridoI=int.parse(opt['rec_hora_inicio'].substring(3,5)) ;
      int horaRecorridoF=int.parse(opt['rec_hora_fin'].substring(0,2)) ;
      int minRecorridoF=int.parse(opt['rec_hora_fin'].substring(3,5)) ; 
      

      final widgetTemp = ListTile(
        title: Text(opt['sen_nombre']),
        //subtitle: Text(min.toString()),
        leading: Icon(Icons.art_track),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext contexto) => PantallaParadasEstudiante(
                  opt['sen_nombre'].toString(), opt['rec_id'].toString(),opt['rut_nombre'].toString(),id_usuario)));
        },
      );
      opciones..add(widgetTemp);
    },
  );
  return opciones;
}
