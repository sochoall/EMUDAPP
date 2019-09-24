import 'package:flutter/material.dart';
import 'package:app_movil/paginas/alerta.dart';
import 'package:app_movil/paginas/avatar.dart';
import 'package:app_movil/pantalla1.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomeScreen("EMOV"),
    'alerta': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    //'card': (BuildContext context) => CardPage(),
    //'animatedContainer': (BuildContext context) => AnimatedContainerPage(),
  };
}
