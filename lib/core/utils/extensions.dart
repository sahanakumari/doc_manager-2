
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_localizations.dart';

extension ExtString on String {
  String tr(BuildContext context, [Map<String, dynamic>? args]) {
    return AppLocalizations.of(context)?.translate(this, args) ?? this;
  }
}

extension ExtDateTime on DateTime {
  DateTime get onlyDate {
    return DateTime(year, month, day);
  }

  bool get withinWeek {
    var now = DateTime.now().onlyDate;
    var time = onlyDate;
    return time.difference(now).inDays <= 7;
  }

  bool get isToday {
    var now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }

  String format([dateOnly = false]) {
    if (dateOnly) {
      try {
        var date = toLocal();
        if (date.isToday) return "today";
        return DateFormat.yMMMd().format(date);
      } catch (e) {
        return toIso8601String();
      }
    }
    try {
      var date = toLocal();
      if (date.isToday) return DateFormat.jm().format(date);
      if (date.withinWeek) return DateFormat.E().add_jm().format(date);
      return DateFormat.MMMd().add_jm().format(date);
    } catch (e) {
      return toIso8601String();
    }
  }
}
