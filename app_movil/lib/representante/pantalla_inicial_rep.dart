import 'package:flutter/material.dart';
import 'package:app_movil/representante/widgets/menu_lateral_rep.dart';
import 'package:app_movil/representante/widgets/lista_estudiantes.dart';

class PantallaRutaRep extends StatefulWidget 
{
  @override
  final String id_usuario; //Creacion de varibales que se vayan a usar
  final String rol;

  PantallaRutaRep(this.id_usuario,this.rol);

  PantallaRutaEstado createState() => PantallaRutaEstado(id_usuario,rol);
}

class PantallaRutaEstado extends State<PantallaRutaRep> 
{
  @override
  final String id_usuario; //Creacion de varibales que se vayan a usar
  final String rol;

  PantallaRutaEstado(this.id_usuario,this.rol);

  Widget build(BuildContext contexto) 
  {
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
                  "ESTUDIANTES  ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Icon(Icons.arrow_downward),
                Icon(Icons.arrow_upward)
              ]),
            ),
          ),
          SliverFillRemaining(
            child: ListaEstudiantes(id_usuario),
          ),
        ],
      ),
      drawer: Drawer(
        child: MenuLateralRep(id_usuario),
      )
    );
  }
}
