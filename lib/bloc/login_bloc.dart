import 'dart:async';
import 'package:everis_poc/bloc/validators.dart';
import 'package:everis_poc/shared_preferences/preferencias_usuario.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final PreferenciasUsuario _prefUsuario = new PreferenciasUsuario();

  LoginBloc() {
    if (_prefUsuario.nombreUsuario != '') { _emailController.value = _prefUsuario.nombreUsuario;}

    if (_prefUsuario.passUsuario != '') { _passwordController.value = _prefUsuario.passUsuario;}
  }

  ///Get data from the Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarUsername);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  ///Combine RXDART
  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  ///Insert values in the Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  ///Get last data in email and password
  String get email => _emailController.value;
  String get password => _passwordController.value;

  ///Very important in bloc to dispose Streams
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
