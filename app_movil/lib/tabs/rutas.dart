import 'package:flutter/material.dart';
import 'package:app_movil/tabs/mapa.dart';

class Rutas extends StatefulWidget {
  @override
  RutaEstado createState() => RutaEstado();
}

class RutaEstado extends State<Rutas> 
{
  @override
  Widget build(BuildContext contexto) 
  {
    return new Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(contexto).size.height - 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: MapPage(),
              //centerTitle: true,
              title: Row(children: <Widget>[
                Text("MAPA  ",style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black) ,),
                Icon(Icons.arrow_downward),
                Icon(Icons.arrow_upward)
              ]),
            ),
            //child: new Container(color: Colors.red,height: 640.0,
          ),
          SliverFillRemaining(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        title: Text(
                          "RUTAS",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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

