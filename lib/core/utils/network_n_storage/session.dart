// import 'package:shared_preferences/shared_preferences.dart';

/*Supported theme modes [0=> System default, 1=> Light, 2=> Dark]*/
import 'package:hive_flutter/hive_flutter.dart';

const _THEME_MODE = 1;

/*Color code int value (decimal)*/
const _COLOR_SCHEME = 0xfffab206;

/*Card corner radius*/
const _CORNER_RADIUS = 5.0;

/*Supported fonts [Josefin Sans, Montserrat, Poppins, null=> System default]*/
const _FONT_NAME = "Poppins";

/*Supported font scale factors [0.8=> Tiny, 0.9=> Small, 1.0=> Normal, 1.1=> Large, 1.2=> Huge]*/
const _FONT_SIZE = 1.0;

/*Supported languages [en=> English, es=> Espanol (Spanish), null=> System default]*/
const _LANGUAGE = null;

//Preferences key names
const appThemeMode = "app_ThemeMode";
const appColorScheme = "app_ColorScheme";
const appCornerRadius = "app_CornerRadius";
const appFontName = "app_FontName";
const appFontSize = "app_FontSize";
const appLanguage = "app_Language";
const loginMobile = "login_Mobile";
const loginUUID = "login_UUID";

class Session {

  static final _pref = Hive.box('login');


  //App Settings
  static int get themeMode => _pref.get(appThemeMode) ?? _THEME_MODE;

  static int get colorScheme => _pref.get(appColorScheme) ?? _COLOR_SCHEME;

  static double get cornerRadius =>
      _pref.get(appCornerRadius) ?? _CORNER_RADIUS;

  static String get fontName => _pref.get(appFontName) ?? _FONT_NAME;

  static double get fontSize => _pref.get(appFontSize) ?? _FONT_SIZE;

  static String? get language => _pref.get(appLanguage) ?? _LANGUAGE;

  static set themeMode(int value) {
    _pref.put(appThemeMode, value);
  }

  static set colorScheme(int value) {
    _pref.put(appColorScheme, value);
  }

  static set cornerRadius(double value) {
    _pref.put(appCornerRadius, value);
  }

  static set fontName(String value) {
    _pref.put(appFontName, value);
  }

  static set fontSize(double value) {
    _pref.put(appFontSize, value);
  }

  static set language(String? value) {
    if (value == null) {
      _pref.delete(appLanguage);
    } else {
      _pref.put(appLanguage, value);
    }
  }

  static get isLoggedIn => sessionUser != null;

  static SessionUser? get sessionUser {
    var mobile = _pref.get(loginMobile);
    var uuid = _pref.get(loginUUID);
    if (mobile == null || uuid == null) return null;
    return SessionUser(uuid, mobile);
  }

  static set sessionUser(SessionUser? value) {
    if (value == null || value.mobile == null) {
      _pref.delete(loginMobile);
      _pref.delete(loginUUID);
    } else {
      _pref.put(loginMobile, value.mobile!);
      _pref.put(loginUUID, value.uuid);
    }
  }
}

class SessionUser {
  final String uuid;
  final String? mobile;

  SessionUser(this.uuid, this.mobile);
}
