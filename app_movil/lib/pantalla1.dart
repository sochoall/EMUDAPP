import 'package:flutter/material.dart';
import 'package:app_movil/rutas/rutas.dart';
import 'package:app_movil/tabs/alumnos.dart';
import 'package:app_movil/tabs/operdidos.dart';
import 'package:app_movil/tabs/rutas.dart';
import 'package:app_movil/widgets/menu_lateral.dart';


class Pag1 extends StatelessWidget {
  final String aux; //Creacion de varibales que se vayan a usar
  Pag1(this.aux); //Asignacion de las variables a los parametros
  @override
  Widget build(BuildContext contexto) {
    //final appTitle = 'Form Validation Demo';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
       theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 172, 200, 1), fontFamily: 'Raleway'),
      routes: getApplicationRoutes(),

      /**Esto es para cuando no encuentra una pagina */
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(aux));
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String aux1;
  HomeScreen(this.aux1);
  HomeScreenState createState() => HomeScreenState(aux1); //Paso de paramteros
}

class HomeScreenState extends State<HomeScreen> {
  final String aux1;
  HomeScreenState(this.aux1);
  int index = 0;

  Widget callPage(int index) {
    switch (index) {
      case 0:
        return Rutas();
      case 1:
        return Alumno();
      case 2:
        return Perdidos();
        break;
      default:
        return Rutas();
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
                icon: Icon(Icons.add_location,color: Colors.black), title: Text("Rutas",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        wordSpacing: 5.0)),backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box,color: Colors.black), title: Text("Alumnos",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        wordSpacing: 5.0)),backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment,color: Colors.black), title: Text("O.Perdidos",style: TextStyle(
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
          title: Text("EMOV EP",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  //fontSize: 35.0,
                  //wordSpacing: 5.0
                  )),
        ),
        drawer: Drawer(
          child: MenuLateral(),
        ));
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