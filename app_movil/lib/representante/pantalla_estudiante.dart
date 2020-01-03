import 'package:flutter/material.dart';
import 'package:app_movil/representante/mapa_estudiantes.dart';

class PantallaParadasEstudiante extends StatelessWidget 
{
  final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String id_estudiante;
  final String nombre;
  final String idUsuario;

  PantallaParadasEstudiante(
    this.nombreRuta, this.id_estudiante, this.nombre, this.idUsuario);

  @override
  Widget build(BuildContext contexto) 
  {
    return HomeScreen(nombreRuta, id_estudiante, nombre, idUsuario);
  }
}

class HomeScreen extends StatefulWidget 
{
  @override
  final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String id_estudiante;
  final String nombre;
  final String idUsuario;
  HomeScreen(this.nombreRuta, this.id_estudiante, this.nombre, this.idUsuario);
  HomeScreenState createState() => HomeScreenState(
      nombreRuta, id_estudiante, nombre, idUsuario); //Paso de paramteros
}

class HomeScreenState extends State<HomeScreen> 
{
  @override
  final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String id_estudiante;
  final String nombre;
  final String idUsuario;
  String sentido = "";
  HomeScreenState(
      this.nombreRuta, this.id_estudiante, this.nombre, this.idUsuario);

  @override
  Widget build(BuildContext contexto)
  {
    if (nombreRuta.toUpperCase().compareTo("IDA") == 0)
      sentido = "EMBARQUE";
    else
      sentido = "DESEMBARQUE";

    MyHomePageState.location = [];
    MyHomePageState.points = [];
    
    return new Scaffold(
      body: MyApp(this.id_estudiante),
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<Choice>(
            itemBuilder: (BuildContext context) 
            {
              return choices.map((Choice choice) 
              {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
       backgroundColor: Colors.lightBlue,
        title: Row(children: <Widget>[
          Text(
            sentido + " ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}

class Choice 
{
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'SALIR', icon: Icons.exit_to_app),
];
