import 'package:flutter/material.dart';
import 'package:everis_poc/shared_preferences/preferencias_usuario.dart';
import 'package:everis_poc/routes/routes.dart';
import 'bloc/provider.dart';


///Initialize Shared Preferences
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

///Provider Widget parent for using Bloc pattern
class MyApp extends StatelessWidget {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    return Provider(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'PoC everis Flutter',
            initialRoute: prefs.ultimaPagina,
            theme: ThemeData(
              primaryColor: Colors.blue
            ),
            routes: getApplicationRoutes())
            );
  }
}
