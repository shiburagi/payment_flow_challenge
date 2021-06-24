import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final SessionManager instance = SessionManager();
  static const String THEME = "THEME";
  SharedPreferences? _preferences;
  Future initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  set theme(int? value) => _preferences?.setInt(THEME, value ?? 0);

  int? get theme => _preferences?.getInt(THEME);
}
