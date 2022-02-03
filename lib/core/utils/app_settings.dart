
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'network_n_storage/session.dart';

class AppSettings with ChangeNotifier {
  int? _expandedIndex;

  ThemeMode? _themeMode;
  Locale? _locale;
  double? _textScale;
  String? _fontName;
  int? _color;
  double? _cornerRadius;

  int? get expandedIndex => _expandedIndex;

  double get textScale => _textScale ?? Session.fontSize;

  String get fontName => _fontName ?? Session.fontName;

  int get color => _color ?? Session.colorScheme;

  ThemeMode _getThemeMode(int value) {
    switch (value) {
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Locale? _getLocale(String? code) {
    if (code == null || code.isEmpty) return null;
    return Locale(code);
  }

  ThemeMode get themeMode => _themeMode ?? _getThemeMode(Session.themeMode);

  double get cornerRadius => _cornerRadius ?? Session.cornerRadius;

  Locale? get locale => _locale ?? _getLocale(Session.language);

  set textScale(double scaleFactor) {
    _textScale = scaleFactor;
    Session.fontSize = scaleFactor;
    notifyListeners();
  }

  set fontName(String name) {
    _fontName = name;
    Session.fontName = name;
    notifyListeners();
  }

  set color(int value) {
    _color = value;
    Session.colorScheme = value;
    notifyListeners();
  }

  set cornerRadius(double value) {
    _cornerRadius = value;
    Session.cornerRadius = value;
    notifyListeners();
  }

  set expandedIndex(int? index) {
    _expandedIndex = index;
    notifyListeners();
  }

  set locale(Locale? locale) {
    _locale = locale;
    Session.language = locale?.languageCode ?? "";
    notifyListeners();
  }

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    Session.themeMode = themeMode.index;
    notifyListeners();
  }
}
