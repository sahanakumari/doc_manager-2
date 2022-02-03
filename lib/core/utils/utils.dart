import 'dart:math';


import 'package:doc_manager/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ColorUtils {
  static int _random(max) {
    return Random().nextInt(max);
  }

  static Color get randomColor =>
      Color.fromRGBO(_random(200), _random(200), _random(200), 1);
}

class DataUtils {
  static const List<String> bloodGroups = [
    "A+ve",
    "A-ve",
    "AB+ve",
    "AB-ve",
    "B+ve",
    "B-ve",
    "O+ve",
    "O-ve",
  ];
  static const List<String> genders = ["male", "female"];
  static List<Country> countries = [Country.india, Country.nepal];
}

class DateTimeUtils {
  static String dateFormatted(String? date) {
    if (date == null) return "";
    var dt = DateTime.tryParse(date);
    if (dt == null) return date;
    return DateFormat.yMMMd().format(dt);
  }
}
