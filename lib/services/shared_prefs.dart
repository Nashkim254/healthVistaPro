part of 'services.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;
  static const email = "email";
  static const password = "password";
  static const locale = "locale";


  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static String? getEmail() => _prefs!.getString(email);

  static String? getPassword() => _prefs!.getString(password);

  static String? getLocale() => _prefs!.getString(locale);




  static Future setLocale(String _locale) async => await _prefs!.setString(locale, _locale);

  static Future setEmail(String _email) async => await _prefs!.setString(email, _email);

  static Future setPassword(String _password) async => await _prefs!.setString(password, _password);



}
