import 'package:flutter/material.dart';
import '../../provider.dart';
import '../objetos_perdidos_inicio.dart';

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
                initialData: [],
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
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
  if (data == null) {
    return [];
  }
  data.forEach(
    (opt) {
      opciones
        ..add(UserAccountsDrawerHeader(
          accountName: new Text(opt['nombre'] + " " + opt['apellido']),
          accountEmail: new Text(opt['correo'].replaceAll('*', '@')),
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
