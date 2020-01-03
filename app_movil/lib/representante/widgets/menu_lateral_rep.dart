//Clase que permite crear el menu lateral
//en cualquier ventana de la app segun se lo requiera

import 'package:app_movil/transportista/tabs/objetos_perdidos_page.dart';
import 'package:flutter/material.dart';
import '../../provider.dart';
import '../objetos_perdidos_inicio.dart';
import '../objetos_perdidos_representante.dart';
import 'lista_objetos_estudiante.dart';

class MenuLateralRep extends StatelessWidget {
  final String idUsuario;
  MenuLateralRep(this.idUsuario);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
                future: menuProviderRep.cargarData5(idUsuario),
                //Enlazada al cargardata
                initialData: [],
                //Informcion por defecto
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  //recibe una funcion

                  //print(snapshot.data);
                  return ListView(
                    children: _listItems(snapshot.data, context,idUsuario),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

List<Widget> _listItems(List<dynamic> data, BuildContext context,idUsuario) {
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
          accountEmail: new Text(opt['correo']),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/menu.jpg'), fit: BoxFit.cover)),

         
        ));
    },
  );
  opciones
    ..add(ListTile(
      title: Text("OBJETOS PERDIDOS"),
      leading: Icon(Icons.view_headline),
      onTap: () {
         Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext contexto) => PagInicialOp(idUsuario)));
      },
    ));
    
  opciones..add(ListTile(
    title: Text("SALIR"),
    leading: Icon(Icons.exit_to_app),
    onTap: (){},
  ));
  return opciones;
}
