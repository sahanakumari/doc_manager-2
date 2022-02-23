
import 'package:doc_manager/core/services/session_helper.dart';
import 'package:flutter/material.dart';


class AppSettings with ChangeNotifier {
  int? _expandedIndex;

  ThemeMode? _themeMode;
  Locale? _locale;
  double? _textScale;
  String? _fontName;
  int? _color;
  double? _cornerRadius;

  int? get expandedIndex => _expandedIndex;

  double get textScale => _textScale ?? SessionHelper.fontSize;

  String get fontName => _fontName ?? SessionHelper.fontName;

  int get color => _color ?? SessionHelper.colorScheme;

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

  ThemeMode get themeMode => _themeMode ?? _getThemeMode(SessionHelper.themeMode);

  double get cornerRadius => _cornerRadius ?? SessionHelper.cornerRadius;

  Locale? get locale => _locale ?? _getLocale(SessionHelper.language);

  set textScale(double scaleFactor) {
    _textScale = scaleFactor;
    SessionHelper.fontSize = scaleFactor;
    notifyListeners();
  }

  set fontName(String name) {
    _fontName = name;
    SessionHelper.fontName = name;
    notifyListeners();
  }

  set color(int value) {
    _color = value;
    SessionHelper.colorScheme = value;
    notifyListeners();
  }

  set cornerRadius(double value) {
    _cornerRadius = value;
    SessionHelper.cornerRadius = value;
    notifyListeners();
  }

  set expandedIndex(int? index) {
    _expandedIndex = index;
    notifyListeners();
  }

  set locale(Locale? locale) {
    _locale = locale;
    SessionHelper.language = locale?.languageCode ?? "";
    notifyListeners();
  }

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    SessionHelper.themeMode = themeMode.index;
    notifyListeners();
  }
}
