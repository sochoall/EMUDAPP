import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:app_movil/bloc/validators.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _cedulaController = BehaviorSubject<String>();
  

  //Recuperar los datos del stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  Stream<String> get cedulaStream => _cedulaController.stream.transform(validarCedula);

  Stream<bool>get formValidStream => 
    Observable.combineLatest2(cedulaStream, passwordStream, (e,p)=>true);

  //Insertar valores al stream
  Function(String) get changedEmail => _emailController.sink.add;
  Function(String) get changedPassword => _passwordController.sink.add;
  Function(String) get changeCedula => _cedulaController.sink.add;

  //Obtener el ultimo valor ingresado a los Streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get cedula => _cedulaController.value;
  

  //Cerrar cuando no se escucha
  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _cedulaController?.close();
  }
}
