import 'package:app_movil/transportista/widgets/lista_rutas_objetos.dart';
import 'package:flutter/material.dart';


class PantallaObjetos extends StatefulWidget {
  @override
  final String id_usuario; //Creacion de varibales que se vayan a usar
  PantallaObjetos(this.id_usuario);

  PantallaObjetosEstado createState() => PantallaObjetosEstado(id_usuario);
}

class PantallaObjetosEstado extends State<PantallaObjetos> {
  @override
  final String id_usuario; //Creacion de varibales que se vayan a usar
  PantallaObjetosEstado(this.id_usuario);
  Widget build(BuildContext contexto) {
    return new Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              //expandedHeight: MediaQuery.of(contexto).size.height - 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/emov.png',
                  height: 100,
                  width: 300,
                ),
                //centerTitle: true,
                title: Row(children: <Widget>[
                  Text(
                    "OBJETOS PERDIDOS  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ]),
              ),
              //child: new Container(color: Colors.red,height: 640.0,
            ),
            SliverFillRemaining(
              child: ListaRutasObjetos(id_usuario),
            ),
          ],
        ),
        //drawer: Drawer(
          //child: MenuLateral(id_usuario),
        //)
        );
  }
}
