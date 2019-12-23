import 'package:app_movil/representante/pantalla_inicial_rep.dart';
import 'package:app_movil/rutas/rutas.dart';
import 'package:app_movil/transportista/widgets/lista_rutas.dart';
import 'package:app_movil/transportista/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';




class PagEleccion extends StatelessWidget {
  @override
  final String id_usuario; //Creacion de varibales que se vayan a usar

  PagEleccion(this.id_usuario);
  Widget build(BuildContext contexto) {
    return Eleccion(id_usuario);
  }
  
}

class Eleccion extends StatefulWidget 
{
  final String id_usuario; //Creacion de varibales que se vayan a usar
  Eleccion(this.id_usuario);

  HomeEleccionState createState() => HomeEleccionState(id_usuario); //Paso de paramteros
}

class HomeEleccionState extends State<Eleccion> {
  @override
  final String id_usuario; //Creacion de varibales que se vayan a usar
  HomeEleccionState(this.id_usuario);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      body:Center( 
        child:
      Container(
        height: 190,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        //color: Colors.white,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(""),
          
          Text("Bienvenido! Por Favor Elija Una Opción:",style:
          TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),),
        Text(""),
          ListTile(
            title: Text("Padre de Familia"),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/padre.jpg'),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      PantallaRuta(id_usuario, "")));
            },
          ),
          ListTile(
            title: Text("Conductor"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      PantallaRuta(id_usuario, "")));
            },
           leading: CircleAvatar(
              backgroundImage: AssetImage('assets/transporte.png'),
            ),
          ),
            Text(""),
        ],
      ),
      ),
      ),
    );
  }

}

class PagInicial extends StatelessWidget {
  @override
  final String id_usuario; //Creacion de varibales que se vayan a usar
  final String rol;
  PagInicial(this.id_usuario, this.rol);

  Widget build(BuildContext contexto) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: '/',
      home: PantallaRuta(id_usuario, rol),
      theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 172, 200, 1), fontFamily: 'Raleway'),
      routes: getApplicationRoutes("", "", "", ""),
    );
  }
}

class PantallaRuta extends StatefulWidget {
  @override
  final String id_usuario; //Creacion de varibales que se vayan a usar
  final String rol;
  PantallaRuta(this.id_usuario, this.rol);
  PantallaRutaEstado createState() => PantallaRutaEstado(id_usuario, rol);
}

class PantallaRutaEstado extends State<PantallaRuta> {
  @override
  final String id_usuario; //Creacion de varibales que se vayan a usar
  final String rol;
  PantallaRutaEstado(this.id_usuario, this.rol);

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
                //centerTitle: true,
                title: Row(children: <Widget>[
                  Text(
                    "RUTAS  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Icon(Icons.arrow_downward),
                  Icon(Icons.arrow_upward)
                ]),
              ),
            ),
            SliverFillRemaining(
              child: ListaRutas(id_usuario),
            ),
          ],
        ),
        drawer: Drawer(
          child: MenuLateral(id_usuario),
        ));
  }
}
