import 'package:shared_preferences/shared_preferences.dart';

///iOS in NSUserDefaults
///Android in Shared Preferences
class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  clear() {
    _prefs.setString('token', '');
  }

  get nombreUsuario {
    return _prefs.getString('nombre') ?? '';
  }

  set nombreUsuario(String nombre) {
    _prefs.setString('nombre', nombre);
  }

  get passUsuario {
    return _prefs.getString('password') ?? '';
  }

  set passUsuario(String nombre) {
    _prefs.setString('password', nombre);
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}
