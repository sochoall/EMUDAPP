import 'package:flutter/material.dart';
import 'package:app_movil/rutas/rutas.dart';
import 'package:app_movil/representante/widgets/menu_lateral_rep.dart';
import 'package:app_movil/representante/widgets/lista_estudiantes.dart';

class PagInicialRep extends StatelessWidget 
{
  @override
  final String id_usuario; //Creacion de varibales que se vayan a usar
  final String rol;

  PagInicialRep(this.id_usuario,this.rol);

  Widget build(BuildContext contexto) 
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PantallaRuta(id_usuario,rol),
      theme: ThemeData(primaryColor: Color.fromRGBO(0, 172, 200, 1), fontFamily: 'Raleway'),
      routes: getApplicationRoutes("", "","",""),
    );
  }
}

class PantallaRuta extends StatefulWidget 
{
  @override
   final String id_usuario; //Creacion de varibales que se vayan a usar
  final String rol;

  PantallaRuta(this.id_usuario,this.rol);
  PantallaRutaEstado createState() => PantallaRutaEstado(id_usuario,rol);
}

class PantallaRutaEstado extends State<PantallaRuta> 
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
                Text("ESTUDIANTES  ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
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
