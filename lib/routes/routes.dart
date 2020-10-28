import 'package:everis_poc/pages/home_page.dart';
import 'package:everis_poc/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:everis_poc/pages/login_page.dart';



Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'register': (BuildContext context) => RegisterPage(),
    'home': (BuildContext context) => HomePage(),
  };
}
