import 'package:flutter/material.dart';
import 'package:app_movil/transportista/pantalla_paradas.dart';

Map<String, WidgetBuilder> getApplicationRoutes(String nombreRuta,String idRecorrido,String nombre,String idUsuario) 
{
  return <String, WidgetBuilder>
  {
    'paradas': (BuildContext context) => HomeScreen(nombreRuta,idRecorrido,nombre,idUsuario),
  };
}
