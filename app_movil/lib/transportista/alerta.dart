import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void mostrarAlert(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text("ERROR"),
          content: Row(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/error.png',
                    height: 35,
                    width: 35,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "   USUARIO Y/O CONTRASEÑA",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    " INCORRECTO.",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
}

void usuarioInvalido(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text("ERROR"),
          content: Row(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/error.png',
                    height: 35,
                    width: 35,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "   USUARIO NO",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    " ADMITIDO.",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
}

void showToast(BuildContext context) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('CREDENCIALES DE USUARIO INCORRECTAS'),
      action: SnackBarAction(
          label: 'Cerrar', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
