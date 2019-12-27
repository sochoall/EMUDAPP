import 'package:app_movil/transportista/widgets/lista_rutas_objetos.dart';
import 'package:flutter/material.dart';

class PantallaObjetos extends StatefulWidget {
  @override
  final String id_usuario;
  PantallaObjetos(this.id_usuario);
  PantallaObjetosEstado createState() => PantallaObjetosEstado(id_usuario);
}

class PantallaObjetosEstado extends State<PantallaObjetos> {
  @override
  final String id_usuario;
  PantallaObjetosEstado(this.id_usuario);
  Widget build(BuildContext contexto) {
    return new Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/emov.png',
                height: 100,
                width: 300,
              ),
              title: Row(children: <Widget>[
                Text(
                  "OBJETOS PERDIDOS  ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ]),
            ),
          ),
          SliverFillRemaining(
            child: ListaRutasObjetos(id_usuario),
          ),
        ],
      ),
    );
  }
}
