
import 'package:doc_manager/core/services/app_settings.dart';
import 'package:doc_manager/core/services/session_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


const MaterialColor kSwatch = MaterialColor(0xff202023, {
  50: Color(0xffe7e7e9),
  100: Color(0xffd0d0d4),
  200: Color(0xffa2a2aa),
  300: Color(0xff74747f),
  400: Color(0xff4a4a51),
  500: Color(0xff202023),
  600: Color(0xff1c1c1f),
  700: Color(0xff19191c),
  800: Color(0xff161618),
  900: Color(0xff131315),
});

const Color kPrimaryColor = Color(0xff015ecb);
const Color kAccentColor = Color(0xfffab206);
const Color kButtonColor = Color(0xff1BB792);
const Color kHintColor = Color(0xffdedede);
const Color kDividerColor = Color(0xffbcbcbc);
const Color kErrorColor = Color(0xffcd0909);
Color kBackgroundColor = Colors.white;

//Dark theme
const Color kPrimaryColorDark = Color(0xff2f579f);
const Color kAccentColorDark = Color(0xfffab206);
const Color kButtonColorDark = Color(0xff1BB792);
const Color kHintColorDark = Color(0xffdedede);
const Color kDividerColorDark = Color(0x55bcbcbc);
const Color kErrorColorDark = Color(0xffcd0909);
Color kBackgroundColorDark = kSwatch;

class AppTheme {
  final AppSettings settings;

  AppTheme(this.settings);

  static double get kRadius => (SessionHelper.cornerRadius) * 2.0;

  static double get kRadiusSmall => (SessionHelper.cornerRadius) * 1.0;

  static double get kRadiusSmallest => (SessionHelper.cornerRadius) * 0.5;

  TextTheme get _textTheme => TextTheme(
    bodyText1: TextStyle(
      color: kSwatch,
      fontSize: 14.0 * settings.textScale,
      fontWeight: FontWeight.bold,
      fontFamily: settings.fontName,
    ),
    bodyText2: TextStyle(
      color: kSwatch,
      fontSize: 14.0 * settings.textScale,
      fontFamily: settings.fontName,
    ),
    subtitle1: TextStyle(
      color: kSwatch,
      fontSize: 18 * settings.textScale,
      fontWeight: FontWeight.bold,
      fontFamily: settings.fontName,
    ),
    subtitle2: TextStyle(
      color: kSwatch,
      fontFamily: settings.fontName,
      fontSize: 14.0 * settings.textScale,
    ),
    headline1: TextStyle(
      color: kSwatch,
      fontFamily: settings.fontName,
      fontSize: 35 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    headline2: TextStyle(
      color: kSwatch,
      fontFamily: settings.fontName,
      fontSize: 28 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    headline3: TextStyle(
      color: kSwatch,
      fontFamily: settings.fontName,
      fontSize: 24 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    headline4: TextStyle(
      color: kSwatch,
      fontFamily: settings.fontName,
      fontSize: 21 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    headline5: TextStyle(
      color: kSwatch,
      fontFamily: settings.fontName,
      fontSize: 18 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    headline6: TextStyle(
      color: kSwatch,
      fontFamily: settings.fontName,
      fontSize: 14 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    caption: TextStyle(
      color: kSwatch[400],
      fontFamily: settings.fontName,
      fontSize: 12 * settings.textScale,
      fontWeight: FontWeight.w300,
    ),
    button: TextStyle(
      color: kSwatch,
      fontWeight: FontWeight.w900,
      fontSize: 11 * settings.textScale,
      fontFamily: settings.fontName,
    ),
    overline: TextStyle(
      color: kSwatch,
      fontFamily: settings.fontName,
      fontSize: 14.0 * settings.textScale,
    ),
  );

  TextTheme get _textThemeDark => TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 14.0 * settings.textScale,
      fontFamily: settings.fontName,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 14.0 * settings.textScale,
      fontFamily: settings.fontName,
    ),
    subtitle1: TextStyle(
      color: Colors.white,
      fontSize: 18.0 * settings.textScale,
      fontWeight: FontWeight.bold,
      fontFamily: settings.fontName,
    ),
    subtitle2: TextStyle(
      color: Colors.white,
      fontFamily: settings.fontName,
      fontSize: 14.0 * settings.textScale,
    ),
    headline1: TextStyle(
      color: Colors.white,
      fontFamily: settings.fontName,
      fontSize: 35 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    headline2: TextStyle(
      color: Colors.white,
      fontFamily: settings.fontName,
      fontSize: 28 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    headline3: TextStyle(
      color: Colors.white,
      fontFamily: settings.fontName,
      fontSize: 24 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    headline4: TextStyle(
      color: Colors.white,
      fontFamily: settings.fontName,
      fontSize: 21 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    headline5: TextStyle(
      color: Colors.white,
      fontFamily: settings.fontName,
      fontSize: 18 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    headline6: TextStyle(
      color: Colors.white,
      fontFamily: settings.fontName,
      fontSize: 14 * settings.textScale,
      fontWeight: FontWeight.w900,
    ),
    caption: TextStyle(
      color: Colors.white70,
      fontFamily: settings.fontName,
      fontSize: 12 * settings.textScale,
      fontWeight: FontWeight.w300,
    ),
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontSize: 11 * settings.textScale,
      fontFamily: settings.fontName,
    ),
    overline: TextStyle(
      color: Colors.white,
      fontFamily: settings.fontName,
      fontSize: 14.0 * settings.textScale,
    ),
  );

  InputDecorationTheme get _inputTheme => InputDecorationTheme(
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: kDividerColor, width: 0.5),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: kDividerColor, width: 0.5),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(settings.color), width: 1),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: kErrorColor, width: 0.5),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: kErrorColor, width: 1),
    ),
  );

  InputDecorationTheme get _inputThemeDark => InputDecorationTheme(
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: kDividerColorDark, width: 0.5),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: kDividerColorDark, width: 0.5),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(settings.color), width: 1),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: kErrorColorDark, width: 0.5),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: kErrorColorDark, width: 1),
    ),
  );

  TextSelectionThemeData get _textSelectionTheme => TextSelectionThemeData(
    cursorColor: Color(settings.color),
    selectionHandleColor: Color(settings.color),
    selectionColor: Color(settings.color).withOpacity(0.5),
  );

  ThemeData get theme => ThemeData(
    primarySwatch: kSwatch,
    textSelectionTheme: _textSelectionTheme,
    colorScheme: ColorScheme(
      primary: Color(settings.color),
      primaryVariant: Color(settings.color),
      secondary: Color(settings.color),
      secondaryVariant: Color(settings.color),
      surface: Colors.white,
      background: kBackgroundColor,
      error: kErrorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: kSwatch,
      onBackground: kSwatch,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      height: 36,
      colorScheme: const ColorScheme(
        primary: kButtonColor,
        primaryVariant: kButtonColorDark,
        secondary: Colors.white,
        secondaryVariant: Colors.white,
        surface: kButtonColor,
        background: kButtonColor,
        error: kErrorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
      buttonColor: Color(settings.color),
    ),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusSmall),
      ),
    ),
    primaryColor: kPrimaryColor,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    secondaryHeaderColor: kPrimaryColor,
    backgroundColor: kSwatch[50],
    dividerColor: kSwatch[100],
    hintColor: kSwatch[200],
    primaryColorBrightness: Brightness.light,
    scaffoldBackgroundColor: kBackgroundColor,
    textTheme: _textTheme,
    inputDecorationTheme: _inputTheme,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleTextStyle: _textTheme.headline6?.copyWith(color: kPrimaryColor),
      toolbarTextStyle:
      _textTheme.headline6?.copyWith(color: kPrimaryColor),
      foregroundColor: kPrimaryColor,
      color: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: kSwatch[50]!,
      disabledColor: kSwatch,
      selectedColor: Color(settings.color),
      secondarySelectedColor: Color(settings.color),
      padding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      labelStyle: _textTheme.bodyText2!,
      secondaryLabelStyle:
      _textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
      brightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(color: kSwatch),
    fontFamily: settings.fontName,
  );

  ThemeData get darkTheme => ThemeData(
    primarySwatch: kSwatch,
    colorScheme: ColorScheme(
      primary: Color(settings.color),
      primaryVariant: Color(settings.color),
      secondary: Color(settings.color),
      secondaryVariant: Color(settings.color),
      surface: kSwatch,
      background: kSwatch,
      error: kErrorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    textSelectionTheme: _textSelectionTheme,
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      height: 36,
      colorScheme: const ColorScheme(
        primary: kButtonColor,
        primaryVariant: kButtonColorDark,
        secondary: Colors.white,
        secondaryVariant: Colors.white,
        surface: kButtonColor,
        background: kButtonColor,
        error: kErrorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
      buttonColor: Color(settings.color),
    ),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusSmall),
      ),
    ),
    inputDecorationTheme: _inputThemeDark,
    primaryColor: kPrimaryColorDark,
    canvasColor: kSwatch,
    secondaryHeaderColor: kPrimaryColorDark,
    cardColor: kSwatch,
    hintColor: Colors.white38,
    disabledColor: kSwatch[200],
    backgroundColor: kSwatch,
    brightness: Brightness.dark,
    primaryColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: kBackgroundColorDark,
    textTheme: _textThemeDark,
    appBarTheme: AppBarTheme(
      titleTextStyle:
      _textThemeDark.headline6?.copyWith(color: kPrimaryColor),
      toolbarTextStyle:
      _textThemeDark.headline6?.copyWith(color: kPrimaryColor),
      foregroundColor: kPrimaryColor,
      elevation: 0.0,
      color: Colors.transparent,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: kSwatch[900]!,
      disabledColor: kSwatch,
      selectedColor: Color(settings.color),
      secondarySelectedColor: Color(settings.color),
      padding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      labelStyle: _textThemeDark.button!,
      secondaryLabelStyle: _textThemeDark.button!,
      brightness: Brightness.dark,
    ),
    dividerColor: kDividerColorDark,
    iconTheme: const IconThemeData(color: Colors.white),
    fontFamily: settings.fontName,
  );
}
