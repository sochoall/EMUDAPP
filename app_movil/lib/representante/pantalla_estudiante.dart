import 'package:flutter/material.dart';
import 'package:app_movil/transportista/tabs/rutas.dart';

class PantallaParadasEstudiante extends StatelessWidget 
{
  final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String idRecorrido;
  final String nombre;
  final String idUsuario;

  PantallaParadasEstudiante(this.nombreRuta,this.idRecorrido,this.nombre,this.idUsuario); 

  @override
  Widget build(BuildContext contexto) 
  {
    return HomeScreen(nombreRuta,idRecorrido,nombre,idUsuario);
  }
}

class HomeScreen extends StatefulWidget 
{
  @override
  final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String idRecorrido;
  final String nombre;
  final String idUsuario;

  HomeScreen(this.nombreRuta,this.idRecorrido,this.nombre,this.idUsuario); 
  HomeScreenState createState() => HomeScreenState(nombreRuta,idRecorrido,nombre,idUsuario); //Paso de parametros
}

class HomeScreenState extends State<HomeScreen> 
{
  @override
  final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String idRecorrido;
  final String nombre;
  final String idUsuario;
  HomeScreenState(this.nombreRuta,this.idRecorrido,this.nombre,this.idUsuario); 

  @override
  Widget build(BuildContext contexto) 
  {
    return new Scaffold(
      body: Rutas(this.idRecorrido),
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
        backgroundColor: Color.fromRGBO(0, 172, 200, 1),
        title:Row(
          children: <Widget>[
            Text(nombre+" ", style: TextStyle(fontWeight: FontWeight.bold)),
            Icon(Icons.compare_arrows),
            Text(" "+nombreRuta, style: TextStyle(fontWeight: FontWeight.bold)),
          ]
        ),
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
