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

  PantallaParadasEstudiante(this.nombreRuta,this.idRecorrido,this.nombre,this.idUsuario); 


  @override
  Widget build(BuildContext contexto) {
    //final appTitle = 'Form Validation Demo';
    return HomeScreen(nombreRuta,idRecorrido,nombre,idUsuario);
  }
}

class HomeScreen extends StatefulWidget {
  @override
 final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String idRecorrido;
final String nombre;
final String idUsuario;

  HomeScreen(this.nombreRuta,this.idRecorrido,this.nombre,this.idUsuario); 

  HomeScreenState createState() => HomeScreenState(nombreRuta,idRecorrido,nombre,idUsuario); //Paso de paramteros
}

class HomeScreenState extends State<HomeScreen> {
  @override
  final String nombreRuta; //Creacion de varibales que se vayan a usar
  final String idRecorrido;
  final String nombre;
  final String idUsuario;
  HomeScreenState(this.nombreRuta,this.idRecorrido,this.nombre,this.idUsuario); 
 

  int index = 0;

  Widget callPage(int index) {
    switch (index) {
      case 0:
        return Rutas(this.idRecorrido);
      case 1:
        return ObjetosP();
        break;
      default:
        return ObjetosP();
    }
  }

  @override
  Widget build(BuildContext contexto) {
    return new Scaffold(
        body: callPage(index),
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
                icon: Icon(Icons.assignment, color: Colors.black),
                title: Text("O.Perdidos",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        wordSpacing: 5.0))),
          ],
        ),
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
          title: 
              Row(children: <Widget>[
                        Text(
                          nombre+" ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.compare_arrows),
                        Text(
                          " "+nombreRuta,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
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
