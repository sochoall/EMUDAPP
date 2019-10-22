import 'package:app_movil/transportista/alerta.dart';
import 'package:app_movil/transportista/pantalla_paradas.dart';
import 'package:flutter/material.dart';



Map<String, WidgetBuilder> getApplicationRoutes(String nombreRuta,String idRecorrido,String nombre,String idUsuario) {
  return <String, WidgetBuilder>{
    //'/': (BuildContext context) => PantallaRuta(),
    'paradas': (BuildContext context) => HomeScreen(nombreRuta,idRecorrido,nombre,idUsuario),
    //'alerta': (BuildContext context) => AlertPage(),

    //'card': (BuildContext context) => CardPage(),
    //'animatedContainer': (BuildContext context) => AnimatedContainerPage(),
  };
  
}
