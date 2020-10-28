import 'package:everis_poc/bloc/login_bloc.dart';
import 'package:everis_poc/bloc/provider.dart';
import 'package:everis_poc/providers/auth.dart';
import 'package:everis_poc/utils/utils.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[_loginForm(context)],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height * 0.1,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: <Widget>[
                // Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBotonRegistro(bloc),
                SizedBox(height: 30.0),
                _crearBotonForgetPassword(bloc),
              ],
            ),
          ),
          FlatButton(
            child: Text('¿Tienes cuenta? ir a Login'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            initialValue: bloc.email != '' ? bloc.email : '',
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.account_circle, color: Colors.green),
                labelText: 'Usuario',
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            initialValue: bloc.password != '' ? bloc.password : '',
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.green),
                labelText: 'Contraseña',
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  _crearBotonRegistro(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Crear usuario')),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.green,
          textColor: Colors.white,
          onPressed: snapshot.hasData || bloc.email != ''
              ? () => _register(bloc, context)
              : null,
        );
      },
    );
  }

    _crearBotonForgetPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Reset Passw')),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: snapshot.hasData || bloc.email != ''
              ? () => _forget(bloc, context)
              : null,
        );
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    try {
      dynamic info = await _authService.register(bloc.email, bloc.password);
      mostrarAlerta(context, 'usuario creado con uid:' + info.uid);
    } catch (e) {
      mostrarAlerta(context, e.message);
    }
  }

    _forget(LoginBloc bloc, BuildContext context) async {
    try {
      dynamic info = await _authService.forgetPassword(bloc.email);
      if(info)
      mostrarAlerta(context, 'Se ha enviado un correo a la cuenta ingresada.');
      else
       mostrarAlerta(context, 'Error');
    } catch (e) {
      mostrarAlerta(context, e.message);
    }
  }

  
}
