import 'package:app_movil/main.dart';
import 'package:flutter/material.dart';
import '../../provider.dart';
import 'lista_recorrido_objetos.dart';

class ListaRutasObjetos extends StatelessWidget {
  @override
  final String id_usuario;

  ListaRutasObjetos(this.id_usuario);

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listaProvider.cargarData1(id_usuario),
        initialData: [],
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: datosSliverList(snapshot.data, context),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

List<Widget> datosSliverList(List<dynamic> datos, BuildContext context) {
  final List<Widget> opciones = [];
  opciones
    ..add(SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            child: Column(
              children: datosListTile(datos, context),
            ),
          )
        ],
      ),
    ));
  return opciones;
}

List<Widget> datosListTile(List<dynamic> datos, BuildContext context) {
  final List<Widget> opciones = [];

  datos.forEach(
    (opt) {
      final widgetTemp = ExpansionTile(
        title: Text(
          opt['nombre'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.call_to_action),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        children: <Widget>[
          Container(
            child: ListaRecorridoObjetoParada(opt['id'].toString(), id_usuario),
          )
        ],
      );
      opciones..add(widgetTemp);
    },
  );
  return opciones;
}
