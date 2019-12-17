# app_movil

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Guía App Movil

## main.dart 
  Interfaz Gráfica del Login y validación del tipo de usuario que intentará acceder a la aplicaión.

## Carpeta Transportista

## pantalla_incial.dart
  - <b>PagEleccion:</b> Clase que Contruye la interfaz para que el usuario en caso de tener dos roles pueda elegir el que desee. 
  - En caso que sea conductor invocará al método <b>PagInicial</b>
  - En caso que elija padre de familia invocará al método <b>PagInicialRep</b> 
  - <b>PagInicial:</b> Clase que construye la interfaz en donde estarán las rutas disponibles. Esta clase construirá Expanded's con las rutas y dentro del mismo construirá ListTile con los recorridos disponibles; para realizar esto invocará al método <b>ListaRutas(id_usuario)</b>.</br> 
    En la misma clase para la construcción del drawer(menú lateral) invoca a la clase <b>MenuLateral(id_usuario)</br>.  

  
