import 'package:flutter/material.dart';
import 'package:app_movil/transportista/tabs/mapa.dart';
import 'package:app_movil/transportista/tabs/rutas.dart';
import 'package:app_movil/transportista/tabs/registro_estudiantes_page.dart';

class PantallaParadas extends StatelessWidget {
  final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String idRecorrido;
  final String nombre;
  final String idUsuario;
  PantallaParadas(
      this.nombreRuta, this.idRecorrido, this.nombre, this.idUsuario);
  @override
  Widget build(BuildContext contexto) {
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
  int index = 0;
  Widget callPage(int index, String sentido) {
    switch (index) {
      case 0:
        return Rutas(this.idRecorrido);
      case 1:
        return listado(MyHomePageState.ids.first);
        break;
      default:
        return Rutas(this.idRecorrido);
    }
  }
  Future<bool> _onBack()
  {
    return showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text("Si regresa se perderán TODOS los cambios realizados. ¿Está seguro que desea SALIR?"),
        actions: <Widget>[
          FlatButton(
            child: Text("SI") ,
            onPressed: (){
              Navigator.pop(context,true);
            },
          ),
          FlatButton(
            child: Text("NO") ,
            onPressed: (){
              Navigator.pop(context,false);
            },
          )
        ],
      )
    );
  }
  @override
  Widget build(BuildContext contexto) {
    if (nombreRuta.toUpperCase().compareTo("IDA") == 0) {
      sentido = "EMBARQUE";
    } else {
      sentido = "DESEMBARQUE";
    }
    return WillPopScope(
       onWillPop: _onBack,
          child: new Scaffold(
        body: callPage(index, sentido),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.add_location, color: Colors.black),
                title: Text("Rutas",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        wordSpacing: 5.0)),
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box, color: Colors.black),
                title: Text("Alumnos",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        wordSpacing: 5.0)),
                backgroundColor: Colors.black),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          actions: <Widget>[
            PopupMenuButton<Choice>(
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
          //backgroundColor: Color.fromRGBO(0, 172, 200, 1),
          title: Row(children: <Widget>[
            Text(
              sentido + " ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
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
