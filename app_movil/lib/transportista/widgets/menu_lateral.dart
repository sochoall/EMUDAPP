//Clase que permite crear el menu lateral
//en cualquier ventana de la app segun se lo requiera

import 'package:flutter/material.dart';
import '../../provider.dart';

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
                //Enlazada al cargardata
                initialData: [],
                //Informcion por defecto
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  //recibe una funcion
                  if (snapshot.hasData) {
                    //print(snapshot.data);
                    return ListView(
                      children: _listItems(snapshot.data, context),
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

List<Widget> _listItems(List<dynamic> data, BuildContext context) {
  final List<Widget> opciones = [];
  //widgetTemp=Widget;

  if (data == null) {
    return [];
  }

  data.forEach(
    (opt) {
      opciones
        ..add(UserAccountsDrawerHeader(
          //Cabecera dentro el menu con nombre e imagen
          accountName: new Text(opt['nombre'] + " " + opt['apellido']),
          accountEmail: new Text(opt['correo'].replaceAll('*', '@')),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover)),

          currentAccountPicture: new CircleAvatar(
            //Se puede cargar una imagen circular
            backgroundImage: AssetImage('assets/cabecera_img.jpg'),
            //NetworkImage("https://cdn.mos.cms.futurecdn.net/hX4zXbRctPaYiaw2PgiEUU.jpg"),
          ),
        ));
    },
  );
  opciones
    ..add(ListTile(
      title: Text("OBJETOS PERDIDOS"),
      leading: Icon(Icons.exit_to_app),
      onTap: () {},
    ));

    opciones
    ..add(ListTile(
      title: Text("SALIR"),
      leading: Icon(Icons.exit_to_app),
      onTap: () {},
    ));
  return opciones;
}
