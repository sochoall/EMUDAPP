//Clase que permite crear el menu lateral
//en cualquier ventana de la app segun se lo requiera

import 'package:flutter/material.dart';
import 'package:app_movil/utils/icono_string.dart';
import 'package:app_movil/widgets/menu_provider.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: lista(),
          ),
        ],
      ),
    );
  }
}

Widget lista() {
  return FutureBuilder(
      future: menuProvider.cargarData(),
      //Enlazada al cargardata
      initialData: [],
      //Informcion por defecto
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        //recibe una funcion

        //print(snapshot.data);
        return ListView(
          children: _listItems(snapshot.data, context),
        );
      });
}

List<Widget> datos(List<dynamic> datos,String aux,BuildContext context)
  { 
     final List<Widget> opciones = [];
    datos.forEach((opt) {
   if(opt['padre'].toString().compareTo(aux)==0)
   {
     final widgetTemp = ListTile(
      title:Text(opt['texto']) ,
      leading: getIcon(opt['icon']),
      //trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
      onTap: () {
         Navigator.of(context).pushNamed( opt['ruta']);
      },
    );
     opciones..add(widgetTemp);
   }
   },
   );
    return opciones;
  }

List<Widget> _listItems(List<dynamic> data, BuildContext context) {
  final List<Widget> opciones = [];
    //widgetTemp=Widget;

  if (data == null) {
    return [];
  }

  opciones
    ..add(UserAccountsDrawerHeader(
      //Cabecera dentro el menu con nombre e imagen
      accountName: new Text("PABLO LOJA"),
      accountEmail: new Text("arevalopablo96@gmail.com"),
      decoration: BoxDecoration(
         image: DecorationImage(
              image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover)
              ),

      currentAccountPicture: new CircleAvatar(
        //Se puede cargar una imagen circular
        backgroundImage: AssetImage('assets/cabecera_img.jpg'),
        //NetworkImage("https://cdn.mos.cms.futurecdn.net/hX4zXbRctPaYiaw2PgiEUU.jpg"),
      ),

      otherAccountsPictures: <Widget>[
        new CircleAvatar(
          backgroundColor: Colors.white,
          child: new Text("A"),
        )
      ],
    ));

  //for (var i = 0; i < data.length; i++) {
   

    //  widgetTemp = ExpansionTile(
    //title:data.elementAt(i)["texto"],
      //leading: getIcon(opt['icon']),
      //trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
    //);

  //};
  


 data.forEach((opt) {
   if(opt['padre'].toString().compareTo("0")==0)
   {
     final widgetTemp = ExpansionTile(
      title:Text(opt['texto']) ,
      leading: getIcon(opt['icon']),
      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),

      children: datos(data,opt['id'],context),


    );
     opciones..add(widgetTemp);
   }
   },
   );



    /*ListTile(
      title: Text(opt['texto']),
      leading: getIcon(opt['icon']),
      //Se necesita un metodo para generar el icono segun String
      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
      onTap: () {
         Navigator.of(context).pushNamed( opt['ruta']);
        //Navigator.pushNamed(context, opt['ruta']);
        //final route = MaterialPageRoute(
        //  builder: (context) {
        //  return AlertPage();
        //});
        //Navigator.push(context, route);
      },
    );*/

    
  return opciones;
}
