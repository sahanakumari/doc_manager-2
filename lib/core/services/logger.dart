import 'dart:developer';

import '../../data/app_data/app_config.dart';


void appLog(
  Object object, {
  Object? error,
  DateTime? time,
  StackTrace? stackTrace,
  String tag = "",
}) {
  if (AppConfig.env == SourceConfig.prod) return;
  log(
    "(${AppConfig.env}) $tag: $object",
    error: error,
    time: time ?? DateTime.now(),
    stackTrace: stackTrace,
  );
}
