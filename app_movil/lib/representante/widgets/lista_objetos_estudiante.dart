import 'package:flutter/material.dart';
import '../../main.dart';
import '../../provider.dart';
import 'lista_objetos_recorrido_estudiante.dart';

class ListaEstudiantesObjetos extends StatelessWidget {
  @override
  final String id_usuario; 
  ListaEstudiantesObjetos(this.id_usuario);
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listaEstudiante.cargarData4(id_usuario),
        initialData: [],
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return CustomScrollView(
            slivers: datosSliverList(snapshot.data, context),
          );
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
        title: Text(opt['nombre']+" "+opt['apellido'], style: TextStyle(
                              fontWeight: FontWeight.bold),),
        leading: Icon(Icons.directions_bus),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        children: <Widget>[
          Container(
          child: ListaRecorridoEstudianteObjetos(opt['id'].toString(),id_usuario),
          )
        ],
      );
      opciones..add(widgetTemp);
    },
  );
  return opciones;
}
