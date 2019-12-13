import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_movil/bloc/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:app_movil/bloc/login_bloc.dart';
import 'package:app_movil/transportista/alerta.dart';
import 'package:app_movil/transportista/pantalla_inicial.dart';
import 'package:app_movil/representante/pantalla_inicial_rep.dart';
import 'package:app_movil/transportista/tabs/objetos_perdidos_page.dart';

void main() => runApp(MyApp()); //Inicio del Programa
String rol;
String id_usuario;

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Provider(
        child: MaterialApp(
      initialRoute: 'login',
      debugShowCheckedModeBanner: false,
      routes: 
      {
        'login': (BuildContext context) => Login(), //Rutas establecidas
        'home': (BuildContext context) =>  PagInicial(id_usuario,""),
        'home2': (BuildContext context) => PagEleccion(id_usuario),
        'homeRep': (BuildContext context) => PagInicialRep(id_usuario,rol),
      },
      theme: ThemeData(primaryColor: Colors.lightBlue),
    ));
  }
}

class Login extends StatelessWidget 
{
  @override

   Future<bool> check() async 
   {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile)
      return true;
    else if (connectivityResult == ConnectivityResult.wifi)
  		return true;
    return false;
  }

   

  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: Stack(
      	children: <Widget>[_crearFondo(context), _loginForm(context)],
    ));
  }

  Widget _crearFondo(BuildContext context) 
  {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(36, 113, 163, 1.0),
        Color.fromRGBO(66, 120, 185, 1.0),
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(
          top: 60.0,
          left: 30.0,
          child: circulo,
        ),
        Positioned(
          top: -40.0,
          right: -30.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        Positioned(
          bottom: 120.0,
          right: 20.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -20.0,
          child: circulo,
        ),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/emov.png',
                height: 100,
                width: 300,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'BUS APP',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) 
  {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height * 0.290,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  "Ingreso",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearCedula(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _crearBoton(bloc)
              ],
            ),
          ),
          Text("Olvido la contraseña"),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearCedula(LoginBloc bloc) 
  {
    //Campos para el ingreso de la cédula
    return StreamBuilder(
      stream: bloc.cedulaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) 
      {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                icon: Icon(Icons.vpn_lock, color: Colors.cyan),
                hintText: "Cédula de identidad",
                labelText: "Cédula de identidad",
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeCedula,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) 
  {
    //Campo para creacion de la contraseña
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) 
      {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.cyan),
              labelText: "Contraseña",
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changedPassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) 
  {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) 
      {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text("Ingresar"),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.lightBlue,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) 
  {
    Future<String> consultar() async 
    {
      final response = await http.get("http://192.168.137.1:8888/login/${bloc.cedula}*${bloc.password}");
      return Future.value(response.body);
    }
    Future<List> consultarRoles(id) async 
    {
      final response = await http.get("http://192.168.137.1:8888/rol?op=$id");
      return json.decode(response.body);
    }
    
    checkValue() async {
      String val = await consultar();
      val=val.replaceAll('"', "");
      id_usuario=val;
      
      if (id_usuario.compareTo("0")==0) 
         showToast(context);
			else 
      {
      	List<dynamic> listaRoles = await consultarRoles(id_usuario);

        if (listaRoles.length==1) 
        {
        	listaRoles.forEach((opt)
          {
          	if ( opt['nombre'].toString().compareTo("PADRE DE FAMILIA")==0)
          		Navigator.pushReplacementNamed(context, 'homeRep');
           	else if(opt['nombre'].toString().compareTo("TRANSPORTISTA")==0)
             	Navigator.pushReplacementNamed(context, 'home');
           	else
             	usuarioInvalido(context);
          });
        } 
        else
        	Navigator.pushReplacementNamed(context, 'home2');
      }
    }
    checkValue();
  }
}
