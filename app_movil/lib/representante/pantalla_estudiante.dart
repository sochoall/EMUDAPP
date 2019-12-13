import 'package:app_movil/transportista/tabs/alumnos.dart';
import 'package:app_movil/transportista/tabs/objetos_perdidos_page.dart';
import 'package:app_movil/transportista/tabs/rutas.dart';
import 'package:app_movil/transportista/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/rutas/rutas.dart';

class PantallaParadasEstudiante extends StatelessWidget {
  final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String idRecorrido;
  final String nombre;
  final String idUsuario;

  PantallaParadasEstudiante(
      this.nombreRuta, this.idRecorrido, this.nombre, this.idUsuario);

  @override
  Widget build(BuildContext contexto) {
    //final appTitle = 'Form Validation Demo';
    return HomeScreen(nombreRuta, idRecorrido, nombre, idUsuario);
  }
}

class HomeScreen extends StatefulWidget {
  @override
  final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String idRecorrido;
  final String nombre;
  final String idUsuario;
  HomeScreen(this.nombreRuta, this.idRecorrido, this.nombre, this.idUsuario);
  HomeScreenState createState() => HomeScreenState(
      nombreRuta, idRecorrido, nombre, idUsuario); //Paso de paramteros
}

class HomeScreenState extends State<HomeScreen> {
  @override
  final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String idRecorrido;
  final String nombre;
  final String idUsuario;
  String sentido = "";
  HomeScreenState(
      this.nombreRuta, this.idRecorrido, this.nombre, this.idUsuario);

  @override
  Widget build(BuildContext contexto) {
    if (nombreRuta.toUpperCase().compareTo("IDA") == 0) {
      sentido = "EMBARQUE";
    } else {
      sentido = "DESEMBARQUE";
    }
    return new Scaffold(
      body: Rutas(this.idRecorrido),

      appBar: AppBar(
        //title: Text(aux1),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            //onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
        backgroundColor: Color.fromRGBO(0, 172, 200, 1),
        //Text(nombre+Icons.play_arrow+ nombreRuta,
        title: Row(children: <Widget>[
          Text(
            sentido + " ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          //Icon(Icons.compare_arrows),
          //Text(
          //" "+nombreRuta,
          //style: TextStyle(
          //  fontWeight: FontWeight.bold),
          //),
        ]),
      ),
      //drawer: Drawer(
      //child: MenuLateral(idUsuario),
      //)
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'SALIR', icon: Icons.exit_to_app),
];
