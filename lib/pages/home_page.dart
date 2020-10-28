import 'package:everis_poc/providers/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('PoC everis'),
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _authService.singOut();
                Navigator.pushReplacementNamed(context, 'login');
              },
              icon: Icon(Icons.person),
              label: Text('logout'))
        ],
      ),
      body: Column(
        children: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _authService.changeEmail('javier.valvano@gmail.com');
              },
              icon: Icon(Icons.email),
              label: Text('Change email')),
          SizedBox(height: 30.0),
          FlatButton.icon(
              onPressed: () async {
                await _authService.deleteUser();
                Navigator.pushReplacementNamed(context, 'login');
              },
              icon: Icon(Icons.delete),
              label: Text('Delete User'))
        ],
      ),
    );
  }
}
