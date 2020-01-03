import 'package:app_movil/main.dart';
import 'package:app_movil/representante/pantalla_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../provider.dart';

String idRuta = "";

class ListaRecorridoEstudiante extends StatelessWidget {
  final String id_estudiante;
  final String id_usuario;
  ListaRecorridoEstudiante(this.id_estudiante, this.id_usuario);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listaRecorridoSentidoEstudiante.cargarData6(id_estudiante),
        initialData: [],
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return Column(
            children: _listItems(snapshot.data, context,id_estudiante),
          );
        });
  }
}

List<Widget> _listItems(List<dynamic> data, BuildContext context,String id_estudiante) {
  final List<Widget> opciones = [];
  if (data == null) {
    return [];
  }
  DateTime now = DateTime.now();
  String fecha = DateFormat('kk:mm').format(now);
  int hora = int.parse(fecha.substring(0, 2));
  int min = int.parse(fecha.substring(3, 5));
  data.forEach(
    (opt) {
      int horaRecorridoI =
          int.parse(opt['rec_hora_inicio'].substring(0, 2)) - 1;
      int minRecorridoI = int.parse(opt['rec_hora_inicio'].substring(3, 5));
      int horaRecorridoF =
          int.parse(opt['rec_hora_inicio'].substring(0, 2)) + 2;
      int minRecorridoF = int.parse(opt['rec_hora_inicio'].substring(3, 5));

      if ((horaRecorridoI == hora && min >= minRecorridoI) ||
          (horaRecorridoF == hora && min < minRecorridoF) ||
          (horaRecorridoF > hora && horaRecorridoI < hora)) {
        final widgetTemp = ListTile(
          title: Text(opt['sen_nombre']),
          subtitle: Text(fecha +
              " " +
              opt['rec_hora_inicio'] +
              "   " +
              opt['rec_hora_fin'] +
              "   " +
              opt['rec_id'].toString()),
          leading: Icon(Icons.art_track),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext contexto) => PantallaParadasEstudiante(
                    opt['sen_nombre'].toString(),
                    id_estudiante,
                    opt['rut_nombre'].toString(),
                    id_usuario)));
          },
        );
        opciones..add(widgetTemp);
      }
    },
  );
  return opciones;
}
