import 'package:flutter/material.dart';

import '../../provider.dart';

class ListaParadas12 extends StatelessWidget {                              //Creacion de Lista de rutas
final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String idRecorrido;


  ListaParadas12(this.nombreRuta,this.idRecorrido); 


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //future: listaParadasProvider.cargarData2(idRecorrido),
      //Enlazada al cargardata
      initialData: [],
        //Informcion por defecto
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
        }
        );  
  }
}


List<Widget> datosSliverList(List<dynamic> datos,BuildContext context)
{
   final List<Widget> opciones = [];
  opciones..add(SliverList(
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

List<Widget> datosListTile(List<dynamic> datos,BuildContext context)
  { 
    final List<Widget> opciones = [];
    
    datos.forEach((opt) {
     final widgetTemp = ListTile(
      title:Text(opt['nombre']) ,
      leading: Icon(Icons.directions_walk),
      onTap: (){
        //Navigator.of(context).push(
        //MaterialPageRoute(builder: (BuildContext contexto) => PantallaParadas(opt['nombre'])));
      },
      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue)
    );
     opciones..add(widgetTemp);
   },
  );
  return opciones;
}

