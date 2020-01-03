import 'package:app_movil/transportista/tabs/objetos_perdidos_rutas.dart';
import 'package:flutter/material.dart';
import '../../provider.dart';

String idUsuario1 = "";

class MenuLateral extends StatelessWidget {
  final String idUsuario;
  MenuLateral(this.idUsuario);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
                future: menuProvider.cargarData(idUsuario),
                initialData: [],
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: _listItems(snapshot.data, context, idUsuario),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

List<Widget> _listItems(List<dynamic> data, BuildContext context, idUsuario) {
  final List<Widget> opciones = [];
  if (data == null) {
    return [];
  }
  data.forEach(
    (opt) {
      opciones
        ..add(UserAccountsDrawerHeader(
          accountName: new Text(opt['nombre'] + " " + opt['apellido']),
          accountEmail: new Text(opt['correo']),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/menu.jpg'), fit: BoxFit.cover)),
        ));
    },
  );
  opciones
    ..add(ListTile(
      title: Text("Objetos Perdidos"),
      leading: Icon(Icons.view_headline),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext contexto) => PantallaObjetos(idUsuario)));
      },
    ));

  opciones
    ..add(ListTile(
      title: Text("Salir"),
      leading: Icon(Icons.exit_to_app),
      onTap: () {},
    ));
  return opciones;
}
