part of '../utils.dart';
class ColorUtils {
  static int _random(max) {
    return Random().nextInt(max);
  }

  static Color get randomColor =>
      Color.fromRGBO(_random(200), _random(200), _random(200), 1);
}