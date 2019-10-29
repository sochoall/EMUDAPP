import 'package:flutter/material.dart';

class Perdidos extends StatefulWidget{
  OperdidosEstado createState()=> OperdidosEstado();
}

class OperdidosEstado extends State <Perdidos>{
  @override 
  Widget build(BuildContext contexto) {
    return Scaffold(
       body: Cuerpo(),
    );
  }
}
class Cuerpo extends StatelessWidget{
  //final String title;
  //cuerpo(this.title);
  @override 
  Widget build(BuildContext contexto){
    return new Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
           SliverAppBar(
            expandedHeight: MediaQuery.of(contexto).size.height-200,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              //background: ,
              //centerTitle: true,
              title: Row(
                children: <Widget>[
                  Text("MAPA  "),
                  Icon(Icons.arrow_downward),
                  Icon(Icons.arrow_upward)
                ]
              ),
            ),
            //child: new Container(color: Colors.red,height: 640.0,
          ),
          SliverFillRemaining(   
            child:  CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        title: Text("RUTAS"),
                      ),
                      ListTile(
                        title: Text("RUTA 1"),
                        subtitle: Text("Sayausi - Ciudad de Cuenca"),
                      ),
                      ListTile(
                        title: Text("RUTA 2"),
                        subtitle: Text("Ciudad de Cuenca - Sayausi"),
                      ),
                      ListTile(
                        title: Text("RUTA 3"),
                        subtitle: Text("Nocturno Sayausi - Ciudad de Cuenca"),
                      ),
                      //HeaderWidget("RUTAS"),
                      //HeaderWidget("Header 2"),
                      //HeaderWidget("Header 3"),
                      //HeaderWidget("Header 4"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],        
      ),
    );
  }
}